//
//  MNWebImageDownloaderOperation.m
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import "MNWebImageDownloaderOperation.h"

@implementation MNWebImageDownloaderOperation

- (void)main {
    //线程睡眠,模拟网络延时
   // [NSThread sleepForTimeInterval:5];
    
   // NSLog(@"%@",[NSThread currentThread]);
    
    //如果当前操作标记为取消状态,直接return,不做成功前的回调.
    if (self.isCancelled) {
        
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    //将图片存入沙盒
    if (image) {
        
        [data writeToFile:[self.urlStr appendCachePath] atomically:YES];
        
        NSLog(@"%@",[self.urlStr appendCachePath]);
    }
    
    if (self.successBlock) {
        //切换主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.successBlock(image);
        }];
    }

}

+(instancetype)webImageDownloaderOperationWithURLStr:(NSString *)urlStr andSuccessBlock:(void(^)(UIImage *image)) successBlock {
    
    MNWebImageDownloaderOperation *op = [[MNWebImageDownloaderOperation alloc] init];
    op.urlStr = urlStr;
    op.successBlock = successBlock;
    
    return op;
}

@end
