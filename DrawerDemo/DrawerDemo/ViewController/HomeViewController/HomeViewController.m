//
//  HomeViewController.m
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/10.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize drawer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openLeftDrawer{
    [self.drawer openDrawerWithLeft];
}
-(void)openRightDrawer{
    [self.drawer openDrawerWithRight];
}
-(void)closeDrawer{
    [self.drawer closeDrawerWithLeftAndRight];
}
-(BOOL)drawerIsOpen{
    return self.drawer.isOpen;
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
