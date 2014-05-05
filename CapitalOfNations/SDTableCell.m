//
//  SDTableCell.m
//  CapitalOfNations
//
//  Created by sanket on 28/03/2014.
//  Copyright (c) 2014 Techmentation. All rights reserved.
//

#import "SDTableCell.h"

@implementation SDTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
