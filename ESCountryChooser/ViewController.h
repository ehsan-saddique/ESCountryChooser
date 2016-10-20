//
//  ViewController.h
//  ESCountryChooser
//
//  Created by Ehsan Saddique on 20/10/2016.
//  Copyright © 2016 Ehsan Saddique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESCountryTableViewController.h"

@interface ViewController : UIViewController <ESCountryTableViewControllerDelegate>

@property(nonatomic, strong) IBOutlet UILabel* lblCountry;

@end

