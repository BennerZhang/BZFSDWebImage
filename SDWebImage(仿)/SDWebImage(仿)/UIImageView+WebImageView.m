//
//  UIImageView+WebImageView.m
//  SDWebImage(仿)
//
//  Created by zzx on 2017/6/25.
//  Copyright © 2017年 zzx. All rights reserved.
//

#import "UIImageView+WebImageView.h"
#import <objc/runtime.h>

#define keyURLString "urlString"

@implementation UIImageView (WebImageView)


- (void)setLastURLString:(NSString *)lastURLString
{
    
    objc_setAssociatedObject(self,keyURLString , lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    return objc_getAssociatedObject(self, keyURLString);
    
}

- (void)bzsd_setImageWithURLString:(NSString *)URLString
{
    
    //判断图片是否和上次相同
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        [[BZWebImageManager sharedManager]cancelLastOperation:self.lastURLString];
        
    }
    
    
    //记录上一次图片的地址
    self.lastURLString = URLString;
    
    
    [[BZWebImageManager sharedManager] downloadOperaionWithURLString:URLString completionBlock:^(UIImage *image) {
        
        self.image = image;
        
    }];
    
    
}




@end
