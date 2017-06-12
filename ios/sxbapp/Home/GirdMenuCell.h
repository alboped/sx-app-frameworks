//
//  GirdMenuCell.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/6.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GirdMenuCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
- (void)menuData:(NSDictionary *)menuDic;
@end
