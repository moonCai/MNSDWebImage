//
//  NSString+path.h
//  异步下载网络图片
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)
// 为了拼接全路径
- (NSString *)appendCachePath;
@end
