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

    sideMenuViewController.view.backgroundColor = [UIColor whiteColor];
    sideMenuViewController.contentViewInPortraitOffsetCenterX = 50;
    sideMenuViewController.contentViewScaleValue = 0.8;
    sideMenuViewController.interactivePopGestureRecognizerEnabled = NO;
    self.view.window.rootViewController = sideMenuViewController;
}

@end
