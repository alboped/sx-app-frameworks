//
//  UserManager.h
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface UserManager : NSObject

+ (instancetype)sharedUserManager;
- (void)saveUserInfo:(UserInfo *)userInfo;
- (UserInfo *)user;
- (NSString*)userToken;
- (void)logOut;

@end
