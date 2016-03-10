//
//  DrawerViewController.h
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/9.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DrawerViewController : UIViewController
{
    @private
    //主界面根视图
    UIViewController *_rootViewController;
}
//设置left控制器
@property(nonatomic,strong)UIViewController * leftViewController;
//设置right控制器
@property(nonatomic,strong)UIViewController * rightViewController;
//设置leftWidth 默认150
@property(nonatomic,assign)CGFloat leftDrawerWidth;
//设置rightWidth 默认150
@property(nonatomic,assign)CGFloat rightDrawerWidth;
//抽屉是否打开
@property(nonatomic,assign)BOOL isOpen;
//缩放比例,不设置的话默认是不缩放（0-1）
@property(nonatomic,assign)float scale;


/****************************************  初始化视图的方法  ********************************************/
//初始化left、right、middle的视图控制器
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController LeftViewController:(UIViewController *)leftViewController RightViewController:(UIViewController *)rightViewController;
//初始化middle的视图控制器
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController;
/*****************************************************************************************************/


/************************    下面四个方法可能需要在拥有--抽屉--的控制器实现     ***************************/
//打开左侧抽屉
-(void)openDrawerWithLeft;
//打开右侧抽屉
-(void)openDrawerWithRight;
//关闭抽屉
-(void)closeDrawerWithLeftAndRight;
//获取抽屉打开的状态
-(BOOL)drawerIsOpenState;
/***********************************************************************************************/


//设置背景
-(void)setBackgroundImage:(UIImage *)image;
@end
/*******************************************************************************************/
/****************************************抽屉协议（实现该协议便能拥有抽屉）********************************************/
//抽屉自控制器的协议 要在自控制器实现synthesize
@protocol DrawerChildViewController <NSObject>
@required
@property(nonatomic,weak) DrawerViewController * drawer;
@end


@protocol DrawerViewDelegate <NSObject>
@property(nonatomic,assign)id <DrawerViewDelegate> delegate;
@optional

//抽屉即将打开、已经打开
-(void)Drawer:(DrawerViewController *)drawer RightViewWilldOpen:(UIViewController *)rightViewController;
-(void)Drawer:(DrawerViewController *)drawer RightViewDidOpen:(UIViewController *)rightViewController;
-(void)Drawer:(DrawerViewController *)drawer RightViewWillClose:(UIViewController *)rightViewController;
-(void)Drawer:(DrawerViewController *)drawer RightViewDidClose:(UIViewController *)rightViewController;

-(void)Drawer:(DrawerViewController *)drawer LeftViewWilldOpen:(UIViewController *)leftViewController;
-(void)Drawer:(DrawerViewController *)drawer LeftViewDidOpen:(UIViewController *)leftViewController;
-(void)Drawer:(DrawerViewController *)drawer LeftViewWillClose:(UIViewController *)leftViewController;
-(void)Drawer:(DrawerViewController *)drawer LeftViewDidClose:(UIViewController *)leftViewController;

@end
/********************************************************************************************/