//
//  TaskBean.h
//  xiaoyuxiaoyuDylib
//
//  Created by luck on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskBean : NSObject<NSCoding>

@property(strong, nonatomic) NSString *checkFirst; // @synthesize checkFirst=_checkFirst;
@property(strong, nonatomic) NSString *timeInterval; // @synthesize timeInterval=_timeInterval;
@property(strong, nonatomic) NSString *lastOpen; // @synthesize lastOpen=_lastOpen;
@property(strong, nonatomic) NSString *openTime; // @synthesize openTime=_openTime;
@property(strong, nonatomic) NSString *isFirst; // @synthesize isFirst=_isFirst;
@property(strong, nonatomic) NSString *trialTime; // @synthesize trialTime=_trialTime;
@property(strong, nonatomic) NSString *expiredAt; // @synthesize expiredAt=_expiredAt;
@property(strong, nonatomic) NSString *bundleId; // @synthesize bundleId=_bundleId;
@property(strong, nonatomic) NSString *displayName; // @synthesize displayName=_displayName;


@end
