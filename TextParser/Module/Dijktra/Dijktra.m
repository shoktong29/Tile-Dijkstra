//
//  Dijktra.m
//  TPS
//
//  Created by martin magalong on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dijktra.h"

@implementation Dijktra

+ (int)findPath:(Node *)start withEnd:(Node *)end withEdges:(NSMutableArray *)edgeList withNodeManager:(NodeManager *)nodeManager
{
    NodeManager *_nodeManager = nodeManager;
    
    //1. Set the cost of origin/start node to 0
    [[_nodeManager getNodeWithId:start.nodeId] setCost:0];
    NSMutableArray *_nodeList = [[NSMutableArray alloc]initWithArray:_nodeManager.nodeList];
    
    //2. Get the node with the least cost value in the nodeList
    while (_nodeList.count > 0) {
        _nodeList = [self sortArrayOfDictionary:_nodeList byKey:@"cost"];
        Node *node = [_nodeList objectAtIndex:0];
    //3. Get all the neigbor of the current node and update their cost value
        [_nodeList removeObject:node];
        [self relaxNeighbor:node nodeList:_nodeList edgeList:edgeList];
    }
    
    
    //5. Trace the path starting from the destination to start using nodes' parent.
    //[self getPath:end];
//    NSLog(@"TRAVEL COST: %d",end.cost);
    return  end.cost;
}

+ (void)relaxNeighbor:(Node *)node nodeList:(NSMutableArray *)nodeList edgeList:(NSMutableArray *)edgeList
{
    for (int x=0; x<edgeList.count; x++) {
        Edge *edge = [edgeList objectAtIndex:x];
        if(edge.start.nodeId == node.nodeId){
            //3.1 Get the neighbor of the current node
            int currentCost = edge.end.cost;
            int newCost = node.cost+edge.cost;
            if(newCost < currentCost)
            {
                //3.2 Update the cost of neighbor node if newCost is less than the currentCost
                for(int y=0; y<nodeList.count; y++)
                {
                    Node *end = [nodeList objectAtIndex:y];
                    if (end.nodeId == edge.end.nodeId) {
                        end.cost = newCost;
                        //4. Set the parent of the node for tracing path later
                        [end setParentNode:edge.start];
                        break;
                    }
                }
            }
        }
    }
}

+ (void)getPath:(Node *)node container:(NSMutableArray *)container
{
    NSMutableArray *path = container;
    (node !=nil)?[path insertObject:node atIndex:0]:nil; //catches the error of node is nil
    if(node.parentNode != nil){
        [self getPath:node.parentNode container:path];
    }
    else {
        for (int x=0; x<path.count; x++) {
            NSLog(@" -> %@",[[path objectAtIndex:x] nodeId]);
        }
    }
}

+ (NSMutableArray *)sortArrayOfDictionary:(NSMutableArray *)array byKey:(NSString *)key
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:key ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    return array;
}

@end