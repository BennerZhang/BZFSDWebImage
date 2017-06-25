//
//  NSString+path.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "NSString+path.h"
#import "NSString+Hash.h"

@implementation NSString (path)

//获取cache文件夹内部文件路径
- (NSString *)appendCachePath
{
    //cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //获取文件缓存的名字
    NSString *name = [self md5String];
    
    //cachePath和naem名字对接
    NSString *filePath = [cachePath stringByAppendingPathComponent:name];
    
    return filePath;
    
}


@end
