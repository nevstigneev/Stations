//
//  TTRStationDetailViewController.h
//  Stations
//
//  Created by Nikolay Evstigneev on 27.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTRStation;

@interface TTRStationDetailViewController : UITableViewController

@property (strong, nonatomic) TTRStation *station;

@end
