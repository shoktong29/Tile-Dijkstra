//
//  ViewController.h
//  TextParser
//
//  Created by martin magalong on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NodeManager;
@class EdgeManager;
@class Node;
@interface ViewController : UIViewController
{
    NodeManager *_nodeManager;
    EdgeManager *_edgeManager;
    NSMutableDictionary *_listView;
    
    Node *_start;
    Node *_end;
    
    int _gridRows;
    int _gridCols;
}

@end
