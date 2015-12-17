//
//  ViewController.m
//  MyWeather
//
//  Created by rentit on 2015. 12. 17..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ViewController.h"

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
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_cityNameLabel]-[_currentTemperatureLabel]-[_currentPressureLabel]-[_currentHumidityLabel]-[_minTemperatureLabel]-[_maxTemperatureLabel]-[_sunriseLabel]-[_sunsetLabel]-|" options:0 metrics:nil views:views]];
    
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cityNameLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentPressureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currentHumidityLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_minTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_maxTemperatureLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sunriseLabel]-|" options:0 metrics:nil views:views]];
    [horizontalConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_sunsetLabel]-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:verticalConstraints];
    [self.view addConstraints:horizontalConstraints];
}

- (void) updateLabelsWithData{
    self.cityNameLabel.text = @"Budapest";
    self.currentTemperatureLabel.text = @"32 C";
    self.currentPressureLabel.text = @"3532";
    self.currentHumidityLabel.text = @"85";
    self.minTemperatureLabel.text = @"12 C";
    self.maxTemperatureLabel.text = @"35 C";
    self.sunriseLabel.text = @"5:35AM";
    self.sunsetLabel.text = @"6:25 AM";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
