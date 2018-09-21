//
//  TaskBean.m
//  xiaoyuxiaoyuDylib
//
//  Created by luck on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "TaskBean.h"

@implementation TaskBean

/*
 @property(strong, nonatomic) NSString *checkFirst; // @synthesize checkFirst=_checkFirst;
 @property(strong, nonatomic) NSString *timeInterval; // @synthesize timeInterval=_timeInterval;
 @property(strong, nonatomic) NSString *lastOpen; // @synthesize lastOpen=_lastOpen;
 @property(strong, nonatomic) NSString *openTime; // @synthesize openTime=_openTime;
 @property(strong, nonatomic) NSString *isFirst; // @synthesize isFirst=_isFirst;
 @property(strong, nonatomic) NSString *trialTime; // @synthesize trialTime=_trialTime;
 @property(strong, nonatomic) NSString *expiredAt; // @synthesize expiredAt=_expiredAt;
 @property(strong, nonatomic) NSString *bundleId; // @synthesize bundleId=_bundleId;
 @property(strong, nonatomic) NSString *displayName; // @synthesize displayName=_displayName;

 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.checkFirst = [aDecoder decodeObjectForKey:@"checkFirst"];
        self.timeInterval = [aDecoder decodeObjectForKey:@"timeInterval"];
        self.lastOpen = [aDecoder decodeObjectForKey:@"lastOpen"];
        self.openTime = [aDecoder decodeObjectForKey:@"openTime"];
        self.isFirst = [aDecoder decodeObjectForKey:@"isFirst"];
        self.trialTime = [aDecoder decodeObjectForKey:@"trialTime"];
        self.expiredAt = [aDecoder decodeObjectForKey:@"expiredAt"];
        self.bundleId = [aDecoder decodeObjectForKey:@"bundleId"];
        self.displayName = [aDecoder decodeObjectForKey:@"displayName"];
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.checkFirst forKey:@"checkFirst"];
    [aCoder encodeObject:self.timeInterval forKey:@"timeInterval"];
    [aCoder encodeObject:self.lastOpen forKey:@"lastOpen"];
    [aCoder encodeObject:self.openTime forKey:@"openTime"];
    [aCoder encodeObject:self.isFirst forKey:@"isFirst"];
    [aCoder encodeObject:self.trialTime forKey:@"trialTime"];
    [aCoder encodeObject:self.expiredAt forKey:@"expiredAt"];
    [aCoder encodeObject:self.bundleId forKey:@"bundleId"];
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
}
@end
