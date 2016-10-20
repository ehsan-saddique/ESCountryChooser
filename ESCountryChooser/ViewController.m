//
//  ViewController.m
//  ESCountryChooser
//
//  Created by Ehsan Saddique on 20/10/2016.
//  Copyright © 2016 Ehsan Saddique. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSelectCountryAction:(id)sender {
    ESCountryTableViewController *viewController = (ESCountryTableViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ESCountryTableViewController"];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)sender:(id)sender didSelectCountry:(ESCountry *)country {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.lblCountry.text = country.name;
}

-(void)didCancelSender:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
