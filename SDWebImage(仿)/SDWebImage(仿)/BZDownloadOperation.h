//
//  BZDownloadOperation.h
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/23.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BZDownloadOperation : NSOperation


+(instancetype)downloadOperaionWithURLString:(NSString *)URLString finished:(void(^)(UIImage *image))finishedBlock;

@end
