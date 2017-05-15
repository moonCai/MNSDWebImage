//
//  HMAppModel.h
//  异步下载网络图片
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
/*
    - 保存数据的模型
 */
@interface HMAppModel : NSObject

// 下载量
@property (nonatomic, copy) NSString *download;
// 图片地址
@property (nonatomic, copy) NSString *icon;
// 应用名
@property (nonatomic, copy) NSString *name;

/*
{
    download = "10311\U4e07";
    icon = "http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png";
    name = "\U690d\U7269\U5927\U6218\U50f5\U5c38";
}
 */

@end
