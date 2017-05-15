//
//  MNWebImageDownloaderManager.m
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import "MNWebImageDownloaderManager.h"

@interface MNWebImageDownloaderManager ()

/**
 全局队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;

/**
 操作缓存池
 */
@property (nonatomic,strong) NSMutableDictionary<NSString *, MNWebImageDownloaderOperation *> *opCache;

/**
 图片缓存池
 */
@property (nonatomic,strong) NSMutableDictionary *imagesCache;

@end

@implementation MNWebImageDownloaderManager

+(instancetype)sharedManager {
    static MNWebImageDownloaderManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MNWebImageDownloaderManager alloc] init];
    });
    
    return instance;
}

-(instancetype)init {
    
    if (self = [super init]) {
        //监听内存警告的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - 下载图片
-(void)downloaderImageWithURLStr:(NSString *)urlStr andSuccessBlock:(void(^)(UIImage *image))successBlock {
    
    //判断内存或者沙盒中是否有需要加载的图片
    if([self checkImageWithURLStr:urlStr]) {
        successBlock([self.imagesCache objectForKey:urlStr]);
        return;
    }
    
    MNWebImageDownloaderOperation *op = [MNWebImageDownloaderOperation webImageDownloaderOperationWithURLStr:urlStr andSuccessBlock:^(UIImage *image) {
        //判断图片是否存在,保存到内存缓存池中
        if (image) {
            
            [self.imagesCache setValue:image forKey:urlStr];
            
        }
        
        
        if (successBlock) {
            
            successBlock(image);
            
        }
        
        NSLog(@"图片下载成功");
        
        [self.opCache removeObjectForKey:urlStr];
        
    }];
    
    if ([_opCache objectForKey:urlStr]) {
        
        NSLog(@"图片下载中");
        
        return;
    }
    
    //将操作添加到缓存池中
    [self.opCache setValue:op forKey:urlStr];
    
    [self.queue addOperation:op];
    
}

#pragma mark- 判断内存或者沙盒中是否有需要加载的图片
- (BOOL)checkImageWithURLStr:(NSString *)urlStr {
    
    //判断内存中是否有需要下载的图片
    if ([self.imagesCache valueForKey:urlStr] != nil) {
        NSLog(@"从内存中加载图片");
        // successBlock([self.imagesCache valueForKey:urlStr]);
        return YES;
    }
    
    //判断沙盒中是否有需要加载的图片
    UIImage *tempImage = [UIImage imageWithContentsOfFile:[urlStr appendCachePath]];
    if (tempImage) {
        
        NSLog(@"从沙盒中获取图片");
        //将图片存储到内存中
        [self.imagesCache setObject:tempImage forKey:urlStr];
        
        return YES;
        
    }
    
    return NO;
    
}

#pragma mark- 取消操作
-(void)cancelOperationWithlastURL:(NSString *)lastURL {
    
    //取消上一次操作
    [[self.opCache valueForKey:lastURL] cancel];
    
    //从缓存池中移除上一次操作
    [self.opCache removeObjectForKey:lastURL];
    
    
}

//懒加载图片缓存池
-(NSMutableDictionary *)imagesCache {
    if (!_imagesCache) {
        _imagesCache = [[NSMutableDictionary alloc] init];
    }
    return _imagesCache;
}

//懒加载缓存池
-(NSMutableDictionary<NSString *,MNWebImageDownloaderOperation *> *)opCache {
    
    if (!_opCache) {
        _opCache = [[NSMutableDictionary alloc] init];
    }
    
    return _opCache;
}

//懒加载操作队列
-(NSOperationQueue *)queue {
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return _queue;
}

#pragma mark - 清除内存
-(void)clearMemory {
    //清除操作缓存池
    [self.opCache removeAllObjects];
    //清除图片缓存池
    [self.imagesCache removeAllObjects];
    //取消队列中的所有操作
    [self.queue cancelAllOperations];

}

@end
