#import "BuildingsViewController.h"
#import <MapKit/MapKit.h>

#import "AppDelegate.h"
#import "UWBuilding.h"
#import "UWGoose.h"

//-80.56 < longitude < -80.535
//43.465 < latitude < 43.479

static double minLongitude = -80.56;
static double maxLongitude = -80.535;

static double minLatitude = 43.465;
static double maxLatitude = 43.479;

static double uWaterlooLongitude = -80.54382;
static double uWaterlooLatitude = 43.47076;

static NSString *const kBuildingsTitle = @"Buildings";
static NSString *const kGooseWatch = @"Goose Watch";

@interface BuildingsViewController () <MKMapViewDelegate>

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, assign) BOOL isGooseWatch;

@end

@implementation BuildingsViewController

- (void)isGooseWatch:(BOOL)isGooseWatchFlag {
    self.isGooseWatch = isGooseWatchFlag;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isGooseWatch) {
        self.title = kGooseWatch;
    } else {
        self.title = kBuildingsTitle;
    }
    self.mapView.delegate = self;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D poiCoordinates;
    poiCoordinates.latitude = uWaterlooLatitude;
    poiCoordinates.longitude= uWaterlooLongitude;
    
    [self setMapViewRegion:poiCoordinates];
    
    
    if (self.isGooseWatch) {
        for(UWGoose *goose in self.appDelegate.geese) {
            [self addAnnotationWithLatitude:goose.latitude longitude:goose.longitude title:goose.location subtitle:@""];
        }
    } else {
        for(UWBuilding *building in self.appDelegate.buildings) {
            [self addAnnotationWithLatitude:building.latitude longitude:building.longitude title:building.name subtitle:building.code];
        }
    }
    
    [super viewDidAppear:animated];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D poiCoordinates = userLocation.location.coordinate;
    if ((minLatitude < poiCoordinates.latitude < maxLatitude) && (minLongitude < poiCoordinates.longitude < maxLongitude)) {
        [self setMapViewRegion:userLocation.coordinate];
    }
}

- (void)setMapViewRegion:(CLLocationCoordinate2D)poiCoordinates {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoordinates, 600, 400);
    [self.mapView setRegion:viewRegion animated:YES];
}

- (void)addAnnotationWithLatitude:(double)latitude
                        longitude:(double)longitude
                            title:(NSString *)title
                         subtitle:(NSString *)subtitle
{
    CLLocationCoordinate2D poiCoordinates;
    poiCoordinates.latitude = latitude;
    poiCoordinates.longitude= longitude;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = poiCoordinates;
    point.title = title;
    point.subtitle = subtitle;
    
    [self.mapView addAnnotation:point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if (annotation != self.mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.canShowCallout = YES;
        if (self.isGooseWatch) {
            pinView.image = [UIImage imageNamed:@"goose_icon_map.png"];
        } else {
            pinView.image = [UIImage imageNamed:@"building_icon_map.png"];
        }
    }
    else {
        [self.mapView.userLocation setTitle:@"You are here"];
    }
    return pinView;
}

@end
