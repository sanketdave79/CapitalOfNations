//
//  SDTestController.m
//  CapitalOfNations
//
//  Created by sanket on 23/04/2014.
//  Copyright (c) 2014 Techmentation. All rights reserved.
//

#import "SDTestController.h"

@interface SDTestController ()

@end

@implementation SDTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self testInstanceArrayGenerated];
          
            
        });
    });
    
    
    
    
}


- (NSMutableDictionary *)testInstanceArrayGenerated
{
    testInstance = nil;
    
    testmarks = 0;
    
    questionnumber = 1;
    
    //NSMutableArray *fourRandomlyGeneratedNumbers = [[NSMutableArray alloc] init];
    testInstance = [[NSMutableDictionary alloc] init];
    
    
    
    for (int i = 1; i<=3; i++) {
        
        int randomlychosencountry = arc4random() % [mainDict count];
        int wrongansweroneid = arc4random() % [mainDict count];
        int wronganswertwoid = arc4random() % [mainDict count];
        
        
        NSLog(@"Selected for test: %@",[[mainDict valueForKey:[NSString stringWithFormat:@"%i",arc4random() % [mainDict count]]] valueForKey:@"name"]);
        
        
        NSString *countryname = [[mainDict valueForKey:[NSString stringWithFormat:@"%i",randomlychosencountry]] valueForKey:@"name"];
        
        NSString *capitalname = [[mainDict valueForKey:[NSString stringWithFormat:@"%i",randomlychosencountry]] valueForKey:@"capital"];
        
        NSString *wronganswerone = [[mainDict valueForKey:[NSString stringWithFormat:@"%i",wrongansweroneid]] valueForKey:@"capital"];
        
        NSString *wronganswertwo = [[mainDict valueForKey:[NSString stringWithFormat:@"%i",wronganswertwoid]] valueForKey:@"capital"];
        
        NSString *question = [NSString stringWithFormat:@"What is  captial of %@ ? ",countryname];
        
        [testInstance setObject:[NSDictionary dictionaryWithObjectsAndKeys:question,@"question",capitalname,@"answer",wronganswerone,@"wronganswerone",wronganswertwo,@"wronganswertwo", nil] forKey:[NSString stringWithFormat:@"%i",i]];
        
        
        
       
    }
    NSLog(@"%@",[testInstance description]);
    
   // NSLog(@"Question 1 :%@",[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"question"]);
    
    self.questionLabel.text = [[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"question"];
    
    NSMutableDictionary *randomizeoptions = [[NSMutableDictionary alloc] init];
    
    int option1 = 0;
    int option2 = 0;
    int option3 = 0;
    
   
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"answer",@"option", nil] forKey:[NSString stringWithFormat:@"0"]];
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"wronganswerone",@"option", nil] forKey:[NSString stringWithFormat:@"1"]];
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"wronganswertwo",@"option", nil] forKey:[NSString stringWithFormat:@"2"]];
    
    int candidate = arc4random() % 2;
    option1 = candidate;
    
    
    for (int x = 0; x <= 30; x++)
    {
         candidate = arc4random() % 2;
        if (candidate != option1)
        {
            option2 = candidate;
            break;
        }
        
    }
    
    for (int k = 0; k <= 2; k++)
    {
        
        
        if (k != option1 && k != option2)
        {
            option3 = k;
            
        }
        
    }
    
        
    NSLog(@"Option 1 :%i",option1);
    NSLog(@"Option 2 :%i",option2);
    NSLog(@"Option 3 :%i",option3);
    
    NSString *testing = [[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option3]] valueForKey:@"option"];
    
    NSLog(@" Yayyyy or Not Yayyyy !!! ? : %@",testing);
    
    
    [self.option1 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option1]] valueForKey:@"option"]] forState:UIControlStateNormal];
    [self.option2 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option2]] valueForKey:@"option"]] forState:UIControlStateNormal];
    [self.option3 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option3]] valueForKey:@"option"]] forState:UIControlStateNormal];
    
    
    
//#define UIColorFromRGB(rgbValue) [UIColor \
//colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
//green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
//blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//    UIColor *color = UIColorFromRGB(0xF7F7F7);
//    
    
    
    
    
    return testInstance;
    
}

-(IBAction)SelectAndNext:(id)sender
{
    
    NSLog(@"Question Number : %i",questionnumber);
    
        
    if ([sender tag] == 1)
    {
        if ([self.option1.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number %i Option 1 Correct",questionnumber);
            testmarks++;
            
            
        }
        if (![self.option1.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number 1  Option 1 Wrong");
           
        }
        
        
    }
    
    if ([sender tag] == 2)
    {
        if ([self.option2.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number 1 Option 2 Correct");
            testmarks++;
            
        
        }
        if (![self.option1.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number 1 Option 2 Wrong");

        }
        
    
    
    }
    
    if ([sender tag] == 3)
    {
        if ([self.option3.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number 1 Option 3 Correct");
            testmarks++;
            
            
        }
        if (![self.option1.titleLabel.text isEqualToString:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"answer"]])
        {
            NSLog(@"Q Number 1 Option 3 Wrong");
        }
        
       
    }
    
   
    
   questionnumber++;
    
   

    
    
    
       
   

    
}


-(IBAction)setquestionsAndOptions:(id)sender
{
    
    if (questionnumber >= 4)
        
    {
        if (testmarks <= 2) {
            
            self.questionLabel.text = [NSString stringWithFormat:@"Received %i out of 3 Marks",testmarks];
            
            [self.option1 setTitle:@"Good" forState:UIControlStateNormal];
            [self.option2 setTitle:@"Try !!" forState:UIControlStateNormal];
            [self.option3 setTitle:@"Retry Same Test !" forState:UIControlStateNormal];
            
            questionnumber = 0;
            testmarks = 0;

        }
        
        if (testmarks == 3) {
            
            self.questionLabel.text = [NSString stringWithFormat:@"Received %i out of 3 Marks",testmarks];
            
            [self.option1 setTitle:@"Very" forState:UIControlStateNormal];
            [self.option2 setTitle:@"well" forState:UIControlStateNormal];
            [self.option3 setTitle:@"Done !!!!" forState:UIControlStateNormal];
            
        }

       
    }
    
    else {
        
        NSMutableDictionary *randomizeoptions = [[NSMutableDictionary alloc] init];
        
        int option1 = 0;
        int option2 = 0;
        int option3 = 0;
        
        
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"answer",@"option", nil] forKey:[NSString stringWithFormat:@"0"]];
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"wronganswerone",@"option", nil] forKey:[NSString stringWithFormat:@"1"]];
        [randomizeoptions setObject:[NSDictionary dictionaryWithObjectsAndKeys:@"wronganswertwo",@"option", nil] forKey:[NSString stringWithFormat:@"2"]];
        
        int candidate = arc4random() % 2;
        option1 = candidate;
        
        
        for (int x = 0; x <= 30; x++)
        {
            candidate = arc4random() % 2;
            if (candidate != option1)
            {
                option2 = candidate;
                break;
            }
            
        }
        
        for (int k = 0; k <= 2; k++)
        {
            
            
            if (k != option1 && k != option2)
            {
                option3 = k;
                
            }
            
        }
        
        
        NSLog(@"Option 1 :%i",option1);
        NSLog(@"Option 2 :%i",option2);
        NSLog(@"Option 3 :%i",option3);
        
        NSString *testing = [[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option1]] valueForKey:@"option"];
        
        NSLog(@" Yayyyy or Not Yayyyy !!! ? : %@",testing);
        
        self.questionLabel.text = [[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:@"question"];
        
        [self.option1 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option1]] valueForKey:@"option"]] forState:UIControlStateNormal];
        [self.option2 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option2]] valueForKey:@"option"]] forState:UIControlStateNormal];
        [self.option3 setTitle:[[testInstance valueForKey:[NSString stringWithFormat:@"%i",questionnumber]] valueForKey:[[randomizeoptions valueForKey:[NSString stringWithFormat:@"%i",option3]] valueForKey:@"option"]] forState:UIControlStateNormal];
        

    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
