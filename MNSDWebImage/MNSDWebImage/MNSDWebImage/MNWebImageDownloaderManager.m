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

-(void)downloaderImageWithURLStr:(NSString *)urlStr andSuccessBlock:(void(^)(UIImage *image))successBlock {
    
    MNWebImageDownloaderOperation *op = [MNWebImageDownloaderOperation webImageDownloaderOperationWithURLStr:urlStr andSuccessBlock:^(UIImage *image) {
        
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

-(void)cancelOperationWithlastURL:(NSString *)lastURL {
    
    //取消上一次操作
    [[self.opCache valueForKey:lastURL] cancel];
    
    //从缓存池中移除上一次操作
    [self.opCache removeObjectForKey:lastURL];
    
    
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

@end
