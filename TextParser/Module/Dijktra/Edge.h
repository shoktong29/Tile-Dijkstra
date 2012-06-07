//
//  Path.h
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;
@interface Edge : NSObject
{
    
}
@property(nonatomic,assign) __unsafe_unretained Node *start;
@property(nonatomic,assign) __unsafe_unretained Node *end;
@property(nonatomic,assign) int cost;

-(id)initEdgeFromNode:(Node *)start WithEndNode:(Node *)end withCost:(int)cost;
@end
