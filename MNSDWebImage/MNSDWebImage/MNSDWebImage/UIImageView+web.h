//
//  UIImageView+web.h
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/16.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (web)

/**
 上一次操作的加载路径
 */
@property (nonatomic,copy) NSString *lastURLStr;

-(void)mn_imageWithURLStr:(NSString *)URLStr;

@end
