#import "DateProvider.h"

@implementation DateProvider

+ (NSDateFormatter *)defaultDateFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    });
    
    return dateFormatter;
}

+ (NSDateFormatter *)displayDateFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
    });
    
    return dateFormatter;
}

@end
