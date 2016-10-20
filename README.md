#ESCountryChooser

`ESCountryChooser` is a simple API that allows users to choose a country from a searchable list. The available countries are taken from iOS default countries list, whose ISO 3166-1 alpha-2 two-letter country codes are used by the API to represent countries.

#Features

This library provides the following features:
- A country can be selected from a list in a table view.
- The list can be searched using a search bar.
- The list can be searched using a country's name or ISO code e.g "us" for "United States".
- All the countries assigned a ISO 3166-1 alpha-2 two-letter code are available.
- Countries are localised through the NSLocale API methods
- The anatomy of the view presented by `ESCountryChooser` is the following:
  - A UITableViewController is presented.
  - A search bar is added in tableViewHeader.
  - The view is a full screen view designed to be presented modally.
  - The table view presents the list of countries, sorted by name, in the current language of the user.
  
#Prerequisites

This library has been built with Xcode 8 using iOS 8.0 as a build target. This library requires iOS >= 8.

This library requires ARC (Automatic Reference Counting) and compilation will fail if ARC support is not available.

#Usage

First of all you must need to do following things:
- Add a `UITableViewController` in your storyboard.
- Assign `ESCountryTableViewController` class to this controller.
- Assign storyboardID "ESCountryTableViewController" to this controller.
- Add one prototype cell in this table view controller and give it the identifier "Cell".

The `ESCountryTableViewController` must be presented modally by the presenting view controller. The `ESCountryTableViewController` won't dismiss itself when a country is chosen. Instead, `ESCountryTableViewController` instance will rely on a delegate conforming to the `ESCountryTableViewControllerDelegate` protocol to receive the country selection event and to dismiss it.
```objective-c
-(IBAction)btnSelectCountryAction:(id)sender {
    ESCountryTableViewController *viewController = (ESCountryTableViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"ESCountryTableViewController"];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}
```

The `ESCountryTableViewController` protocol defines didSelectCountry method which is invoked when a country has been selected. This method returns an `ESCountry` object which contains all the information of country e.g name and ISO code.
```objective-c
-(void)sender:(id)sender didSelectCountry:(ESCountry *)country {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(country.name);
    NSLog(country.ISOCode);
}
```

If cancel button was pressed then simple dismiss the controller.
```objective-c
-(void)didCancelSender:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
```
