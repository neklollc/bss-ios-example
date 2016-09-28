//
//  TableViewController.m
//  BSS_iOS_Example
//
//  Created by Air on 29.10.15.
//  Copyright © 2015 NEKLO. All rights reserved.
//

#import "TableViewController.h"

#import "AppDelegate.h"
#import "BSSURLRequest.h"

@interface TableViewController ()

@property (nonatomic, strong) NSArray *objectsList;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultUICustomization];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/news", kObjectKey];
    [BSSURLRequest requestWithType:detailedURL method:@"GET" parameters:nil success:^(NSDictionary *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.objectsList = response[@"data"];
            
            [self.tableView reloadData];
        });
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSError *error) {
        self.objectsList = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error load content" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        });
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private

- (void)defaultUICustomization {
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objectsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kSubTitleTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *jsonObject = [self.objectsList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = jsonObject[@"title"];
    cell.detailTextLabel.text = jsonObject[@"shortDescription"];
    
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [cell.imageView setImage:[UIImage imageNamed:@"default"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonObject[@"thumbnail"]]];
        
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.imageView setImage:image];
                });
            }
        }
    });
    
    return cell;
}

@end
