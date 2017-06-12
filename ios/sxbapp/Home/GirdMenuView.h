//
//  GirdMenuView.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/6.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GirdMenuView : UIView

@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, copy) void(^menuClickBlock)(NSDictionary *menuDic);

@end
