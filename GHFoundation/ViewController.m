//
//  ViewController.m
//  GHFoundation
//
//  Created by Rong on 2017/10/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"汉字";
    BOOL flag = [str gh_isChinese];
    NSLog(@"%d",flag);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
