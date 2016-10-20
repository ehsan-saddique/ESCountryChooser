//
//  ESCountry.h
//  ESCountryChooser
//
//  Created by Ehsan Saddique on 10/08/2016.
//  Copyright © 2016 Ehsan Saddique. All rights reserved.
//

#import "ESCountry.h"

@implementation ESCountry

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stId = @"";
        self.name = @"";
        self.ISOCode = @"";
    }
    return self;
}

@end
