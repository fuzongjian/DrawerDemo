# DrawerDemo
抽屉的简单实用及其原理
20160310 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
self.window.backgroundColor = [UIColor whiteColor];
[self.window makeKeyAndVisible];
//设置根视图
DrawerViewController * drawer = [[DrawerViewController alloc] initWithRootViewController:[[HomeTabBarViewController alloc]init] LeftViewController:[[LeftViewController alloc] init] RightViewController:[[RightViewController alloc]init]];
drawer.leftDrawerWidth = 200;
drawer.scale = 0.8;
[drawer setBackgroundImage:[UIImage imageNamed:@"1-1"]];
self.window.rootViewController = drawer;
return YES;
}

DrawerViewController.h
//设置leftWidth 默认150
@property(nonatomic,assign)CGFloat leftDrawerWidth;
//设置rightWidth 默认150
@property(nonatomic,assign)CGFloat rightDrawerWidth;
//抽屉是否打开
@property(nonatomic,assign)BOOL isOpen;
//缩放比例,不设置的话默认是不缩放（0-1）
@property(nonatomic,assign)float scale;