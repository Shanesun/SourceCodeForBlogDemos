//
//  ViewController.m
//  TestRunloop
//
//  Created by Shane on 2018/11/21.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadToDoSomething) object:nil];
    thread.name = @"test_thread_runloop";
    [thread start];
}

- (void)threadToDoSomething {
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [runloop run];
}


@end
