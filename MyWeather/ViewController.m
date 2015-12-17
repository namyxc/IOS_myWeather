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
