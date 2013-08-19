//
//  ManpowerEmployeeViewController.m
//  Manpower
//
//  Created by Hongcheol Park on 8/17/13.
//  Copyright (c) 2013 Hongcheol Park. All rights reserved.
//

#import "ManpowerEmployeeViewController.h"
#import "ManpowerEmployeeCell.h"
#import "Employee.h"

@interface ManpowerEmployeeViewController ()

@end

@implementation ManpowerEmployeeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self searchAll];
}

- (void)searchAll {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSArray *result = [context executeFetchRequest:request error:&error];
    self.employees = [NSArray arrayWithArray:result];
}

- (void)searchAllAndSort {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sorters = [NSArray arrayWithObject:numberSort];
    
    [request setEntity:entity];
    [request setSortDescriptors:sorters];
    
    NSArray *result = [context executeFetchRequest:request error:&error];
    self.employees = [NSArray arrayWithArray:result];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.employees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    ManpowerEmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Employee *employee = [self.employees objectAtIndex:indexPath.row];
    
    [cell.employeeNumber setText:employee.number];
    [cell.employeeName setText:employee.name];
    [cell.departmentName setText:employee.department.name];
    
    return cell;
}

@end
