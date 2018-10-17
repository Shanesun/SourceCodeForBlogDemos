//
//  main.m
//  TestBlock
//
//  Created by Shane on 2018/10/17.
//  Copyright © 2018 Shane. All rights reserved.
//

#import <stdio.h>

int main(int argc, char * argv[]) {
    int tmpVal = 10;
    void (^blk)(void) = ^{
        printf("val = %d", tmpVal); // val = 10
    };
    
    tmpVal = 2;
    blk();
}
