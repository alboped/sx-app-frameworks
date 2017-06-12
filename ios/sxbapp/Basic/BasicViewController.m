//
//  BasicViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:5]} forState:UIControlStateNormal];
    
    //左边返回按钮
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, 0, 40, 44);
    [_leftButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    //解决ios7leftBarButtonItem 偏移问题
    UIBarButtonItem *negativeSpacerLeft = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacerLeft.width = -10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacerLeft, leftItem];
    //中间标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 44)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    self.navigationItem.titleView = _titleLabel;
    
    //右边按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 40, 44);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacerRight.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacerRight, rightItem];
}
- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    self.titleLabel = nil;
    self.rightButton = nil;
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
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
