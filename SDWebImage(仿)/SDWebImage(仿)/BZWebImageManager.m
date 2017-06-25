//
//  BZWebImageManager.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "BZWebImageManager.h"

@interface BZWebImageManager()

@property (nonatomic,strong)NSOperationQueue *queue;

//操作缓存池
@property (nonatomic ,strong)NSMutableDictionary *opDictionary;

@end

@implementation BZWebImageManager

//使用单例
+(instancetype)sharedManager
{
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [self new];
        
    });
    
    return instance;
    
}


- (instancetype)init
{
    
    if (self = [super init])
    {
        
        self.queue = [NSOperationQueue new];
        
        self.opDictionary = [NSMutableDictionary new];
        
    }
    
    return self;
    
}




//设置单例下载
- (void)downloadOperaionWithURLString:(NSString *)URLString completionBlock:(void(^)(UIImage *image))completionBlock
{
    
    if ([self.opDictionary objectForKey:URLString] != nil) {
        
        return;
        
    }
    
    
    
    //获取图片地址
    //创建自定义操作
    BZDownloadOperation *op = [BZDownloadOperation downloadOperaionWithURLString:URLString finished:^(UIImage *image) {
        
        if (completionBlock != nil) {
            
            completionBlock(image);
            
        }
        
        //图片下载完成后 移除对应的操作
        [self.opDictionary removeObjectForKey:URLString];
        
    }];
    
    
    //添加到操作缓存池
    [self.opDictionary setObject:op forKey:URLString];
    
    //加入队列
    [self.queue addOperation:op];
    
    
    
}




@end
