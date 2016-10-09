//
//  FontInfoViewController.m
//  Fonts
//
//  Created by 叶明 on 10/9/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "FontInfoViewController.h"
#import "FavoritesList.h"

@interface FontInfoViewController ()

@property(weak,nonatomic) IBOutlet UILabel *fontSampleLabel;
@property(weak,nonatomic) IBOutlet UISlider *fontSizeSlider;
@property(weak,nonatomic) IBOutlet UILabel *fontSizeLabel;
@property(weak,nonatomic) IBOutlet UISwitch *favoriteSwitch;

@end

@implementation FontInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fontSampleLabel.font = self.font;
    self.fontSampleLabel.text = @"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 1234567890";
    self.fontSizeSlider.value = self.font.pointSize;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f",self.font.pointSize];
    self.favoriteSwitch.on = self.favorite;
}

-(IBAction)sliderFontSize:(UISlider *)slider{
    float newSize = roundf(slider.value);
    self.fontSampleLabel.font = [self.font fontWithSize:newSize];
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f",newSize];
}

-(IBAction)toggleFavorite:(UISwitch *)sender{
    FavoritesList *favorites = [FavoritesList sharedFavoritesList];
    if(sender.on){
        [favorites addFavorite:self.font.fontName];
    }
    else{
        [favorites removeFavorite:self.font.fontName];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
