//
//  EdgeManager.h
//  TextParser
//
//  Created by martin magalong on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Edge.h"

@class Node;
@class NodeManager;
@interface EdgeManager : NSObject
{

}
@property (nonatomic, assign) __unsafe_unretained NodeManager *nodeManager;
@property (nonatomic,readonly) __strong NSMutableArray *edgeList;
- (id)initWithNodeManager:(NodeManager *)manager;
- (void)generateEdgeForNode:(Node *)node;
@end
