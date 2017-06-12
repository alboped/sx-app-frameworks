//
//  GirdMenuCell.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/6.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "GirdMenuCell.h"

#define TopSpace 5
#define ImageWidth 30
#define LeftSpace (SCREEN_WIDTH/ 4.0  - ImageWidth) / 2.0
#define LabelWidth SCREEN_WIDTH/ 4.0
#define LabelHeight 20
@implementation GirdMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addMenuCell];
    }
    return self;
}
- (void)addMenuCell
{
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(LeftSpace, TopSpace, ImageWidth, ImageWidth)];
    [self addSubview:_iconView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconView.bottom, LabelWidth, LabelHeight)];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
}
- (void)menuData:(NSDictionary *)menuDic
{
    _iconView.image = [UIImage imageNamed:menuDic[@"icon"]];
    _titleLabel.text = menuDic[@"title"];
}
@end
