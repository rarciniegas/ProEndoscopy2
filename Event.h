//
//  Event.h
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/10/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * itemSerial;
@property (nonatomic, retain) NSNumber * itemQuantity;
@property (nonatomic, retain) NSString * itemType;
@property (nonatomic, retain) NSDecimalNumber * itemPrice;

@end
