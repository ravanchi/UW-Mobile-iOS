#import "UWGoose.h"

@implementation UWGoose

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"nestID"    : @"id",
             @"location"  : @"location",
             @"latitude"  : @"latitude",
             @"longitude" : @"longitude"};
}

- (id<NSCopying>)uniqueKey {
    return self.nestID;
}

+ (NSValueTransformer *)nestIDJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *nestID) {
        return @([nestID integerValue]);
    }];
}

@end
