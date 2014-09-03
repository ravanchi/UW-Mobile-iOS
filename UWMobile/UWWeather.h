#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWWeather : MTLModel <MTLJSONSerializing, UWModel>

@property CGFloat currentTemperature;
@property CGFloat humidity;
@property (nonatomic, strong, readonly) NSDate *observationTime;

@end
