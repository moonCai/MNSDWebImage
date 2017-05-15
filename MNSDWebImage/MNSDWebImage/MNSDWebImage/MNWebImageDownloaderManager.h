//
//  MNWebImageDownloaderManager.h
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNWebImageDownloaderOperation.h"

@interface MNWebImageDownloaderManager : NSObject

+(instancetype)sharedManager;

//下载图片
-(void)downloaderImageWithURLStr:(NSString *)urlStr andSuccessBlock:(void(^)(UIImage *image))successBlock;

//取消操作
-(void)cancelOperationWithlastURL:(NSString *)lastURL;

@end
