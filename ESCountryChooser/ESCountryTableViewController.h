//
//  ESCountryTableViewController.h
//  ESCountryChooser
//
//  Created by Ehsan Saddique on 10/08/2016.
//  Copyright © 2016 Ehsan Saddique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESCountry.h"

@class ESCountryTableViewController;

@protocol ESCountryTableViewControllerDelegate <NSObject>

@required
-(void)sender:(id)sender didSelectCountry:(ESCountry *)country;
-(void)didCancelSender:(id)sender;

@end

@interface ESCountryTableViewController : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property(nonatomic,weak) id <ESCountryTableViewControllerDelegate> delegate;

@end
