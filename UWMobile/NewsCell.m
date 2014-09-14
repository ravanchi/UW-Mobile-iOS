#import "NewsCell.h"
#import "UWNews.h"

#import "DateProvider.h"

#define TotalTopAndBottomPadding (10)
#define TimeTopSpace (2.5)
#define kMaxWidth (280)

@interface NewsCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end

@implementation NewsCell

+ (CGFloat)heightWithNews:(UWNews *)news {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f] ,
                                 NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    CGRect boundingRect = [news.title boundingRectWithSize:CGSizeMake(kMaxWidth, 8000)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributes
                                                   context:NULL];
    
    return TotalTopAndBottomPadding + TimeTopSpace + 12 + 15 + 1 + boundingRect.size.height;
}

- (void)configureWithNews:(UWNews *)news {
    self.titleLabel.text = news.title;
    self.timeLabel.text = [[DateProvider displayDateFormat] stringFromDate:news.published];
}

@end
