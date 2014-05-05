//
//  SDTableViewController.h
//  CapitalOfNations
//
//  Created by sanket on 28/03/2014.
//  Copyright (c) 2014 Techmentation. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SDTableViewController : UITableViewController {
    NSURLConnection *theConnection;
   
    NSMutableDictionary *dictionaryfortest;
    NSMutableDictionary *mainDict;


}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) NSArray *countries;
@property (nonatomic,strong) NSArray *capitals;
@property (nonatomic,strong) NSMutableArray *resultsforcountries;

@property (nonatomic,strong) NSArray *resultArray;




@property (nonatomic, strong) NSArray *dataarray;





@end
