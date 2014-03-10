//
//  ViewController.h
//  UISearchBar
//
//  Created by veggie freak on 3/4/14.
//  Copyright (c) 2014 veggie freak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray * initialCities;
@property (nonatomic, strong) NSMutableArray * filteredCities;

@property BOOL isFiltered;

@end
