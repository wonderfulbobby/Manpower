//
//  ManpowerAddViewController.h
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManpowerAddViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *entityType;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) UITextField *employeeNumber;
@property (strong, nonatomic) UITextField *employeeName;
@property (strong, nonatomic) UITextField *departmentNameForEmployee;
@property (strong, nonatomic) UITextField *departmentNumber;
@property (strong, nonatomic) UITextField *departmentName;

- (IBAction)add:(id)sender;
- (IBAction)changedEntityType:(id)sender;

@end
