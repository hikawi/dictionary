//
//  DTWordViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordViewController.h"
#import "Views/DTFontSensitiveLabel.h"
#import "Views/DTPlaySoundButton.h"
#import "Views/DTURLButton.h"
#import <AVFoundation/AVFoundation.h>

@interface DTWordViewController ()

@property NSArray<DTWordEntry *> *entries;
@property NSMutableArray<id<DTFontSwitcherChoiceDelegate>> *labels;

@end

@implementation DTWordViewController

@synthesize entries;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.entries = @[];
        self.labels = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (instancetype)initWithEntries:(NSArray<DTWordEntry *> *)entries {
    self = [self init];
    self.entries = entries;
    return self;
}

- (void)handleChoice:(DTFontType)choice {
    for(DTFontSensitiveLabel *label in self.labels) {
        [label handleChoice:choice];
    }
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
    DTFontSensitiveLabel *definitionLabel = [[DTFontSensitiveLabel alloc] initWithSize:15];
    definitionLabel.numberOfLines = 0;
    definitionLabel.text = definition.definition;
    definitionLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    definitionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [definitionView addSubview:definitionLabel];
    [NSLayoutConstraint activateConstraints:@[
        [definitionLabel.topAnchor constraintEqualToAnchor:definitionView.topAnchor],
        [definitionLabel.leadingAnchor constraintEqualToAnchor:decorativeView.trailingAnchor constant:20],
        [definitionLabel.trailingAnchor constraintEqualToAnchor:definitionView.trailingAnchor],
    ]];
    [self.labels addObject:definitionLabel];

    // If there's no example, we stretch the definition to cover the view and return.
    if (definition.example == NULL) {
        [definitionLabel.bottomAnchor constraintEqualToAnchor:definitionView.bottomAnchor].active = YES;
        return;
    }

    // If there is, we add the example right below the definition, and stretch that example to the view instead.
    DTFontSensitiveLabel *exampleLabel = [[DTFontSensitiveLabel alloc] initWithSize:15];
    exampleLabel.numberOfLines = 0;
    exampleLabel.text = [NSString stringWithFormat:@"\"%@\"", definition.example];
    exampleLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    exampleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [definitionView addSubview:exampleLabel];
    [NSLayoutConstraint activateConstraints:@[
        [exampleLabel.topAnchor constraintEqualToAnchor:definitionLabel.bottomAnchor constant:16],
        [exampleLabel.leadingAnchor constraintEqualToAnchor:definitionLabel.leadingAnchor],
        [exampleLabel.trailingAnchor constraintEqualToAnchor:definitionView.trailingAnchor],
        [exampleLabel.bottomAnchor constraintEqualToAnchor:definitionView.bottomAnchor],
    ]];
    [self.labels addObject:exampleLabel];
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

    // The "part of speech" label.
    DTFontSensitiveLabel *partOfSpeechLabel = [[DTFontSensitiveLabel alloc] initItalicWithSize:18 weight:DTFontWeightBold];
    partOfSpeechLabel.text = meaning.partOfSpeech;
    partOfSpeechLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    partOfSpeechLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [partOfSpeechView addSubview:partOfSpeechLabel];
    [self.labels addObject:partOfSpeechLabel];

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
    DTFontSensitiveLabel *meaningLabel = [[DTFontSensitiveLabel alloc] initWithSize:16];
    meaningLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    meaningLabel.text = @"Meaning";
    [meaningStackView addArrangedSubview:meaningLabel];
    [self.labels addObject:meaningLabel];

    // Next, we set it up the definition stack view.
    UIStackView *definitionStackView = [[UIStackView alloc] init];
    definitionStackView.spacing = 12;
    definitionStackView.axis = UILayoutConstraintAxisVertical;
    definitionStackView.alignment = UIStackViewAlignmentFill;
    [meaningStackView addArrangedSubview:definitionStackView];

    // For each definition, we add to the provided stack view.
    for (DTWordDefinition *definition in meaning.definitions) {
        [self loadWordDefinition:definition toStack:definitionStackView];
    }
}

- (void)loadWordSynonyms:(NSArray<NSString *> *)synonyms toStack:(UIStackView *)stackView {
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
        // Well, this sucks, I guess sources can't be changed.
        NSAttributedString *urlString = [[NSAttributedString alloc]
            initWithString:url.absoluteString
                attributes:@{
                    NSForegroundColorAttributeName : [UIColor colorNamed:@"DictionaryPrimaryLabel"],
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
        [self.labels addObject:urlButton];
    }
}

/// Loads an entire word entry to the main stack view.
///
/// As a word may have multiple entires, eg. lead having a "leader" type of entry and a "lead" the material
/// type of entry. Therefore this screen has to be able to handle multiple entries of the same word.
///
/// - Parameters:
///   - entry: The word entry to load.
///   - stackView: The stack view to put into.
- (void)loadWordEntry:(DTWordEntry *)entry toStack:(UIStackView *)stackView {
    // Now the stack view to simulate the design using flexboxes. The main stack view separates
    // elements at 32px each.
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.spacing = 32;
    mainStackView.alignment = UIStackViewAlignmentFill;
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [stackView addArrangedSubview:mainStackView];

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
    DTFontSensitiveLabel *spellingLabel = [[DTFontSensitiveLabel alloc] initWithSize:32 weight:DTFontWeightBold];
    spellingLabel.text = entry.word;
    spellingLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    [spellingStackView addArrangedSubview:spellingLabel];
    [self.labels addObject:spellingLabel];

    // The UILabel to draw the phonetic.
    DTFontSensitiveLabel *phoneticLabel = [[DTFontSensitiveLabel alloc] initWithSize:18];
    phoneticLabel.text = entry.phonetic;
    phoneticLabel.textColor = [UIColor colorNamed:@"DictionaryPrimary"];
    [spellingStackView addArrangedSubview:phoneticLabel];
    [self.labels addObject:phoneticLabel];

    // Let's setup that play button with some image assets we set up in Assets.
    DTPlaySoundButton *playButton = [[DTPlaySoundButton alloc] initWithAudio:entry.firstUsablePhonetic.audio];
    [overviewStackView addArrangedSubview:playButton];

    // Now we pushes in the word meanings.
    for (DTWordMeaning *meaning in entry.meanings) {
        [self loadWordMeaning:meaning toStack:mainStackView];
    }

    // Before adding the separator, it's the section for synonyms and antonyms.

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
    DTFontSensitiveLabel *sourceLabel = [[DTFontSensitiveLabel alloc] initWithSize:14];
    sourceLabel.attributedText =
        [[NSAttributedString alloc] initWithString:@"Source"
                                        attributes:@{
                                            NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                        }];
    sourceLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    [sourceStackView addArrangedSubview:sourceLabel];
    [self.labels addObject:sourceLabel];

    // Now we add individual source URLs to the source stack view.
    [self loadWordSources:entry.sources toStack:sourceStackView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup the scroll view for the word view, as a lot of words may have too much content to display in one screen.
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    [NSLayoutConstraint activateConstraints:@[
        [mainScrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [mainScrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
        [mainScrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [mainScrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
    ]];

    // Now the stack view to simulate the design using flexboxes. The main stack view separates
    // elements at 48px each.
    // This stack view is the one that separates between ENTRIES.
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.spacing = 48;
    mainStackView.alignment = UIStackViewAlignmentFill;
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainScrollView addSubview:mainStackView];
    [NSLayoutConstraint activateConstraints:@[
        [mainStackView.topAnchor constraintEqualToAnchor:mainScrollView.contentLayoutGuide.topAnchor],
        [mainStackView.leadingAnchor constraintEqualToAnchor:mainScrollView.contentLayoutGuide.leadingAnchor],
        [mainStackView.trailingAnchor constraintEqualToAnchor:mainScrollView.contentLayoutGuide.trailingAnchor],
        [mainStackView.bottomAnchor constraintEqualToAnchor:mainScrollView.contentLayoutGuide.bottomAnchor],
        [mainStackView.widthAnchor constraintEqualToAnchor:mainScrollView.frameLayoutGuide.widthAnchor],
    ]];

    // For each entry, we load onto that stack view.
    for (DTWordEntry *entry in self.entries) {
        [self loadWordEntry:entry toStack:mainStackView];
    }
}

@end
