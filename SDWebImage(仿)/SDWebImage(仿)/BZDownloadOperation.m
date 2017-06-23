//
//  BZDownloadOperation.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/23.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "BZDownloadOperation.h"




@interface BZDownloadOperation()

//接受外界地址
@property(nonatomic,copy)NSString *URLString;

//准备接受外面调入的block
@property (nonatomic,copy)void(^finishBlock)(UIImage *image);


@end


//下载图片需要
//1.图片地址
//2.需要回调代码块

@implementation BZDownloadOperation





+(instancetype)downloadOperaionWithURLString:(NSString *)URLString finished:(void(^)(UIImage *image))finishedBlock;
{
    BZDownloadOperation *downloadOp = [BZDownloadOperation new];
    
    //记录全局图片地址
    downloadOp.URLString = URLString;
    
    downloadOp.finishBlock = finishedBlock;
    
    return downloadOp;
    
}



- (void)main
{
    
    NSLog(@"传入");
    
    NSURL *url = [NSURL URLWithString:_URLString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    [NSThread sleepForTimeInterval:1];
    
    
    if (self.isCancelled == YES) {
        
        NSLog(@"取消");
        
        return ;
        
    }
    
    
    
    
    if (self.finishBlock != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
          
            self.finishBlock(image);
            
        }];
    }
    
    
}

@end
