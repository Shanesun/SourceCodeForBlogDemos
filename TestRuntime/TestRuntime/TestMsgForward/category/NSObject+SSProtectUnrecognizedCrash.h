//
//  NSObject+SSProtectUnrecognizedCrash.h
//  TestRuntime
//
//  Created by Shane on 2018/12/28.
//  Copyright © 2018 Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SSProtectUnrecognizedCrash)

@property (nonatomic, assign, class) BOOL unrecognizedSELGuardEnabled;

@end

NS_ASSUME_NONNULL_END
