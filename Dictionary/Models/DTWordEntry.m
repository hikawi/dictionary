//
//  DTWordEntry.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordEntry.h"

@implementation DTWordEntry

@synthesize word;
@synthesize phonetics;
@synthesize meanings;
@synthesize sources;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.word = @"";
        self.phonetics = @[];
        self.meanings = @[];
        self.sources = @[];
    }
    return self;
}

+ (DTWordEntry *)testWord {
    DTWordEntry *entry = [[DTWordEntry alloc] init];

    DTWordPhonetic *firstPhonetic = [[DTWordPhonetic alloc] initWithText:@"/ˈkiːbɔːd/"];
    DTWordPhonetic *secondPhonetic = [[DTWordPhonetic alloc] initWithText:@"/ˈkiːbɔːd/"];
    DTWordPhonetic *thirdPhonetic =
        [[DTWordPhonetic alloc] initWithText:@"/ˈkibɔɹd/"
                                       audio:@"https://api.dictionaryapi.dev/media/pronunciations/en/keyboard-us.mp3"];

    DTWordMeaning *nounMeaning = [[DTWordMeaning alloc] init];
    nounMeaning.partOfSpeech = @"noun";
    nounMeaning.synonyms = @[ @"electronic keyboard" ];
    nounMeaning.definitions = @[
        [[DTWordDefinition alloc]
            initWithDefinition:@"(etc.) A set of keys used to operate a typewriter, computer etc."],
        [[DTWordDefinition alloc]
            initWithDefinition:
                @"A component of many instruments including the piano, organ, and harpsichord consisting of usually "
                @"black and white keys that cause different tones to be produced when struck."],
        [[DTWordDefinition alloc]
            initWithDefinition:@"A device with keys of a musical keyboard, used to control electronic sound-producing "
                               @"devices which may be built into or separate from the keyboard device."],
    ];

    DTWordMeaning *verbMeaning = [[DTWordMeaning alloc] init];
    verbMeaning.partOfSpeech = @"verb";
    verbMeaning.definitions = @[
        [[DTWordDefinition alloc] initWithDefinition:@"To type on a computer keyboard."
                                             example:@"Keyboarding is the part of this job I hate the most."],
    ];

    entry.word = @"keyboard";
    entry.phonetics = @[ firstPhonetic, secondPhonetic, thirdPhonetic ];
    entry.meanings = @[ nounMeaning, verbMeaning ];
    entry.sources = @[ [NSURL URLWithString:@"https://en.wiktionary.org/wiki/keyboard"] ];

    return entry;
}

@end
