//
//  BasicViewController.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *rightButton;
- (void)leftButtonClick;

@end
