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
    self.stationFetcher = [[TTRStationFetcher alloc] initWithCitiesType:self.citiesType];
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
    if (section < self.cities.count) {
        TTRCity *city = self.cities[section];
        NSArray<TTRStation *> *stations = city.stations;
        return stations.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TTRStationCell" forIndexPath:indexPath];
    if (indexPath.section < self.cities.count) {
        TTRCity *city = self.cities[indexPath.section];
        NSArray<TTRStation *> *stations = city.stations;
        if (indexPath.row < stations.count) {
            TTRStation *station = stations[indexPath.row];
            cell.textLabel.text = station.stationTitle;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cities.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section < self.cities.count) {
        TTRCity *city = self.cities[section];
        return [NSString stringWithFormat:@"%@, %@", city.cityTitle, city.countryTitle];
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section >= self.cities.count) {
        return;
    }
    TTRCity *city = self.cities[indexPath.section];
    if (indexPath.row >= city.stations.count) {
        return;
    }
    TTRStation *station = city.stations[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(stationsTableViewController:stationSelected:)]) {
        [self.delegate stationsTableViewController:self stationSelected:station.stationTitle];
    }
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    if (!searchString.length) {
        [self refreshTable];
        return;
    }
    NSPredicate *stationPredicate = [NSPredicate predicateWithFormat:@"stationTitle CONTAINS[c] %@", searchString];
    NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"stations.@count > 0"];
    [self.stationFetcher fetchStationsFromFileWithCompletion:^(NSArray<TTRCity *> *data, NSError *error) {
        self.cities = data;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (TTRCity *city in self.cities) {
                city.stations = [city.stations filteredArrayUsingPredicate:stationPredicate];
            }
            self.cities = [self.cities filteredArrayUsingPredicate:cityPredicate];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
    }];
}

- (void)dealloc {
    [self.searchController.view removeFromSuperview];
}

@end
