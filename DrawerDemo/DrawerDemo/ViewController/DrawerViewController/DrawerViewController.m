//
//  DrawerViewController.m
//  DrawerDemo
//
//  Created by fdkj0002 on 16/3/9.
//  Copyright © 2016年 FZJ.com. All rights reserved.
//

#import "DrawerViewController.h"
/**
 *  抽屉打开时主视图 Y的值
 */
#define MIDDLE_CENTER_Y self.rootViewController.view.center.y
/**
 *  抽屉打开的状态记录
 */
typedef enum{
    LEFT_OPEN,
    RIGHT_OPEN,
    DRAWER_CLOSE
}DrawerOpenType;
@interface DrawerViewController ()
@property(nonatomic,strong)UIViewController * rootViewController;
@property(nonatomic,strong)UIImageView * bgView;
@property(nonatomic,assign)DrawerOpenType OPEN_TYPE;
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
    //左边抽屉打开时要执行的动作
    __typeof (self) __weak weakSelf = self;
    void (^startAnimationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf)return ;
        strongSelf.rootViewController.view.center = CGPointMake([self set_LEFT_OPEN_X], MIDDLE_CENTER_Y);
        strongSelf.rootViewController.view.transform = CGAffineTransformMakeScale([self setDrawerScale], [self setDrawerScale]);
        strongSelf.leftViewController.view.frame = CGRectMake(0, 0, self.leftViewController.view.bounds.size.width, self.leftViewController.view.bounds.size.height);
        if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:LeftViewWilldOpen:)]) {
            [strongSelf.delegate Drawer:strongSelf LeftViewWilldOpen:strongSelf.leftViewController];
        }
    };
    //动画执行完成后将信息传递给代理
    void(^completionAnimationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf)return ;
        if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:LeftViewDidOpen:)]) {
            [strongSelf.delegate Drawer:strongSelf LeftViewDidOpen:strongSelf.leftViewController];
        }
        self.OPEN_TYPE = LEFT_OPEN;
        self.isOpen = !self.isOpen;
    };
    
    if (self.isOpen) {
        [self closeDrawerWithLeftAndRight];
    }else{
        [UIView animateWithDuration:[self setCustomAnimationDuration] animations:^{
            startAnimationBlock();
        } completion:^(BOOL finished) {
            completionAnimationBlock();
        }];
    }
}
#pragma mark ---
#pragma mark ---打开右边抽屉
-(void)openDrawerWithRight{
    //右边抽屉打开时要执行的动作
    __typeof (self) __weak weakSelf = self;
    void (^startAnimationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf)return ;
        strongSelf.rootViewController.view.center = CGPointMake([self set_RIGHT_OPEN_X], MIDDLE_CENTER_Y);
        strongSelf.rootViewController.view.transform = CGAffineTransformMakeScale([strongSelf setDrawerScale], [strongSelf setDrawerScale]);
        strongSelf.rightViewController.view.frame = CGRectMake(strongSelf.view.bounds.size.width - strongSelf.rightDrawerWidth, 0, strongSelf.rightViewController.view.bounds.size.width, strongSelf.rightViewController.view.bounds.size.height);
        if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:RightViewWilldOpen:)]) {
            [strongSelf.delegate Drawer:strongSelf RightViewWilldOpen:strongSelf.rightViewController];
        }
    };
    //动画执行完成后将信息传递给代理
    void(^completionAnimationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if(!strongSelf)return ;
        if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:RightViewDidOpen:)]) {
            [strongSelf.delegate Drawer:strongSelf RightViewDidOpen:strongSelf.rightViewController];
        }
        self.OPEN_TYPE = RIGHT_OPEN;
        self.isOpen = !self.isOpen;
    };
    
    
    if (self.isOpen) {
        [self closeDrawerWithLeftAndRight];
    }else{
        [UIView animateWithDuration:[self setCustomAnimationDuration] animations:^{
            startAnimationBlock();
        } completion:^(BOOL finished) {
            completionAnimationBlock();
        }];
    }
    
}
#pragma mark ---
#pragma mark ---关闭抽屉
-(void)closeDrawerWithLeftAndRight{
    __typeof (self) __weak weakSelf = self;
    //关闭抽屉时执行的动作
    void (^startAnimationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf)return ;
        strongSelf.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        strongSelf.rootViewController.view.center = strongSelf.view.center;
        switch (weakSelf.OPEN_TYPE) {
            case RIGHT_OPEN:
                strongSelf.rightViewController.view.frame = CGRectMake(strongSelf.view.bounds.size.width, 0, strongSelf.rightViewController.view.bounds.size.width, strongSelf.rightViewController.view.bounds.size.height);
                if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:RightViewWillClose:)]) {
                    [strongSelf.delegate Drawer:strongSelf RightViewWillClose:strongSelf.rightViewController];
                }
                break;
            case LEFT_OPEN:
                strongSelf.leftViewController.view.frame = CGRectMake(- strongSelf.leftViewController.view.bounds.size.width, 0, strongSelf.leftViewController.view.bounds.size.width, strongSelf.leftViewController.view.bounds.size.height);
                if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:LeftViewWillClose:)]) {
                    [strongSelf.delegate Drawer:strongSelf LeftViewWillClose:strongSelf.leftViewController];
                }
                break;
            default:
                break;
        }
    };
    //动作执行完成后将信息传递给代理
    void(^completionAnimationBlock)(void) =^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf)return ;
        switch (strongSelf.OPEN_TYPE) {
            case LEFT_OPEN:
                if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:LeftViewDidClose:)]) {
                    [strongSelf.delegate Drawer:strongSelf RightViewDidClose:strongSelf.leftViewController];
                }
                break;
            case RIGHT_OPEN:
                if ([strongSelf.delegate conformsToProtocol:@protocol(DrawerViewDelegate)] && [strongSelf.delegate respondsToSelector:@selector(Drawer:RightViewDidClose:)]) {
                    [strongSelf.delegate Drawer:strongSelf RightViewDidClose:strongSelf.rightViewController];
                }
                break;
            default:
                break;
        }
        strongSelf.OPEN_TYPE = DRAWER_CLOSE;
        
    };
    [UIView animateWithDuration:[self setCustomAnimationDuration] animations:^{
        startAnimationBlock();
    } completion:^(BOOL finished) {
        completionAnimationBlock();
    }];
    self.isOpen = NO;
}
#pragma mark ---
#pragma mark ---获取抽屉打开的状态
-(BOOL)drawerIsOpenState{
    return self.isOpen;
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
#pragma mark ---
#pragma mark ---动画执行的时间
-(CGFloat)setCustomAnimationDuration{
    if (self.animationDuration == 0) {
        return 0.5;
    }else{
        return self.animationDuration;
    }
}
#pragma mark ---
#pragma mark ---left抽屉打开时主视图 X的值
-(CGFloat)set_LEFT_OPEN_X{
    return self.rootViewController.view.center.x+self.leftDrawerWidth - self.rootViewController.view.bounds.size.width*(1-[self setDrawerScale])/2;
}
#pragma mark ---
#pragma mark ---right抽屉打开是主视图 X的值
-(CGFloat)set_RIGHT_OPEN_X{
    return self.rootViewController.view.center.x-self.rightDrawerWidth + self.rootViewController.view.bounds.size.width*(1-[self setDrawerScale])/2;
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
