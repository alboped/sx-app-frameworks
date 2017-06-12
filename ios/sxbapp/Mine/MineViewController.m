//
//  MineViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "MineViewController.h"
#import "ReactNativeViewController.h"
#import "WebViewController.h"
#import "LogInViewController.h"
#import "AppDelegate.h"
@interface MineViewController ()
@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) UIButton *webButton;
@property (nonatomic, strong) UIButton *logOutBtn;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.leftButton.hidden = YES;

    _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _testBtn.backgroundColor = [UIColor redColor];
    _testBtn.frame = CGRectMake(20, 120, 260, 40);
    [_testBtn setTitle:@"测试RN" forState:UIControlStateNormal];
    _testBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _testBtn.titleLabel.textColor = [UIColor whiteColor];
    [_testBtn addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testBtn];
    
    
    _webButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _webButton.backgroundColor = [UIColor redColor];
    _webButton.frame = CGRectMake(20, 210, 260, 40);
    [_webButton setTitle:@"测试WEB" forState:UIControlStateNormal];
    _webButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _webButton.titleLabel.textColor = [UIColor whiteColor];
    [_webButton addTarget:self action:@selector(webBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_webButton];

    _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logOutBtn.backgroundColor = [UIColor redColor];
    _logOutBtn.frame = CGRectMake(20, 270, 260, 40);
    [_logOutBtn setTitle:@"退 出 登 录" forState:UIControlStateNormal];
    _logOutBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _logOutBtn.titleLabel.textColor = [UIColor whiteColor];
    [_logOutBtn addTarget:self action:@selector(logOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logOutBtn];
}
- (void)testBtnClick
{
    ReactNativeViewController *rnVC = [[ReactNativeViewController alloc] init];
    rnVC.urlSource = @"index.ios";
    rnVC.moduleName = @"Sxbapp";
    [self.navigationController pushViewController:rnVC animated:YES];
}
- (void)webBtnClick
{
    WebViewController *rnVC = [[WebViewController alloc] init];
    rnVC.linkUrl= @"https://www.baidu.com/";
    [self.navigationController pushViewController:rnVC animated:YES];
}
- (void)logOutBtnClick
{
    [[UserManager sharedUserManager] logOut];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = [[LogInViewController alloc] init];
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
