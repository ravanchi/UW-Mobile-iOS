#import "UWSideMenuItem.h"

@implementation UWSideMenuItem

- (instancetype)initWithName:(NSString *)name
   selectedImageName:(NSString *)selectedImageName
 unselectedImageName:(NSString *)unselectedImageName {
    if (self = [super init]) {
        _name = name;
        _selectedImageName = selectedImageName;
        _unselectedImageName = unselectedImageName;
    }
    
    return self;
}

@end
