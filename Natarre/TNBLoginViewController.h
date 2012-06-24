//
//  TNBLoginViewController.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNBLoginViewController : UIViewController {
    IBOutlet UITextField * emailField;
    IBOutlet UITextField * passwordField;
}

-(IBAction)sumbitButtonWasPressed:(id)sender;

@end
