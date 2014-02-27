#import <Specta/Specta.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "NSNumber+Ruby.h"

SpecBegin(NSNumberRuby)

describe(@"NSNumber+Ruby#abs", ^{
  
  it(@"should return a positive number with a negative input", ^{
    
    NSNumber *number = @(-8080);
    
    expect([number rby_abs]).to.equal(8080);
    
  });
  
  it(@"should return a positive number with a positive input", ^{
    
    NSNumber *number = @8080;
    
    expect([number rby_abs]).to.equal(8080);
    
  });
  
});

describe(@"NSNumber+Ruby#ceil", ^{
  
  it(@"should return a 80 with an input of 79.1", ^{
    
    NSNumber *number = @(79.1);
    
    expect([number rby_ceil]).to.equal(80);
    
  });
  
  it(@"should return a 80 with an input of 79.6", ^{
    
    NSNumber *number = @(79.6);
    
    expect([number rby_ceil]).to.equal(80);
    
  });
  
  it(@"should return a 80 with an input of 80", ^{
    
    NSNumber *number = @80;
    
    expect([number rby_ceil]).to.equal(80);
    
  });
  
});

describe(@"NSNumber+Ruby#floor", ^{

  it(@"should return a 79 with an input of 79.1", ^{
    
    NSNumber *number = @(79.1);
    
    expect([number rby_floor]).to.equal(79);
    
  });
  
  it(@"should return a 79 with an input of 79.6", ^{
    
    NSNumber *number = @(79);
    
    expect([number rby_floor]).to.equal(79);
    
  });
  
  it(@"should return a 80 with an input of 80", ^{
    
    NSNumber *number = @80;
    
    expect([number rby_floor]).to.equal(80);
    
  });
  
});

describe(@"NSNumber+Ruby#imaginary", ^{
  
  it(@"should equal zero", ^{
    
    expect([NSNumber rby_imaginary]).to.equal(0);
    
  });
  
});

describe(@"NSNumber+Ruby#times", ^{
  
  it(@"should iterate 5 times", ^{
    
    __block NSInteger count = 0;
    [@5 rby_times:^(NSInteger idx) {
      count++;
    }];
    
    expect(count).to.equal(5);
    
  });
  
  it(@"should iterate 0 times", ^{
    
    __block NSInteger count = 0;
    [@0 rby_times:^(NSInteger idx) {
      count++;
    }];
    
    expect(count).to.equal(0);
    
  });
  
  it(@"should iterate 0 times", ^{
    
    __block NSInteger count = 0;
    [@(-1) rby_times:^(NSInteger idx) {
      count++;
    }];
    
    expect(count).to.equal(0);
    
  });
  
});

SpecEnd