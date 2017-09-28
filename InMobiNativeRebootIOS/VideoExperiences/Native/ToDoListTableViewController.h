//
//  ToDoListTableViewController.h SnipSnap
//  TodoList
//
//  Created by Ankit Mittal on 27/04/15.
//  Copyright (c) 2015 Inmobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableCell.h"
#import "SampleData.h"
#import "DraggableView.h"

#import "IMNativeStrands.h"
#import "IMNativeStrandsDelegate.h"

@interface ToDoListTableViewController : UITableViewController

@property(nonatomic,strong) UIActivityIndicatorView *indicator;
@property (nonatomic, strong) NSString *category_name;

@end
