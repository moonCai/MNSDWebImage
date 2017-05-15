//
//  ViewController.m
//  MNSDWebImage
//
//  Created by 蔡钰 on 2017/5/15.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

#import "ViewController.h"
#import "MNWebImageDownloaderOperation.h"

@interface ViewController ()

/**
 操作缓存池
 */
@property (nonatomic,strong) NSMutableDictionary<NSString *, MNWebImageDownloaderOperation *> *opCache;

/**
 全局队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;

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
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *urlStr = @"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png";
    
    if ([_opCache valueForKey:urlStr]) {
        
        NSLog(@"图片下载中");
    
        return;
    }
    
    MNWebImageDownloaderOperation *op = [MNWebImageDownloaderOperation webImageDownloaderOperationWithURLStr:@"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png" andSuccessBlock:^(UIImage *image) {
        
        self.imgView.image = image;
        
        NSLog(@"图片下载成功");
        
        [self.opCache removeObjectForKey:urlStr];
        
    }];
    
    //将操作添加到缓存池中
    [self.opCache setValue:op forKey:urlStr];
    
    [self.queue addOperation:op];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
