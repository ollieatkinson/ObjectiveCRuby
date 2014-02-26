//
//  NSArray+Ruby.h
//  Ruby
//
//  Created by Oliver Atkinson on 15/10/2013.
//  Copyright (c) 2013 OliverAtkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+RubyAlias.h"

@interface NSArray (Ruby)

- (NSArray *)rby_map:(id (^)(id object))block;

- (NSDictionary *)rby_groupBy:(id (^)(id object))block;

- (id)rby_inject:(id (^)(id sum, id object))block;

- (id)rby_inject:(id)start block:(id (^)(id sum, id object))block;

- (id)rby_min:(NSComparisonResult (^)(id a, id b))block;

- (id)rby_max:(NSComparisonResult (^)(id a, id b))block;

- (id)rby_minBy:(NSNumber *(^)(id object))block;

- (id)rby_maxBy:(NSNumber *(^)(id object))block;

- (BOOL)rby_none:(BOOL (^)(id object))block;

- (BOOL)rby_one:(BOOL (^)(id object))block;

- (NSArray *)rby_partition:(BOOL (^)(id object))block;

- (NSArray *)rby_reject:(BOOL (^)(id object))block;

@end
