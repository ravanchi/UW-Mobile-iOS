#import "EventsViewController.h"
#import "EventCell.h"

#import "AppDelegate.h"

static NSString *const kEventsTitle = @"EVENTS";

@interface EventsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kEventsTitle;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.appDelegate.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EventCell class])
                                                     forIndexPath:indexPath];
    
    [(EventCell *)cell configureWithEvent:self.appDelegate.events[indexPath.row]];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UWEvent *event = self.appDelegate.events[indexPath.row];
    return CGSizeMake(CGRectGetWidth(collectionView.frame), [EventCell heightWithEvent:event]);
}


@end
