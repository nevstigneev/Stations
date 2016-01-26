//
//  TTRScheduleViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 25.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRScheduleViewController.h"
#import "TTRTextField.h"

typedef NS_ENUM(NSInteger, TTRTextFieldIndex) {
    TTRTextFieldIndexFrom,
    TTRTextFieldIndexTo,
    TTRTextFieldIndexDate
};

@interface TTRScheduleViewController () <TTRTextFieldDelegate>

@end

@implementation TTRScheduleViewController

#pragma mark - TTRTextFieldDelegate

- (void)textFieldRightButtonTapped:(TTRTextField *)textField {
    if (textField.tag == TTRTextFieldIndexFrom) {
        [self performSegueWithIdentifier:@"TTRStationFromSegue" sender:textField];
    } else if (textField.tag == TTRTextFieldIndexTo) {
        [self performSegueWithIdentifier:@"TTRStationToSegue" sender:textField];
    } else if (textField.tag == TTRTextFieldIndexDate) {
        //
    }
}

@end
