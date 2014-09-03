#import "UWWeather.h"

#import "DateProvider.h"

@implementation UWWeather

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"currentTemperature"  : @"temperature_current_c",
             @"humidity"            : @"relative_humidity_percent",
             @"observationTime"    : @"observation_time"};
}

- (id<NSCopying>)uniqueKey {
    return self.observationTime;
}

+ (NSValueTransformer *)observationTimeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

@end
