//
//  DTWordViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordViewController.h"
#import "Views/DTURLButton.h"
#import <AVFoundation/AVFoundation.h>

@interface DTWordViewController ()

@property DTWordPhonetic *phonetic;
@property(strong) AVAudioPlayer *audioPlayer;

@end

@implementation DTWordViewController

@synthesize entry;
@synthesize phonetic;
@synthesize audioPlayer;

- (instancetype)initWithEntry:(DTWordEntry *)entry {
    self = [self init];
    self.entry = entry;
    self.phonetic = entry.firstUsablePhonetic;
    return self;
}

/// Loads the word definition into the definition stack view.
///
/// - Parameters:
///   - definition: The definition to load.
///   - stackView: The stack view to add to.
- (void)loadWordDefinition:(DTWordDefinition *)definition toStack:(UIStackView *)stackView {
    // We create the container for the definition.
    UIView *definitionView = [[UIView alloc] init];
    [stackView addArrangedSubview:definitionView];

    // Then, we create the little dot, as decorative element.
    UIView *decorativeView = [[UIView alloc] init];
    decorativeView.backgroundColor = [UIColor colorNamed:@"DictionaryPrimary"];
    decorativeView.translatesAutoresizingMaskIntoConstraints = NO;
    decorativeView.layer.cornerRadius = 2.5;
    decorativeView.clipsToBounds = YES;
    [definitionView addSubview:decorativeView];
    [NSLayoutConstraint activateConstraints:@[
        [decorativeView.heightAnchor constraintEqualToConstant:5],
        [decorativeView.widthAnchor constraintEqualToConstant:5],
        [decorativeView.topAnchor constraintEqualToAnchor:definitionView.topAnchor constant:7.5],
        [decorativeView.leadingAnchor constraintEqualToAnchor:definitionView.leadingAnchor],
    ]];

    // Then, we add the label that displays the definition.
    UILabel *definitionLabel = [[UILabel alloc] init];
    definitionLabel.numberOfLines = 0;
    definitionLabel.text = definition.definition;
    definitionLabel.font = [UIFont systemFontOfSize:15];
    definitionLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    definitionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [definitionView addSubview:definitionLabel];
    [NSLayoutConstraint activateConstraints:@[
        [definitionLabel.topAnchor constraintEqualToAnchor:definitionView.topAnchor],
        [definitionLabel.leadingAnchor constraintEqualToAnchor:decorativeView.trailingAnchor constant:20],
        [definitionLabel.trailingAnchor constraintEqualToAnchor:definitionView.trailingAnchor],
    ]];

    // If there's no example, we stretch the definition to cover the view and return.
    if(definition.example == NULL) {
        [definitionLabel.bottomAnchor constraintEqualToAnchor:definitionView.bottomAnchor].active = YES;
        return;
    }

    // If there is, we add the example right below the definition, and stretch that example to the view instead.
    UILabel *exampleLabel = [[UILabel alloc] init];
    exampleLabel.numberOfLines = 0;
    exampleLabel.text = [NSString stringWithFormat:@"\"%@\"", definition.example];
    exampleLabel.font = [UIFont systemFontOfSize:15];
    exampleLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    exampleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [definitionView addSubview:exampleLabel];
    [NSLayoutConstraint activateConstraints:@[
        [exampleLabel.topAnchor constraintEqualToAnchor:definitionLabel.bottomAnchor constant:16],
        [exampleLabel.leadingAnchor constraintEqualToAnchor:definitionLabel.leadingAnchor],
        [exampleLabel.trailingAnchor constraintEqualToAnchor:definitionView.trailingAnchor],
        [exampleLabel.bottomAnchor constraintEqualToAnchor:definitionView.bottomAnchor],
    ]];
}

/// Loads the word meaning into the overall main stack view.
///
/// - Parameters:
///   - meaning: The meaning to load.
///   - stackView: The stack view to add to.
- (void)loadWordMeaning:(DTWordMeaning *)meaning toStack:(UIStackView *)stackView {
    // We add the view that shows the "part of speech" of the meaning
    // and a simple decorative bar.
    UIView *partOfSpeechView = [[UIView alloc] init];
    [stackView addArrangedSubview:partOfSpeechView];

    // The "part of speech" label. Before adding a label, we create a font descriptor
    // to allow both italic and bold font face.
    UIFontDescriptor *boldItalicDescriptor = [[UIFontDescriptor alloc] init];
    UIFontDescriptorSymbolicTraits traits = boldItalicDescriptor.symbolicTraits;
    traits |= UIFontDescriptorTraitBold;
    traits |= UIFontDescriptorTraitItalic;

    UILabel *partOfSpeechLabel = [[UILabel alloc] init];
    partOfSpeechLabel.text = meaning.partOfSpeech;
    partOfSpeechLabel.font = [UIFont fontWithDescriptor:[boldItalicDescriptor fontDescriptorWithSymbolicTraits:traits]
                                                   size:18];
    partOfSpeechLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    partOfSpeechLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [partOfSpeechView addSubview:partOfSpeechLabel];

    // Now the separator.
    UIView *partOfSpeechSeparator = [[UIView alloc] init];
    partOfSpeechSeparator.backgroundColor = [UIColor colorNamed:@"DictionaryTetriaryBackground"];
    partOfSpeechSeparator.layer.cornerRadius = 0.5;
    partOfSpeechSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [partOfSpeechView addSubview:partOfSpeechSeparator];

    // Setup constraints to apply the part of speech view properly.
    [NSLayoutConstraint activateConstraints:@[
        [partOfSpeechSeparator.heightAnchor constraintEqualToConstant:1],

        [partOfSpeechLabel.leadingAnchor constraintEqualToAnchor:partOfSpeechView.leadingAnchor],
        [partOfSpeechLabel.centerYAnchor constraintEqualToAnchor:partOfSpeechView.centerYAnchor],

        [partOfSpeechSeparator.centerYAnchor constraintEqualToAnchor:partOfSpeechView.centerYAnchor],
        [partOfSpeechSeparator.leadingAnchor constraintEqualToAnchor:partOfSpeechLabel.trailingAnchor constant:16],
        [partOfSpeechSeparator.trailingAnchor constraintEqualToAnchor:partOfSpeechView.trailingAnchor],
    ]];

    // Before adding the meaning sections, we setup a stack view for that, again.
    UIStackView *meaningStackView = [[UIStackView alloc] init];
    meaningStackView.spacing = 16;
    meaningStackView.axis = UILayoutConstraintAxisVertical;
    meaningStackView.alignment = UIStackViewAlignmentLeading;
    [stackView addArrangedSubview:meaningStackView];

    // Next, we add the "Meaning" label.
    UILabel *meaningLabel = [[UILabel alloc] init];
    meaningLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    meaningLabel.text = @"Meaning";
    meaningLabel.font = [UIFont systemFontOfSize:16];
    [meaningStackView addArrangedSubview:meaningLabel];

    // Next, we set it up the definition stack view.
    UIStackView *definitionStackView = [[UIStackView alloc] init];
    definitionStackView.spacing = 12;
    definitionStackView.axis = UILayoutConstraintAxisVertical;
    definitionStackView.alignment = UIStackViewAlignmentFill;
    [meaningStackView addArrangedSubview:definitionStackView];

    // For each definition, we add to the provided stack view.
    for(DTWordDefinition *definition in meaning.definitions) {
        [self loadWordDefinition:definition toStack:definitionStackView];
    }
}

/// Loads the word source URLs into the overall source stack view.
///
/// This sets up a second stack view that has no separation, and add URIs here,
/// before adding the entire stack view to the source one.
///
/// - Parameters:
///   - urls: The array of URLs to add.
///   - stackView: The stack view to add to.
- (void)loadWordSources:(NSArray<NSURL *> *)urls toStack:(UIStackView *)stackView {
    UIStackView *urlStackView = [[UIStackView alloc] init];
    urlStackView.axis = UILayoutConstraintAxisVertical;
    urlStackView.spacing = 0;
    urlStackView.alignment = UIStackViewAlignmentLeading;
    [stackView addArrangedSubview:urlStackView];

    for (NSURL *url in urls) {
        // First, we create the mutable attributed string.
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];

        // Then, we add the attributed underline string.
        NSAttributedString *urlString = [[NSAttributedString alloc]
            initWithString:url.absoluteString
                attributes:@{
                    NSForegroundColorAttributeName : [UIColor colorNamed:@"DictionaryPrimaryLabel"],
                    NSFontAttributeName : [UIFont systemFontOfSize:14],
                    NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                }];
        [str appendAttributedString:urlString];

        // Before adding the icon, we add a space.
        NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:@" "];
        [str appendAttributedString:spaceString];

        // Then, we get the icon attachment.
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        UIImage *linkImage = [UIImage systemImageNamed:@"square.and.arrow.up"];
        UIImage *tintedLinkImage = [linkImage imageWithTintColor:[UIColor colorNamed:@"DictionarySecondaryLabel"]];
        attachment.image = tintedLinkImage;

        // Convert the attachment into an attributed string.
        NSAttributedString *iconString = [NSAttributedString attributedStringWithAttachment:attachment];
        [str appendAttributedString:iconString];

        // Create the button that acts like the label, to open the URL.
        DTURLButton *urlButton = [[DTURLButton alloc] initWithURL:url];
        [urlButton setAttributedTitle:str forState:UIControlStateNormal];
        urlButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
        urlButton.titleLabel.lineBreakStrategy = NSLineBreakStrategyNone;
        [urlStackView addArrangedSubview:urlButton];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup the scroll view for the word view, as a lot of words may have too much content to display in one screen.
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:mainScrollView];
    [NSLayoutConstraint activateConstraints:@[
        [mainScrollView.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [mainScrollView.safeAreaLayoutGuide.bottomAnchor
            constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [mainScrollView.safeAreaLayoutGuide.leadingAnchor
            constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [mainScrollView.safeAreaLayoutGuide.trailingAnchor
            constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
    ]];

    // Now the stack view to simulate the design using flexboxes. The main stack view separates
    // elements at 32px each.
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.spacing = 32;
    mainStackView.alignment = UIStackViewAlignmentFill;
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainScrollView addSubview:mainStackView];
    [NSLayoutConstraint activateConstraints:@[
        [mainStackView.topAnchor constraintEqualToAnchor:mainScrollView.safeAreaLayoutGuide.topAnchor],
        [mainStackView.leadingAnchor constraintEqualToAnchor:mainScrollView.safeAreaLayoutGuide.leadingAnchor],
        [mainStackView.trailingAnchor constraintEqualToAnchor:mainScrollView.safeAreaLayoutGuide.trailingAnchor],
    ]];

    // Top section would contain the word's spelling, phonetics and a play button to play
    // the pronuniciation for that word.
    UIStackView *overviewStackView = [[UIStackView alloc] init];
    overviewStackView.axis = UILayoutConstraintAxisHorizontal;
    overviewStackView.spacing = 8;
    overviewStackView.distribution = UIStackViewDistributionFill;
    overviewStackView.alignment = UIStackViewAlignmentCenter;
    [mainStackView addArrangedSubview:overviewStackView];

    // Let's setup the stack view to hold the spelling and phonetics. They have a spacing of 8px.
    UIStackView *spellingStackView = [[UIStackView alloc] init];
    spellingStackView.axis = UILayoutConstraintAxisVertical;
    spellingStackView.spacing = 8;
    spellingStackView.distribution = UIStackViewDistributionFill;
    spellingStackView.alignment = UIStackViewAlignmentLeading;
    [overviewStackView addArrangedSubview:spellingStackView];

    // The UILabels to draw the spelling.
    UILabel *spellingLabel = [[UILabel alloc] init];
    spellingLabel.text = self.entry.word;
    spellingLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    spellingLabel.font = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];
    [spellingStackView addArrangedSubview:spellingLabel];

    // The UILabel to draw the phonetic.
    UILabel *phoneticLabel = [[UILabel alloc] init];
    phoneticLabel.text = self.phonetic.text;
    phoneticLabel.textColor = [UIColor colorNamed:@"DictionaryPrimary"];
    phoneticLabel.font = [UIFont systemFontOfSize:18];
    [spellingStackView addArrangedSubview:phoneticLabel];

    // Let's setup that play button with some image assets we set up in Assets.
    UIImage *playImage = [UIImage imageNamed:@"DictionaryPlaySoundIcon"];
    UIImage *playHighlightedImage = [UIImage imageNamed:@"DictionaryPlaySoundHighlightedIcon"];
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.contentMode = UIViewContentModeScaleAspectFit;
    [playButton setImage:playImage forState:UIControlStateNormal];
    [playButton setImage:playHighlightedImage forState:UIControlStateHighlighted];
    [playButton setImage:playHighlightedImage forState:UIControlStateFocused];
    [playButton setImage:playHighlightedImage forState:UIControlStateSelected];
    [playButton setImage:[playImage imageWithTintColor:UIColor.systemGrayColor] forState:UIControlStateDisabled];
    [playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [NSLayoutConstraint activateConstraints:@[
        [playButton.heightAnchor constraintEqualToConstant:48],
        [playButton.widthAnchor constraintEqualToConstant:48],
    ]];
    [overviewStackView addArrangedSubview:playButton];

    // Disable the play button if the audio is not available.
    if (self.phonetic.audio == NULL) {
        playButton.enabled = NO;
    }

    // Now we pushes in the word meanings.
    for (DTWordMeaning *meaning in self.entry.meanings) {
        [self loadWordMeaning:meaning toStack:mainStackView];
    }

    // Before we get to the final section of the screen, we have to add a separator.
    UIView *separatorView = [[UIView alloc] init];
    [NSLayoutConstraint activateConstraints:@[
        [separatorView.heightAnchor constraintEqualToConstant:1],
    ]];
    separatorView.backgroundColor = [UIColor colorNamed:@"DictionaryTetriaryBackground"];
    separatorView.layer.cornerRadius = 0.5;
    [mainStackView addArrangedSubview:separatorView];

    // Finally, we put in the source URLs for this word, starting with the stack view.
    // Stack views are so great for dynamic content.
    UIStackView *sourceStackView = [[UIStackView alloc] init];
    sourceStackView.spacing = 4;
    sourceStackView.axis = UILayoutConstraintAxisVertical;
    sourceStackView.alignment = UIStackViewAlignmentLeading;
    [mainStackView addArrangedSubview:sourceStackView];

    // We add the text "Source" underlined as a label to the source stack view.
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.attributedText =
        [[NSAttributedString alloc] initWithString:@"Source"
                                        attributes:@{
                                            NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                        }];
    sourceLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    sourceLabel.font = [UIFont systemFontOfSize:14];
    [sourceStackView addArrangedSubview:sourceLabel];

    // Now we add individual source URLs to the source stack view.
    [self loadWordSources:self.entry.sources toStack:sourceStackView];
}

#pragma mark - Delegated methods

/// Plays the audio associated at the phonetic's URL using AVFoundation's AVPlayer.
- (void)playAudio {
    if (self.audioPlayer != NULL && self.audioPlayer.playing) {
        // Stop the audio if it's playing.
        [self.audioPlayer stop];
    } else if (self.audioPlayer == NULL) {
        // If it's not fetched yet, fetch the audio file.
        NSURLSessionDataTask *task =
            [NSURLSession.sharedSession dataTaskWithURL:self.phonetic.audio
                                      completionHandler:^(NSData *data, id response, NSError *error) {
                                        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
                                        if (error != NULL) {
                                            NSLog(@"%@", error);
                                        }

                                        self.audioPlayer.volume = 1;
                                        [self.audioPlayer prepareToPlay];
                                        [self.audioPlayer play];
                                      }];
        [task resume];
    } else {
        // Reuse the audio if it's already fetched.
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

@end
