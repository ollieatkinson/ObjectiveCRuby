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
 Returns the denominator (always positive).
 */
- (instancetype)rby_denominator;

/*
 Uses / to perform division, then converts the result to an integer. numeric does not define the / operator; this is left to subclasses.
 */
- (instancetype)rby_divide:(NSNumber *)number;

/*
 Returns an array containing the quotient and modulus obtained by dividing num by numeric. If q, r = x.divmod(y), then
 
 q = floor(x/y)
 x = q*y+r
 The quotient is rounded toward -infinity, as shown in the following table:
 
 a    |  b  |  a.divmod(b)  |   a/b   | a.modulo(b) | a.remainder(b)
 ------+-----+---------------+---------+-------------+---------------
 13   |  4  |   3,    1     |   3     |    1        |     1
 ------+-----+---------------+---------+-------------+---------------
 13   | -4  |  -4,   -3     |  -4     |   -3        |     1
 ------+-----+---------------+---------+-------------+---------------
 -13   |  4  |  -4,    3     |  -4     |    3        |    -1
 ------+-----+---------------+---------+-------------+---------------
 -13   | -4  |   3,   -1     |   3     |   -1        |    -1
 ------+-----+---------------+---------+-------------+---------------
 11.5 |  4  |   2,    3.5   |   2.875 |    3.5      |     3.5
 ------+-----+---------------+---------+-------------+---------------
 11.5 | -4  |  -3,   -0.5   |  -2.875 |   -0.5      |     3.5
 ------+-----+---------------+---------+-------------+---------------
 -11.5 |  4  |  -3,    0.5   |  -2.875 |    0.5      |    -3.5
 ------+-----+---------------+---------+-------------+---------------
 -11.5 | -4  |   2,   -3.5   |   2.875 |   -3.5      |    -3.5
 */
- (instancetype)rby_divideMod:(NSNumber *)number;

/*
 Returns zero.
 */
- (instancetype)rby_imaginary;

@end
