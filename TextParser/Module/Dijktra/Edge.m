//
//  Path.m
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"
#import "Node.h"

@implementation Edge
@synthesize start = _start;
@synthesize end = _end;
@synthesize cost = _cost;

-(id)initEdgeFromNode:(Node *)start WithEndNode:(Node *)end withCost:(int)cost
{
    self = [super init];
    if(self)
    {
        _start = start;
        _end = end;
        _cost = cost;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : StartId=%@ EndId=%@ cost=%d",[super description],_start.nodeId,_end.nodeId,_cost];
}

@end
