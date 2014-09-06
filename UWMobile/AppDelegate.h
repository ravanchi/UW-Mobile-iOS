#import "UWWeather.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSArray *news;
@property (nonatomic, strong) UWWeather *weather;
@property (nonatomic, strong) NSArray *buildings;

@end
