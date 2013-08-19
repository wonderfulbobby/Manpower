//
//  ManpowerEmployeeCell.h
//  Manpower
//
//  Created by Hongcheol Park on 8/17/13.
//  Copyright (c) 2013 Hongcheol Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManpowerEmployeeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *employeeNumber;
@property (strong, nonatomic) IBOutlet UILabel *employeeName;
@property (strong, nonatomic) IBOutlet UILabel *departmentName;

@end
