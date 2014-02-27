# Ruby-ish methods for Objective-C

##Intro
This is a project for personal development to learn more about Objective-C and Ruby.

##Tests
Tests are provided through [Expecta](https://github.com/specta/expecta), and are largely reproduced from the [Ruby
Reference page](http://www.ruby-doc.org/core-2.1.1/), some methods may be changed slightly
in how they function, but for the most part the goal is to ape Ruby behaviour.

##Examples

####Loop five times

```objective-c
[@5 rby_times:^(NSInteger idx) {
  NSLog(@"%d", idx);
}];
```

_result_

```
1
2
3
4
5
```

####Group by

```
NSArray *array = @[ @1, @2, @3, @4, @5, @6 ];

NSDictionary *result = [array rby_groupBy:^(NSNumber *object) {
  return @([object integerValue] % 3);
}];

```
_result_

```
@{
  @0 : @[ @3, @6 ],
  @1 : @[ @1, @4 ],
  @2 : @[ @2, @5 ],
}
```

##Current Implemented Methods

###NSArray+Ruby

```
#map
#group_by
#inject
#min
#max
#min_by
#max_by
#none
#one
#partition
#reject
#plus
#times
#union
#intersect
#compact
#cycle
#transpose
#unique
#rotate
#push
#pop
```

###NSNumber+Ruby

```
#abs
#ceil
#floor
#imaginary
#times
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Improvements

Unit tests for NSArray which need writing:

```
#one  
#partition  
#reject
#plus
#plus
#times
#union
#intersect
#compact
#cycle
#transpose
#unique
#rotate
#push
#pop
```