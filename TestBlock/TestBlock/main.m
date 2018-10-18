//
//  main.m
//  TestBlock
//
//  Created by Shane on 2018/10/17.
//  Copyright © 2018 Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

static int outTmpVal = 30;

int main(int argc, char * argv[]) {
    int tmpVal = 10;
    static int localTmpVal = 20;
    NSMutableArray *localMutArray = [NSMutableArray new];
    
    void (^blk)(void) = ^{
        printf("val = %d\n", tmpVal); // val = 10
        printf("localTmpVal = %d\n", localTmpVal); // localTmpVal = 21
        printf("outTmpVal = %d\n", outTmpVal); // outTmpVal = 31

        [localMutArray addObject:@"newObj"];
        printf("localMutArray.count = %d\n", (int)localMutArray.count); // localMutArray.count = 2
    };
    
    tmpVal = 2;
    localTmpVal = 21;
    outTmpVal = 31;
    [localMutArray addObject:@"startObj"];
    blk();
}
