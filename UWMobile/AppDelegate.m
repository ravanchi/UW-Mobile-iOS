#import "AppDelegate.h"

#import <AFHTTPRequestOperationManager.h>
#import <MTLJSONAdapter.h>
#import "UWEvent.h"
#import "UWEventTimes.h"
#import "UWNews.h"

#import "SplashScreenViewController.h"

const NSString *apiKey = @"624b3a3eab10f59832f55b39f6900947";
const NSString *eventsUrl = @"https://api.uwaterloo.ca/v2/events.json";
const NSString *newsUrl = @"https://api.uwaterloo.ca/v2/news.json";

@interface AppDelegate()

@property (nonatomic, strong) SplashScreenViewController *splashScreen;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.splashScreen = (SplashScreenViewController *)self.window.rootViewController;
    [self fetchNews];
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

- (void)fetchCurrentEvents
{
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
                 NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
             }
             
             self.events = eventData;
             [self.splashScreen proceedToHomeViewController];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)fetchNews
{
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
                 NSLog(@"Couldn't convert app infos JSON to ChoosyAppInfo models: %@", error);
             }
             
             self.news = newsData;
             [self.splashScreen proceedToHomeViewController];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

@end
