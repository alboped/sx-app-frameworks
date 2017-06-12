//
//  RNCommonModule.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/6.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "RNCommonModule.h"
#import "RNSington.h"
@implementation RNCommonModule

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(closeView)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[RNSington sharedReactNative].reactVC.navigationController popViewControllerAnimated:YES];
    });
}

@end
