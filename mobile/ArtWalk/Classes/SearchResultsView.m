//
//  SearchResultsView.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchResultsView.h"
#import "JSON.h"

@implementation SearchResultsView

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

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

#pragma mark Initialization
- (id) init {
	if (self = [super init]) {
		//self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
		self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
		
		// Create table view
		theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, 320, 220)];
		[theTableView setDelegate:self];
		[theTableView setDataSource:self];
		[theTableView setRowHeight:80];
		[self.view addSubview:theTableView];
		[theTableView setBackgroundColor:[UIColor grayColor]];
		[theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		// Initialize our arrays
		photoTitles = [[NSMutableArray alloc] init];
		photoImage = [[NSMutableArray alloc] init];
		 		
	}
	return self;
	
}

#pragma mark -
- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"viewdidload called");
	
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8000/recent/?mode=json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];

	NSLog(@"viewdidload completed");
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
	
	NSLog(@"DidFinishLoading: %@", responseData);
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	// Create a dictionary from the JSON string
	NSArray *results = [jsonString JSONValue];
	
	// Loop through each entry in the array...
	for (NSDictionary *artPiece in results)
	{
		// Get title of the image
		NSString *title = [artPiece	objectForKey:@"title"];
		
		// Save the title to the photo titles array
		[photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
		
		NSArray *media = [artPiece objectForKey:@"media"];
		
		for (NSDictionary *medium in media)
		{
			NSString *photoURLString = [medium objectForKey:@"url"];
			[photoImage addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
			NSLog(@"photoURLString: %@", photoURLString);
		}
		
	} 
	// Update the table with data
	[theTableView reloadData];
}

#pragma mark extremely old iphone2/3 code for making tables
#pragma mark Table Mgmt

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [photoTitles count];
}

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cachedCell"];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"cachedCell"] autorelease];
	
#if __IPHONE_3_0
	cell.textLabel.text = [photoTitles objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont systemFontOfSize:13.0];
#else
	cell.text = [photoTitles objectAtIndex:indexPath.row];
	cell.font = [UIFont systemFontOfSize:13.0];
#endif
	
	NSData *imageData = [photoImage objectAtIndex:indexPath.row];
	
#if __IPHONE_3_0
	cell.imageView.image = [UIImage imageWithData:imageData];
#else
	cell.image = [UIImage imageWithData:imageData];
#endif
	
	return cell;
}


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


- (void)dealloc {
	[photoTitles release];
	[photoImage release];
    [super dealloc];
}


@end
