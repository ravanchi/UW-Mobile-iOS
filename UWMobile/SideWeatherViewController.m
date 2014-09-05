#import "SideWeatherViewController.h"
#import "UWWeather.h"
#import "AppDelegate.h"
#import "DateProvider.h"

@interface SideWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation SideWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self configureWithWeather:self.appDelegate.weather];
}

- (void)configureWithWeather:(UWWeather *)weather {
    self.temperatureLabel.text = [NSString stringWithFormat:@"%ld", lroundf(weather.currentTemperature)];
    [self setUpHumidityLabel:weather.humidity];
    [self setUpWindSpeedLabel:weather.windSpeed];
    self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Updated: %@", [[DateProvider displayDateFormat] stringFromDate: weather.observationTime]];
}

- (void)setUpHumidityLabel:(CGFloat)humidity {
    NSString *descriptionLabel = @"Humidity %@";
    NSString *humidityString = [NSString stringWithFormat:@"%.1f", humidity];
    NSString *fullHumidityString = [NSString stringWithFormat:descriptionLabel, humidityString];
    NSMutableAttributedString *attributedHumidityString = [[NSMutableAttributedString alloc] initWithString:fullHumidityString attributes:nil];
    
    [attributedHumidityString beginEditing];
    [attributedHumidityString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor grayColor]
                                 range:NSMakeRange(0, 8)];
    
    [attributedHumidityString addAttribute:NSFontAttributeName
                                value:[UIFont systemFontOfSize:11]
                                range:NSMakeRange(0, 8)];
    [attributedHumidityString endEditing];
    
    self.humidityLabel.attributedText = attributedHumidityString;
}

- (void)setUpWindSpeedLabel:(CGFloat)windSpeed {
    NSString *descriptionLabel = @"Wind Speed %@";
    NSString *windSpeedString = [NSString stringWithFormat:@"%.1f", windSpeed];
    NSString *fullWindSpeedString = [NSString stringWithFormat:descriptionLabel, windSpeedString];
    NSMutableAttributedString *attributedHumidityString = [[NSMutableAttributedString alloc] initWithString:fullWindSpeedString attributes:nil];
    
    [attributedHumidityString beginEditing];
    [attributedHumidityString addAttribute:NSForegroundColorAttributeName
                                     value:[UIColor grayColor]
                                     range:NSMakeRange(0, 10)];
    
    [attributedHumidityString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:11]
                                     range:NSMakeRange(0, 10)];
    [attributedHumidityString endEditing];
    
    self.windSpeedLabel.attributedText = attributedHumidityString;
}

@end
