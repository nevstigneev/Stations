//
//  TTRScheduleViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 25.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRScheduleViewController.h"
#import "TTRTextField.h"
#import "TTRStationsTableViewController.h"
#import "TTRDateViewController.h"

typedef NS_ENUM(NSInteger, TTRTextFieldIndex) {
    TTRTextFieldIndexDeparture,
    TTRTextFieldIndexDestination
};

typedef NS_ENUM(NSInteger, TTRSegmentIndex) {
    TTRSegmentIndexNone = -1,
    TTRSegmentIndexToday,
    TTRSegmentIndexTomorrow,
    TTRSegmentIndexSelect
};

@interface TTRScheduleViewController () <TTRTextFieldDelegate, TTRStationsTableViewControllerDelegate, TTRDateViewControllerDelegate>

@property (weak, nonatomic) IBOutlet TTRTextField *departureField;
@property (weak, nonatomic) IBOutlet TTRTextField *destinationField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dateControl;

@end

@implementation TTRScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateControl.selectedSegmentIndex = TTRSegmentIndexNone;
}

#pragma mark - Actions

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == TTRSegmentIndexSelect) {
        [self performSegueWithIdentifier:@"TTRDateSegue" sender:sender];
    }
}

#pragma mark - TTRTextFieldDelegate

- (void)textFieldRightButtonTapped:(TTRTextField *)textField {
    if (textField.tag == TTRTextFieldIndexDeparture) {
        [self performSegueWithIdentifier:@"TTRDepartureSegue" sender:textField];
    } else if (textField.tag == TTRTextFieldIndexDestination) {
        [self performSegueWithIdentifier:@"TTRDestinationSegue" sender:textField];
    }
}

#pragma mark - TTRStationsTableViewControllerDelegate

- (void)stationsTableViewController:(TTRStationsTableViewController *)vc stationSelected:(NSString *)title {
    if (vc.citiesType == TTRCitiesTypeDeparture) {
        self.departureField.text = title;
    } else if (vc.citiesType == TTRCitiesTypeDestination) {
        self.destinationField.text = title;
    }
    [vc.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TTRDateViewControllerDelegate

- (void)dateViewControllerCancelButtonTapped:(TTRDateViewController *)vc {
    [vc dismissViewControllerAnimated:YES completion:nil];
    self.dateControl.selectedSegmentIndex = TTRSegmentIndexNone;
}

- (void)dateViewController:(TTRDateViewController *)vc dateSelected:(NSDate *)date {
    [vc dismissViewControllerAnimated:YES completion:nil];
    self.dateControl.selectedSegmentIndex = TTRSegmentIndexNone;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self.dateControl setTitle:dateString forSegmentAtIndex:TTRSegmentIndexSelect];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TTRDepartureSegue"]) {
        TTRStationsTableViewController *vc = (TTRStationsTableViewController *)segue.destinationViewController;
        vc.citiesType = TTRCitiesTypeDeparture;
        vc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"TTRDestinationSegue"]) {
        TTRStationsTableViewController *vc = (TTRStationsTableViewController *)segue.destinationViewController;
        vc.citiesType = TTRCitiesTypeDestination;
        vc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"TTRDateSegue"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        TTRDateViewController *vc = (TTRDateViewController *)nav.viewControllers.firstObject;
        vc.delegate = self;
    }
}

@end
