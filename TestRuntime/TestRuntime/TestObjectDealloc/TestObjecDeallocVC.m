//
//  TestObjecDeallocVC.m
//  TestRuntime
//
//  Created by Shane on 2018/11/20.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "TestObjecDeallocVC.h"
#import "TestObjectDeallocProcess.h"

@interface TestObjecDeallocVC ()

@end

@implementation TestObjecDeallocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestObjectDeallocProcess *objc = [TestObjectDeallocProcess new];
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
