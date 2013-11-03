//
//  NSArray+Ruby.m
//  Ruby
//
//  Created by Oliver Atkinson on 15/10/2013.
//  Copyright (c) 2013 OliverAtkinson. All rights reserved.
//

#import "NSArray+Ruby.h"

@implementation NSArray (Ruby)

#pragma alias rby_collect
- (NSArray *)rby_map:(id (^)(id object))block;
{
  NSParameterAssert(block);
  
  NSMutableArray *mappedArray = [[NSMutableArray alloc] initWithCapacity:self.count];
  for (id object in self) {
    [mappedArray addObject:block(object)];
  }
  return mappedArray;
}

- (NSDictionary *)rby_groupBy:(id (^)(id object))block;
{
  NSParameterAssert(block);
  
  NSMutableDictionary *groupedDictionary = [[NSMutableDictionary alloc] init];
  for (id object in self) {
    id key = block(object);
    if (groupedDictionary[key]) {
      [groupedDictionary[key] addObject:object];
    } else {
      groupedDictionary[key] = [NSMutableArray arrayWithObject:object];
    }
  }
  return groupedDictionary;
}

#pragma alias rby_reduce

- (id)rby_inject:(id (^)(id sum, id object))block;
{
  return [self rby_inject:nil block:block];
}

- (id)rby_inject:(id)start block:(id (^)(id sum, id object))block;
{
  id sum = start;
  for (id object in self) {
    sum = sum ? block(sum, object) : object;
  }
  return sum;
}

- (id)rby_min:(NSComparisonResult (^)(id a, id b))block;
{
  NSParameterAssert(block);

  id min = self.firstObject;
  
  for (id object in self) {
    
    NSComparisonResult result = block(object, min);
    
    if (NSOrderedDescending == result) {
      min = object;
    }
  }
  
  return min;
}

- (id)rby_max:(NSComparisonResult (^)(id a, id b))block;
{
  NSParameterAssert(block);

  id max = self.firstObject;
  
  for (id object in self) {
    
    NSComparisonResult result = block(object, max);
    
    if (NSOrderedAscending == result) {
      max = object;
    }
  }
  
  return max;
}

- (id)rby_minBy:(NSNumber *(^)(id object))block;
{
  NSParameterAssert(block);
  
  id min              = self.firstObject;
  NSNumber *minResult = nil;
  
  for (id object in self) {
    
    NSNumber *comparable = block(object);
    
    if (!minResult) {
      minResult = comparable;
      continue;
    }
    
    if (NSOrderedAscending == [comparable compare:minResult]) {
      min = object;
    }
  }
  
  return min;
}

- (id)rby_maxBy:(NSNumber *(^)(id object))block;
{
  NSParameterAssert(block);
  
  id max              = self.firstObject;
  NSNumber *maxResult = nil;
  
  for (id object in self) {
    
    NSNumber *comparable = block(object);
    
    if (!maxResult) {
      maxResult = comparable;
      continue;
    }
    
    if (NSOrderedDescending == [comparable compare:maxResult]) {
      max = object;
    }
  }
  
  return max;
}

- (BOOL)rby_none:(BOOL (^)(id object))block;
{
  NSParameterAssert(block);

  for (id object in self) {
    if (block(object)) {
      return NO;
    }
  }
  return YES;
}

- (BOOL)rby_one:(BOOL (^)(id object))block;
{
  NSParameterAssert(block);

  BOOL foundOne = NO;
  
  for (id object in self) {
    if (block(object)) {
      if (foundOne) {
        return NO;
      }
      foundOne = YES;
    }
  }
  
  return foundOne;
}

- (NSArray *)rby_partition:(BOOL (^)(id object))block;
{
  NSParameterAssert(block);

  NSMutableArray *left  = [[NSMutableArray alloc] init];
  NSMutableArray *right = [[NSMutableArray alloc] init];
  
  for (id object in self) {
    if (block(object)) {
      [left addObject:object];
    } else {
      [right addObject:object];
    }
  }

  return @[ left, right ];
}

- (NSArray *)rby_reject:(BOOL (^)(id object))block;
{
  NSParameterAssert(block);
   
  NSMutableArray *array  = [[NSMutableArray alloc] init];
  
  for (id object in self) {
    if (!block(object)) [array addObject:object];
  }
  
  return array;
}

@end