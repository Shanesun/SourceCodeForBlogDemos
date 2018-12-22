//
//  AutoreleaseViewController.m
//  ObjectMemeryDemo
//
//  初步证明 autorelease 是在延迟对象释放
//  不能使用 不可变NSString 来做证明的例子，NSString有字符串驻留技术对其优化。
//
//  Created by Shane on 2018/12/22.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "AutoreleaseViewController.h"

@interface AutoreleaseViewController ()

@property (nonatomic, weak) NSObject *weakObject;

@end

@implementation AutoreleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 场景0 获取autorelease 对象
//     [self getAutoreleaseObject];
    
//    // 场景 1 strong对象
//    NSObject *object = [NSObject new];
//    self.weakObject = object;
    
    // 场景 2
//        @autoreleasepool {
//            NSObject *object = [NSObject new];
//            self.weakObject = object;
//        }
    
    // 场景 3
//        NSObject *object = nil;
//        @autoreleasepool {
//            object = [NSObject new];
//            self.weakObject = object;
//        }
    
    NSLog(@"objec: %@", self.weakObject);
}

- (NSObject *)getAutoreleaseObject {
    NSObject *object = [NSObject new];
    self.weakObject = object;
    return object;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"objec: %@", self.weakObject);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"objec: %@", self.weakObject);
}

@end
