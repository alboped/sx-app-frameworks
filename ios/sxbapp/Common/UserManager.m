//
//  UserManager.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "UserManager.h"

static UserInfo *_userInfo = nil;

@implementation UserManager


+ (instancetype)sharedUserManager
{
    static UserManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[UserManager alloc] init];
        _userInfo = [_manager userInfo];
    });
    return _manager;
}
-(NSString *)userFilePath
{
    NSString *path  =[DocumentDrictoryPath stringByAppendingPathComponent:@"user.plist"];
    return path;
}
- (void)saveUserInfo:(UserInfo *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:[self userFilePath]];
    _userInfo = [self userInfo];
}
- (UserInfo *)userInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self userFilePath]];
}
- (UserInfo *)user
{
    return _userInfo;
}
-(NSString*)userToken
{
    return _userInfo.token;
}
- (void)logOut
{
    _userInfo = nil;
    [[NSFileManager defaultManager] removeItemAtPath:[self userFilePath] error:nil];
}

@end
