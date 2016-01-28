//
//  TTRPageViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 27.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRDateViewController.h"

@interface TTRDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation TTRDateViewController

#pragma mark - Actions

- (IBAction)cancelButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dateViewControllerCancelButtonTapped:)]) {
        [self.delegate dateViewControllerCancelButtonTapped:self];
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dateViewController:dateSelected:)]) {
        [self.delegate dateViewController:self dateSelected:self.datePicker.date];
    }
}

@end
