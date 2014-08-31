#import "UWNews.h"

#import "DateProvider.h"

@implementation UWNews

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"newsID"    : @"id",
             @"title"     : @"title",
             @"site"      : @"site",
             @"link"      : @"link",
             @"published" : @"published",
             @"updated"   : @"updated"};
}

- (id<NSCopying>)uniqueKey {
    return self.newsID;
}

+ (NSValueTransformer *)titleJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *titleString) {
        titleString = [titleString stringByReplacingOccurrencesOfString:@"&amp;"
                                               withString:@"&"];
        
        return [titleString stringByReplacingOccurrencesOfString:@"&#039;"
                                       withString:@"'"];
    }];
}

+ (NSValueTransformer *)linkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)publishedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

+ (NSValueTransformer *)updatedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSString *dateTimeString) {
        return [[DateProvider defaultDateFormat] dateFromString:dateTimeString];
    }];
}

@end
