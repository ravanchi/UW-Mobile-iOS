#import "UWEventTimes.h"
#import "DateProvider.h"

@implementation UWEventTimes

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"startTime" : @"start",
             @"endTime"   : @"end"};
}

- (id<NSCopying>)uniqueKey {
    return self.startTime;
}

+ (NSValueTransformer *)startTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

+ (NSValueTransformer *)endTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

@end
