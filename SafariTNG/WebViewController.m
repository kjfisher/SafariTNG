//
//  ViewController.m
//  SafariTNG
//
//  Created by Kristen L. Fisher on 5/14/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate    >; //needed for auto-complete
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation WebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlString = @"http://www.mobilemakers.co";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self.spinner stopAnimating];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self goToUrlString:@"http://www.mobilemakers.co"];
    }
}

/**
 NSString *urlString = @"http://www.mobilemakers.co";
 NSURL *url = [NSURL URLWithString:urlString];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 [self.myWebView loadRequest:request];

 */

-(void)goToUrlString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}


/**
 The TextField checks if it has a delegate when ENTER is presssed within it
 The TextField's delegate is this ViewController instance (self)
 The TextField checks if textFieldShouldReturn: is implemented on its delegate
 The TextField calls textFieldShouldReturn: if it is implemented

 Thus we can respond to the TextField's events
*/

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"loading failed :(";
    alert.message = error.localizedDescription;
    [alert addButtonWithTitle:@"that sucks"];
    [alert addButtonWithTitle:@"go home"];
    alert.delegate = self;
    [alert show];
    [self.spinner stopAnimating];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self goToUrlString:textField.text];

    //dismiss keyboard
    [textField resignFirstResponder];

    return YES;
}
/**
 NSString *urlString = textField.text;
 NSURL *url = [NSURL URLWithString:urlString];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 [self.myWebView loadRequest:request];
 */
@end
