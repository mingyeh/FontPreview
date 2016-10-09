//
//  FontListTableViewController.h
//  Fonts
//
//  Created by 叶明 on 9/30/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListTableViewController : UITableViewController

@property(copy,nonatomic)NSArray *fontNames;
@property(assign,nonatomic) BOOL showFavorites;

@end
