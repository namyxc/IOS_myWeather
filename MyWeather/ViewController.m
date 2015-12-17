//
//  ViewController.m
//  MyWeather
//
//  Created by rentit on 2015. 12. 17..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UILabel *currentDescription;
@property (nonatomic, strong) UIImageView *currentIcon;
@property (nonatomic, strong) UILabel *currentTemperatureLabel;
@property (nonatomic, strong) UILabel *currentPressureLabel;
@property (nonatomic, strong) UILabel *currentHumidityLabel;
@property (nonatomic, strong) UILabel *minTemperatureLabel;
@property (nonatomic, strong) UILabel *maxTemperatureLabel;
@property (nonatomic, strong) UILabel *sunriseLabel;
@property (nonatomic, strong) UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) NSDictionary *currentWeatherData;

@property (nonatomic, strong) CLLocationManager *locationManager ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cityNameLabel =[UILabel new];
    self.currentDescription =[UILabel new];
    self.currentIcon = [UIImageView new];
    self.currentTemperatureLabel =[UILabel new];
    self.currentPressureLabel =[UILabel new];
    self.currentHumidityLabel =[UILabel new];
    self.minTemperatureLabel =[UILabel new];
    self.maxTemperatureLabel =[UILabel new];
    self.sunriseLabel =[UILabel new];
    self.sunsetLabel =[UILabel new];
    
    [self setupLayout];
    
    
    [self startUpdateLocation];
}
/*
-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
*/
-(void) setupLayout{
    
    NSArray *labels = @[self.cityNameLabel, self.currentTemperatureLabel, self.currentPressureLabel, self.currentHumidityLabel, self.minTemperatureLabel, self.maxTemperatureLabel, self.sunriseLabel, self.sunsetLabel, self.currentDescription];
    
    for (UILabel *label in labels) {
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = [UIColor whiteColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:label];
    }

    self.cityNameLabel.font = [UIFont systemFontOfSize:35];
    self.cityNameLabel.textAlignment = NSTextAlignmentCenter;
    self.currentTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: _currentIcon];
    self.currentIcon.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentIcon.backgroundColor = [UIColor whiteColor];
    self.currentDescription.textAlignment = NSTextAlignmentCenter;

    
    [self.sunriseLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    NSMutableArray *verticalConstraints = [NSMutableArray new];
    NSMutableArray *horizontalConstraints = [NSMutableArray new];
    
    [horizontalConstraints addObject:[NSLayoutConstraint constraintWithItem:self.currentIcon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.currentIcon.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(
                                                         _cityNameLabel,
                                                         _currentDescription,
                                                         _currentIcon,
                                                         _currentTemperatureLabel,
                                                         _currentPressureLabel,
                                                         _currentHumidityLabel,
                                                         _minTemperatureLabel,
                                                         _maxTemperatureLabel,
                                                         _sunriseLabel,
                                                         _sunsetLabel,
                                                         _arrowImageView);
    
    [verticalConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_cityNameLabel(<=50)]-0-[_currentTemperatureLabel(<=20)]-[_currentIcon(50)]-[_currentDescription]-[_arrowImageView]-[_minTemperatureLabel]-[_maxTemperatureLabel]-[_currentPressureLabel]-[_currentHumidityLabel]->=0-[_sunriseLabel]-15-|" options:0 metrics:nil views:views]];
    
    
    [verticalConstraints addObject:[NSLayoutConstraint constraintWithItem:self.sunriseLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sunsetLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cityNameLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentPressureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentHumidityLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_minTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_maxTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sunriseLabel][_sunsetLabel]-|" options:0 metrics:nil views:views]];
    
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentDescription]-|" options:0 metrics:nil views:views]];
    
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=0-[_currentIcon(50)]->=0-|" options:0 metrics:nil views:views]];

    
    [self.view addConstraints:verticalConstraints];
    [self.view addConstraints:horizontalConstraints];
}

- (void) startUpdateLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [CLLocationManager new];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.distanceFilter = 500;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        
        self.locationManager.delegate = self;
        
        [self.locationManager startUpdatingLocation];
        
        if ([CLLocationManager headingAvailable]) {
            [self.locationManager startUpdatingHeading];
        }
        
    }else{
        
    }
    
}

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if ([locations count] > 0) {
        CLLocation *location = [locations lastObject];
        [self fetchCurrentWeatherWithLocation:location];
        NSLog(@"location: %@", location);
        
        self.arrowImageView.layer.affineTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS( [self.currentWeatherData[@"wind"][@"deg"] doubleValue]));
    }
    
}


-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"newHeading: %@", newHeading);
    self.arrowImageView.layer.affineTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(newHeading.trueHeading + [self.currentWeatherData[@"wind"][@"deg"] doubleValue]));

}


-(void) fetchCurrentWeatherWithLocation: (CLLocation *)location {
    
    NSDictionary *parameters = @{//@"q": @"Budapest, hu",
                                 @"lat": @(location.coordinate.latitude),
                                 @"lon": @(location.coordinate.longitude),
                                 @"appid": @"2de143494c0b295cca9337e1e96b00e0",
                                 @"units": @"metric"};
    __weak ViewController *weakSelf = self;
    
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/weather";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        weakSelf.currentWeatherData = responseObject;
        [weakSelf updateLabelsWithData];
        
        NSString *iconUrl = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", responseObject[@"weather"][0][@"icon"]];
        
        [self.currentIcon setImageWithURL:[NSURL URLWithString:iconUrl]];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        self.cityNameLabel.text = @"ERROR";
    }];
    
    
}


- (void) updateLabelsWithData{
    self.cityNameLabel.text = self.currentWeatherData[@"name"];
    self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%@ °C", self.currentWeatherData[@"main"][@"temp"]];
    
    self.currentPressureLabel.text = [NSString stringWithFormat:@"Current pressure: %@ hPa", self.currentWeatherData[@"main"][@"pressure"]];
    self.currentHumidityLabel.text = [NSString stringWithFormat:@"Current humidity: %@ %%", self.currentWeatherData[@"main"][@"humidity"]];
    
    self.minTemperatureLabel.text = [NSString stringWithFormat:@"Minimum temperature today: %@ °C", self.currentWeatherData[@"main"][@"temp_min"]];
    self.maxTemperatureLabel.text = [NSString stringWithFormat:@"Maximum temperature today: %@ °C", self.currentWeatherData[@"main"][@"temp_max"]];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"HH:mm";
    
    NSTimeInterval sunriseTimeStamp = [self.currentWeatherData[@"sys"][@"sunrise"] doubleValue];
    NSTimeInterval sunsetTimeStamp = [self.currentWeatherData[@"sys"][@"sunset"] doubleValue];
    
    NSDate *sunrise = [NSDate dateWithTimeIntervalSince1970:sunriseTimeStamp];
    NSDate *sunset = [NSDate dateWithTimeIntervalSince1970:sunsetTimeStamp];
    self.sunriseLabel.text = [NSString stringWithFormat:@"Daylight: %@ - ", [dateFormatter stringFromDate: sunrise]];

    self.sunsetLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: sunset]];
    self.currentDescription.text =self.currentWeatherData[@"weather"][0][@"description"];
;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
