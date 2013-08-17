//
//  ManpowerDepartmentTableViewController.m
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

    [self searchAll];
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

@end
