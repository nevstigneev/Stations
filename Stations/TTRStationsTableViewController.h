//
//  TTRStationsTableViewController.h
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRConstants.h"

@protocol TTRStationsTableViewControllerDelegate;

@interface TTRStationsTableViewController : UITableViewController

@property (assign, nonatomic) TTRCitiesType citiesType;
@property (weak, nonatomic) id<TTRStationsTableViewControllerDelegate> delegate;

@end

@protocol TTRStationsTableViewControllerDelegate <NSObject>

- (void)stationsTableViewController:(TTRStationsTableViewController *)vc stationSelected:(NSString *)title;

@end
