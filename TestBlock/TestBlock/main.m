//
//  main.m
//  TestBlock
//
//  Created by Shane on 2018/10/17.
//  Copyright © 2018 Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark- A
void exampleA_addBlockToArray(NSMutableArray*array) {
    char b = 'A';
    // 这个block在堆上
    // 这个block原本是在栈上，但是因为数组的关系，编译器会将其复制到堆上。
    // 数组内部元素默认是Strong，将一个Block赋值给strong/weak类型(除__unsafe_unretained，这个类型相当于指针)编译器会将Block复制到堆上。
    [array addObject:^{
        printf("%c\n", b);
    }];
}

void exampleA() {
    NSLog(@"---------- exampleA ---------- \n");
    
    NSMutableArray *array = [NSMutableArray array];
    exampleA_addBlockToArray(array);
    void(^block)(void) = [array objectAtIndex:0];
    block(); // 显示A
}

#pragma mark- B
void exampleB_addBlockToArray(NSMutableArray *array) {
    // 这个block在.data全，全局block
    // block内部没有使用外部变量。
    [array addObject:^{
        printf("B\n");
    }];
}

void exampleB() {
    NSLog(@"---------- exampleB ---------- \n");
    
    NSMutableArray *array = [NSMutableArray array];
    exampleB_addBlockToArray(array);
    void(^block)(void) = [array objectAtIndex:0];
    block(); // 显示B
}

#pragma mark- C
typedef void(^cBlock)(void);
cBlock exampleC_getBlock() {
    char d = 'C';
    return^{
        printf("%c\n", d);
    };
}

void exampleC() {
    NSLog(@"---------- exampleC ---------- \n");
    
    // 在函数结尾return block时，编译器会自动copy到堆上。
    cBlock blk_c = exampleC_getBlock();
    blk_c();  // 显示C
}

#pragma mark- D
NSArray* exampleD_getBlockArray() {
    int val = 10;
    
    // 只有第一个Block被Copy到堆上，其他依旧在栈上，超过作用域释放。指针变成野指针。
    // 这里为什么只有第一个Block会被复制到堆上，猜测可能和initWithObjects:实现形式有关系。
    return [[NSArray alloc] initWithObjects:^{NSLog(@"blk1:%d",val);}, ^{NSLog(@"blk0:%d",val);}, ^{NSLog(@"blk0:%d",val);}, nil];
}

void exampleD() {
    NSLog(@"---------- exampleD ---------- \n");
    
    typedef void (^blk_t)(void);
    NSArray *array = exampleD_getBlockArray();
    
    NSLog(@"array count = %ld", [array count]);
    blk_t blk = (blk_t)[array objectAtIndex:1];
    
    blk();  // crash 野指针
}

#pragma mark- E
NSArray* exampleE_getBlockArray() {
    int val = 10;
    // 这种方式添加的block都会被复制到堆上。
    // 数组stong了里面对象和 exampleA 一致。
    NSMutableArray *mutableArray = [NSMutableArray new];
    [mutableArray addObject:^{NSLog(@"blk0:%d",val);}];
    [mutableArray addObject:^{NSLog(@"blk1:%d",val);}];
    [mutableArray addObject:^{NSLog(@"blk2:%d",val);}];
    
    return mutableArray;
}

void exampleE() {
    NSLog(@"---------- exampleE ---------- \n");
    
    typedef void (^blk_t)(void);
    NSArray *array = exampleE_getBlockArray();
    NSLog(@"array count = %ld", [array count]);
    
    blk_t blk = (blk_t)[array objectAtIndex:1];
    blk(); // 显示 blk1:10
}

#pragma mark- F
void exampleF() {
    NSLog(@"---------- exampleF ---------- \n");
    
    typedef void (^blk_f)(id obj);
    // __unsafe_unretained 相当于指针类型，编译器不会copy操作。
    // blk 和 array 超出作用域从栈上释放。
    __unsafe_unretained blk_f blk;
    {
        id array = [[NSMutableArray alloc] init];
        
        blk = ^(id obj) {
            [array addObject:obj];
            NSLog(@"array count = %ld", [array count]);
        };
    }
    
    blk([[NSObject alloc] init]);   // array count = 0
    blk([[NSObject alloc] init]);   // array count = 0
}

#pragma mark- G
void exampleG() {
    NSLog(@"---------- exampleG ---------- \n");
    
    typedef void (^blk_f)(id obj);
    // 隐式 strong 类型。编译器会复制到堆上
    // 捕获的array指针，也会复制到堆上。
    blk_f blk;
    {
        id array = [[NSMutableArray alloc] init];
        
        blk = ^(id obj) {
            [array addObject:obj];
            NSLog(@"array count = %ld", [array count]);
        };
    }
    
    blk([[NSObject alloc] init]);   // array count = 1
    blk([[NSObject alloc] init]);   // array count = 2
}

#pragma mark- H
void exampleH() {
    NSLog(@"---------- exampleH ---------- \n");
    
    typedef void (^blk_f)(id obj);
    // 隐式 strong 类型。编译器会复制到堆上
    // weakArray 遵从内存管理原则并且Block内有没有使用array。
    blk_f blk;
    {
        id array = [[NSMutableArray alloc] init];
        id __weak weakArray = array;
        
        blk = ^(id obj) {
            [weakArray addObject:obj];
            NSLog(@"array count = %ld", [weakArray count]);
        };
    }
    
    blk([[NSObject alloc] init]);   // array count = 0
    blk([[NSObject alloc] init]);   // array count = 0
}

#pragma mark- M
void exampleI() {
    NSLog(@"---------- exampleI ---------- \n");
    
    typedef void (^blk_g)(id obj);
    // 隐式 strong 类型。编译器会复制到堆上
    // blockWeakArray 遵从内存管理原则并且Block内有没有使用array。
    blk_g blk;
    {
        id array = [[NSMutableArray alloc] init];
        __block id __weak blockWeakArray = array;
        
        blk = [^(id obj) {
            [blockWeakArray addObject:obj];
            NSLog(@"array count = %ld", [blockWeakArray count]);
        } copy];
    }
    
    blk([[NSObject alloc] init]);   // array count = 0
    blk([[NSObject alloc] init]);   // array count = 0
}
    

int main(int argc, char * argv[]) {
    exampleA();
    exampleB();
    exampleC();
//    exampleD();
    exampleE();
    exampleF();
    exampleG();
    exampleH();
    exampleI();
}
