//
//  ViewController.m
//  test
//
//  Created by 孫 濤 on 2016/11/10.
//  Copyright © 2016年 me.suntao All rights reserved.
//

#import "STThreadCreationViewController.h"
#include <objc/message.h>
#import "STThreadTimeTool.h"

@interface STThreadCreationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tctLabel;

@end

@implementation STThreadCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    STThreadTimeModel *timeModel = [STThreadTimeTool computeThreadCreationTimeWithThreadCount:self.threadCount];
    self.timeLabel.text = [NSString stringWithFormat:@"Average Thread Time: %llu μsec\nTotal Thread Time: %.3f sec", timeModel.averageTime + timeModel.averageExecTime, (timeModel.averageTime + timeModel.averageExecTime)*self.threadCount/1000000.0];
    self.tctLabel.text = [NSString stringWithFormat:@"Average Creation: %llu μsec\nAverage Execution: %llu µsec\nMin Exec: %llu\nMax Exec: %llu", timeModel.averageTime, timeModel.averageExecTime, timeModel.minExecTime, timeModel.maxExecTime];
}

@end
