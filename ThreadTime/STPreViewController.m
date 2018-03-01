//
//  STPreViewController.m
//  test
//
//  Created by 孫 濤 on 2018/3/1.
//  Copyright © 2018年 me.suntao All rights reserved.
//

#import "STPreViewController.h"
#import "STThreadCreationViewController.h"

@interface STPreViewController ()

@property (weak, nonatomic) IBOutlet UITextField *threadCountTextField;
@end

@implementation STPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    STThreadCreationViewController *vc = segue.destinationViewController;
    vc.threadCount = self.threadCountTextField.text.integerValue;
}

@end
