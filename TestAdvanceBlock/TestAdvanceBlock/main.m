//
//  main.m
//  TestAdvanceBlock
//
//  Created by Shane on 2018/10/30.
//  Copyright © 2018 Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "fishhook.h"

typedef void(^block)(void);

typedef struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
}__block_impl;

void blockimp() {
    printf("hello world\n");
}

block gBlock = ^(){
    printf("hello world");
};


void HookBlockToPrintHelloWorld(id block) {
    __block_impl *block_impl = (__bridge __block_impl *)block;
    block_impl->FuncPtr = &blockimp;
}

void HookBlockToPrintArguments(id block) {
    
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        block myblock = ^(){
            NSLog(@"my block");
        };
        
        HookBlockToPrintHelloWorld(myblock);
        
        myblock();
    
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
