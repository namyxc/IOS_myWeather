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
}

-(void) setupLayout{

    self.cityNameLabel.font = [UIFont systemFontOfSize:35];
    self.cityNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.currentTemperatureLabel.font = [UIFont systemFontOfSize:22];
    self.currentTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    
    self.minTemperatureLabel.font = [UIFont systemFontOfSize:22];
    self.maxTemperatureLabel.font = [UIFont systemFontOfSize:22];
    self.currentPressureLabel.font = [UIFont systemFontOfSize:22];
    self.currentHumidityLabel.font = [UIFont systemFontOfSize:22];
    
    self.sunriseLabel.font = [UIFont systemFontOfSize:22];
    self.sunsetLabel.font = [UIFont systemFontOfSize:22];
    [self.sunriseLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    
    self.cityNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentPressureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentHumidityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sunriseLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.sunsetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.cityNameLabel];
    [self.view addSubview:self.currentTemperatureLabel];
    [self.view addSubview:self.currentPressureLabel];
    [self.view addSubview:self.currentHumidityLabel];
    [self.view addSubview:self.minTemperatureLabel];
    [self.view addSubview:self.maxTemperatureLabel];
    [self.view addSubview:self.sunriseLabel];
    [self.view addSubview:self.sunsetLabel];
    
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
                                                         _sunsetLabel);
    
    [verticalConstraints addObjectsFromArray:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_cityNameLabel(<=50)]-0-[_currentTemperatureLabel(<=20)]-75-[_minTemperatureLabel]-[_maxTemperatureLabel]-[_currentPressureLabel]-[_currentHumidityLabel]-[_sunriseLabel]->=0-|" options:0 metrics:nil views:views]];
    
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
    /*NSURL *url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=Budapest,hu&appid=2de143494c0b295cca9337e1e96b00e0"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *task =
     */
    
}


- (void) updateLabelsWithData{
    self.cityNameLabel.text = @"Budapest";
    self.currentTemperatureLabel.text = @"32 C";
    self.currentPressureLabel.text = @"3532";
    self.currentHumidityLabel.text = @"85";
    self.minTemperatureLabel.text = @"Minimum temperature today: 12 C";
    self.maxTemperatureLabel.text = @"Maximum temperature today: 35 C";
    self.sunriseLabel.text = @"Daylight: 5:35AM - ";
    self.sunsetLabel.text = @"6:25 AM";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
