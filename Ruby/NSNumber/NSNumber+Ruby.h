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
 Uses / to perform division, then converts the result to an integer.
 */
- (instancetype)rby_divide:(NSNumber *)number;

/*
 Returns zero.
 */
- (instancetype)rby_imaginary;

@end
