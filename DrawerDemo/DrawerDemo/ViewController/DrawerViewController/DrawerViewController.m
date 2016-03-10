//
//  DrawerViewController.m
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/9.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "DrawerViewController.h"
/**
 *  抽屉打开和关闭动画持续时间
 */
#define ANIMATION_DURATION 0.5
/**
 *  抽屉打开时主视图的缩放比例
 */
#define OPEN_SCALE 0.8
/**
 *  left抽屉打开时主视图 X的值
 */
#define LEFT_OPEN_X self.rootViewController.view.center.x+self.leftDrawerWidth - self.rootViewController.view.bounds.size.width*(1-OPEN_SCALE)/2
/**
 *  right抽屉打开是主视图 X的值
 */
#define RIGHT_OPEN_X self.rootViewController.view.center.x-self.rightDrawerWidth + self.rootViewController.view.bounds.size.width*(1-OPEN_SCALE)/2
/**
 *  抽屉打开时主视图 Y的值
 */
#define MIDDLE_CENTER_Y self.rootViewController.view.center.y
typedef enum{
    LEFT_OPEN,
    RIGHT_OPEN
}DrawerOpenType;
@interface DrawerViewController ()
@property(nonatomic,strong)UIViewController * rootViewController;
@property(nonatomic,strong)UIImageView * bgView;
@end

@implementation DrawerViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setLeftAndRightDrawerWidth];
    }
    return self;
}
#pragma mark ---
#pragma mark ---初始化middle的视图
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super init]) {
        //设置根视图
        [self setRootViewController:rootViewController];
    }
    return self;
}
#pragma mark ---
#pragma mark ---初始化left、middle、right的视图
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController LeftViewController:(UIViewController *)leftViewController RightViewController:(UIViewController *)rightViewController{
    if (self = [super init]) {
        [self setLeftViewController:leftViewController];
        [self setRightViewController:rightViewController];
        [self setRootViewController:rootViewController];
    }
    return self;
}
#pragma mark ---
#pragma mark ---设置根视图
-(void)setRootViewController:(UIViewController *)rootViewController{
    if (_rootViewController != rootViewController) {
        _rootViewController = rootViewController;
        if ([rootViewController respondsToSelector:@selector(setDrawer:)]) {
            [rootViewController performSelector:@selector(setDrawer:) withObject:self];
        }
        [self.view addSubview:rootViewController.view];
        rootViewController.view.frame = self.view.bounds;
    }
}
#pragma mark ---
#pragma mark ---设置左侧抽屉
-(void)setLeftViewController:(UIViewController *)leftViewController{
    if (_leftViewController != leftViewController) {
        _leftViewController = leftViewController;
        if ([leftViewController respondsToSelector:@selector(setDrawer:)]) {
            [leftViewController performSelector:@selector(setDrawer:) withObject:self];
        }
        [self.view addSubview:leftViewController.view];
        CGRect frame = leftViewController.view.frame;
        frame.origin.x = - frame.size.width;
        frame.origin.y = 0;
        leftViewController.view.frame = frame;
    }
}
#pragma mark ---
#pragma mark ---设置右边抽屉
-(void)setRightViewController:(UIViewController *)rightViewController{
    if (_rightViewController != rightViewController) {
        _rightViewController = rightViewController;
        if ([rightViewController respondsToSelector:@selector(setDrawer:)]) {
            [rightViewController performSelector:@selector(setDrawer:) withObject:self];
        }
        [self.view addSubview:rightViewController.view];
        CGRect frame = rightViewController.view.frame;
        frame.origin.x = self.view.bounds.size.width;
        frame.origin.y = 0;
        rightViewController.view.frame = frame;
    }
}
#pragma mark ---
#pragma mark ---打开左边抽屉
-(void)openDrawerWithLeft{
    if (self.isOpen) {
        [self closeDrawerWithLeftAndRight];
    }else{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            self.rootViewController.view.center = CGPointMake(LEFT_OPEN_X, MIDDLE_CENTER_Y);
            self.rootViewController.view.transform = CGAffineTransformMakeScale([self setDrawerScale], [self setDrawerScale]);
            self.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
        }];
    }
    self.isOpen = !self.isOpen;
}
#pragma mark ---
#pragma mark ---打开右边抽屉
-(void)openDrawerWithRight{
    if (self.isOpen) {
        [self closeDrawerWithLeftAndRight];
    }else{
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            self.rootViewController.view.center = CGPointMake(RIGHT_OPEN_X, MIDDLE_CENTER_Y);
            self.rootViewController.view.transform = CGAffineTransformMakeScale([self setDrawerScale], [self setDrawerScale]);
            self.rightViewController.view.frame = CGRectMake(self.view.bounds.size.width - self.rightDrawerWidth, 0, self.rightViewController.view.bounds.size.width, self.rightViewController.view.bounds.size.height);
        }];
    }
    self.isOpen = !self.isOpen;
}
#pragma mark ---
#pragma mark ---关闭抽屉
-(void)closeDrawerWithLeftAndRight{
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        self.rootViewController.view.center = self.view.center;
        self.leftViewController.view.frame = CGRectMake(- self.leftViewController.view.bounds.size.width, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
        self.rightViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.rightViewController.view.bounds.size.width, self.rightViewController.view.bounds.size.height);
    }];
}
#pragma mark ---
#pragma mark ---设置背景
//设置背景
-(void)setBackgroundImage:(UIImage *)image{
    self.bgView.image = image;
}
#pragma mark ---
#pragma mark ---设置缩放系数(0-1)
-(float)setDrawerScale{
    if (self.scale == 0 || self.scale > 1 || self.scale < 0) {
        return 1.0;
    }else{
        return self.scale;
    }
}
#pragma mark ---
#pragma mark ---设置左右的抽屉的宽度
-(void)setLeftAndRightDrawerWidth{
    if ((int)self.leftDrawerWidth == 0) {
        self.leftDrawerWidth = 150;
    }
    if ((int)self.rightDrawerWidth == 0) {
        self.rightDrawerWidth = 150;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:self.bgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
