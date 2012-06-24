//
//  TNBRegisterViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNBAppDelegate.h"

@interface TNBRegisterViewController : UIViewController {
    IBOutlet UITextField * nameField;
    IBOutlet UITextField * emailField;
    IBOutlet UITextField * passwordField;
}

-(IBAction)submitButtonWasPressed:(id)sender;

@end
