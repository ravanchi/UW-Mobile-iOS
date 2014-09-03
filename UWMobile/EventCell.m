#import "EventCell.h"
#import "UWEvent.h"
#import "UWEventTimes.h"

#import "DateProvider.h"

@interface EventCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation EventCell

+ (CGFloat)heightWithEvent:(UWEvent *)event {
    return 65;
}

- (void)configureWithEvent:(UWEvent *)event {
    self.titleLabel.text = event.title;
    self.timeLabel.text = [[DateProvider displayDateFormat] stringFromDate:((UWEventTimes *)event.times[0]).startTime];
}

@end
