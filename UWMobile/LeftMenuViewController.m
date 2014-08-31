#import "LeftMenuViewController.h"
#import "UWSideMenuItem.h"
#import "SideMenuItemCell.h"
#import "NewsViewController.h"
#import "EventsViewController.h"

#import <RESideMenu.h>

@interface LeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMenuItems];
}

- (void)initMenuItems {
    NSMutableArray *menuItems = [NSMutableArray array];
    
    [menuItems addObject:[[UWSideMenuItem alloc] initWithName:@"News" selectedImageName:@"" unselectedImageName:@""]];
    [menuItems addObject:[[UWSideMenuItem alloc] initWithName:@"Events" selectedImageName:@"" unselectedImageName:@""]];
    
    self.menuItems = menuItems;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    UWSideMenuItem *menuItem = self.menuItems[indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SideMenuItemCell class])
                                           forIndexPath:indexPath];
    
    [(SideMenuItemCell *)cell setupWithSideMenuItem:menuItem];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NewsViewController *newsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([NewsViewController class])];
        ((UINavigationController *)self.sideMenuViewController.contentViewController).viewControllers = [[NSArray alloc] initWithObjects:newsViewController, nil];
    } else if (indexPath.row == 1) {
        EventsViewController *eventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([EventsViewController class])];
        ((UINavigationController *)self.sideMenuViewController.contentViewController).viewControllers = [[NSArray alloc] initWithObjects:eventsViewController, nil];
    }
    
    [self.sideMenuViewController setContentViewController:self.sideMenuViewController.contentViewController];
    [self.sideMenuViewController hideMenuViewController];
}

@end
