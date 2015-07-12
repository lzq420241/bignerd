//
//  BNRContainer.h
//  RandomPossessions
//
//  Created by LiZiqiang on 7/11/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem
{
    NSArray *subItems;
    int containerValue;
    int reportIndentation;
}

+ (NSString *)tabs:(int)tab_cnt;

- (id)initWithItems: (NSArray *)items
       containerName: (NSString *)cName
      containerValue: (int)cValue
    conntainerNumber: (NSString *)cSNumber;

@property (nonatomic, strong) NSArray *subItems;
@property (nonatomic) int containerValue;
@property (nonatomic) int reportIndentation;

@end
