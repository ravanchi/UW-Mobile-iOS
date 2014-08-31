#import "NewsCell.h"
#import "UWNews.h"

#import "DateProvider.h"

@interface NewsCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation NewsCell

- (void)configureWithNews:(UWNews *)news {
    self.titleLabel.text = news.title;
    self.timeLabel.text = [[DateProvider dateFormatter] stringFromDate:news.published];
}

@end
