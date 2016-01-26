//
//  TTRStationsTableViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStationsTableViewController.h"
#import "TTRStationFetcher.h"

@interface TTRStationsTableViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) TTRStationFetcher *stationFetcher;

@end

@implementation TTRStationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSearchController];
    self.stationFetcher = [[TTRStationFetcher alloc] init];
    [self.stationFetcher fetchStationsFromFileWithCompletion:^(NSDictionary *data, NSError *error) {
        if (!error) {
            NSLog(@"done");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)setupNavigationBar {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.placeholder = @"";
    [self.searchController.searchBar setValue:@"Отмена" forKey:@"cancelButtonText"];
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchString = searchController.searchBar.text;
    [self.tableView reloadData];
}

- (void)dealloc {
    [self.searchController.view removeFromSuperview];
}

@end
