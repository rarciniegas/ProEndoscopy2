//
//  MasterViewController.h
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/9/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

