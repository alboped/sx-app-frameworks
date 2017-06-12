//
//  UserInfo.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/5.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.token = StringValue([attributes valueForKeyPath:@"token"]);
    self.loginName = StringValue([attributes valueForKeyPath:@"loginName"]);
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.token = [aDecoder decodeObjectForKey:@"token"];
    self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
}
-(void)dealloc
{
    self.token = nil;
    self.loginName = nil;
}

@end
