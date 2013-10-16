//
//  NSArray+RubyAlias.m
//  Ruby
//
//  Created by Oliver Atkinson on 16/10/2013.
//  Copyright (c) 2013 OliverAtkinson. All rights reserved.
//

#import "NSArray+RubyAlias.h"
#import "NSArray+Ruby.h"

@implementation NSArray (RubyAlias)

- (NSArray *)rby_collect:(id (^)(id object))block;
{
  return [self rby_map:block];
}

- (id)rby_reduce:(id (^)(id sum, id object))block;
{
  return [self rby_inject:block];
}

@end
