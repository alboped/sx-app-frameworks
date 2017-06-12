//
//  WebViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWebView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)addWebView
{
    self.titleLabel.text = @"网页";
    self.navigationItem.titleView = self.titleLabel;
    [self.rightButton setTitle:@"关闭" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.rightButton addTarget:self action:@selector(cloceClick) forControlEvents:UIControlEventTouchUpInside];
    //传参数
    NSDictionary *bodyData = @{
                               @"token": [[UserManager sharedUserManager] userToken]
                               };
    NSString *jsonData = [CommonUtility dicOrArrayToJson:bodyData];
    NSString *json = [NSString stringWithFormat:@"json=%@",jsonData];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:_linkUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0f];
    [request setHTTPBody:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    //创建webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.titleLabel.text = title;
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"++++++++++++++++++");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"------------------");

}
- (void)leftButtonClick
{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)cloceClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
