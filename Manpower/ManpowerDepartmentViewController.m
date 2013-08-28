//
//  ManpowerDepartmentViewController.m
//  Manpower
//
//  Created by Hongcheol Park on 8/17/13.
//  Copyright (c) 2013 Hongcheol Park. All rights reserved.
//

#import "ManpowerDepartmentViewController.h"
#import "ManpowerDepartmentCell.h"
#import "Department.h"

@interface ManpowerDepartmentViewController ()

@end

@implementation ManpowerDepartmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self searchAll];
    [self searchAllAndSort];
}

- (void)searchAll {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSArray *result = [context executeFetchRequest:request error:&error];
    self.departments = [NSArray arrayWithArray:result];
}

- (void)searchAllAndSort {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
    
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sorters = [NSArray arrayWithObject:numberSort];
    
    [request setEntity:entity];
    [request setSortDescriptors:sorters];
    
    NSArray *result = [context executeFetchRequest:request error:&error];
    self.departments = [NSArray arrayWithArray:result];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.departments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DepartmentCell";
    ManpowerDepartmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Department *department = [self.departments objectAtIndex:indexPath.row];
    
    [cell.departmentNumber setText:department.number];
    [cell.departmentName setText:department.name];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel *departmentNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width / 2, headerView.frame.size.height)];
    [departmentNumber setText:@"부서번호"];
    [departmentNumber setTextAlignment:NSTextAlignmentCenter];
    [departmentNumber setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:departmentNumber];
    
    UILabel *departmentName = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.size.width / 2, 0, headerView.frame.size.width / 2, headerView.frame.size.height)];
    [departmentName setText:@"부서이름"];
    [departmentName setTextAlignment:NSTextAlignmentCenter];
    [departmentName setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:departmentName];
    
    return headerView;
}

@end
