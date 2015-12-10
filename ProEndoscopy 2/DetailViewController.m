//
//  DetailViewController.m
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/9/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import "DetailViewController.h"
#import "Event.h"

@interface DetailViewController ()  <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UIPickerView *assetField;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DetailViewController

@synthesize pickerData, pickerView, productTextField, serialTextField;

#pragma mark -Init
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        UINavigationItem *navItem = self.navigationItem;
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
        navItem.rightBarButtonItem = bbi;
    }
    return self;
}

#pragma mark - Mehtods
-(IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
    //if the device has a camera take a picture otherwise use the photo album
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    //Place picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    productTextField.placeholder = @"Product name";
    productTextField.keyboardType = UIKeyboardTypeAlphabet;
    
    serialTextField.placeholder = @"Serial number";
    serialTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //this doesnt go here
    pickerData = [[NSArray alloc] initWithObjects:@"Arthroscopy", @"Cystoscopy", @"ENT", @"Gynecology", @"Laparoscopy", @"Urology", @"Hysteroscope", @"Resectoscope", @"Instruments", @"Sets", @"Sale", nil];
    
    [pickerView selectRow:3 inComponent:0 animated:NO];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Event *item = self.item;
    self.itemNameField.text = item.itemName;
    self.serialNumberField.text = item.itemSerial;
    self.descriptionField.text = item.itemDescription;
    self.quantityField.text = [NSString stringWithFormat:@"%d", item.itemQuantity];
    self.priceField.text = [NSString stringWithFormat:@"%d", item.itemPrice];
    
    NSString *imageKey = self.item.timeStamp;
    //Get the image for its image key from the image store
    //UIImage *imageToDisplay = [[ENDImageStore sharedStore]imageForKey:imageKey];
    
    //Use that image to put it into the imageView
    //self.imageView.image = imageToDisplay;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //Clear first responder
    [self.view endEditing:YES];
    
    NSInteger row = [pickerView selectedRowInComponent:0];
    
    //save changes to item
    Event   *item = self.item;
    item.itemName = self.itemNameField.text;
    item.itemSerial = self.serialNumberField.text;
    item.itemDescription = self.descriptionField.text;
    item.itemType = [pickerData objectAtIndex:row];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)setItem:(Event *)item
{
    _item = item;
    self.navigationItem.title = _item.itemSerial;
}

#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [pickerData count];
}
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return [pickerData objectAtIndex:row];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get Picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //Store the image in ENDImageStore
    //[[ENDImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    //put that image onto the screen in our image view
    self.imageView.image = image;
    
    //Take image picker of the screen
    //You mus called this dismiss mehtod
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard
{
    [productTextField resignFirstResponder];
    [serialTextField resignFirstResponder];
}


@end
