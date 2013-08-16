//
//  ManpowerDeleteViewController.h
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManpowerAppDelegate.h"

@interface ManpowerDeleteViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *entityType;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UITextField *targetText;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;

- (IBAction)remove:(id)sender;
- (IBAction)changedEntityType:(id)sender;

@end
