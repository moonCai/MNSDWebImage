//
//  NSString+path.m
//  异步下载网络图片
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendCachePath{
    // 获取沙盒路径
    NSString *file = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true).lastObject;
    NSLog(@"沙盒路径:%@",file);
    // 图片名
    NSString *name = [self lastPathComponent];
    // 全路径
    NSString *fileName = [file stringByAppendingPathComponent:name];
    return fileName;
}

@end
