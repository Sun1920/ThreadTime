//
//  STThreadTimeTool.h
//  ObjectTest
//
//  Created by 孫 濤 on 2018/3/1.
//  Copyright © 2018年 me.suntao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STThreadTimeModel : NSObject
@property (nonatomic, assign) uint64_t averageTime;
@property (nonatomic, assign) uint64_t averageExecTime;
@property (nonatomic, assign) uint64_t maxExecTime;
@property (nonatomic, assign) uint64_t minExecTime;
@end

@interface STThreadTimeTool : NSObject
+ (STThreadTimeModel *)computeThreadCreationTimeWithThreadCount:(NSUInteger)count;
@end
