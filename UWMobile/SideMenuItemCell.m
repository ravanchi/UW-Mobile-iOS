#import "SideMenuItemCell.h"
#import "UWSideMenuItem.h"

@interface SideMenuItemCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SideMenuItemCell

- (void)setupWithSideMenuItem:(UWSideMenuItem *)menuItem {
    self.nameLabel.text = menuItem.name;
}

@end
