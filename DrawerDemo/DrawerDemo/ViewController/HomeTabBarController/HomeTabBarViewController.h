//
//  HomeTabBarViewController.h
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/9.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerViewController.h"
@interface HomeTabBarViewController : UITabBarController<DrawerChildViewController>

-(void)openLeftDrawer;
-(void)openRightDrawer;
-(void)closeDrawer;
@end
