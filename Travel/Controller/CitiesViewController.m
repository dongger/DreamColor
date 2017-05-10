//
//  CitiesViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesModel.h"
#import "CyAlertView.h"
#import "NSObject+Cache.h"
#import "CitiesGroup.h"

@interface CitiesViewController ()
@property NSArray *CitiesData;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CitiesGroup getArrayFromKey:@"kCitiesData"].count > 0) {
        _CitiesData = [CitiesGroup getArrayFromKey:@"kCitiesData"];
        [self.tableView reloadData];
    } else {
        [CitiesModel fetchWithSuccess:^(NSArray *citiesData) {
            [CyAlertView message:[citiesData description]];
            [citiesData saveWithKey:@"kCitiesData"];
            _CitiesData = citiesData;
            [self.tableView reloadData];
        } failure:^(NSString *errorMessage) {
            [CyAlertView message:errorMessage];
        }];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
