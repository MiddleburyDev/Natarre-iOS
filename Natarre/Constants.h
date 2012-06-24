//
//  Constants.h
//  Natarre
//
//  Created by Thomas Beatty on 6/23/12.
//  Copyright (c) 2012 Nate Beatty. All rights reserved.
//

#ifndef Natarre_Constants_h
#define Natarre_Constants_h

// Token Salts
#define kTNBUploadSalt @"Te99y"
#define kTNBDownloadSalt @"Wi11"

// Server URLs
#define kTNBBaseURL @"http://willpotter.local:3000/"
#define kTNBLoginURL kTNBBaseURL @"/mobile/api/login/natarre"
#define kTNBRegisterURL kTNBBaseURL @"/mobile/api/register/natarre"

#define kTNBThisWeekPromptURL kTNBBaseURL @"/mobile/api/prompts/thisweek"
#define kTNBStoriesForPromptURL kTNBBaseURL @"/mobile/api/stories/forprompt"
#define kTNBPopularStoriesURL kTNBBaseURL @"/mobile/api/stories/popular"
#define kTNBFavoriteStoriesURL kTNBBaseURL @"/mobile/api/stories/favorites"
#define kTNBReadingListURL kTNBBaseURL @"/mobile/api/stories/readinglist"

#define kTNBFavsURL kTNBBaseURL @"/mobile/api/add/vote"

#define kTNBAllPromptsURL kTNBBaseURL @"/mobile/api/prompts/all"

// NSUserDefaults Login Keys
#define kTNBNSUserDefaultsTokenKey @"kTNBNSUserDefaultsTokenKey"
#define kTNBNSUserDefaultsEmailKey @"kTNBNSUserDefaultsEmailKey"
#define kTNBNSUserDefaultsUserIDKey @"kTNBNSUserDefaultsUserIDKey"


#endif
