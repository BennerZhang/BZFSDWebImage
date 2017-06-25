//
//  UIImageView+WebImageView.h
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BZWebImageManager.h"

@interface UIImageView (WebImageView)

@property (nonatomic ,copy)NSString *lastURLString;

//创建快速方法
- (void)bzsd_setImageWithURLString:(NSString *)URLString;

@end
