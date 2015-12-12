//
//  ViewController.m
//  MiddleAlignedButton
//
//  Created by Barry on 12/11/15.
//  Copyright © 2015 BarryLee. All rights reserved.
//

#import "ViewController.h"
#import "MiddleAlignedButton.h"

@interface UIView (MiddleAlignedButton)
@end

@implementation UIView (MiddleAlignedButton)

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end

@interface ViewController ()

@property (nonatomic, weak) IBOutlet MiddleAlignedButton *button;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
@property (nonatomic, strong) UILabel *imageLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    self.button.layer.cornerRadius = 4.0f;
    self.button.layer.masksToBounds = YES;
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor whiteColor];
    self.button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    self.button.titleLabel.textColor = [UIColor lightGrayColor];
    [self.button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    self.imageLabel = [UILabel new];
    [self.imageLabel setText:@""];
    [self.imageLabel setOpaque:NO];
    [self.imageLabel setTextColor:[UIColor colorWithRed:0.72 green:0.43 blue:0.47 alpha:1.00]];
    [self.imageLabel setTextAlignment:NSTextAlignmentCenter];
    [self.imageLabel setBackgroundColor:[UIColor clearColor]];

    [self updateButtonContent];
}

- (void)buttonDidTouchUpInside:(UIButton *)button
{
    [self updateButtonContent];
}

- (void)updateButtonContent
{
    self.imageLabel.font = [UIFont systemFontOfSize:8.0f + arc4random() % 60];
    [self.imageLabel sizeToFit];
    self.imageLabel.frame = ({
        CGRect frame = self.imageLabel.frame;
        frame.size.width = frame.size.height;// + arc4random() % 60;
        frame;
    });
    UIImage *image = [self.imageLabel snapshotImage];

    if ([image respondsToSelector:@selector(imageWithRenderingMode:)]) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }

    NSMutableString *title = [NSMutableString stringWithString:[NSUUID UUID].UUIDString];
    [title deleteCharactersInRange:NSMakeRange(0, arc4random() % title.length)];
    title = [@"Apple" mutableCopy];

    [UIView animateWithDuration:0 animations:^{
        [self.button setImage:image forState:UIControlStateNormal];
        [self.button setTitle:title forState:UIControlStateNormal];
        [self.button setMiddleSpace:arc4random() % 10];
    }];
}

@end
