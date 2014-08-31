#import "UWEvent.h"
#import "UWEventTimes.h"

#import "DateProvider.h"

@implementation UWEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"eventID" : @"id",
             @"site" : @"site",
             @"siteName" : @"site_name",
             @"title" : @"title",
             @"times" : @"times",
             @"link" : @"link",
             @"updated" : @"updated"};
}

- (id<NSCopying>)uniqueKey {
    return self.eventID;
}

+ (NSValueTransformer *)linkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)timesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[UWEventTimes class]];
}

+ (NSValueTransformer *)updatedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

@end
