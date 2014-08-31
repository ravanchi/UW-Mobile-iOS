#import "ThinHorizontalLineView.h"

@interface ThinHorizontalLineView()

@property (nonatomic, strong) UIColor *thinBackgroundColor;
@property BOOL bottom;

@end

@implementation ThinHorizontalLineView

- (void)awakeFromNib {
    self.thinBackgroundColor = self.backgroundColor;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.thinBackgroundColor.CGColor);
    CGFloat y = self.bottom ? rect.origin.y + 0.5f : rect.origin.y;
    CGContextFillRect(context, CGRectMake(rect.origin.x, y, rect.size.width, 0.5f));
}


@end
