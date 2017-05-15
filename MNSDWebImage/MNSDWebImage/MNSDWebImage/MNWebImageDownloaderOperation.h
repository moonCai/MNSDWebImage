//
//  MNWebImageDownloaderOperation.h
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+path.h"
#import <UIKit/UIKit.h>

@interface MNWebImageDownloaderOperation : NSOperation

/**
 下载路径
 */
@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,copy) void(^successBlock)(UIImage *image);

+(instancetype)webImageDownloaderOperationWithURLStr:(NSString *)urlStr andSuccessBlock:(void(^)(UIImage *image)) successBlock;

@end
