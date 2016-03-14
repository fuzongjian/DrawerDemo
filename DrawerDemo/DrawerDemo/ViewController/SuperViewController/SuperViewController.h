//
//  SuperViewController.h
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/8.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerViewController.h"
//左边还是右边
typedef NS_ENUM(NSInteger,LRType){
    LeftType,
    Righttype
};
@interface SuperViewController : UIViewController<DrawerChildViewController>

//自定义标题,以及标题颜色
-(void)setCustomTitle:(NSString *)title TitleFont:(CGFloat)fontSize TitleColor:(UIColor *)color;

-(void)setCustomLRImage:(UIImage *)image ImageSize:(CGSize)size WithLeftRight:(LRType)type;
-(void)setCustomLRTitle:(NSString *)title TitleFone:(CGFloat)fontSize TitleColor:(UIColor *)color withLeftRight:(LRType)type;

@end
