//
//  NSArray+Ruby.m
//  Ruby
//
//  Created by Oliver Atkinson on 15/10/2013.
//  Copyright (c) 2013 OliverAtkinson. All rights reserved.
//

#import "NSArray+Ruby.h"
#import "NSNumber+Ruby.h"

@implementation NSArray (Ruby)

#pragma alias rby_collect
- (instancetype)rby_map:(id (^)(id object))block;
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

- (instancetype)rby_reject:(BOOL (^)(id object))block;
{
  NSParameterAssert(block);
   
  NSMutableArray *array  = [[NSMutableArray alloc] init];
  
  for (id object in self) {
    if (!block(object)) [array addObject:object];
  }
  
  return array;
}

- (instancetype)rby_plus:(NSArray *)array;
{
  return [self arrayByAddingObjectsFromArray:array];
}

- (instancetype)rby_times:(NSArray *)array;
{
  if (self.count != array.count) {
    [NSException raise:NSInvalidArgumentException
                format:NSLocalizedString(@"Array must have the same number of entities", @"exception message")];
  }
  
  NSMutableArray *multipliedArray = [@[] mutableCopy];
  
  [self enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
    
    if (![number isKindOfClass:[NSNumber class]] || ![array[idx] isKindOfClass:[NSNumber class]]) {
      NSException *exception =
      [NSException exceptionWithName:NSInternalInconsistencyException
                              reason:@"Object is not of type NSNumber"
                            userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"No implicit conversion into Number", @"exception message")}];
      
      [exception raise];
    }
    
    [multipliedArray addObject:@([number doubleValue] * [array[idx] doubleValue])];
  }];
  
  return [multipliedArray copy];
}

- (instancetype)rby_union:(NSArray *)array;
{
  NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:self];
  [set unionOrderedSet:[NSOrderedSet orderedSetWithArray:array]];
  return [set array];
}

- (instancetype)rby_intersect:(NSArray *)array;
{
  NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:self];
  [set intersectsOrderedSet:[NSOrderedSet orderedSetWithArray:array]];
  return [set array];
}

- (instancetype)rby_compact;
{
  return [self rby_reject:^BOOL(id object) {
    return [object isKindOfClass:[NSNull class]];
  }];
}

- (void)rby_cycle:(void (^)(id object, BOOL *stop))block;
{
  [self rby_cycle:nil block:block];
}

- (void)rby_cycle:(NSNumber *)times block:(void (^)(id object, BOOL *stop))block;
{
  long long count = [times longLongValue];
  
  if (times && [times longLongValue] <= 0) {
    return;
  }
  
  long long iteration = 0;
  
  BOOL stop = NO;
  
  while (!times || iteration++ < count) {
    for (id object in self) {
      block(object, &stop);
      
      if (stop) {
        return;
      }
    }
  }
}

- (instancetype)rby_transpose:(NSArray *)array;
{
  NSMutableArray *mutableArray = [@[] mutableCopy];
  NSNumber *max                = nil;
  
  for (id object in self) {
    
    if (![object isKindOfClass:[NSArray class]]) {
      NSException *exception =
      [NSException exceptionWithName:NSInternalInconsistencyException
                              reason:@"Object is not of type NSArray"
                            userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"Object is not of type NSArray", @"exception message")}];
      
      [exception raise];
    }
    
    max = max ?: @([object count]);
    
    if ([object count] != [max unsignedIntegerValue]) {
      
      NSException *exception =
      [NSException exceptionWithName:NSInternalInconsistencyException
                              reason:@"All arrays must be same length"
                            userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"All arrays must be same length", @"exception message")}];
      
      [exception raise];
    }
    
    [max rby_times:^(NSUInteger idx) {
      NSMutableArray *entry = mutableArray[idx] ?: [@[] mutableCopy];
      [entry addObject:object[idx]];
    }];
    
  }
  
  return [mutableArray copy];
}

- (instancetype)rby_unique;
{
  return [[NSMutableOrderedSet orderedSetWithArray:self] array];
}

- (instancetype)rby_rotate;
{
  return [self rby_rotate:1];
}

- (instancetype)rby_rotate:(NSInteger)times;
{
  NSArray *array = self;
  for (NSInteger idx = 0; idx != times; times < 0 ? idx-- : idx++) {
    array = [array reverseObjectEnumerator].allObjects;
  }
  return array;
}

- (instancetype)rby_push:(id)object;
{
  if ([object isKindOfClass:[NSArray class]]) {
    return [self arrayByAddingObjectsFromArray:object];
  } else {
    return [self arrayByAddingObject:object];
  }
}

- (instancetype)rby_pop;
{
  return [self rby_pop:1];
}

- (instancetype)rby_pop:(NSUInteger)number;
{
  if (number >= [self count]) {
    return @[ ];
  }
  
  return [self subarrayWithRange:NSMakeRange(0, number)];
}

@end
