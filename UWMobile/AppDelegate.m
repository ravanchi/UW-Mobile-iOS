#import "AppDelegate.h"

#import <AFHTTPRequestOperationManager.h>
#import <MTLJSONAdapter.h>
#import "UWEvent.h"
#import "UWEventTimes.h"
#import "UWNews.h"
#import "UWWeather.h"
#import "UWBuilding.h"
#import "UWGoose.h"

#import "SplashScreenViewController.h"

const NSString *apiKey = @"624b3a3eab10f59832f55b39f6900947";
const NSString *eventsUrl = @"https://api.uwaterloo.ca/v2/events.json";
const NSString *newsUrl = @"https://api.uwaterloo.ca/v2/news.json";
const NSString *weatherUrl = @"https://api.uwaterloo.ca/v2/weather/current.json";
const NSString *buildingUrl = @"https://api.uwaterloo.ca/v2/buildings/list.json";
const NSString *gooseUrl = @"https://api.uwaterloo.ca/v2/resources/goosewatch.json";

@interface AppDelegate()

@property (nonatomic, strong) SplashScreenViewController *splashScreen;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    
    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Bold" size:17.0f],
                                            NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.splashScreen = (SplashScreenViewController *)self.window.rootViewController;
    [self fetchNews];
    [self fetchEvents];
    [self fetchWeather];
    [self fetchBuildings];
    [self fetchGeese];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)fetchBuildings {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *buildingsStringUrl = [NSString stringWithFormat:@"%@?key=%@", buildingUrl, apiKey];
    
    [manager GET:buildingsStringUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
             NSArray *buildingsJSON = responseDictionary[@"data"];
             
             NSError *error;
             
             NSArray *buildingsData = [MTLJSONAdapter modelsOfClass:[UWBuilding class] fromJSONArray:buildingsJSON error:&error];
             
             if (error) {
                 NSLog(@"Couldn't convert News JSON to UWBuilding models: %@", error);
             }
             
//             NSLog(@"%@", buildingsData);
             
             self.buildings = buildingsData;
             if(self.geese != nil && self.weather != nil && self.news != nil && self.events != nil) {
                 [self.splashScreen proceedToHomeViewController];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)fetchEvents {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *eventsStringUrl = [NSString stringWithFormat:@"%@?key=%@", eventsUrl, apiKey];
    
    [manager GET:eventsStringUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
             NSArray *eventsJSON = responseDictionary[@"data"];
             
             NSError *error;
             
             NSArray *eventData = [MTLJSONAdapter modelsOfClass:[UWEvent class] fromJSONArray:eventsJSON error:&error];
             
             if (error) {
                 NSLog(@"Couldn't convert Events JSON to UWEvent models: %@", error);
             }
             
             eventData = [eventData sortedArrayUsingComparator:^NSComparisonResult(UWEvent *event1, UWEvent *event2){
                 
                 NSDate *event1StartTime = ((UWEventTimes *)event1.times[0]).startTime;
                 NSDate *event2StartTime = ((UWEventTimes *)event2.times[0]).startTime;
                 
                 if ([event1StartTime laterDate:event2StartTime]) {
                     return (NSComparisonResult)NSOrderedDescending;
                 }
                 
                 if ([event1StartTime earlierDate:event2StartTime]) {
                     return (NSComparisonResult)NSOrderedAscending;
                 }
                 	
                 return (NSComparisonResult)NSOrderedSame;
             }];
             
//             NSLog(@"%@", eventData);
             
             self.events = eventData;
             if(self.geese != nil && self.weather != nil && self.buildings != nil && self.news != nil) {
                 [self.splashScreen proceedToHomeViewController];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)fetchWeather {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *weatherStringUrl = [NSString stringWithFormat:@"%@", weatherUrl];
    
    [manager GET:weatherStringUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
             NSDictionary *weatherJSON = responseDictionary[@"data"];
             
             NSError *error;
             
             NSArray *weatherData = [MTLJSONAdapter modelOfClass:[UWWeather class] fromJSONDictionary:weatherJSON error:&error];
             
             if (error) {
                 NSLog(@"Couldn't convert Weather JSON to UWWeather model: %@", error);
             }
             
             
//             NSLog(@"%@", weatherData);
             
             self.weather = (UWWeather *)weatherData;
             if(self.geese != nil && self.news != nil && self.buildings != nil && self.events != nil) {
                 [self.splashScreen proceedToHomeViewController];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)fetchNews {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *newsStringUrl = [NSString stringWithFormat:@"%@?key=%@", newsUrl, apiKey];
    
    [manager GET:newsStringUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
             NSArray *newsJSON = responseDictionary[@"data"];
             
             NSError *error;
             
             NSArray *newsData = [MTLJSONAdapter modelsOfClass:[UWNews class] fromJSONArray:newsJSON error:&error];
             
             if (error) {
                 NSLog(@"Couldn't convert News JSON to UWNews models: %@", error);
             }
             
             NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"published" ascending:NO];
             
             newsData = [newsData sortedArrayUsingDescriptors:@[descriptor]];
             
             //             NSLog(@"%@", newsData);
             
             self.news = newsData;
             if(self.geese != nil && self.weather != nil && self.buildings != nil && self.events != nil) {
                 [self.splashScreen proceedToHomeViewController];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)fetchGeese {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *geeseStringUrl = [NSString stringWithFormat:@"%@?key=%@", gooseUrl, apiKey];
    
    [manager GET:geeseStringUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
             NSArray *geeseJSON = responseDictionary[@"data"];
             
             NSError *error;
             
             NSArray *geeseData = [MTLJSONAdapter modelsOfClass:[UWGoose class] fromJSONArray:geeseJSON error:&error];
             
             if (error) {
                 NSLog(@"Couldn't convert News JSON to UWGoose models: %@", error);
             }
             
             NSLog(@"%@", geeseData);
             
             self.geese = geeseData;
             if(self.news != nil && self.weather != nil && self.buildings != nil && self.events != nil) {
                 [self.splashScreen proceedToHomeViewController];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

@end
