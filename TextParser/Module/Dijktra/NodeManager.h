//
//  NodeManager.h
//  TPS
//
//  Created by martin magalong on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
@interface NodeManager : NSObject
{
    
}
@property(nonatomic,readonly) __strong NSMutableArray *nodeList;

- (void)generateNodeWithid:(NSString *)nodeId withName:(NSString *)name;
- (void)generateNodeWithid:(NSString *)nodeId withType:(NodeType)type;
- (Node *)getNodeWithId:(NSString *)nodeId;
- (void)clearAllNodeParents;
@end
