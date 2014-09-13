#import "SideMenuItemCell.h"
#import "UWSideMenuItem.h"

@interface SideMenuItemCell()

@property (nonatomic, strong) UWSideMenuItem *menuItem;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation SideMenuItemCell

- (void)setupWithSideMenuItem:(UWSideMenuItem *)menuItem {
    self.menuItem = menuItem;
    self.nameLabel.text = menuItem.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.menuItem.unselectedImageName]];
}

@end
