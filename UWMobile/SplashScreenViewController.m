#import <RESideMenu.h>

#import "SplashScreenViewController.h"
#import "NewsViewController.h"
#import "LeftMenuViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)proceedToHomeViewController {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsNavigationController"];
    [navigationController popToRootViewControllerAnimated:NO];
    LeftMenuViewController *leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LeftMenuViewController class])];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    
    [sideMenuViewController.view setBackgroundColor:[UIColor colorWithRed:(51/255.0) green:(51/255.0) blue:(51/255.0) alpha:0.95]];
    sideMenuViewController.contentViewInPortraitOffsetCenterX = 54;
    sideMenuViewController.contentViewScaleValue = 1;
    sideMenuViewController.interactivePopGestureRecognizerEnabled = NO;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOpacity = 1.0f;
    sideMenuViewController.contentViewShadowRadius = 7.0f;
    sideMenuViewController.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    sideMenuViewController.bouncesHorizontally = NO;
    self.view.window.rootViewController = sideMenuViewController;
}

@end
