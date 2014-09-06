#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWGoose : MTLModel <MTLJSONSerializing, UWModel>

@property (nonatomic, strong) NSNumber *nestID;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end
