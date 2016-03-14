//
//  SuperViewController.m
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/8.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController
@synthesize drawer;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSuperViewControllerUI];
}
-(void)configSuperViewControllerUI{
    UIButton * leftIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    leftIcon.frame = CGRectMake(0, 0, 45, 45);
    [leftIcon setBackgroundImage:[UIImage imageNamed:@"medical5c"] forState:UIControlStateNormal];
    [leftIcon addTarget:self action:@selector(leftIconBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftIcon];
    
    UIButton * rightIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    rightIcon.frame = CGRectMake(0, 0, 45, 45);
    [rightIcon setBackgroundImage:[UIImage imageNamed:@"medical4c"] forState:UIControlStateNormal];
    [rightIcon addTarget:self action:@selector(rightIconBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightIcon];
    
}
#pragma mark ---
#pragma mark --- 消除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
-(void)leftIconBtnClicked{
    if (self.navigationController && self.navigationController.tabBarController) {
        if ([self.navigationController.tabBarController respondsToSelector:@selector(openLeftDrawer)]) {
            [self.navigationController.tabBarController performSelector:@selector(openLeftDrawer)];
        }
    }
}
-(void)rightIconBtnClicked{
    if (self.navigationController && self.navigationController.tabBarController) {
        if ([self.navigationController.tabBarController respondsToSelector:@selector(openRightDrawer)]) {
            [self.navigationController.tabBarController performSelector:@selector(openRightDrawer)];
        }
    }
}
-(void)setCustomTitle:(NSString *)title TitleFont:(CGFloat)fontSize TitleColor:(UIColor *)color{
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    lable.text = title;
    lable.font = [UIFont systemFontOfSize:fontSize];
    lable.textColor = color;
    lable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lable;
}
-(void)setCustomLRImage:(UIImage *)image ImageSize:(CGSize)size WithLeftRight:(LRType)type{
    
}
-(void)setCustomLRTitle:(NSString *)title TitleFone:(CGFloat)fontSize TitleColor:(UIColor *)color withLeftRight:(LRType)type{
    
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
