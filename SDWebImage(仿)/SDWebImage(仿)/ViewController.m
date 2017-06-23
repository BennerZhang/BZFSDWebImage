//
//  ViewController.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/23.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "ViewController.h"
#import "BZDownloadOperation.h"


@interface ViewController ()

@property (nonatomic,strong)NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //准备队列
    NSOperationQueue *queue = [NSOperationQueue new];
    
    //创建自定义操作
    BZDownloadOperation *op = [BZDownloadOperation new];
    
    
    //加入队列
    [queue addOperation:op];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
