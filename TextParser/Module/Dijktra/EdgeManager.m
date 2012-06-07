//
//  EdgeManager.m
//  TextParser
//
//  Created by martin magalong on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EdgeManager.h"
#import "NodeManager.h"
@implementation EdgeManager
@synthesize edgeList =_edgeList;
@synthesize nodeManager = _nodeManager;

- (id)initWithNodeManager:(NodeManager *)manager;
{
    self = [super init];
    if (self) {
        _nodeManager = manager;
        _edgeList = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)generateEdgeForNode:(Node *)node
{
    //parse node details
    NSString *nodeId = [NSString stringWithFormat:@"%@",node.nodeId];
    NSMutableString *string1 = [NSMutableString stringWithString:nodeId];
    NSString *stringx = [string1 substringWithRange: NSMakeRange (0, 1)];
    NSString *stringy = [string1 substringWithRange:NSMakeRange(2, 1)];
    int x = [stringx intValue];
    int y = [stringy intValue];
    
    if(node.mType == nodeTypeWalkable) // make sure node is walkable before checking neighbor
    {
        for(int i=-1; i<2; i++){
            for (int j=-1; j<2; j++) {
                //get neigborkey
                NSString *neighborKey = [NSString stringWithFormat:@"%d-%d",x+i,y+j];
                Node *neighbor = [_nodeManager getNodeWithId:neighborKey];
                if(node != neighbor) //checks if currentnode is same with neighbor
                {
                    if (neighbor.mType == nodeTypeWalkable) {
                        int cost = 10;
                        //diagonal neighbors have different cost values
                        if((i==1 && j == 1) || (i==-1 && j== 1) || (i==1 && j== -1) || (i==-1 && j== -1)){
                            cost = 14;
                        }
                        //generate edge between current node and neighbor.
                        Edge *edge = [[Edge alloc]initEdgeFromNode:node WithEndNode:neighbor withCost:cost];
                        [_edgeList addObject:edge];
                    }
                }
            }
        }
    }
}

- (void)dealloc
{
    _edgeList = nil;
}
@end
