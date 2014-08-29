#import "UWViewController.h"
#import <AFHTTPRequestOperationManager.h>


const NSString *apiKey = @"624b3a3eab10f59832f55b39f6900947";

@interface UWViewController ()

@end

@implementation UWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchCurrentWeather];
}

- (void)fetchCurrentWeather {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.uwaterloo.ca/v2/weather/current.json"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

@end
