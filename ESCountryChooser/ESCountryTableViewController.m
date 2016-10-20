//
//  ESCountryTableViewController.m
//  ESCountryChooser
//
//  Created by Ehsan Saddique on 10/08/2016.
//  Copyright © 2016 Ehsan Saddique. All rights reserved.
//

#import "ESCountryTableViewController.h"

@interface ESCountryTableViewController ()

@property(nonatomic) NSPredicate* searchPredicate;
@property(assign) BOOL isSearchActive;
@property (nonatomic, strong) UISearchController *searchController;

@property(nonatomic) NSArray *countryList;
@property(nonatomic) NSArray *searchResults;

@end

@implementation ESCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResults = [NSArray new];
    self.countryList = [NSArray new];
    
    self.countryList = [self allCountriesList];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.scopeButtonTitles = [NSArray array];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
    
    self.navigationItem.title = @"Choose Country";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)cancelButtonTapped {
    if (self.delegate != nil) {
        [self.delegate didCancelSender:self];
    }
}

#pragma mark - UISearchController

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    [self.navigationController.navigationBar setTranslucent:YES];
}

-(void)willDismissSearchController:(UISearchController *)searchController
{
    [self.navigationController.navigationBar setTranslucent:NO];
}

#pragma mark - UISearchResultsUpdating
// Called when the search bar becomes the first responder or when the user makes changes inside the search bar.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    if (searchString.length == 0) {
        self.isSearchActive = NO;
        [self.tableView reloadData];
    }else{
        self.isSearchActive = YES;
        [self searchForText:searchString scope:self.searchController.searchBar.selectedScopeButtonIndex];
        [self.tableView reloadData];
    }
}

- (void)searchForText:(NSString *)searchText scope:(NSUInteger)scopeOption {
    self.searchPredicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@ OR SELF.ISOCode CONTAINS[cd] %@",searchText, searchText];
    self.searchResults = [self.countryList filteredArrayUsingPredicate:self.searchPredicate];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if (self.isSearchActive) {
        rows =  self.searchResults.count;
    }else{
        rows =  self.countryList.count;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    ESCountry* country = [[ESCountry alloc] init];
    if (self.isSearchActive) {
        country = [self.searchResults objectAtIndex:indexPath.row];
    }else{
        country = [self.countryList objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = country.ISOCode;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ESCountry* country = [[ESCountry alloc] init];
    if (self.isSearchActive) {
        country = [self.searchResults objectAtIndex:indexPath.row];
    }else{
        country = [self.countryList objectAtIndex:indexPath.row];
        
    }
    
    if (self.delegate != nil) {
        [self.delegate sender:self didSelectCountry:country];
    }
    
    
}

#pragma mark Custom

-(NSArray *)allCountriesList {
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryCodesArray = [NSLocale ISOCountryCodes];
    NSMutableArray *countriesList = [NSMutableArray new];
    
    for (NSString *countryCode in countryCodesArray) {
        
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        if (displayNameString != nil) {
            ESCountry *country = [[ESCountry alloc] init];
            country.name = displayNameString;
            country.ISOCode = countryCode;
            [countriesList addObject:country];
        }
        
    }
    return countriesList;
}

@end
