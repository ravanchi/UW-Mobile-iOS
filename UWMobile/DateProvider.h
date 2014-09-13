@interface DateProvider : NSObject

+ (NSDateFormatter *)defaultDateFormat;
+ (NSDateFormatter *)displayDateFormat;
+ (NSDateFormatter *)displayHourTimeFormat;

@end

