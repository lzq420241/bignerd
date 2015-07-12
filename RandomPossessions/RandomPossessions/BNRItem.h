//
//  BNRItem.h
//  RandomPossessions
//
//  Created by LiZiqiang on 7/11/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *itemName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
}


+ (id)randomItem;

- (id)initWithItemName: (NSString *)name
        valueInDollars: (int)value
          serialNumber: (NSString *)sNumber;

- (id)initWithItemName: (NSString *)name
          serialNumber: (NSString *)sNumber;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@end
