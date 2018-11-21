//
//  TestSuperKeyWordVC.m
//  TestRuntime
//
//  Created by Shane on 2018/11/20.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "TestSuperKeyWordVC.h"

@interface Father : NSObject
@end

@implementation Father
@end

@interface Son : Father
@end

@implementation Son
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    
    return self;
}
@end

@interface TestSuperKeyWordVC ()

@end

@implementation TestSuperKeyWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Son *son = [Son new];
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
