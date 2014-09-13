#import "DateProvider.h"

@implementation DateProvider

+ (NSDateFormatter *)defaultDateFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    });
    
    return dateFormatter;
}

+ (NSDateFormatter *)displayDateFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
    });
    
    return dateFormatter;
}

+ (NSDateFormatter *)displayHourTimeFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
        [dateFormatter setDateFormat:@"hh:mm aa"];
    });
    
    return dateFormatter;
}

@end
