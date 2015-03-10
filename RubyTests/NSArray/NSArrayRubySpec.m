#import <Specta/Specta.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "NSArray+Ruby.h"

SpecBegin(NSArrayRuby)

/*
 (1..4).collect {|i| i*i }   #=> [1, 4, 9, 16]
 (1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
 */

describe(@"NSArray+Ruby#map", ^{
  
  it(@"should return an empty array with an empty input", ^{
    
    NSArray *array = [@[ ] rby_map:^id(id object) { return object; }];
    
    expect(array).to.haveCountOf(0);
    
  });
  
  it(@" [ 1, 2, 3, 4 ] should get doubled to [ 1, 4, 9, 16 ]", ^{
    
    NSArray *array = [@[ @1, @2, @3, @4 ] rby_map:^(NSNumber *object) {
      return @([object integerValue] * [object integerValue]);
    }];

    expect(array).to.haveCountOf(4);
    expect(array).to.equal((@[ @1, @4, @9, @16 ]));
      
  });
  
  it(@"should add exclaimation marks to each string", ^{
    
    NSArray *array = [@[ @1, @2, @3, @4 ] rby_map:^(NSString *object) {
      return @"cat";
    }];
    
    expect(array).to.equal((@[ @"cat", @"cat", @"cat", @"cat" ]));
    
  });

  it(@"should behave the same as NSArray+Ruby#collect", ^{
    
    id(^block)(NSString *object) = ^(NSString *object) {
      return [object stringByAppendingString:@"!"];
    };
    
    NSArray *map     = [@[ @"a", @"b", @"c", @"d" ] rby_map:block];
    NSArray *collect = [@[ @"a", @"b", @"c", @"d" ] rby_collect:block];
    
    expect(map).to.equal(collect);
    
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
    
    expect(result).to.haveCountOf(0);
    
  });
  
  it(@"should group by items with the same denominator of 3 (n % 3)", ^{
    
    NSDictionary *result = [array rby_groupBy:^(NSNumber *object) {
      return @([object integerValue] % 3);
    }];
    
    expect(result).to.equal((@{
                               @0 : @[ @3, @6 ],
                               @1 : @[ @1, @4 ],
                               @2 : @[ @2, @5 ],
                               }));
    
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
    
    expect(result).to.equal(45);
    
  });
  
  it(@"should multiply some numbers", ^{
    
    NSNumber *result = [@[ @5, @6, @7, @8, @9, @10 ] rby_inject:^(NSNumber *sum, NSNumber *object) {
      return @([sum integerValue] * [object integerValue]);
    }];
    
    expect(result).to.equal(151200);
    
  });
  
  it(@"should find the longest word", ^{
    
    NSArray *longest = @[ @"cat", @"sheep", @"bear" ];
    
    NSString *longestWord = [longest rby_inject:^(NSString *memo, NSString *word) {
      return memo.length > word.length ? memo : word;
    }];
    
    expect(longestWord).to.equal(@"sheep");
    
  });
  
  it(@"should behave the same as NSArray+Ruby#reduce", ^{
    
    id(^block)(NSNumber *sum, NSNumber *object) = ^(NSNumber *sum, NSNumber *object) {
        return @([sum integerValue] + [object integerValue]);
    };
    
    NSNumber *inject = [@[ @5, @6, @7, @8, @9, @10 ] rby_inject:block];
    NSNumber *reduce = [@[ @5, @6, @7, @8, @9, @10 ] rby_reduce:block];
    
    expect(inject).to.equal(reduce);
    
  });
  
});

/*
 a = %w(albatross dog horse)
 a.min {|a,b| a.length <=> b.length }   #=> "dog"
 */

describe(@"NSArray+Ruby#min", ^{
  
  NSArray *array = @[ @"albatross", @"horse", @"dog" ];
  
  it(@"should be return the smallest item in the array, \"dog\"", ^{
    
    NSString *result = [array rby_min:^NSComparisonResult(NSString *a, NSString *b) {
      return a.length < b.length;
    }];
    
    expect(result).to.equal(@"dog");
    
  });
  
});

/*
 a = %w(albatross dog horse)
 a.max {|a,b| a.length <=> b.length }   #=> "albatross"
 */

describe(@"NSArray+Ruby#max", ^{
  
  NSArray *array = @[ @"albatross", @"horse", @"dog" ];
  
  it(@"should be return the largest item in the array, \"albatross\"", ^{
    
    NSString *result = [array rby_max:^NSComparisonResult(NSString *a, NSString *b) {
      return a.length > b.length;
    }];
    
    expect(result).to.equal(@"albatross");
    
  });
  
});

/*
 a = %w(albatross dog horse)
 a.min_by {|x| x.length }   #=> "dog"
 */
describe(@"NSArray+Ruby#min_by", ^{
  
  NSArray *array = @[ @"albatross", @"horse", @"dog" ];
  
  it(@"should be return the smallest item in the array by length, \"dog\"", ^{
    
    NSString *result = [array rby_minBy:^NSNumber *(NSString *object) {
      return @([object length]);
    }];
    
    expect(result).to.equal(@"dog");
    
  });
  
});

/*
 a = %w(albatross dog horse)
 a.max_by {|x| x.length }   #=> "albatross"
 */
describe(@"NSArray+Ruby#max_by", ^{
  
  NSArray *array = @[ @"albatross", @"horse", @"dog" ];
  
  it(@"should be return the largest item in the array by length, \"albatross\"", ^{
    
    NSString *result = [array rby_maxBy:^NSNumber *(NSString *object) {
      return @([object length]);
    }];
    
    expect(result).to.equal(@"albatross");
    
  });
  
});

/*
 %w{ant bear cat}.none? {|word| word.length == 5}  #=> true
 %w{ant bear cat}.none? {|word| word.length >= 4}  #=> false
 [].none?                                          #=> true
 */

describe(@"NSArray+Ruby#none", ^{
  
  NSArray *array = @[ @"ant", @"bear", @"cat" ];
  
  
  it(@"shouldn't have anything in the array @[ @\"ant\", @\"bear\", @\"cat\" ] with 5 letters", ^{
    
    BOOL result = [array rby_none:^BOOL(NSString *object) {
      return object.length == 5;
    }];
    
    expect(result).to.equal(YES);
    
  });
 
  it(@"should have something in the array @[ @\"ant\", @\"bear\", @\"cat\" ] with 4 or more letters", ^{
    
    BOOL result = [array rby_none:^BOOL(NSString *object) {
      return object.length >= 4;
    }];
    
    expect(result).to.equal(NO);
    
  });
  
  it(@"an empty array should return YES", ^{
    
    BOOL result = [@[ ] rby_none:^BOOL(id object) {
      return YES;
    }];
    
    expect(result).to.equal(YES);
    
  });
  
  
});

/*
 a = ["a", "b", "c"]
 a.cycle { |x| puts x }     # print, a, b, c, a, b, c,.. forever.
 a.cycle(2) { |x| puts x }  # print, a, b, c, a, b, c.
 */

describe(@"NSArray+Ruby#cycle", ^{
  
  NSArray *array = @[ @"a", @"b", @"c" ];
  
  
  it (@"should cycle two times when passed 2", ^{
    
    __block NSInteger count = 0;
    [array rby_cycle:@2
               block:^(id object, BOOL *stop) {
                 count++;
               }];
    
    expect(count).to.equal(6);
    
  });
  
  it (@"should cycle zero times when passed 0", ^{
    
    __block NSInteger count = 0;
    [array rby_cycle:@0
               block:^(id object, BOOL *stop) {
                 count++;
               }];
    
    expect(count).to.equal(0);
    
  });
  
  it (@"should cycle zero times when passed -1", ^{
    
    __block NSInteger count = 0;
    [array rby_cycle:@(-1)
               block:^(id object, BOOL *stop) {
                 count++;
               }];
    
    expect(count).to.equal(0);
    
  });
  
  it(@"should cycle forever until *stop = YES", ^{
    
    __block NSInteger count = 0;
    [array rby_cycle:^(id object, BOOL *stop) {
      *stop = ++count == 100;
    }];
    
    expect(count).to.equal(100);
    
  });
  
});

SpecEnd
