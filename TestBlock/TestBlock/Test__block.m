//
//  Test__block.m
//  TestBlock
//
//  Created by Shane on 2018/10/26.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "Test__block.h"

@implementation Test__block

// clang -rewrite-objc 查看__block关键字实现
void testBlockKeyWord() {
    __block int val = 10;
    void (^blk)(void) = ^{
        val = 1;
        printf("val = %d", val);
    };
    
    [blk copy];
    blk();
}


@end
