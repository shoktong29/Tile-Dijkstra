//
//  Node.h
//  TPS2
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    nodeTypeBlock       = 0,
    nodeTypeWalkable    = 1,
}NodeType;

@interface Node : NSObject

@property (nonatomic,assign) int cost;
@property (nonatomic,retain) __strong NSString *name;
@property (nonatomic,readonly) NSString *nodeId;
@property (nonatomic,readonly) NodeType mType;
@property (nonatomic,assign) Node *parentNode;

/* Can be use if node will be of constellation type. */
- (id)initNodeId:(NSString *)nodeId withName:(NSString *)name withCost:(int)cost;

/* Can be use if node will be of grid type. */
- (id)initNodeId:(NSString *)nodeId withType:(NodeType)type;
- (void)setCost:(int)cost;
- (void)setParentNode:(Node *)parentNode;
@end
