//
//  ManpowerAddViewController.m
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import "ManpowerAddViewController.h"

@interface ManpowerAddViewController ()

@end

@implementation ManpowerAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.addButton setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextField) name:UITextFieldTextDidChangeNotification object:nil];
    
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        [self makeEmployeeInfoInputView];
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        [self makeDepartmentInfoInputView];
    }
}

- (void)makeEmployeeInfoInputView {
    UILabel *employeeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 83, 59, 21)];
    [employeeNumberLabel setText:@"사원번호"];
    [employeeNumberLabel setFont:[UIFont systemFontOfSize:17]];
    
    UITextField *employeeNumber = [[UITextField alloc] initWithFrame:CGRectMake(87, 79, 213, 30)];
    [employeeNumber setBorderStyle:UITextBorderStyleRoundedRect];
    
    UILabel *employeeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 116, 59, 21)];
    [employeeNameLabel setText:@"사원이름"];
    [employeeNameLabel setFont:[UIFont systemFontOfSize:17]];
    
    UITextField *employeeName = [[UITextField alloc] initWithFrame:CGRectMake(87, 112, 213, 30)];
    [employeeName setBorderStyle:UITextBorderStyleRoundedRect];
    
    UILabel *departmentNameforEmployeeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 149, 59, 21)];
    [departmentNameforEmployeeLabel setText:@"부서이름"];
    [departmentNameforEmployeeLabel setFont:[UIFont systemFontOfSize:17]];
    
    UITextField *departmentNameForEmployee = [[UITextField alloc] initWithFrame:CGRectMake(87, 145, 213, 30)];
    [departmentNameForEmployee setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.view addSubview:employeeNumberLabel];
    [self.view addSubview:employeeNameLabel];
    [self.view addSubview:departmentNameforEmployeeLabel];
    
    [self.view addSubview:employeeNumber];
    [self.view addSubview:employeeName];
    [self.view addSubview:departmentNameForEmployee];
    
    self.employeeNumber = employeeNumber;
    self.employeeName = employeeName;
    self.departmentNameForEmployee = departmentNameForEmployee;
}

- (void)makeDepartmentInfoInputView {
    UILabel *departmentNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 83, 59, 21)];
    [departmentNumberLabel setText:@"부서번호"];
    [departmentNumberLabel setFont:[UIFont systemFontOfSize:17]];
    
    UITextField *departmentNumber = [[UITextField alloc] initWithFrame:CGRectMake(87, 79, 213, 30)];
    [departmentNumber setBorderStyle:UITextBorderStyleRoundedRect];
    
    UILabel *departmentNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 116, 59, 21)];
    [departmentNameLabel setText:@"부서이름"];
    [departmentNameLabel setFont:[UIFont systemFontOfSize:17]];
    
    UITextField *departmentName = [[UITextField alloc] initWithFrame:CGRectMake(87, 112, 213, 30)];
    [departmentName setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.view addSubview:departmentNumberLabel];
    [self.view addSubview:departmentNameLabel];
    
    [self.view addSubview:departmentNumber];
    [self.view addSubview:departmentName];
    
    self.departmentNumber = departmentNumber;
    self.departmentName = departmentName;
}

- (IBAction)add:(id)sender {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.departmentNameForEmployee.text];
        [request setPredicate:predicate];
        
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if ([result count] > 0) {
            Department *department = [result objectAtIndex:0];
            
            Employee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
            [newEmployee setNumber:self.employeeNumber.text];
            [newEmployee setName:self.employeeName.text];
            [newEmployee setDepartment:department];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Manpower" message:@"존재하지 않는 부서입니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        Department *newDepartment = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:context];
        [newDepartment setNumber:self.departmentNumber.text];
        [newDepartment setName:self.departmentName.text];
    }
    
    [context save:&error];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Manpower" message:@"추가되었습니다." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)changedEntityType:(id)sender {    
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UITextField class]]) {
            [view removeFromSuperview];
        }
    }
    
    [self.addButton setHidden:YES];
    
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        [self makeEmployeeInfoInputView];
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        [self makeDepartmentInfoInputView];
    }
}

- (void)checkTextField {
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        if (self.employeeNumber.text.length > 0 && self.employeeName.text.length > 0 && self.departmentNameForEmployee.text.length > 0) {
            [self.addButton setHidden:NO];
        } else {
            [self.addButton setHidden:YES];
        }
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        if (self.departmentNumber.text.length > 0 && self.departmentName.text.length > 0) {
            [self.addButton setHidden:NO];
        } else {
            [self.addButton setHidden:YES];
        }
    }
}

@end
