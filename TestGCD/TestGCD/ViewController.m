//
//  ViewController.m
//  TestGCD
//
//  Created by Shane on 2018/12/10.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "ViewController.h"

#define MAX1(a,b) a > b ? a : b
static int MyConstant = 200;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    main2();
    main1();
    
    NSMutableArray *tmp1 = [NSMutableArray arrayWithObject:@"1"];
    
    NSArray * array = [NSArray arrayWithObject:tmp1];
    NSArray * copyArry = [array copy];
    
    tmp1[0] = @"2";
    
    NSLog(@"array:%p", array);
    NSLog(@"copyArry:%p", copyArry);
    
    [self func1];
    [self func2];
    [self func3];
    [self func4];
    
}



int main2() {
    int i = 200;
    printf("largest: %d\n", MAX1(i++,100));
    printf("i: %d\n", i);
    return 0;
}




static inline int maxt(int l, int r) {
    return l > r ? l : r;
}

int main1() {
    int i = MyConstant;
    printf("largest: %d\n", maxt(i++,100));
    printf("i: %d\n", i);
    return 0;
}
//同步派遣+串行队列
- (void)func1{
    dispatch_queue_t q = dispatch_queue_create("aaaaa", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(q, ^{
        NSLog(@"1111");
    });
    NSLog(@"22222");
}

//异步派遣+串行队列
- (void)func2{
    dispatch_queue_t q = dispatch_queue_create("bbbbbb", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        NSLog(@"1111");
    });
    NSLog(@"22222");
}

//同步派遣+并行队列
- (void)func3{
    dispatch_queue_t q = dispatch_queue_create("cccccc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(q, ^{
        NSLog(@"1111");
    });
    NSLog(@"22222");
}

//异步派遣+并行队列
- (void)func4{
    dispatch_queue_t q = dispatch_queue_create("ddddddd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        NSLog(@"1111");
    });
    NSLog(@"22222");
}

@end
