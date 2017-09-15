//
//  ViewController.m
//  ScaryBugsMac
//
//  Created by wanglei on 2017/9/15.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "ViewController.h"
#import "ScaryBugsDoc.h"
#import "EDStarRating.h"
#import <Quartz/Quartz.h>

@interface ViewController ()<NSTableViewDelegate, NSTableViewDataSource, EDStarRatingProtocol>

@property (nonatomic, strong) NSMutableArray<ScaryBugsDoc *> *bugs;
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSTextField *bugTitleView;
@property (strong) IBOutlet EDStarRating *bugRating;
@property (strong) IBOutlet NSImageView *bugImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bugImageView.wantsLayer = YES;
    self.bugImageView.layer.borderWidth = 1;
    self.bugImageView.layer.borderColor = [NSColor gridColor].CGColor;
    [self configureBugRating];
}

- (void)configureBugRating{
    self.bugRating.backgroundColor = [NSColor clearColor];
    self.bugRating.starImage = [NSImage imageNamed:@"star_empty.png"];
    self.bugRating.starHighlightedImage = [NSImage imageNamed:@"star_full.png"];
    self.bugRating.maxRating = 5.0;
    self.bugRating.editable = YES;
    self.bugRating.horizontalMargin = 10;
    self.bugRating.displayMode = EDStarRatingDisplayFull;
    self.bugRating.rating = 0;
    self.bugRating.delegate = self;
}

//添加
- (IBAction)addBug:(NSButton *)sender {
    
    ScaryBugsDoc *newBug = [[ScaryBugsDoc alloc] initWithTitle:@"New Bug" rating:0.0 thumbImage:nil fullImage:nil];
    [self.bugs addObject:newBug];
    
    NSInteger newRowIndex = self.bugs.count - 1;
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationEffectGap];
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
    [self.tableView scrollRowToVisible:newRowIndex];
}

//删除
- (IBAction)deleteBug:(NSButton *)sender {
    ScaryBugsDoc *selectedBug = [self selectedBugDoc];
    if (selectedBug) {
        [self.bugs removeObject:selectedBug];
        [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.tableView.selectedRow] withAnimation:NSTableViewAnimationSlideRight];
        [self setDetailInfo:nil];
    }
}

//更新 title
- (IBAction)bugTitleDidEndEdit:(NSTextField *)sender {
    ScaryBugsDoc *selectedBug = [self selectedBugDoc];
    if (selectedBug) {
        selectedBug.data.title = sender.stringValue;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.bugs indexOfObject:selectedBug]];
        NSIndexSet *columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}

//更新 rating
- (void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
    ScaryBugsDoc *selectedBug = [self selectedBugDoc];
    if (selectedBug) {
        selectedBug.data.rating = rating;
    }
}

- (IBAction)changePicture:(NSButton *)sender {
    
    ScaryBugsDoc *selectedBug = [self selectedBugDoc];
    if (selectedBug) {
        [[IKPictureTaker pictureTaker] beginPictureTakerSheetForWindow:self.view.window withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
    
}

- (void)pictureTakerDidEnd:(IKPictureTaker *)picker returnCode:(NSInteger)code contextInfo:(void *)contextInfo{
    NSImage *image = [picker outputImage];
    if (image != nil && (code == NSModalResponseOK)) {
        self.bugImageView.image = image;
        ScaryBugsDoc *selectedBug = [self selectedBugDoc];
        selectedBug.fullImage = image;
        selectedBug.thumbImage = image;
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.tableView selectedRow]];
        NSIndexSet *columnSet = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadDataForRowIndexes:indexSet columnIndexes:columnSet];
    }
}

//获取选中行
- (ScaryBugsDoc *)selectedBugDoc{
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow >= 0 && self.bugs.count > selectedRow) {
        ScaryBugsDoc *selectedBug = [self.bugs objectAtIndex:selectedRow];
        return selectedBug;
    }
    return nil;
}

//显示详情信息
- (void)setDetailInfo:(ScaryBugsDoc *)bugDoc{
    NSString *title = @"";
    NSImage *image = nil;
    float rating = 0.0;
    if (bugDoc != nil) {
        title = bugDoc.data.title;
        image = bugDoc.fullImage;
        rating = bugDoc.data.rating;
    }
    self.bugTitleView.stringValue = title;
    self.bugImageView.image = image;
    self.bugRating.rating = rating;
}

//选中的通知
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    ScaryBugsDoc *bugDoc = [self selectedBugDoc];
    [self setDetailInfo:bugDoc];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.bugs.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if ([cellView.identifier isEqualToString:@"BugColumn"]) {
        ScaryBugsDoc *bugDoc = [self.bugs objectAtIndex:row];
        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = bugDoc.data.title;
    }
    return cellView;
}

- (NSMutableArray<ScaryBugsDoc *> *)bugs{
    if (!_bugs) {
        ScaryBugsDoc *bug1 = [[ScaryBugsDoc alloc] initWithTitle:@"Potato bug" rating:4 thumbImage:[NSImage imageNamed:@"potatoBugThumb.jpg"] fullImage:[NSImage imageNamed:@"potatoBug.jpg"]];
        ScaryBugsDoc *bug2 = [[ScaryBugsDoc alloc] initWithTitle:@"House Centipede" rating:3 thumbImage:[NSImage imageNamed:@"centipedeThumb.jpg"] fullImage:[NSImage imageNamed:@"centipede.jpg"]];
        ScaryBugsDoc *bug3 = [[ScaryBugsDoc alloc] initWithTitle:@"Wolf Spider" rating:5 thumbImage:[NSImage imageNamed:@"wolfSpiderThumb.jpg"] fullImage:[NSImage imageNamed:@"wolfSpider.jpg"]];
        ScaryBugsDoc *bug4 = [[ScaryBugsDoc alloc] initWithTitle:@"Lady Bug" rating:1 thumbImage:[NSImage imageNamed:@"ladybugThumb.jpg"] fullImage:[NSImage imageNamed:@"ladybug.jpg"]];
        _bugs = [[NSMutableArray alloc] initWithObjects:bug1, bug2, bug3, bug4, nil];
    }
    return _bugs;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
