//
//  Node.m
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

@implementation Node
@synthesize cost = _cost;
@synthesize name = _name;
@synthesize nodeId = _nodeId;
@synthesize parentNode = _parentNode;
@synthesize mType = _mType;

- (id)initNodeId:(NSString *)nodeId withName:(NSString *)name withCost:(int)cost;
{
    self = [super init];
    if(self)
    {
        _nodeId = nodeId;
        _name = name;
        _cost = cost;
        _parentNode = nil;
    }
    return self;
}

- (id)initNodeId:(NSString *)nodeId withType:(NodeType)type
{
    self = [super init];
    if(self)
    {
        _nodeId = nodeId;
        _name = nil;
        _cost = INT_MAX;
        _parentNode = nil;
        _mType = type;
    }
    return self;
}

- (void)setCost:(int)cost
{
    _cost = cost;
}

- (void)setParentNode:(Node *)parentNode
{
    _parentNode = parentNode;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : nodeId=%@ type=%d cost=%d",[super description],_nodeId,_mType,_cost];
}

- (void)dealloc
{
    
}
@end
