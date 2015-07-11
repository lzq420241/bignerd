//
//  main.m
//  RandomPossessions
//
//  Created by LiZiqiang on 7/11/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRContainer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create a mutable array object, store its adddress in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 2; i++) {
            BNRContainer *p = [[BNRContainer alloc] init];
            [items addObject:p];
        }
        
        // Bronze Challenge
        //NSLog(@"%@", [items objectAtIndex:10]);
        
        for (BNRContainer *item in items) {
            NSLog(@"%@", item);
        }
        
        BNRContainer *superContainer = [[BNRContainer alloc] initWithItems:items
                                               containerName:@"SuperContainer"
                                              containerValue:10
                                            conntainerNumber:@"1A1A1"];
        NSLog(@"%@", superContainer);
        
        NSMutableArray *new_item = [[NSMutableArray alloc] init];
        [new_item addObject:(id)superContainer];
        [new_item addObject:(id)[items objectAtIndex:0]];
        [new_item addObject:(id)superContainer];
        [new_item addObject:(id)[items objectAtIndex:1]];
        BNRContainer *ultraContainer = [[BNRContainer alloc] initWithItems:new_item
                                                             containerName:@"UltraContainer"
                                                            containerValue:10
                                                          conntainerNumber:@"0A0A0"];
        NSLog(@"%@", ultraContainer);
        
        items = nil;
    }
    return 0;
}
