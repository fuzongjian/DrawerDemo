//
//  HomeViewController.h
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/10.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "SuperViewController.h"
#import "DrawerViewController.h"
@interface HomeViewController : SuperViewController<DrawerChildViewController>

-(void)openLeftDrawer;
-(void)openRightDrawer;
-(void)closeDrawer;
-(BOOL)drawerIsOpen;

@end
