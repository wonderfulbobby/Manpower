//
//  Employee.h
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 16..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * departmentName;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Department *department;

@end
