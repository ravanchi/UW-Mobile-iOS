#import "UWEvent.h"
#import "UWEventTimes.h"

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

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    });
    
    return dateFormatter;
}

+ (NSValueTransformer *)linkJSONTransformer {
    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)timesJSONTransformer {
    // tell Mantle to populate times property with an array of UWEventTimes objects
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[UWEventTimes class]];
}

+ (NSValueTransformer *)updatedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *dateTimeString) {
        return [[self dateFormatter] dateFromString:dateTimeString];
    } reverseBlock:^id(NSDate *dateTime) {
        return [[self dateFormatter] stringFromDate:dateTime];
    }];
}

@end
