//
//  ManpowerDeleteViewController.m
//  Manpower
//
//  Created by Hongcheol Park on 13. 8. 15..
//  Copyright (c) 2013년 Hongcheol Park. All rights reserved.
//

#import "ManpowerDeleteViewController.h"

@interface ManpowerDeleteViewController ()

@end

@implementation ManpowerDeleteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.deleteButton setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextField) name:UITextFieldTextDidChangeNotification object:nil];
}

- (IBAction)remove:(id)sender {
    ManpowerAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeEmployee) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.targetText.text];
        [request setPredicate:predicate];
        
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if ([result count] > 0) {
            Employee *employee = [result objectAtIndex:0];
            [context deleteObject:employee];
            NSString *resultContent = @"삭제되었습니다.";
            [self.resultTextView setText:resultContent];
        } else {
            NSString *resultContent = @"데이터가 존재하지 않습니다.";
            [self.resultTextView setText:resultContent];
        }
    } else if (self.entityType.selectedSegmentIndex == ManpowerEntityTypeDepartment) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
        [request setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.targetText.text];
        [request setPredicate:predicate];
        
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if ([result count] > 0) {
            Department *department = [result objectAtIndex:0];
            [context deleteObject:department];
            NSString *resultContent = @"삭제되었습니다.";
            [self.resultTextView setText:resultContent];
        } else {
            NSString *resultContent = @"데이터가 존재하지 않습니다.";
            [self.resultTextView setText:resultContent];
        }
    }
}

- (IBAction)changedEntityType:(id)sender {
    if (self.targetText.text.length > 0) {
        [self.deleteButton setHidden:NO];
    } else {
        [self.deleteButton setHidden:YES];
    }
}

- (void)checkTextField {
    if (self.targetText.text.length > 0) {
        [self.deleteButton setHidden:NO];
    } else {
        [self.deleteButton setHidden:YES];
    }
}

@end
