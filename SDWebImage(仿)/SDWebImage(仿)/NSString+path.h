//
//  NSString+path.h
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (path)

//获取cache文件夹内部文件路径
- (NSString *)appendCachePath;

@end
