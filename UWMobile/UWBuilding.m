#import "UWBuilding.h"

@implementation UWBuilding

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"buildingID"    : @"building_id",
             @"code"          : @"building_code",
             @"name"          : @"building_name",
             @"latitude"      : @"latitude",
             @"longitude"     : @"longitude"};
}

- (id<NSCopying>)uniqueKey {
    return self.buildingID;
}

+ (NSValueTransformer *)buildingIDJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *buildingID) {
        return @([buildingID integerValue]);
    }];
}

- (void)setNilValueForKey:(NSString*)key
{
    if ([key isEqualToString:@"longitude"])
    {
        self.longitude = 0.0;
        return;
    } else if ([key isEqualToString:@"latitude"]) {
        self.latitude = 0.0;
        return;
    }
    
    [super setNilValueForKey:key];
}

@end
