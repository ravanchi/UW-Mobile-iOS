#import "EventCell.h"
#import "UWEvent.h"
#import "UWEventTimes.h"

#import "DateProvider.h"

@interface EventCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@end

@implementation EventCell

+ (CGFloat)heightWithEvent:(UWEvent *)event {
    return 60;
}

- (void)configureWithEvent:(UWEvent *)event {
    self.titleLabel.text = event.title;
    self.timeLabel.text = [[DateProvider displayDateFormat] stringFromDate:((UWEventTimes *)event.times[0]).startTime];
    self.siteLabel.text = [@" | " stringByAppendingString: event.site];
}

@end
