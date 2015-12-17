//
//  ViewController.m
//  MyWeather
//
//  Created by rentit on 2015. 12. 17..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UILabel *currentTemperatureLabel;
@property (nonatomic, strong) UILabel *currentPressureLabel;
@property (nonatomic, strong) UILabel *currentHumidityLabel;
@property (nonatomic, strong) UILabel *minTemperatureLabel;
@property (nonatomic, strong) UILabel *maxTemperatureLabel;
@property (nonatomic, strong) UILabel *sunriseLabel;
@property (nonatomic, strong) UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) NSDictionary *currentWeatherData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.cityNameLabel =[UILabel new];
    self.currentTemperatureLabel =[UILabel new];
    self.currentPressureLabel =[UILabel new];
    self.currentHumidityLabel =[UILabel new];
    self.minTemperatureLabel =[UILabel new];
    self.maxTemperatureLabel =[UILabel new];
    self.sunriseLabel =[UILabel new];
    self.sunsetLabel =[UILabel new];
    
    [self setupLayout];
    
    [self updateLabelsWithData];
    
    [self fetchCurrentWeather];
}
/*
-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
*/
-(void) setupLayout{
    
    NSArray *labels = @[self.cityNameLabel, self.currentTemperatureLabel, self.currentPressureLabel, self.currentHumidityLabel, self.minTemperatureLabel, self.maxTemperatureLabel, self.sunriseLabel, self.sunsetLabel];
    
    for (UILabel *label in labels) {
        label.font = [UIFont systemFontOfSize:22];
        label.textColor = [UIColor whiteColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:label];
    }

    self.cityNameLabel.font = [UIFont systemFontOfSize:35];
    self.cityNameLabel.textAlignment = NSTextAlignmentCenter;
    self.currentTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.sunriseLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    NSMutableArray *verticalConstraints = [NSMutableArray new];
    NSMutableArray *horizontalConstraints = [NSMutableArray new];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(
                                                         _cityNameLabel,
                                                         _currentTemperatureLabel,
                                                         _currentPressureLabel,
                                                         _currentHumidityLabel,
                                                         _minTemperatureLabel,
                                                         _maxTemperatureLabel,
                                                         _sunriseLabel,
                                                         _sunsetLabel,
                                                         _arrowImageView);
    
    [verticalConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_cityNameLabel(<=50)]-0-[_currentTemperatureLabel(<=20)]-[_arrowImageView]-[_minTemperatureLabel]-[_maxTemperatureLabel]-[_currentPressureLabel]-[_currentHumidityLabel]-[_sunriseLabel]->=0-|" options:0 metrics:nil views:views]];
    
    [verticalConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_currentHumidityLabel]-[_sunsetLabel]" options:0 metrics:nil views:views]];
    
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cityNameLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentPressureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentHumidityLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_minTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_maxTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sunriseLabel][_sunsetLabel]-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:verticalConstraints];
    [self.view addConstraints:horizontalConstraints];
}

-(void) fetchCurrentWeather {
    
    NSDictionary *parameters = @{@"q": @"Budapest, hu",
                                 @"appid": @"2de143494c0b295cca9337e1e96b00e0",
                                 @"units": @"metric"};
    __weak ViewController *weakSelf = self;
    
    NSString *urlString = @"http://api.openweathermap.org/data/2.5/weather";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        weakSelf.currentWeatherData = responseObject;
        [weakSelf updateLabelsWithData];
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
;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
