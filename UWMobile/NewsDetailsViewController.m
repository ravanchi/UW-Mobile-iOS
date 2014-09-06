#import "NewsDetailsViewController.h"
#import "UWNews.h"

static NSString *const kNewsDetailsTitle = @"News Details";

@interface NewsDetailsViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *backgroundWebView;
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UWNews *news;

@end

@implementation NewsDetailsViewController

- (void)configureWithNews:(UWNews *)news {
    self.news = news;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kNewsDetailsTitle;
    self.backgroundWebView.delegate = self;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.news.link];
    [self.backgroundWebView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *contentString = [self.backgroundWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"field field-name-body field-type-text-with-summary field-label-hidden\")[0].innerHTML"];
    
        contentString =
        [NSString stringWithFormat:@"<div style=\"position: absolute; top: 0px; left: 30px; right:30px; font-family: 'Lucida Grande', Helvetica, Arial, sans-serif; font-size: 30pt; color: #000;\">%@", contentString];
        [self.webView loadHTMLString:contentString baseURL:self.news.link];
}

@end
