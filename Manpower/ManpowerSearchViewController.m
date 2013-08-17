//
//  ManpowerSearchViewController.m
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import "ManpowerSearchViewController.h"

@interface ManpowerSearchViewController ()

@end

@implementation ManpowerSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.searchButton setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextField) name:UITextFieldTextDidChangeNotification object:nil];
}

- (IBAction)search:(id)sender {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.searchText.text];
        [request setPredicate:predicate];
        
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if ([result count] > 0) {
            Employee *employee = [result objectAtIndex:0];
            NSString *resultContent = [NSString stringWithFormat:@"사원번호 : %@\n사원이름 : %@\n부서이름 : %@", employee.number, employee.name, employee.departmentName];
            [self.resultTextView setText:resultContent];
        } else {
            NSString *resultContent = @"데이터가 존재하지 않습니다.";
            [self.resultTextView setText:resultContent];
        }
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.searchText.text];
        [request setPredicate:predicate];
        
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if ([result count] > 0) {
            Department *department = [result objectAtIndex:0];
            NSString *resultContent = [NSString stringWithFormat:@"부서번호 : %@\n부서이름 : %@", department.number, department.name];
            [self.resultTextView setText:resultContent];
        } else {
            NSString *resultContent = @"데이터가 존재하지 않습니다.";
            [self.resultTextView setText:resultContent];
        }
    }
}

- (IBAction)changedEntityType:(id)sender {
    self.resultTextView.text = @"";
}

- (void)checkTextField {
    if (self.searchText.text.length > 0) {
        [self.searchButton setHidden:NO];
    } else {
        [self.searchButton setHidden:YES];
    }
}

@end
