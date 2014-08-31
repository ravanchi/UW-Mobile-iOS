#import "UWEventTimes.h"

@implementation UWEventTimes

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"startTime" : @"start",
             @"endTime" : @"end"};
}

- (id<NSCopying>)uniqueKey {
    return self.startTime;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    });
    
    return dateFormatter;
}

+ (NSValueTransformer *)startTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateTimeString) {
        return [[self dateFormatter] dateFromString:dateTimeString];
    } reverseBlock:^id(NSDate *dateTime) {
        return [[self dateFormatter] stringFromDate:dateTime];
    }];
}

+ (NSValueTransformer *)endTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateTimeString) {
        return [[self dateFormatter] dateFromString:dateTimeString];
    } reverseBlock:^id(NSDate *dateTime) {
        return [[self dateFormatter] stringFromDate:dateTime];
    }];
}

@end
