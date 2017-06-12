//
//  ReactNativeViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "ReactNativeViewController.h"
#import "RNSington.h"
@interface ReactNativeViewController ()

@end

@implementation ReactNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [RNSington sharedReactNative].reactVC = self;
//    NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:_urlSource withExtension:@"jsbundle"];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:_moduleName
                                                 initialProperties:nil
                                                     launchOptions:nil];
//    NSString * strUrl = @"http://172.16.40.101:8081/index.ios.bundle?platform=ios&dev=true";
//    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
//    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                         moduleName:@"Sxbapp"
//                                                  initialProperties:nil
//                                                      launchOptions:nil];
    rootView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:rootView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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
