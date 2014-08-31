#import "ThinHorizontalLineView.h"

@interface ThinHorizontalLineView()

@property (nonatomic, strong) UIColor *thinBackgroundColor;

@end

@implementation ThinHorizontalLineView

- (void)awakeFromNib {
    self.thinBackgroundColor = self.backgroundColor;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.thinBackgroundColor.CGColor);
    CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0.5f));
}


@end
