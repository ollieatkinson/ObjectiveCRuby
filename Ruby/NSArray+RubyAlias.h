//
//  NSArray+RubyAlias.h
//  Ruby
//
//  Created by Oliver Atkinson on 16/10/2013.
//  Copyright (c) 2013 OliverAtkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (RubyAlias)

- (NSArray *)rby_collect:(id (^)(id object))block;

- (id)rby_reduce:(id (^)(id sum, id object))block;

- (id)rby_reduce:(id)start block:(id (^)(id sum, id object))block;

@end
