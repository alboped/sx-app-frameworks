//
//  LogInViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"
#import "BasicTabBarController.h"
#define DistanceLeft (SCREEN_WIDTH - 260) / 2.0

@interface LogInViewController ()

@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UITextField *keyField;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self addUIView];
}
- (void)addUIView
{
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(DistanceLeft, (self.view.frame.size.height - 160) / 2.0, 60, 40)];
    _accountLabel.text = @"账号";
    _accountLabel.textColor = [UIColor blackColor];
    _accountLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_accountLabel];
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(_accountLabel.right, _accountLabel.top, 200, 40)];
    _accountField.placeholder = @"请输入登陆账号";
    _accountField.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
    _accountField.layer.borderWidth= 0.6f;
    _accountField.layer.cornerRadius = 3.0f;
    _accountField.textColor = [UIColor blackColor];
    _accountField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_accountField];
    
    _keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(DistanceLeft, _accountLabel.bottom + 20, 60, 40)];
    _keyLabel.text = @"密码";
    _keyLabel.textColor = [UIColor blackColor];
    _keyLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_keyLabel];
    _keyField = [[UITextField alloc] initWithFrame:CGRectMake(_keyLabel.right, _keyLabel.top, 200, 40)];
    _keyField.placeholder = @"请输入登陆密码";
    _keyField.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
    _keyField.layer.borderWidth= 0.6f;
    _keyField.layer.cornerRadius = 3.0f;
    _keyField.textColor = [UIColor blackColor];
    _keyField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_keyField];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = [UIColor redColor];
    _loginBtn.frame = CGRectMake(DistanceLeft, _keyField.bottom + 20, 260, 40);
    [_loginBtn setTitle:@"登  陆" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}


- (void)loginClick
{
    NSString *url = [NetworkingManager urlWithURLType:URLTYPE_USERLOGIN];
    NSDictionary *data = @{
                           @"username": @"T110665",
                           @"password": @"123456"
                           };
    [NetworkingManager getWithURL:url params:data success:^(id obj) {
        NSLog(@"成功");
        UserInfo *user = [[UserInfo alloc] initWithAttributes:obj];
        [[UserManager sharedUserManager] saveUserInfo:user];
        //登录成功
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = [[BasicTabBarController alloc] init];
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    
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
