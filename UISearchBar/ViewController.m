//
//  ViewController.m
//  UISearchBar
//
//  Created by veggie freak on 3/4/14.
//  Copyright (c) 2014 veggie freak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mySearchBar, myTableView, initialCities, filteredCities, isFiltered;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    initialCities = [[NSMutableArray alloc]initWithObjects:@"London", @"SF", @"Tokyo", nil];
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
    if (isFiltered == YES)
    {
        return filteredCities.count;
    }
    else
    {
        return initialCities.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell
    *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (isFiltered == YES)
    {
        cell.textLabel.text = [filteredCities objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [initialCities objectAtIndex:indexPath.row];
    }
    
    return cell;
}

//#pragme mark -
//#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        isFiltered = YES;
        filteredCities = [[NSMutableArray alloc]init];
        
        //Fast enumerate
        for (NSString * cityName in initialCities)
        {
            NSRange cityNameRange = [cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (cityNameRange.location != NSNotFound)
            {
                [filteredCities addObject:cityName];
            }
        
        }
    }
    
    //Reload our table view
    [myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [mySearchBar resignFirstResponder];
}

@end
