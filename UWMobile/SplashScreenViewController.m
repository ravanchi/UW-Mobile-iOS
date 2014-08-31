#import <RESideMenu.h>

#import "SplashScreenViewController.h"
#import "NewsViewController.h"
#import "LeftMenuViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)proceedToHomeViewController {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsNavigationController"];
    [navigationController popToRootViewControllerAnimated:NO];
    LeftMenuViewController *leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LeftMenuViewController class])];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];

    self.view.window.rootViewController = sideMenuViewController;
    sideMenuViewController.view.backgroundColor = [UIColor whiteColor];
}

@end
