//
//  AssetType.h
//  ProEndoscopy 2
//
//  Created by roberto arciniegas on 12/9/15.
//  Copyright (c) 2015 Team D. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface AssetType : NSManagedObject

@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSSet *itemAsset;
@end

@interface AssetType (CoreDataGeneratedAccessors)

- (void)addItemAssetObject:(Item *)value;
- (void)removeItemAssetObject:(Item *)value;
- (void)addItemAsset:(NSSet *)values;
- (void)removeItemAsset:(NSSet *)values;

@end
