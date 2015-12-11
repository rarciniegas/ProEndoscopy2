//
//  DetailViewController.h
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/9/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Event.h"
#import "AppDelegate.h"

@class Event;

@interface DetailViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView    *singlePicker;
    NSArray         *pickerData;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong)Event *item;

@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialTextField;

@property (nonatomic, retain) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

