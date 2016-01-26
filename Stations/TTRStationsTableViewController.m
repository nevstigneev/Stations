//
//  TTRStationsTableViewController.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStationsTableViewController.h"
#import "TTRStationFetcher.h"
#import "TTRCity.h"
#import "TTRStation.h"

@interface TTRStationsTableViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) TTRStationFetcher *stationFetcher;
@property (strong, nonatomic) NSArray<TTRCity *> *cities;

@end

@implementation TTRStationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupSearchController];
    self.cities = [[NSArray alloc] init];
    self.stationFetcher = [[TTRStationFetcher alloc] init];
    [self refreshTable];

}

- (void)refreshTable {
    [self.stationFetcher fetchStationsFromFileWithCompletion:^(NSArray<TTRCity *> *data, NSError *error) {
        if (!error) {
            self.cities = data;
            [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TTRCity *city = self.cities[section];
    NSArray<TTRStation *> *stations = city.stations;
    return stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TTRStationCell" forIndexPath:indexPath];
    TTRCity *city = self.cities[indexPath.section];
    NSArray<TTRStation *> *stations = city.stations;
    TTRStation *station = stations[indexPath.row];
    cell.textLabel.text = station.stationTitle;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cities.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    TTRCity *city = self.cities[section];
    return [NSString stringWithFormat:@"%@, %@", city.cityTitle, city.countryTitle];
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
