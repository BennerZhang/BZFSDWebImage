//
//  BZWebImageManager.h
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZDownloadOperation.h"

@interface BZWebImageManager : NSObject

//使用单例
+(instancetype)sharedManager;


//设置单例下载
- (void)downloadOperaionWithURLString:(NSString *)URLString completionBlock:(void(^)(UIImage *image))completionBlock;


@end
