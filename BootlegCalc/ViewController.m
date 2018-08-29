//
//  ViewController.m
//  BootlegCalc
//
//  Created by tbeauch on 8/1/18.
//  Copyright © 2018 tbeauch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) calculatorMode currentMode;


@end

@implementation ViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)goHandler:(UIButton *)sender
{
	NSString *src1VolTxt = self.src1VolField.text;
	NSString *src1ConcTxt = self.src1ConcField.text;
	NSString *src2VolTxt = self.src2VolField.text;
	NSString *src2ConcTxt = self.src2ConcField.text;
	NSString *targetConcTxt = self.targetConcField.text;
	NSString *finalVolTxt = self.finalVolField.text;

	float src1Vol = src1VolTxt.floatValue;
	float src1Conc = src1ConcTxt.floatValue;
	float targetConc = targetConcTxt.floatValue;
	float src2Vol = src2VolTxt.floatValue;
	float src2Conc = src2ConcTxt.floatValue;
	float finalVol = finalVolTxt.floatValue;

	float interimConc1;
	float interimConc2;
	
	switch (self.currentMode)
	{
		case DILUTE_MODE:
			interimConc1 = src1Conc > targetConc ? (src1Conc - targetConc) : (targetConc - src1Conc);
			interimConc2 = (src2Conc > targetConc) ? (src2Conc - targetConc) : (targetConc - src2Conc);
			
			src2Vol = src1Vol * interimConc1 / interimConc2;
			
			self.src2VolField.text = [NSString stringWithFormat:@"%.3f", src2Vol];
			self.finalVolField.text = [NSString stringWithFormat:@"%.3f", src1Vol + src2Vol];
			break;
			
		case MIX_MODE:
			interimConc1 = src1Conc > targetConc ? (src1Conc - targetConc) : (targetConc - src1Conc);
			interimConc2 = (src2Conc > targetConc) ? (src2Conc - targetConc) : (targetConc - src2Conc);
			
			finalVol = src1Vol + src2Vol;

			targetConc = ((src1Vol * src1Conc) + (src2Vol * src2Conc)) / finalVol;

			self.finalVolField.text = [NSString stringWithFormat:@"%.3f", finalVol];
			self.targetConcField.text = [NSString stringWithFormat:@"%.3f", targetConc];
			break;
	
			
		case BLEND_MODE:
			default:
			interimConc1 = src1Conc > targetConc ? (src1Conc - targetConc) : (targetConc - src1Conc);
			interimConc2 = (src2Conc > targetConc) ? (src2Conc - targetConc) : (targetConc - src2Conc);

			src1Vol = finalVol * (interimConc2 / (interimConc1 + interimConc2));
			src2Vol = finalVol * (interimConc1 / (interimConc1 + interimConc2));

			self.src1VolField.text = [NSString stringWithFormat:@"%.3f", src1Vol];
			self.src2VolField.text = [NSString stringWithFormat:@"%.3f", src2Vol];
			break;
	}
}
- (IBAction)modeChangeHandler:(id)sender
{
	switch (self.currentMode) {
		case DILUTE_MODE:   // Switching to Mix Mode
			self.currentMode = MIX_MODE;
			[self.modeSwitcher setTitle: @"Mix Mode" forState:UIControlStateNormal];
			[self.modeDescriptLabel setText:@"Mix Mode: Calculate final volume and concentration based on source volumes and concentrations"];

			self.src1VolField.enabled = TRUE;
			self.src2VolField.enabled = TRUE;
			self.finalVolField.enabled = FALSE;
			self.targetConcField.enabled = FALSE;
			break;
			
		case MIX_MODE:// Switching to Blend Mode
			self.currentMode = BLEND_MODE;
			[self.modeSwitcher setTitle: @"Blend Mode" forState:UIControlStateNormal];
			[self.modeDescriptLabel setText:@"Blend Mode: Calculate Volumes of Solution 1 and 2 to give desired final volume and concentration"];

			self.src1VolField.enabled = FALSE;
			self.src2VolField.enabled = FALSE;
			self.finalVolField.enabled = TRUE;
			self.targetConcField.enabled = TRUE;
			break;
			
		case BLEND_MODE: // Switching to Dilute Mode
		default:
			self.currentMode = DILUTE_MODE;
			[self.modeSwitcher setTitle: @"Dilute Mode" forState:UIControlStateNormal];
			[self.modeDescriptLabel setText:@"Dilute Mode: Calculate amount of Solution 2 to add to Solution 1 for desired final dilution"];

			self.src1VolField.enabled = TRUE;
			self.src2VolField.enabled = FALSE;
			self.finalVolField.enabled = FALSE;
			self.targetConcField.enabled = TRUE;
			break;
	}
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
	
}


@end
