#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:(244.0f/255.0f) green:(244.0f/255.0f) blue:(244.0f/255.0f) alpha:1.0];
}

@end
