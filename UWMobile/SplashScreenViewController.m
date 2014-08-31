#import "SplashScreenViewController.h"
#import "NewsViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)proceedToHomeViewController {
    UINavigationController *nc = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsNavigationController"];
    [nc popToRootViewControllerAnimated:FALSE];
    self.view.window.rootViewController = nc;
}

@end
