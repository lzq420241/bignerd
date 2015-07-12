//
//  BNRContainer.m
//  RandomPossessions
//
//  Created by LiZiqiang on 7/11/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer
@synthesize subItems, containerValue, reportIndentation;

+ (NSString *)tabs:(int)tab_cnt
{
    NSMutableString *tabs = [[NSMutableString alloc] init];
    for (int i = 0; i < tab_cnt; i++) {
        [tabs appendString:@"\t"];
    }
    return tabs;
}

- (id)initWithItems:(NSArray *)items
      containerName:(NSString *)cName
     containerValue:(int)cValue
   conntainerNumber:(NSString *)cSNumber
{
    self = [super initWithItemName:cName
                    valueInDollars:cValue
                      serialNumber:cSNumber];
    
    if (self) {
        [self setSubItems:items];
        [self setContainerValue:cValue];
        [self setReportIndentation:1];
        [self setValueInDollars:[self getTotalValue]];
    }
    return self;
}

- (id)init
{
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        BNRItem *p = [BNRItem randomItem];
        [items addObject:p];
    }
    
    return [self initWithItems:items
                  containerName:@"Container"
                 containerValue:3
               conntainerNumber:randomSerialNumber];
}

// valueInDollars must be used as totalValue,
// variable from base class makes recursive totalValue calculation easy to be implemented.
- (int)getTotalValue
{
    int totalValue = containerValue;
    for (BNRItem *item in subItems) {
        totalValue += [item valueInDollars];
    }
    return totalValue;
}

- (NSString *)getSubItemDesc
{
    NSMutableString *item_desc = [[NSMutableString alloc] init];
    for (BNRItem *item in subItems) {
        if ([item class] == [BNRContainer class]) {
            // Indentate when subItem is a BNRContainer
            [(BNRContainer *)item setReportIndentation:reportIndentation+1];
        }
        [item_desc appendString:[[NSString alloc] initWithFormat:@"\n%@%@",[BNRContainer tabs:reportIndentation],item]];
    }
    return item_desc;
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@); Worth $%d, recorded on %@, has %lu items %@",
                                   itemName, serialNumber, valueInDollars, dateCreated, (unsigned long)[subItems count],[self getSubItemDesc]];
    
    return descriptionString;
}
@end
