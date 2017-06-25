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

//图片缓存
@property (nonatomic ,strong)NSCache *imageMemCache;

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
        
        self.imageMemCache = [NSCache new];
        
    }
    
    return self;
    
}




//设置单例下载
- (void)downloadOperaionWithURLString:(NSString *)URLString completionBlock:(void(^)(UIImage *image))completionBlock
{
    //在下载图片前,判断是否有缓存
    if ([self chackCache:URLString]) {
        
        if (completionBlock != nil) {
            
            completionBlock([self.imageMemCache objectForKey:URLString]);
            
            return;
        }
        
    }
    
    
    if ([self.opDictionary objectForKey:URLString] != nil) {
        
        return;
        
    }
    
    
    
    //获取图片地址
    //创建自定义操作
    BZDownloadOperation *op = [BZDownloadOperation downloadOperaionWithURLString:URLString finished:^(UIImage *image) {
        
        if (completionBlock != nil) {
            
            completionBlock(image);
            
        }
        
        //实现缓存
        if(image != nil)
        {
            
            [self.imageMemCache setObject:image forKey:URLString];
            
        }
        
        
        //图片下载完成后 移除对应的操作
        [self.opDictionary removeObjectForKey:URLString];
        
    }];
    
    
    //添加到操作缓存池
    [self.opDictionary setObject:op forKey:URLString];
    
    //加入队列
    [self.queue addOperation:op];
    
    
    
}


//设置取消的点击中的下载
- (void)cancelLastOperation:(NSString *)lastOperation
{
    
    //取出
    BZDownloadOperation *lastOp = [self.opDictionary objectForKey:lastOperation];
    
    [lastOp cancel];
    
    [self.opDictionary removeObjectForKey:lastOperation];
    
}


//是否有缓存的主方法
- (BOOL)chackCache:(NSString *)URLString
{
    //判断是否在内存中缓存
    if ([self.imageMemCache objectForKey:URLString] )
    {
        NSLog(@"从内存中加载");
        return YES;
    
    }
    
    //判断是否在沙盒中缓存
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCachePath]];
    
    if ( cacheImage != nil)
    {
        
        NSLog(@"从沙盒中加载");
        
        [self.imageMemCache setObject:cacheImage forKey:URLString];
        
        return YES;
        
    }
    
    return NO;
    
    
}


@end
