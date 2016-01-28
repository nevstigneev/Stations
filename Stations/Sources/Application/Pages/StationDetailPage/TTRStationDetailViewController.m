//
//  TTRStationDetailViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 27.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStationDetailViewController.h"
#import "TTRStation.h"

@interface TTRStationDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countryLable;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *regionLable;
@property (weak, nonatomic) IBOutlet UILabel *stationLable;

@end

@implementation TTRStationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupLabels];
}

- (void)setupNavigationBar {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
}

- (void)setupLabels {
    self.countryLable.text = self.station.countryTitle;
    self.cityLable.text = self.station.cityTitle;
    self.regionLable.text = self.station.regionTitle;
    self.stationLable.text = self.station.stationTitle;
}

@end
