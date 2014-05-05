//
//  SDTestController.h
//  CapitalOfNations
//
//  Created by sanket on 23/04/2014.
//  Copyright (c) 2014 Techmentation. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@interface SDTestController :UIViewController

{
    NSURLConnection *theConnection;
    
    NSMutableDictionary *dictionaryfortest;
    NSMutableDictionary *mainDict;
    NSMutableDictionary *testInstance;
    
    int questionnumber;
    int testmarks;
    
    
    
}


@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIButton *option1;
@property (strong, nonatomic) IBOutlet UIButton *option2;
@property (strong, nonatomic) IBOutlet UIButton *option3;


@end
