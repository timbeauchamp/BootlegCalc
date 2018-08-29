//
//  ViewController.h
//  BootlegCalc
//
//  Created by tbeauch on 8/1/18.
//  Copyright © 2018 tbeauch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *goBtn;
@property (weak, nonatomic) IBOutlet UITextField *src1VolField;
@property (weak, nonatomic) IBOutlet UITextField *src1ConcField;
@property (weak, nonatomic) IBOutlet UITextField *src2VolField;
@property (weak, nonatomic) IBOutlet UITextField *src2ConcField;
@property (weak, nonatomic) IBOutlet UITextField *finalVolField;
@property (weak, nonatomic) IBOutlet UITextField *targetConcField;

@property (weak, nonatomic) IBOutlet UIButton *modeSwitcher;
@property (weak, nonatomic) IBOutlet UILabel *modeDescriptLabel;

@property (nonatomic) int mode;


typedef NS_ENUM(NSInteger, calculatorMode)
{
	MIX_MODE,
	BLEND_MODE,
	DILUTE_MODE
};

@end

