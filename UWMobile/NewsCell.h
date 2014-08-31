@class UWNews;

@interface NewsCell : UICollectionViewCell

+ (CGFloat)heightWithNews:(UWNews *)news;
- (void)configureWithNews:(UWNews *)news;

@end
