# Problems and non-problems

## Refocusing our intent

Eric has expressed an interest in helping Tom with his goals. 

Tom has writing and social networking goals. They include
- supporting other non-technical writers
- moving text through a workflow
- developing some experimental software for encouraging healthy and productive practices
- hosting small and very small social networks and forums for writers - not all writing tools are devices or softwares; some are writing groups and networks of letters (just ask Mersenne)
- eventually, connecting to markets - print, digital sales, crypto, whatever

For now I'm going to call my vision of a text assistant that helps me recur over my writing, the Text Looper.

Tom has some non-goals:
- learning more new text editor than is necessary
	- I'm glad to know Helix exists, I wish them the best, I can't afford to break my finger memory right now. I do see value in a new non-graphical editor that has the benefit of decades of progress since vim; but until it can connect to a Clojure repl and has LSP support for Cucumber, Igotta pin this
- fuckin' with window managers (some day but not today)


## Means that come to mind
Let's not fall into the tool trap. All of the following is just a rough list of technologies and tools which might support the goals. But if they don't? Pitch 'em out.

### Flakes
I have wasted a lot of time being confused on a new platform, so I am all in favor of a rapid reproducible config tool.

### Non-graphical text editor
They're lightweight, they're fast, they can have menus like Spacemacs, they are appropriate for developing on microcomputers or virtual servers or Termux. I do wonder whether it might be better to have a socket mindset: local configured environment talks to a babashka socket repl. Whatever serves the goals. 

### Ansible
A short script to set up a nix beachhead on an arbitrary architecture would be pretty sweet.

### Dev tools
Assuming the non-socket approach: programs like git, curl, a git porcelain, a multiplexer, some kind of way to manage secrets and wallets and such, a dotfiles manager for when you come up with a new config idea that you want to have available on all platforms.

### WebDAV
PureWriter is an Android app that can connect to WebDAV. I think this could suit my privacy-conscious friends, when the Text Looper is in pre-pre-alpha.


### NAS
Can I share music and TV with a small, non-RIAA-luring group of friends? Can I keep art assets somewhere on a drive in my house rather than on some expensive cloud backup?

I would like the Text Looper to be able to handle non-text. That might mean, accumulating video that needs logging and editing, or photos that are in RAW format that need to be reviewed, edited, compressed down to size, captioned, tagged, etc. For Tom it might mean accumulating audio from a livestream, cutting that down to just a little sample library and a Riff on Endlesss. Or whatever, my point is just that there might be a volume of data that is not as cheap as text that needs handling, and perhaps it needs special handling. 

### ActivityPub
Back inna day, when Twitter didn't suck, there was a hashtag, #amwriting. It helped people by being a little hashtag to let other people know, hey I'm doing my morning writing, you could too. I see it as a semaphore, with optional word count or duration, and optional topic or namespace that the writer was working on developing that day.


### Babashka
It's cool to run things off the JVM.

### The JVM
Not that there's anything wrong with regular Clojure.

