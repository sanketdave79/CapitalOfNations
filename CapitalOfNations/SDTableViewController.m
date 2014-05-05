//
//  SDTableViewController.m
//  CapitalOfNations
//
//  Created by sanket on 28/03/2014.
//  Copyright (c) 2014 Techmentation. All rights reserved.
//

#import "SDTableViewController.h"
#import "SDTableCell.h"



@interface SDTableViewController ()

@end

@implementation SDTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initializer];
    
    

    
}

- ( void) initializer
{
    NSMutableDictionary *formattedcountrycapitalpairs = [[NSMutableDictionary alloc] init];
    
    
    
    
    mainDict=[[NSMutableDictionary alloc] init];
    
    
    
    
    
    // Ends here
    
    NSMutableArray *allcountries = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *allcapitals = [[NSMutableArray alloc] init];
    
    
    
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(q, ^{
        
        
        
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.techmentation.com/IphoneApplications/capitalsofnations/data.json"]];
        
        NSError *error;
        NSDictionary *parsedDic = [NSJSONSerialization JSONObjectWithData:data options:0 error: &error];
        if(error)
        {
            NSLog(@"There was an error creating the dictionary from the json data: %@", error);
        }
        
        NSDictionary *resultsdic = [parsedDic objectForKey:@"Results"];
        
        
        
        NSMutableDictionary *country_capital_pairs = [NSMutableDictionary dictionary];
        
        
        
        for (NSString * key in resultsdic.allKeys) {
            
            [country_capital_pairs setObject:[[[resultsdic valueForKey:key] valueForKey:@"Capital"] valueForKey:@"Name"]
                                      forKey:[[resultsdic valueForKey:key] valueForKey:@"Name"]];
            
            
        }
        
        
        NSLog(@"Dictionary: %@", [country_capital_pairs description]);
        
        
        int i = 0;
        
        for(id key in [country_capital_pairs allKeys])
        {
            id value = [country_capital_pairs objectForKey:key];
            //  NSLog(@"%@ : %@", key, value);
            
            
            
            [allcountries addObject:key];
            // NSArray *data = [NSArray arrayWithObject:[NSMutableDictionary dictionaryWithObject:@"foo" forKey:@"BAR"]];
            
            
            
            
            if (value == [NSNull null]) {
                value = @"Not Available";
                [mainDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:value,@"capital",key,@"name", nil] forKey:[NSString stringWithFormat:@"%i",i]];
                [allcapitals addObject:value];
                [formattedcountrycapitalpairs setObject:[NSDictionary dictionaryWithObjectsAndKeys:key,@"Country",value,@"Capital", nil] forKey:[NSString stringWithFormat:@"%i",i]];
            }
            else
            {
                [mainDict setObject:[NSDictionary dictionaryWithObjectsAndKeys:value,@"capital",key,@"name", nil] forKey:[NSString stringWithFormat:@"%i",i]];
                [allcapitals addObject:value];
                [formattedcountrycapitalpairs setObject:[NSDictionary dictionaryWithObjectsAndKeys:key,@"Country",value,@"Capital", nil] forKey:[NSString stringWithFormat:@"%i",i]];
                
            }
            
            
            i = i + 1;
            
            
        }
        
       // NSLog(@"mainDict raw data: %@", [mainDict description]);
        int countofarray =0 ;
        
       
        
        NSLog(@"count of objects in dictionary %i",countofarray);
        
        self.dataarray = [NSArray arrayWithObject:formattedcountrycapitalpairs];
        _countries = allcountries;
        _capitals = allcapitals;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    });
    
    

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void) searchThroughData
{
   
    self.resultArray = nil;
    
    
    
    NSPredicate *resultingPredicate = [NSPredicate predicateWithFormat:@"name contains [search] %@ OR capital contains [search] %@", self.searchBar.text, self.searchBar.text];
    
    
    
    self.resultArray = [[[mainDict allValues] filteredArrayUsingPredicate:resultingPredicate ] mutableCopy];
    
    
 
    
    

    
   
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (tableView == self.tableView) {
      return _countries.count;
      
    } else {
       //[self searchThroughData];
        return self.resultArray.count;
        
    }
    // Return the number of rows in the section.
    
    //return self.searchResults.count;
}

- (void)searchBar:(UISearchBar *) searchBar textDidChange:(NSString *)searchText{
    [self searchThroughData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SDTableCell";
    SDTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (!cell) {
        cell = [[SDTableCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SDTableCell"];
        cell.accessoryType = UITableViewCellStyleDefault;
    }
    
    NSInteger row = [indexPath row];
    
    if (tableView == self.tableView) {
        cell.countrylabel.text = _countries[row];
        cell.capitallabel.text = _capitals[row];
        
    }
    else
    {
        UITableViewCell *newCell = cell;  // a small cheat.. need a better solution!
        NSLog(@"Country : %@", [self.resultArray[indexPath.row] valueForKey:@"name"]);
        newCell.textLabel.text = [NSString stringWithFormat: @" %@ : %@", [self.resultArray[indexPath.row] valueForKey:@"name"], [self.resultArray[indexPath.row] valueForKey:@"capital"]];
        //newCell.textLabel.text = [self.resultArray[indexPath.row] valueForKey:@"name"];
    
      
     //   NSLog(@"Capitals : %@", self.resultsforcapitals[indexPath.row]);
        
    }
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


@end
