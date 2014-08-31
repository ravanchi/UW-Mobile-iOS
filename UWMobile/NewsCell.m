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
    self.timeLabel.text = [[self dateFormatter] stringFromDate:news.published];
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
    });
    
    return dateFormatter;
}

@end
