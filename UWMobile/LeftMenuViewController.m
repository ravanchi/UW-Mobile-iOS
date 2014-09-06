#import "LeftMenuViewController.h"
#import "UWSideMenuItem.h"
#import "SideMenuItemCell.h"
#import "NewsViewController.h"
#import "EventsViewController.h"
#import "BuildingsViewController.h"

#import <RESideMenu.h>

@interface LeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UIColor *selectedCellBGColor;
@property (nonatomic, strong) UIColor *defaultCellBGColor;

@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMenuItems];
    self.selectedCellBGColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.45];;
    self.defaultCellBGColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView.indexPathForSelectedRow == nil) {
        NSIndexPath *initialIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView selectRowAtIndexPath:initialIndexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionTop];
        
        self.lastSelectedIndexPath = initialIndexPath;
    }
}

- (void)initMenuItems {
    NSMutableArray *menuItems = [NSMutableArray array];
    
    [menuItems addObject:[[UWSideMenuItem alloc] initWithName:@"News" selectedImageName:@"" unselectedImageName:@""]];
    [menuItems addObject:[[UWSideMenuItem alloc] initWithName:@"Events" selectedImageName:@"" unselectedImageName:@""]];
    [menuItems addObject:[[UWSideMenuItem alloc] initWithName:@"Buildings" selectedImageName:@"" unselectedImageName:@""]];
    
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath compare:self.lastSelectedIndexPath] != NSOrderedSame) {
        if (indexPath.row == 0) {
            NewsViewController *newsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([NewsViewController class])];
            ((UINavigationController *)self.sideMenuViewController.contentViewController).viewControllers = [[NSArray alloc] initWithObjects:newsViewController, nil];
        } else if (indexPath.row == 1) {
            EventsViewController *eventsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([EventsViewController class])];
            ((UINavigationController *)self.sideMenuViewController.contentViewController).viewControllers = [[NSArray alloc] initWithObjects:eventsViewController, nil];
        } else if (indexPath.row == 2) {
            BuildingsViewController *buildingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([BuildingsViewController class])];
            ((UINavigationController *)self.sideMenuViewController.contentViewController).viewControllers = [[NSArray alloc] initWithObjects:buildingsViewController, nil];
        }
        
        [self.sideMenuViewController setContentViewController:self.sideMenuViewController.contentViewController];
        
        self.lastSelectedIndexPath = indexPath;
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:self.selectedCellBGColor];
    [self.sideMenuViewController hideMenuViewController];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
    if (currentSelectedIndexPath != nil)
    {
        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:self.defaultCellBGColor];
    }
    
    return indexPath;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cell.isSelected == YES)
    {
        [cell setBackgroundColor:self.selectedCellBGColor];
    }
    else
    {
        [cell setBackgroundColor:self.defaultCellBGColor];
    }
}

@end
