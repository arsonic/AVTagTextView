//
//  AVHashTagsTableViewController.m
//  AVTagTextView
//
//  Created by Arseniy Vershinin on 9/14/13.
//

#import "AVHashTagsTableViewController.h"

@interface AVHashTagsTableViewController ()

@end

@implementation AVHashTagsTableViewController
@synthesize hashTagsDelegate = _hashTagsDelegate;
@synthesize hashTagsToDisplay = _hashTagsToDisplay;

/*****************************************************/
#pragma mark - UIView Lifecycle
/*****************************************************/

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
}

/*****************************************************/
#pragma mark - AVTagTableViewControllerProtocol
/*****************************************************/

- (void)setHashTagsToDisplay:(NSArray *)hashTagsToDisplay{
    if(_hashTagsToDisplay != hashTagsToDisplay) {
        _hashTagsToDisplay = hashTagsToDisplay;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hashTagsToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *tag = self.hashTagsToDisplay[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"#%@", tag];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.hashTagsDelegate && [self.hashTagsDelegate respondsToSelector:@selector(hashTagSelected:)]){
        [self.hashTagsDelegate hashTagSelected:self.hashTagsToDisplay[indexPath.row]];
    }
}

@end
