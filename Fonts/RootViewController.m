//
//  RootViewController.m
//  Fonts
//
//  Created by 叶明 on 9/20/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "RootViewController.h"
#import "FavoritesList.h"
#import "FontListTableViewController.h"

@interface RootViewController ()

@property (copy,nonatomic) NSArray *familyNames;
@property (assign,nonatomic) CGFloat cellPointSize;
@property (strong,nonatomic) FavoritesList *favoriteList;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    self.favoriteList = [FavoritesList sharedFavoritesList];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(UIFont*)fontForDisoplayAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        NSString *familyName = [self.familyNames objectAtIndex:indexPath.row];
        NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        return [UIFont fontWithName:fontName size:self.cellPointSize];
    }
    else{
        return nil;
    }
}

#pragma mark - TableViewController methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.favoriteList.favorites.count > 0){
        return 2;
    }
    else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.familyNames.count;
    }
    else{
        return 1;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"All Font Families";
    }
    else{
        return @"Favorites";
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *familyNameCell = @"FamilyName";
    static NSString *favoriteCell = @"Favorites";
    UITableViewCell *tableCell = nil;
    
    if(indexPath.section == 0){
        tableCell = [tableView dequeueReusableCellWithIdentifier:familyNameCell forIndexPath:indexPath];
        tableCell.textLabel.font = [self fontForDisoplayAtIndexPath:indexPath];
        tableCell.textLabel.text = self.familyNames[indexPath.row];
        tableCell.detailTextLabel.text = self.familyNames[indexPath.row];
    }
    else{
        tableCell = [tableView dequeueReusableCellWithIdentifier:favoriteCell forIndexPath:indexPath];
    }
    
    return tableCell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    FontListTableViewController *fontListController = segue.destinationViewController;
    
    if(indexPath.section == 0){
        NSString *fontFamily = self.familyNames[indexPath.row];
        fontListController.fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        fontListController.navigationItem.title = fontFamily;
        fontListController.showFavorites = NO;
    }
    else{
        fontListController.fontNames = self.favoriteList.favorites;
        fontListController.navigationItem.title = @"Favorites";
        fontListController.showFavorites = YES;
    }
}


@end
