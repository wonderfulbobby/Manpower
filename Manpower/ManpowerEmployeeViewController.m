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
//    [self searchAllAndSort];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel *employeeNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width / 3, headerView.frame.size.height)];
    [employeeNumber setText:@"사원번호"];
    [employeeNumber setTextAlignment:NSTextAlignmentCenter];
    [employeeNumber setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:employeeNumber];
    
    UILabel *employeeName = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width / 3 - 1, 0, headerView.frame.size.width / 3 + 2, headerView.frame.size.height)];
    [employeeName setText:@"사원이름"];
    [employeeName setTextAlignment:NSTextAlignmentCenter];
    [employeeName setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:employeeName];
    
    UILabel *departmentName = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width / 3 * 2, 0, headerView.frame.size.width / 3, headerView.frame.size.height)];
    [departmentName setText:@"부서이름"];
    [departmentName setTextAlignment:NSTextAlignmentCenter];
    [departmentName setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:departmentName];
    
    return headerView;
}

@end
