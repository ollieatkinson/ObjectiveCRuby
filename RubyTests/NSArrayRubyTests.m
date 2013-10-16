#import <Kiwi/Kiwi.h>
#import "NSArray+Ruby.h"

SPEC_BEGIN(NSArrayRubySpec)

/*
 (1..4).collect {|i| i*i }   #=> [1, 4, 9, 16]
 (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
 */

describe(@"NSArray+Ruby#map", ^{
  
  it(@"should return an empty array with an empty input", ^{
    
    [[[@[ ] rby_map:^id(id object) {
      return object;
    }] should] equal:@[ ]];
    
  });
  
  it(@" [ 1, 2, 3, 4 ] should get doubled to [ 1, 4, 9, 16 ]", ^{
    
    NSArray *array = [@[ @1, @2, @3, @4 ] rby_map:^(NSNumber *object) {
      return @([object integerValue] * [object integerValue]);
    }];
    
    [[array should] equal:@[ @1, @4, @9, @16 ]];
    
  });
  
  it(@"should add exclaimation marks to each string", ^{
    
    NSArray *array = [@[ @1, @2, @3, @4 ] rby_map:^(NSString *object) {
      return @"cat";
    }];
    
    [[array should] equal:@[ @"cat", @"cat", @"cat", @"cat" ]];
    
  });
  
  it(@"should behave the same as NSArray+Ruby#collect", ^{
    
    id(^block)(NSString *object) = ^(NSString *object) {
      return [object stringByAppendingString:@"!"];
    };
    
    NSArray *map     = [@[ @"a", @"b", @"c", @"d" ] rby_map:block];
    NSArray *collect = [@[ @"a", @"b", @"c", @"d" ] rby_collect:block];
    
    [[map should] equal:collect];
    
  });
  
});

/*
 (1..6).group_by {|i| i%3}   #=> {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
 */

describe(@"NSArray+Ruby#group_by", ^{
  
  NSArray *array = @[ @1, @2, @3, @4, @5, @6 ];
  
  it(@"should return an empty dictionary with an empty input", ^{
    
    NSDictionary *result = [@[ ] rby_groupBy:^id(id object) {
      return object;
    }];
    
    [[result should] equal:@{ }];
    
  });
  
  it(@"should group by items with the same denominator of 3 (n % 3)", ^{
    
    NSDictionary *result = [array rby_groupBy:^(NSNumber *object) {
      return @([object integerValue] % 3);
    }];
    
    [[result should] equal:@{
                             @0 : @[ @3, @6 ],
                             @1 : @[ @1, @4 ],
                             @2 : @[ @2, @5 ],
                             }];
    
  });
  
});

/*
 # Sum some numbers
 (5..10).reduce(:+)                            #=> 45
 
 # Same using a block and inject
 (5..10).inject {|sum, n| sum + n }            #=> 45
 
 # Multiply some numbers
 (5..10).reduce(1, :*)                         #=> 151200
 
 # Same using a block
 (5..10).inject(1) {|product, n| product * n } #=> 151200
 
 # find the longest word
 longest = %w{ cat sheep bear }.inject do |memo,word|
     memo.length > word.length ? memo : word
 end
 longest                                       #=> "sheep"
 */

describe(@"NSArray+Ruby#inject", ^{
  
  it(@"shoud sum some numbers", ^{
    
    NSNumber *result = [@[ @5, @6, @7, @8, @9, @10 ] rby_inject:^(NSNumber *sum, NSNumber *object) {
      return @([sum integerValue] + [object integerValue]);
    }];
    
    [[result should] equal:@(45)];
    
  });
  
  it(@"should multiply some numbers", ^{
    
    NSNumber *result = [@[ @5, @6, @7, @8, @9, @10 ] rby_inject:^(NSNumber *sum, NSNumber *object) {
      return @([sum integerValue] * [object integerValue]);
    }];
    
    [[result should] equal:@(151200)];
    
  });
  
  it(@"should find the longest word", ^{
    
    NSArray *longest = @[ @"cat", @"sheep", @"bear" ];
    
    NSString *longestWord = [longest rby_inject:^(NSString *memo, NSString *word) {
      return memo.length > word.length ? memo : word;
    }];
    
    [[longestWord should] equal:@"sheep"];
    
  });
  
  it(@"should behave the same as NSArray+Ruby#reduce", ^{
    
    id(^block)(NSNumber *sum, NSNumber *object) = ^(NSNumber *sum, NSNumber *object) {
        return @([sum integerValue] + [object integerValue]);
    };
    
    NSNumber *inject = [@[ @5, @6, @7, @8, @9, @10 ] rby_inject:block];
    NSNumber *reduce = [@[ @5, @6, @7, @8, @9, @10 ] rby_reduce:block];
    
    [[inject should] equal:reduce];
    
  });
  
});

SPEC_END