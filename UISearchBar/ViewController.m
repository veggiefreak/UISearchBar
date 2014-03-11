//
//  ViewController.m
//  UISearchBar
//
//  Created by veggie freak on 3/4/14.
//  Copyright (c) 2014 veggie freak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray * initialCities;
@property (nonatomic, strong) NSMutableArray * filteredCities;

@property BOOL isFiltered;

@end

@implementation ViewController

static NSString *CellIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    self.initialCities = [@[@"London", @"SF", @"Tokyo"] mutableCopy];
//    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
        self.initialCities = [[NSMutableArray alloc]initWithObjects:@"London", @"SF", @"Tokyo", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFiltered == YES)
    {
        return self.filteredCities.count;
    }
    else
    {
        return self.initialCities.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.isFiltered == YES)
    {
        cell.textLabel.text = [self.filteredCities objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.initialCities objectAtIndex:indexPath.row];
    }
    
    return cell;
}

//#pragme mark -
//#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        self.isFiltered = NO;
    }
    else
    {
        self.isFiltered = YES;
        self.filteredCities = [[NSMutableArray alloc]init];
        
        //Fast enumerate
        for (NSString * cityName in self.initialCities)
        {
            NSRange cityNameRange = [cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (cityNameRange.location != NSNotFound)
            {
                [self.filteredCities addObject:cityName];
            }
        
        }
    }
    
    //Reload our table view
    [self.myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
}

@end
