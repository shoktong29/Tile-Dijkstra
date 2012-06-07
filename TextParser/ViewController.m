//
//  ViewController.m
//  TextParser
//
//  Created by martin magalong on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "NodeManager.h"
#import "EdgeManager.h"
#import "Dijktra.h"

#define START_NODE_ID @"0-0"
#define END_NODE_ID @"5-4"

#define CELL_HEIGHT 45
#define CELL_WIDTH 45


@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Makes instance of nodeManager
        NodeManager *nodeManager = [[NodeManager alloc] init];
        _nodeManager = nodeManager;
        
        //Makes instance of edgeManager. Intentionally added _nodeManager as parameter 
        EdgeManager *edgeManager = [[EdgeManager alloc]initWithNodeManager:_nodeManager];
        _edgeManager = edgeManager;
        [self createGraphFromFile:@"GraphData"];
        
        //select start and end node
        _start = [_nodeManager getNodeWithId:START_NODE_ID];
        _gridRows = 6;
        _gridCols = 6;

    }
    return self;
}
#pragma mark - Text file processing, nodes and edges creation
- (void)createGraphFromFile:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    //remove commas in string
    contents =  [contents stringByReplacingOccurrencesOfString:@","
                                                    withString:@""];
    //put into array for processing
    NSArray* lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(int y=0; y<lines.count; y++)
    {
        NSString *line = [lines objectAtIndex:y];
        for (int x=0; x<line.length; x++) {
            
            //display the character;
            NSString *uniqueId = [NSString stringWithFormat:@"%d-%d",x,y];
            NSString *value = [NSString stringWithFormat:@"%@",[line substringWithRange: NSMakeRange (x, 1)]];
            NodeType type = -1;
            if(value.intValue == 1)
            {
                type = nodeTypeWalkable;
            }
            else {
                type = nodeTypeBlock;
            }
            
            [_nodeManager generateNodeWithid:uniqueId withType:type];
        }
    }
    [self generateEdges];
}

- (void)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error
{
    
}


- (void)generateEdges
{
    for(int x=0; x<_nodeManager.nodeList.count; x++)
    {
        Node *node = [_nodeManager.nodeList objectAtIndex:x];
        [_edgeManager generateEdgeForNode:node];
    }
}

#pragma mark - Dijkstra
- (void)getPath
{
    int shortestPathCost = [Dijktra findPath:_start withEnd:_end withEdges:[_edgeManager edgeList] withNodeManager:_nodeManager];
    NSLog(@"The cost of going from %@ and %@ is %d",[_nodeManager getNodeWithId:_start.nodeId].nodeId,[_nodeManager getNodeWithId:_end.nodeId].nodeId ,shortestPathCost);
    
    NSMutableArray *path = [[NSMutableArray alloc]init];
    [Dijktra getPath:[_nodeManager getNodeWithId:_end.nodeId] container:path];
    
    //clear parents 
    
    _start = _end;
    _end = nil;
    [_nodeManager clearAllNodeParents];
    [path removeAllObjects];
    path = nil;
}

#pragma mark - render
- (void)generateViews
{
    for (int x=0; x<_gridCols; x++){
        for(int y=0; y<_gridRows; y++){
            NSString *uniqueId = [NSString stringWithFormat:@"%d-%d",x,y];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x*CELL_WIDTH, y*CELL_HEIGHT, CELL_WIDTH-3, CELL_HEIGHT-3)];
            Node *node = [_nodeManager getNodeWithId:uniqueId];
            view.backgroundColor = (node.mType == 1)?[UIColor greenColor]:[UIColor blackColor];
            
            [self.view addSubview:view];
            [_listView setObject:view forKey:uniqueId];
        }
    }
}

#pragma mark - Default methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //CGPoint touchLocation = [self.view convertTouchToNodeSpace:point];
    CGSize cellSize = CGSizeMake(CELL_WIDTH,CELL_HEIGHT);
    
    int x = (int)point.x / cellSize.width;
    int y = (int)point.y / cellSize.height;
    _end = [_nodeManager getNodeWithId:[NSString stringWithFormat:@"%d-%d",x, y]];
    
    if (_end.mType == nodeTypeWalkable) {
        if(x>= 0 && x<_gridCols){
            if(y>=0 && y<_gridRows){
                [self getPath];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self generateViews];
}

@end
