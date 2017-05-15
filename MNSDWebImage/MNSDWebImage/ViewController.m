//
//  ViewController.m
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MNWebImageDownloaderOperation.h"
#import "YYModel.h"
#import "HMAppModel.h"
#import "MNWebImageDownloaderManager.h"

@interface ViewController ()

/**
 上一次操作的加载路径
 */
@property (nonatomic,copy) NSString *lastURLStr;

@property (nonatomic,strong) NSArray<HMAppModel *> *dataArray;

/**
 展示图片的imageView
 */
@property (nonatomic,weak) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 200, 80, 80)];
    imageView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:imageView];
    
    self.imgView = imageView;
    
    //加载网络数据
    [self loadImagestData];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.dataArray.count > 0) {
        
        NSInteger randomNum = arc4random() % self.dataArray.count;
        
        NSString *urlStr = self.dataArray[randomNum].icon;
        //如果当前的操作跟上一次操作不同
        if (self.lastURLStr && ![self.lastURLStr isEqualToString:urlStr] ) {
            
            NSLog(@"又要取消上一次操作");
            
            [[MNWebImageDownloaderManager sharedManager] cancelOperationWithlastURL:self.lastURLStr];
        }
        
        self.lastURLStr = urlStr;
        
        
        [[MNWebImageDownloaderManager sharedManager] downloaderImageWithURLStr:urlStr andSuccessBlock:^(UIImage *image) {
            self.imgView.image = image;
        }];
        
        
    }
    
    
    
}

#pragma mark - 请求网络数据
-(void)loadImagestData {
    
    //创建网络请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/gitfyq/hm24_loadImageData/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.dataArray = [NSArray yy_modelArrayWithClass:[HMAppModel class] json:responseObject];
        
        NSLog(@"self.dataArray - %@",self.dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"加载异常原因:%@",error);
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
