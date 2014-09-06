#import <Mantle/Mantle.h>
#import "UWModel.h"

@interface UWBuilding : MTLModel <MTLJSONSerializing, UWModel>

@property (nonatomic, assign) NSNumber *buildingID;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end
