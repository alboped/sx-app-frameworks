//
//  HomeViewController.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/2.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "GirdMenuView.h"
#import "WebViewController.h"
#import "ReactNativeViewController.h"
@interface HomeViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *bottomScrollView;
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, strong) GirdMenuView *girdMenuView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.leftButton.hidden = YES;
    //顶部轮播图
    [self addCarouselFigure];
    //底部scrollView
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - _headerView.bottom - 49)];
    _bottomScrollView.backgroundColor = [UIColor grayColor];
    _bottomScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_bottomScrollView];
    [self addGirdMenu];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)addCarouselFigure
{
    
    _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_WIDTH * 0.4) delegate:self placeholderImage:nil];
    _headerView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496664493003&di=5adf6c03fa2b446e48bca29344e07b32&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D2369900843%2C1093290712%26fm%3D214%26gp%3D0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496664492408&di=13d4992c91d1f59e11fc46e72f8e78a2&imgtype=0&src=http%3A%2F%2Fpic.jschina.com.cn%2F0%2F21%2F38%2F92%2F21389202_143444.png",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496664492408&di=8f02ae42f8a2ed1c074660374ecfd228&imgtype=0&src=http%3A%2F%2Fupload.art.ifeng.com%2F2015%2F0811%2F1439260959533.jpg"];
    _headerView.autoScrollTimeInterval = 3.0;
    _headerView.delegate = self;
    _headerView.pageControlDotSize = CGSizeMake(-5, -5);
    _headerView.pageDotColor = [UIColor grayColor];
    _headerView.currentPageDotColor = [UIColor whiteColor];
    _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self.view addSubview:_headerView];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"====%ld",index);
}
- (void)addGirdMenu
{
    NSArray *dataArr = @[
                         @{
                             @"title": @"商户",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"查询",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"消息",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"维护",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"支付宝",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"微信",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"},
                         @{
                             @"title": @"更多",
                             @"icon": @"TabBar_Assets_Sel",
                             @"type": @"web",
                             @"url": @"https://www.baidu.com",
                             @"platm": @"ios"}
                         ];
    _girdMenuView = [[GirdMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    [_girdMenuView.menuArray addObjectsFromArray:dataArr];
    __weak typeof(self) weakSelf = self;
    _girdMenuView.menuClickBlock = ^(NSDictionary *menuDic){
        [weakSelf pushTypeCotroller:menuDic];
    };
    [_bottomScrollView addSubview:_girdMenuView];
}
- (void)pushTypeCotroller:(NSDictionary *)dic
{
    if ([dic[@"type"] isEqualToString:@"web"]) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.linkUrl = dic[@"url"];
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([dic[@"type"] isEqualToString:@"rn"]){
        ReactNativeViewController *reactVC = [[ReactNativeViewController alloc] init];
        reactVC.urlSource = @"";
        reactVC.moduleName = @"";
        [self.navigationController pushViewController:reactVC animated:YES];
    }
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
