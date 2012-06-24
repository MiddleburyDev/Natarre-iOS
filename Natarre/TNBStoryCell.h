//
//  TNBStoryCell.h
//  Natarre
//
//  Created by Thomas Beatty on 6/24/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNBStoryCell : UITableViewCell {
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * authorLabel;
    IBOutlet UIImageView * paintSplatImageView;
}

@property(nonatomic, strong)IBOutlet UILabel * titleLabel;
@property(nonatomic, strong)IBOutlet UILabel * authorLabel;
@property(nonatomic, strong)IBOutlet UIImageView * paintSplatImageView;

@end
