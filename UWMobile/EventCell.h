@class UWEvent;

@interface EventCell : UICollectionViewCell

+ (CGFloat)heightWithEvent:(UWEvent *)event;
- (void)configureWithEvent:(UWEvent *)event;

@end