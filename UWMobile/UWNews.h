#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWNews : MTLModel <MTLJSONSerializing, UWModel>

@property (nonatomic, strong, readonly) NSNumber *newsID;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *site;
@property (nonatomic, strong, readonly) NSURL *link;
@property (nonatomic, strong, readonly) NSDate *published;
@property (nonatomic, strong, readonly) NSDate *updated;

@end
