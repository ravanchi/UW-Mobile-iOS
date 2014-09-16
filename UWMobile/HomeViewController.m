#import "HomeViewController.h"

static NSString *const kHomeTitle = @"HOME";

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kHomeTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
