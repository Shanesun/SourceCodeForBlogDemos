//
//  ViewController.m
//  TestThread
//
//  Created by Shane on 2018/12/26.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_sync(dispatch_queue_create("1111", DISPATCH_QUEUE_SERIAL), ^{
        NSLog(@"1111");
    });
    
    NSLog(@"222");
    
//    [self func2];
}

//异步派遣+串行队列
- (void)func2{

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1111");
    });
    NSLog(@"22222");
}



@end
