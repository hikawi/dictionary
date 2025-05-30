//
//  DTMainViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTMainViewController.h"
#import "Controllers/Empty/DTEmptyViewController.h"
#import "Controllers/Error/DTErrorViewController.h"
#import "Controllers/Loading/DTLoadingViewController.h"
#import "DTWordViewController.h"
#import "Views/DTSearchBar.h"

@interface DTMainViewController () <DTSearchBarDelegate>

@property DTSearchBar *searchBar;
@property UIViewController *childController;

@end

@implementation DTMainViewController

@synthesize childController;

/// Sets up a new child controller at a specified location.
///
/// - Parameters:
///   - controller: The child controller to add.
- (void)setupChildController:(UIViewController *)controller {
    if (self.childController != NULL) {
        [self.childController.view removeFromSuperview];
        [self.childController removeFromParentViewController];
        [self.childController didMoveToParentViewController:NULL];
        self.childController = NULL;
    }

    self.childController = controller;
    self.childController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.childController];
    [self.view addSubview:self.childController.view];
    [NSLayoutConstraint activateConstraints:@[
        [self.childController.view.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor constant:16],
        [self.childController.view.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [self.childController.view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [self.childController.view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor
                                                       constant:-16],
    ]];
    [self.childController didMoveToParentViewController:self];
    [self.view setNeedsLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Remove the navigation bar.
    [self.navigationController setNavigationBarHidden:YES];

    // Set the background color of the main view.
    self.view.backgroundColor = [UIColor colorNamed:@"DictionaryPrimaryBackground"];

    // Put the icon of the application on the top left.
    UIImage *iconImage = [UIImage imageNamed:@"DictionaryVectorIcon"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iconImageView];
    [NSLayoutConstraint activateConstraints:@[
        [iconImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:16],
        [iconImageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [iconImageView.heightAnchor constraintEqualToConstant:32],
        [iconImageView.widthAnchor constraintLessThanOrEqualToConstant:32],
    ]];

    // Put the search bar right below.
    self.searchBar = [[DTSearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    [NSLayoutConstraint activateConstraints:@[
        [self.searchBar.topAnchor constraintEqualToAnchor:iconImageView.bottomAnchor constant:16],
        [self.searchBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
        [self.searchBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor
                                                      constant:-16],
        [self.searchBar.heightAnchor constraintEqualToConstant:48],
    ]];

    // For everywhere on the screen, tapping resigns the search bar's responder.
}

- (void)handleData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
    // If there's an error, we say that there's an error.
    if (error != NULL) {
        NSLog(@"%@", error);
        [self setupChildController:[[DTErrorViewController alloc] init]];
        return;
    }

    // If the response is not a HTTP response or not 200, we just send the empty screen.
    if (![response isKindOfClass:NSHTTPURLResponse.class]) {
        [self setupChildController:[[DTEmptyViewController alloc] init]];
        return;
    }

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode != 200) {
        [self setupChildController:[[DTEmptyViewController alloc] init]];
        return;
    }

    // Otherwise, we check what we retrieved and put it in the screen.
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingJSON5Allowed error:NULL];

    // Now, we should have the JSON object, the top level should be an array of entries.
    NSMutableArray<DTWordEntry *> *entries = [[NSMutableArray alloc] init];
    for (id entryJson in json) {
        NSLog(@"%@", entryJson);
        DTWordEntry *entry = [[DTWordEntry alloc] init];
        entry.word = entryJson[@"word"];
        entry.phonetic = entryJson[@"phonetic"];

        // Read phonetics next.
        NSMutableArray *phoneticsArray = [[NSMutableArray alloc] init];
        for (id phonetic in entryJson[@"phonetics"]) {
            NSString *phoneticText = (NSString *)phonetic[@"text"];
            NSString *phoneticAudioLink = (NSString *)phonetic[@"audio"];
            DTWordPhonetic *phonetic = [[DTWordPhonetic alloc] initWithText:phoneticText audio:phoneticAudioLink];
            [phoneticsArray addObject:phonetic];
        }
        entry.phonetics = phoneticsArray;

        // Let's tackle meanings now.
        NSMutableArray *meaningsArray = [[NSMutableArray alloc] init];
        for (id meaningJson in entryJson[@"meanings"]) {
            // Put up part of speech and tackle on definitions.
            DTWordMeaning *meaning = [[DTWordMeaning alloc] init];
            meaning.partOfSpeech = meaningJson[@"partOfSpeech"];

            NSMutableArray *definitionsArray = [[NSMutableArray alloc] init];
            for (id definitionJson in meaningJson[@"definitions"]) {
                DTWordDefinition *definition = [[DTWordDefinition alloc] init];
                definition.definition = definitionJson[@"definition"];
                definition.example = definitionJson[@"example"];
                [definitionsArray addObject:definition];
            }
            meaning.definitions = definitionsArray;

            // Now we move on to synonyms.
            // TODO - Synonyms and Antonyms

            // Finally, we add to the array.
            [meaningsArray addObject:meaning];
        }
        entry.meanings = meaningsArray;

        // Finally, let's read up the sources.
        NSMutableArray *sourcesArray = [[NSMutableArray alloc] init];
        for (id source in entryJson[@"sourceUrls"]) {
            [sourcesArray addObject:[NSURL URLWithString:(NSString *)source]];
        }
        entry.sources = sourcesArray;

        // Add to the entries array to display.
        [entries addObject:entry];
    }

    // Display.
    [self setupChildController:[[DTWordViewController alloc] initWithEntries:entries]];
}

- (void)searchDidPress:(NSString *)query {
    // First, we put up the "Loading" state.
    [self setupChildController:[[DTLoadingViewController alloc] init]];

    // Then we send a request asynchronously, and handle later.
    NSString *urlString = [@"https://api.dictionaryapi.dev/api/v2/entries/en/"
        stringByAppendingString:
            [query stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLPathAllowedCharacterSet]];

    // Create a URL request to handle it.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:5];
    request.HTTPMethod = @"GET";

    NSURLSessionDataTask *task =
        [NSURLSession.sharedSession dataTaskWithRequest:request
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        // Handle UI changes on the main queue.
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                          [self handleData:data response:response error:error];
                                        });
                                      }];
    [task resume];
}

@end
