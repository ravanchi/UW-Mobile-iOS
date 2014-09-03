#import "SideWeatherViewController.h"
#import "UWWeather.h"
#import "AppDelegate.h"

@interface SideWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation SideWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self configureWithWeather:self.appDelegate.weather];
}

- (void)configureWithWeather:(UWWeather *)weather {
    self.temperatureLabel.text = [NSString stringWithFormat:@"%f", weather.currentTemperature];
    self.humidityLabel.text = [NSString stringWithFormat:@"%f", weather.humidity];
}

@end
