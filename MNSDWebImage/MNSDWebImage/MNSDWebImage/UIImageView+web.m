//
//  UIImageView+web.m
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/16.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import "UIImageView+web.h"
#import "MNWebImageDownloaderManager.h"
#import <objc/runtime.h>

@implementation UIImageView (web)

-(void)setLastURLStr:(NSString *)lastURLStr {
    
    objc_setAssociatedObject(self, "KEY", lastURLStr, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(NSString *)lastURLStr {
    
    return  objc_getAssociatedObject(self, "KEY");

}

-(void)mn_imageWithURLStr:(NSString *)URLStr {

    //如果当前的操作跟上一次操作不同
    if (self.lastURLStr && ![self.lastURLStr isEqualToString:URLStr] ) {
        
        NSLog(@"又要取消上一次操作");
        
        [[MNWebImageDownloaderManager sharedManager] cancelOperationWithlastURL:self.lastURLStr];
    }
    
    self.lastURLStr = URLStr;
    
    [[MNWebImageDownloaderManager sharedManager] downloaderImageWithURLStr:URLStr andSuccessBlock:^(UIImage *image) {
        self.image = image;
    }];
    
}



@end
