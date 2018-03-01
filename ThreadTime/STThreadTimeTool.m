//
//  STThreadTimeTool.m
//  ObjectTest
//
//  Created by 孫 濤 on 2018/3/1.
//  Copyright © 2018年 me.suntao All rights reserved.
//

#import "STThreadTimeTool.h"
#import <mach/mach.h>

@implementation STThreadTimeModel

@end


@interface STCreationTime : NSObject

@property (nonatomic, assign) uint64_t start;
@property (nonatomic, assign) uint64_t enter;
@property (nonatomic, assign) uint64_t time;

@end

@implementation STCreationTime

@end


@interface STThreadTimeTool()

@property (nonatomic, strong) NSMutableArray *times;

@end

@implementation STThreadTimeTool

+ (STThreadTimeModel *)computeThreadCreationTimeWithThreadCount:(NSUInteger)count {
    return [[[STThreadTimeTool alloc] init] timeThreadCreationStart:count];
}

- (STThreadTimeModel *)timeThreadCreationStart:(NSUInteger)count {
    uint64_t average = [self timeThreadCreation:count];
    
    uint64_t total = 0;
    uint64_t averageExec = 0;
    uint64_t minExec = 0x7ffffff;
    uint64_t maxExec = 0;
    
    for(NSUInteger i = 0; i < count; i++) {
        STCreationTime *ct = (STCreationTime *)[self.times objectAtIndex:i];
        total += ct.time;
        maxExec = MAX(maxExec, ct.time);
        minExec = MIN(minExec, ct.time);
    }
    averageExec = total / count;
    STThreadTimeModel *model = [STThreadTimeModel new];
    model.averageTime = average;
    model.averageExecTime = averageExec;
    model.maxExecTime = maxExec;
    model.minExecTime = minExec;
    return model;
}

- (uint64_t)timeThreadCreation:(NSUInteger)count
{
    uint64_t start_64;
    uint64_t end_64;
    uint64_t time_64;
    uint64_t total_64 = 0;
    uint64_t average_64 = 0;
    
    NSMutableArray *threads = [[NSMutableArray alloc] initWithCapacity:count];
    self.times = [[NSMutableArray alloc] initWithCapacity:count];
    STCreationTime *ct;
    
    for(NSUInteger i = 0; i < count; i++) {
        
        ct = [[STCreationTime alloc] init];
        [self.times addObject:ct];
        
        start_64 = mach_absolute_time();
        NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(threadStartMethod:) object:ct];
        end_64 = mach_absolute_time();
        ct.start = mach_absolute_time();
        [t start];
        time_64 = [self nanosUsingStart:start_64 end:end_64];//end_64 - start_64;
        total_64 += time_64;
        [threads addObject:t];
        [NSThread sleepForTimeInterval:0.001];
    }
    
    average_64 = total_64 / count;
    
    return average_64;
}

- (void)threadStartMethod:(id)object
{
    uint64_t enter_64 = mach_absolute_time();
    STCreationTime *ct = (STCreationTime *)object;
    ct.enter = enter_64;
    ct.time = ct.enter - ct.start;
}

- (uint64_t)nanosUsingStart:(uint64_t)start end:(uint64_t)end {
    mach_timebase_info_data_t *info = [self timeBaseInfoData];
    
    uint64_t elapsed = end - start;
    uint64_t nanos = elapsed * info->numer / info->denom;
    return nanos;
}

- (mach_timebase_info_data_t *)timeBaseInfoData {
    static mach_timebase_info_data_t info;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        mach_timebase_info(&info);
    });
    return &info;
}

@end
