#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWEventTimes : MTLModel <MTLJSONSerializing, UWModel>

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@end
