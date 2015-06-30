//
//  ViewController.h
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *dealerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard4;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard5;

@property (weak, nonatomic) IBOutlet UIImageView *playerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard4;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard5;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;

- (IBAction)didTapStandButton:(id)sender;
- (IBAction)didTapHitButton:(id)sender;

- (id) initWithCoder:(NSCoder *)aDecoder;
- (void) renderCards;
- (void) restartGame;
- (void) viewWillAppear:(BOOL)animated;
- (void) showSecondDealerCard;
- (void) showNextDealerCard;
- (void) playDealerTurn;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void) handleNotificationGameDidEnd:(NSNotification *)notification;
@end

