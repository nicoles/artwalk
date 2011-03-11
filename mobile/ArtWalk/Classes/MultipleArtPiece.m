    //
//  MultipleArtPiece.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultipleArtPiece.h"
#import "ArtPieceViewCell.h"
#import "JSON.h"
#import "SingleArtPieceView.h"

@implementation MultipleArtPiece

@synthesize artPieces;
@synthesize artPieceViews;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (id)init{
	if (self = [super init]) {
		self.title = @"Art Pieces";
		self.tabBarItem.image = [UIImage imageNamed:@"122-stats.png"];
	}
	
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	// NSLog(@"done!");
	
	// scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320, 460)];
	// [self.view addSubview:scrollView];
	// scrollView.contentSize = CGSizeMake(320, 600);
	artPieces = [[NSMutableArray alloc] init];

	myTableView = [[UITableView alloc] init];
    myTableView.delegate = self;
	myTableView.dataSource = self;
    [self.view addSubview:myTableView];
	self.tableView.rowHeight = 327;
}

- (void)viewWillAppear:(BOOL) animated
{
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/recent/?mode=json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	[super viewWillAppear:animated];
	[self.tableView reloadData];
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // There is only one section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of art pieces.
    NSLog(@"ArtPieces.count%d", [artPieces count]);
	return [artPieces count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
	
	
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];	

    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
		[cell addSubview:((UIView *)[artPieceViews objectAtIndex:indexPath.row])];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	UIView *v;
	for (v in [cell subviews]) {
		if ([v isKindOfClass:[ArtPieceViewCell class]]) {
			break;
		}
	}
	
	SingleArtPieceView *singleArtPieceView = [[SingleArtPieceView alloc] initWithData:((ArtPieceViewCell *)v).data];
	
	[self.navigationController pushViewController:singleArtPieceView animated:YES];
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}


#pragma mark JSON UrlConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
	NSLog(@"didrecieveresponse");
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	NSLog(@"didrecievedata");
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//	label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
	
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	
	NSLog(@"DidFinishLoading: %@", *responseData);
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	artPieceViews = [[NSMutableArray alloc] init];
	
	// Create a dictionary from the JSON string
	self.artPieces = [jsonString JSONValue];
	
	[jsonString release];
	
	for (NSDictionary *artPiece in artPieces) {
		ArtPieceViewCell *v;
		NSArray *topLevelObjects = [[NSBundle mainBundle] 
									loadNibNamed:@"ArtPieceViewCell" 
									owner:nil options:nil];
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UIView class]]) {
				v = (ArtPieceViewCell *) currentObject;
				break;
			}			
		}
		
		[v initWithData:artPiece];		
		[artPieceViews addObject:v];
	}
	
	[self.tableView reloadData];
	
	//TODO: this leaks memory. fix it.
	//	[results release];
	//	[imageData release];
}

- (void)dealloc {
	[responseData release];
    [super dealloc];
}


@end

