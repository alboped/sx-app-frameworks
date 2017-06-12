//
//  BasicTabBarController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "BasicTabBarController.h"
#import "HomeViewController.h"
#import "DataViewController.h"
#import "MoreViewController.h"
#import "MineViewController.h"
#import "BasicNavigationViewController.h"
@interface BasicTabBarController ()
{
    NSUInteger  lastSelectedIndex;
}
@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate=self;
    lastSelectedIndex=0;
    [self setupChildControllers];
}
- (void)setupChildControllers
{
    [self setupChildNavigationControllerWithClass:[BasicNavigationViewController class] tabBarImageName:@"TabBar_HomeBar" rootViewControllerClass:[HomeViewController class] rootViewControllerTitle:@"首页"];
    
    [self setupChildNavigationControllerWithClass:[BasicNavigationViewController class] tabBarImageName:@"TabBar_PublicService" rootViewControllerClass:[DataViewController class] rootViewControllerTitle:@"数据"];
    
    [self setupChildNavigationControllerWithClass:[BasicNavigationViewController class] tabBarImageName:@"TabBar_Discovery" rootViewControllerClass:[MoreViewController class] rootViewControllerTitle:@"更多"];
    
    [self setupChildNavigationControllerWithClass:[BasicNavigationViewController class] tabBarImageName:@"TabBar_Assets" rootViewControllerClass:[MineViewController class] rootViewControllerTitle:@"我的"];
    
}

- (void)setupChildNavigationControllerWithClass:(Class)class tabBarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass rootViewControllerTitle:(NSString *)title
{
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    rootVC.title = title;
    UINavigationController *navVc = [[class  alloc] initWithRootViewController:rootVC];
    navVc.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_Sel", name]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:navVc];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    if(tabBarController.selectedIndex==1 ||tabBarController.selectedIndex==2){
//        [[AlertCenter defaultCenter]postAlertWithMessage:@"暂未开通，敬请期待！"];
//        [tabBarController setSelectedIndex:lastSelectedIndex];
//    }
    
    lastSelectedIndex=tabBarController.selectedIndex;
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
