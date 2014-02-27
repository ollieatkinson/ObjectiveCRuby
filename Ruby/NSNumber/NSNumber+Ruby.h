//
//  NSNumber+Ruby.h
//  Ruby
//
//  Created by Oliver Atkinson on 26/02/2014.
//  Copyright (c) 2014 OliverAtkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Ruby)

/* 
 Returns the absolute value of num.
 */
- (instancetype)rby_abs;

/*
 Returns the smallest Integer greater than or equal to num.
 */
- (instancetype)rby_ceil;

/*
 Returns the largest integer less than or equal to num.
 */
- (instancetype)rby_floor;

/*
 Returns zero.
 */
+ (instancetype)rby_imaginary;

/*
 Execute the block self times
 */
- (void)rby_times:(void (^)(NSInteger idx))block;

@end
