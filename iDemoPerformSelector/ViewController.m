//
//  ViewController.m
//  iDemoPerformSelector
//
//  Created by Bui Duc Khanh on 6/25/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// Hàm demo phần gọi hàm qua Perform Selector trong background
- (IBAction)onPerformInBackgroundTouchUpInside:(id)sender {
    NSLog(@"Start Perform Selector In Background");
    
    [self performSelectorInBackground:@selector(doCrunchData) withObject:nil];
    
    NSLog(@"Done Perform Selector In Background");
    
}

// Hàm demo phần gọi hàm qua Perform Selector trong Thread chính
- (IBAction)onPerformInMainThreadTouchUpInside:(id)sender {
    NSLog(@"Start Perform Selector In Background. It will causes app not responding");
    
    [self performSelectorOnMainThread:@selector(doCrunchData) withObject:nil waitUntilDone:true];
    
    NSLog(@"Done Perform Selector In Main Thread");
}

// Hàm demo phần gọi hàm qua Perform Selector sau một thời gian delay
// Hàm sẽ hiện hoặc ẩn slider tuỳ theo trạng thái
- (IBAction)onPerformAfterDelayTouchUpInside:(id)sender {
    
    if(_slider.hidden) // Đang ẩn thì gọi hàm hiển thị
    {
        NSLog(@"Slider will show after 2 seconds");
        
        [self performSelector:@selector(showSlider) withObject:nil afterDelay: 2];
    }
    else // Đang hiển thị thì gọi hàm ẩn slider
    {
        NSLog(@"Slider will hidden after 2 seconds");
        
        [self performSelector:@selector(hideSlider) withObject:nil afterDelay: 2];
    }
    
}


// Hàm demo gọi perform selector với parameter
- (IBAction)onPerformWithObjectTouchUpInside:(id)sender {
    NSLog(@"Start Perform Selector With Object. It will write key and param sent to selector");
    
    [self performSelectorOnMainThread:@selector(processData:) withObject:@{@"apple": @"táo", @"lemon": @"chanh"} waitUntilDone: true];
    
    NSLog(@"Done Perform Selector With Object");
}


// Hàm thực hiện dừng thread đang thực thi hàm 10 giây
- (void) doCrunchData {
    [NSThread sleepForTimeInterval: 10];
}


// Hàm lấy các param từ dictionary và write ra console
- (void) processData: (NSDictionary*) data {
    for (NSString* key in [data allKeys]) {
        NSLog(@"%@ - %@", key, [data valueForKey:key]);
    }
}


// Ẩn slider
- (void) hideSlider {
    self.slider.hidden = true;
}


// Hiển thị slider
- (void) showSlider {
    self.slider.hidden = false;
}
@end
