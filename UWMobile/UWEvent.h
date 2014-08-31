#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWEvent : MTLModel <MTLJSONSerializing, UWModel>

@property (nonatomic, strong, readonly) NSNumber *eventID;
@property (nonatomic, strong, readonly) NSString *site;
@property (nonatomic, strong, readonly) NSString *siteName;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray *times;
@property (nonatomic, strong, readonly) NSArray *type;
@property (nonatomic, strong, readonly) NSURL *link;
@property (nonatomic, strong, readonly) NSDate *updated;

@end
