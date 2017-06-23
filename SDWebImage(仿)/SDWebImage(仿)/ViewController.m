//
//  ViewController.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/23.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "ViewController.h"
#import "BZDownloadOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "BZAppModel.h"

@interface ViewController ()

@property (nonatomic,strong)NSOperationQueue *queue;

@property (nonatomic,strong)NSArray *appList;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //准备队列
    self.queue = [NSOperationQueue new];
    
    
    [self loadData];
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //随机获取图片地址
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    //获取随机的模型
    BZAppModel *model = self.appList[random];
    
    //创建自定义操作
    BZDownloadOperation *op = [BZDownloadOperation downloadOperaionWithURLString:model.icon finished:^(UIImage *image) {
        
        self.iconImage.image = image;
        
    }];
    
    //加入队列
    [self.queue addOperation:op];
    
}




- (void)loadData
{
    
    
    // 准备图片地址
    NSString *URLString = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM06/master/apps.json";
    
    [[AFHTTPSessionManager manager]GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictArray = responseObject;
        
        self.appList = [NSArray yy_modelArrayWithClass:[BZAppModel class] json:dictArray];
        
        NSLog(@"%@",self.appList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
