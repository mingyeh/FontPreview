//
//  FontListTableViewController.m
//  Fonts
//
//  Created by 叶明 on 9/30/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "FontListTableViewController.h"
#import "FavoritesList.h"
#import "FontSizesViewController.h"
#import "FontInfoViewController.h"

@interface FontListTableViewController ()

@property(assign,nonatomic) CGFloat cellPointSize;

@end

@implementation FontListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIFont *preferredCellFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredCellFont.pointSize;
}

-(UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *) indexPath{
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:_cellPointSize];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.showFavorites){
        self.fontNames = [FavoritesList sharedFavoritesList].favorites;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontName" forIndexPath:indexPath];
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = [self.fontNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.showFavorites;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.showFavorites) return;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *favorite = self.fontNames[indexPath.row];
        [[FavoritesList sharedFavoritesList] removeFavorite:favorite];
        self.fontNames = [FavoritesList sharedFavoritesList].favorites;
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    if([segue.identifier isEqualToString:@"ShowFontSizes"]){
        FontSizesViewController *fontSizeViewController = segue.destinationViewController;
        fontSizeViewController.font = font;
    }
    else if([segue.identifier isEqualToString:@"ShowFontInfo"]){
        FontInfoViewController *fontInfoViewController = segue.destinationViewController;
        fontInfoViewController.font = font;
        fontInfoViewController.favorite = [[FavoritesList sharedFavoritesList].favorites containsObject:font.fontName];
    }
}

@end
