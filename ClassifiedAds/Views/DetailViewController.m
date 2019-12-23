//
//  DetailViewController.m
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassifiedAds-Bridging-Header.h"
#import "ClassifiedAds-Swift.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  NSString *temp = _data.created_at;
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSSSSS"];
  NSLocale *locale = [[NSLocale alloc]
                       initWithLocaleIdentifier:@"he"];
  [dateFormat setLocale:locale];
  NSDate *dte = [dateFormat dateFromString:temp];

  NSDateFormatter *dF = [[NSDateFormatter alloc] init];
  [dF setDateFormat:@"dd MMMM yyyy"];
  
  _nameLabel.text = _data.name;
  _dateLabel.text = [dF stringFromDate:dte];
  _priceLabel.text = _data.price;

  dispatch_async(dispatch_get_global_queue(0,0), ^{
      NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.data.getImage]];
      if ( data == nil )
          return;
      dispatch_async(dispatch_get_main_queue(), ^{
          self.imageView.image = [UIImage imageWithData: data];
      });
  });
  
}


@end
