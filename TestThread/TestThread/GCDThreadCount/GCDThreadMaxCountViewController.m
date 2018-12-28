//
//  GCDThreadMaxCountViewController.m
//  TestThread
//
//  Created by Shane on 2018/12/26.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "GCDThreadMaxCountViewController.h"

@interface GCDThreadMaxCountViewController ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation GCDThreadMaxCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testGCDMaxThreadCount];
}

- (void)testGCDMaxThreadCount {
    self.queue = dispatch_queue_create("x.x.x", DISPATCH_QUEUE_CONCURRENT);
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 10000; ++i) {
        // GCD 线程池 最多64个。
        dispatch_async(self.queue, ^{
            NSLog(@"===执行任务%d, 线程:%@", i, [NSThread currentThread]);
            if (i == 9999) {
                sleep(4000);
                NSLog(@"总耗时: %f ms", (CFAbsoluteTimeGetCurrent() - startTime) *1000.0);
            }
        });
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
