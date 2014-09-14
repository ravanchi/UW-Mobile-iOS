#import "NewsDetailsViewController.h"
#import "UWNews.h"

static NSString *const kNewsDetailsTitle = @"NEWS DETAILS";

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
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
    self.backgroundWebView.delegate = self;
    self.webView.delegate = self;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.news.link];
    [self.backgroundWebView loadRequest:urlRequest];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView == self.backgroundWebView) {
        NSString *contentString = [self.backgroundWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName(\"field field-name-body field-type-text-with-summary field-label-hidden\")[0].innerHTML"];
        
        contentString = [NSString stringWithFormat:@"<style type=\"text/css\">a {text-decoration: none; color:#000;} img {display: none;} button {display: none}</style><div style=\"position: absolute; top: 0px; left: 30px; right:30px; font-family: 'Lucida Grande', Helvetica, Arial, sans-serif; font-size: 36pt; color: #000; background-color: #F4F4F4;\">%@", contentString];

        [self.webView loadHTMLString:contentString baseURL:self.news.link];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		return NO;
	}
	return YES;
}

@end
