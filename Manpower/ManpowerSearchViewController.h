//
//  ManpowerSearchViewController.h
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManpowerAppDelegate.h"

@interface ManpowerSearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *entityType;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;

- (IBAction)search:(id)sender;
- (IBAction)changedEntityType:(id)sender;

@end
