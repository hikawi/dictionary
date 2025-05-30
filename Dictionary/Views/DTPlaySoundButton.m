//
//  DTPlaySoundButton.m
//  Dictionary
//
//  Created by Luna on 2025/05/30.
//

#import "DTPlaySoundButton.h"
#import <AVFoundation/AVFoundation.h>

@interface DTPlaySoundButton ()

@property(strong) AVAudioPlayer *audioPlayer;
@property(strong) NSURL *audio;

@end

@implementation DTPlaySoundButton

@synthesize audioPlayer;
@synthesize audio;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.audio = NULL;
    }
    return self;
}

- (instancetype)initWithAudio:(NSURL *)audio {
    self = [self init];
    self.audio = audio;
    [self setup];
    return self;
}

- (void)setup {
    // Let's setup that play button with some image assets we set up in Assets.
    UIImage *playImage = [UIImage imageNamed:@"DictionaryPlaySoundIcon"];
    UIImage *playHighlightedImage = [UIImage imageNamed:@"DictionaryPlaySoundHighlightedIcon"];
    self.contentMode = UIViewContentModeScaleAspectFit;
    [self setImage:playImage forState:UIControlStateNormal];
    [self setImage:playHighlightedImage forState:UIControlStateHighlighted];
    [self setImage:playHighlightedImage forState:UIControlStateFocused];
    [self setImage:playHighlightedImage forState:UIControlStateSelected];
    [self setImage:[playImage imageWithTintColor:UIColor.systemGrayColor] forState:UIControlStateDisabled];
    [self addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [NSLayoutConstraint activateConstraints:@[
        [self.heightAnchor constraintEqualToConstant:48],
        [self.widthAnchor constraintEqualToConstant:48],
    ]];

    // Disable the play button if the audio is not available.
    if (self.audio == NULL) {
        self.enabled = NO;
    }
}

/// Plays the audio associated at the phonetic's URL using AVFoundation's AVPlayer.
- (void)playAudio {
    if (self.audioPlayer != NULL && self.audioPlayer.playing) {
        // Stop the audio if it's playing.
        [self.audioPlayer stop];
    } else if (self.audioPlayer == NULL) {
        // If it's not fetched yet, fetch the audio file.
        NSURLSessionDataTask *task =
            [NSURLSession.sharedSession dataTaskWithURL:self.audio
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
