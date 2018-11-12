//
//  ViewController.m
//  ObjectMemeryDemo
//
//  Created by Shane on 2018/9/3.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *healArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tmp2];
}

- (void)tmp2 {
    NSArray *tmpArray = [NSArray new];
    
    self.healArray = [NSArray new];
    NSLog(@"%@",tmpArray);
}

- (void)tmp1 {
//    NSError *error;
//    BOOL OK = [myObject performOperationWithError:&error];
//    if (!OK) {
//        // Report the error.
//        // ...
//    }
}

@end
