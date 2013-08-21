//
//  Department.h
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 16..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * name;

@end
