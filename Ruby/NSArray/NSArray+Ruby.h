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

/*
 Invokes block once for each element of self. Creates a new array containing the values returned by the block.
 */
- (instancetype)rby_map:(id (^)(id object))block;

/*
 Creates a dictionary and groups the elements in the array by a common key.
 */
- (NSDictionary *)rby_groupBy:(id (^)(id object))block;


/*
 Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.
 
 If you specify a block, then for each element in enum the block is passed an accumulator value (memo) and the element. If you specify a symbol instead, then each element in the collection will be passed to the named method of memo. In either case, the result becomes the new value for memo. At the end of the iteration, the final value of memo is the return value for the method.
 
 */
- (id)rby_inject:(id (^)(id sum, id object))block;

- (id)rby_inject:(id)start block:(id (^)(id sum, id object))block;

- (id)rby_min:(NSComparisonResult (^)(id a, id b))block;

- (id)rby_max:(NSComparisonResult (^)(id a, id b))block;

- (id)rby_minBy:(NSNumber *(^)(id object))block;

- (id)rby_maxBy:(NSNumber *(^)(id object))block;

- (BOOL)rby_none:(BOOL (^)(id object))block;

- (BOOL)rby_one:(BOOL (^)(id object))block;

- (NSArray *)rby_partition:(BOOL (^)(id object))block;

- (instancetype)rby_reject:(BOOL (^)(id object))block;

- (instancetype)rby_plus:(NSArray *)array;

- (instancetype)rby_times:(NSArray *)array;

- (instancetype)rby_union:(NSArray *)array;

- (instancetype)rby_intersect:(NSArray *)array;

- (instancetype)rby_compact;

- (void)rby_cycle:(void (^)(id object, BOOL *stop))block;

- (void)rby_cycle:(NSNumber *)times block:(void (^)(id object, BOOL *stop))block;

- (instancetype)rby_transpose:(NSArray *)array;

- (instancetype)rby_unique;

- (instancetype)rby_rotate:(NSInteger)times;

- (instancetype)rby_push:(id)object;

- (instancetype)rby_pop;

- (instancetype)rby_pop:(NSInteger)number;

@end
