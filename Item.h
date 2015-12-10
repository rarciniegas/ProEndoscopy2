//
//  Item.h
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/9/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AssetType;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * itemKey;
@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) id itemPhoto;
@property (nonatomic, retain) NSDecimalNumber * itemPrice;
@property (nonatomic, retain) NSNumber * itemQuantity;
@property (nonatomic, retain) NSString * itemSerial;
@property (nonatomic, retain) AssetType *itemAsset;

@end
