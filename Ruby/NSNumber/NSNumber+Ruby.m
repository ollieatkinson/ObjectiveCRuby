//
//  NSNumber+Ruby.m
//  Ruby
//
//  Created by Oliver Atkinson on 26/02/2014.
//  Copyright (c) 2014 OliverAtkinson. All rights reserved.
//

#import "NSNumber+Ruby.h"

@implementation NSNumber (Ruby)

- (instancetype)rby_abs;
{
  return @(abs([self doubleValue]));
}

- (instancetype)rby_ceil;
{
  return @(ceil([self doubleValue]));
}

- (instancetype)rby_floor;
{
  return @(floor([self doubleValue]));
}

- (instancetype)rby_divide:(NSNumber *)number;
{
  return @((NSInteger)([self integerValue] / [number integerValue]));
}

- (instancetype)rby_imaginary;
{
  return @0;
}

@end