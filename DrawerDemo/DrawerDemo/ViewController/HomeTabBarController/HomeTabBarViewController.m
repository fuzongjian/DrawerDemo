//
//  HomeTabBarViewController.m
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/9.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "HomeTabBarViewController.h"
#import "SuperNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface HomeTabBarViewController ()<DrawerViewDelegate>

@end

@implementation HomeTabBarViewController
@synthesize drawer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTabBarViewControllerUI];
}
-(void)configTabBarViewControllerUI{
    
    FirstViewController * firstView = [[FirstViewController alloc] init];
    SuperNavigationController * first = [[SuperNavigationController alloc] initWithRootViewController:firstView];
    first.tabBarItem = [self createName:@"first" withImage:@"available" withSelectImg:@"available-hl"];
    
    SecondViewController * secondView = [[SecondViewController alloc] init];
    SuperNavigationController * second = [[SuperNavigationController alloc] initWithRootViewController:secondView];
    second.tabBarItem = [self createName:@"second" withImage:@"history" withSelectImg:@"history-hl"];
    
    ThirdViewController * thirdView = [[ThirdViewController alloc] init];
    SuperNavigationController * third = [[SuperNavigationController alloc] initWithRootViewController:thirdView];
    third.tabBarItem = [self createName:@"third" withImage:@"going" withSelectImg:@"going-hl"];
    self.viewControllers = @[first,second,third];
    self.tabBar.tintColor = [UIColor redColor];
}
-(UITabBarItem *)createName:(NSString *)name withImage:(NSString *)iName withSelectImg:(NSString *)sename{
    
    return [[UITabBarItem alloc]initWithTitle:name image:[[UIImage imageNamed:iName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:sename] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
-(void)closeDrawer{
    [self.drawer closeDrawerWithLeftAndRight];
}
-(void)openLeftDrawer{
    [self.drawer openDrawerWithLeft];
}
-(void)openRightDrawer{
    [self.drawer openDrawerWithRight];
}
-(BOOL)drawerIsOpen{
    return self.drawer.isOpen;
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
