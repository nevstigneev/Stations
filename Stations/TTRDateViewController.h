//
//  TTRPageViewController.h
//  Stations
//
//  Created by Nikolay Evstigneev on 27.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTRDateViewControllerDelegate;

@interface TTRDateViewController : UIViewController

@property (weak, nonatomic) id<TTRDateViewControllerDelegate> delegate;

@end

@protocol TTRDateViewControllerDelegate <NSObject>

- (void)dateViewControllerCancelButtonTapped:(TTRDateViewController *)vc;
- (void)dateViewController:(TTRDateViewController *)vc dateSelected:(NSDate *)date;

@end
