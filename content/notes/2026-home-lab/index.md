---
title: 2026 Whats In The Home Lab
teaser: ''
date: 2026-04-05 22:34:28.355000+00:00
preview: ''
draft: true
tags:
- '2026'
- Future Trends
- Home Lab
- Innovation
- Technology
categories:
- DIY
- Future Trends
- Home Lab
- Innovation
- Technology
bluesky_post_url: ''
fmContentType: post
canonicalUrl: https://shindasingh.com/2026/04/05/2026-home-lab/
---


I've been running my own homelabs now for a better part of a decade but I never really took the time to document / reward / shoutout the tools that I've been using regularly. 

Part wanting to help ya'll out, part wanting a time capsule to look back on, I thought I'd put together my current favourite tools.

## Media Server - [Plex](https://www.plex.tv/)

{{< img src="plex.png" alt="Plex" resize="900x900>" class="center" >}}

This is a bit cliché. I haven't jumped on the jellyfin bandwagon largely because it's just not as accessible across devices. My current Plex server does everything I need and while I can't imagine switching or adding Jellyfin would be a pain, I haven't hit the wall with Plex yet.

I don't think the plex/stack needs to be overly detailed, what works currently has been working for the last decade:

> [Sonarr](https://sonarr.tv/) / [Radarr](https://radarr.video/) / [Sabnzbd](https://sabnzbd.org/) / [Overseerr](https://overseerr.dev/) / [Trakt](https://trakt.tv/) / [Tautulli](https://tautulli.com/)

## Image Management - [Immich](https://immich.app/)

{{< img src="immich.png" alt="Immich" resize="900x900>" class="center" >}}

I remember my very first PHP project of any merit over 20 years ago was creating an image management library before changing it up to just using some of the early image libraries whose names have been lost to the obscurity of time.

For the most part my personal photos have by and large just been organized manually in folders. It works fine for the DSLR workflow, but Google Photos for the longest time has run and managed all our family phones - which is great except that Google can at any time say woops and wipe out your entire history. A missed subscription and having just everything only exist in the cloud is a bit worrisome.

So in comes the newest addition - _Immich_. I've liked this app enough that I was moved to sponsor its development. It just works well, is able to catalogue all our phone pics and is a solid drop-in replacement for Google Photos. While I still have a Photos account, Immich manages photos just as well for backups. Makes the thought of disconnecting Google that much easier.

## Money Management - [Sure](https://github.com/we-promise/sure)

{{< img src="sure.png" alt="Sure" resize="900x900>" class="center" >}}

I've always sucked at budgeting and while the online tools are nice they're also expensive for something I don't do or use enough. 

Enter Sure. This thing does everything I need, allows for automatic import from bank accounts that support it through 3rd party tools and otherwise handles CSVs pretty easily. 

It's got the charting I need and it has basic LLM integration where it can quickly and automatically categorize and tag expenses. 

I doubt this one shifts too much so long as its core functionality just works.

## PKM - [Silverbullet](https://silverbullet.md/)

{{< img src="silverbullet.png" alt="Silverbullet" resize="900x900>" class="center" >}}

This category has always been tricky. We've gone from Notion to Logseq and here we are today at Silverbullet. 

I was big on Logseq's simplicity last year and even though I fell in love with its speed and its paradigm of note tracking, syncing data between devices was just a miserably horrid experience. I tried using folder sync with Google Drive, and ya it just wasn't pretty. Constant conflicts and eventually the UI just would crawl to a snail's pace. 

While heartbroken at the thought of having to give Logseq the Old Yeller treatment 😭, I stumbled upon Silverbullet. 

This thing blew me away, it's just a web app that works - syncs fine with background workers so can retain notes locally also. Doesn't need any special glue. The graphing, navigation and extension tools are all hella straightforward. I loooweee it.

I really hope I don't gotta migrate again. Although I do sometimes miss LogSeq's daily interface that then links things together but meh.

## File System - BTRFS + MergeFS + Snapraid

After the miserable experience I had trying to resurrect and cut out data from the failed QNAP raid that - yes, was my fault - I decided to just not get myself into that situation again.

Yes RAID offers a ton of advantages, but the disadvantages were just annoying. First and foremost I recognize that RAID or even this setup is no replacement for a proper backup. I recognize that. I believe that, but in the case you get caught with your underwear down and the house on fire, I figure having some files being recoverable off a failed drive is better than a bunch of files not being recoverable due to a messed up stripe. 


{{< img src="https://media.giphy.com/media/NTur7XlVDUdqM/giphy.gif" alt="house on fire this is fine" class="center"  >}}

This setup is just easy - you add a new drive - you get your space. No restriping, no rebalancing. A drive fails, throw in a new one, use snapraid to restore from parity or better yet - restore from your proper backup. Snapshots work, file de-duping works. 

It just works. It's easy. What more do I need?

## Password Management - [Vaultwarden](https://github.com/dani-garcia/vaultwarden)

{{< img src="vaultwarden.png" alt="VaultWarden" resize="900x900>" class="center" >}}

I had to take Lastpass out back last year with the shovel and after having been on it for over 2 decades it was hard to say goodbye.  

But honestly VW which is just a Bitwarden implementation in Rust hasn't made me miss a beat. Plugins all work. It's secure. It's good.

![Thumbs up gif](https://media.giphy.com/media/111ebonMs90YLu/giphy.gif){: .center}

### Photo Editing- [DXO Labs](https://www.dxo.com/) 

{{< img src="dxophoto.png" alt="DXO" resize="900x900>" class="center" >}}

This has been collecting dust and it's Windows only which is kind of a bummer. I don't have my drop-in replacement for Linux yet. 

I'll work on that. I also rarely use it currently since I haven't been taking too many photos.

## Video Editing - [Davinci Resolve Studio](https://www.blackmagicdesign.com/products/davinciresolve/)

{{< img src="davinci.png" alt="Davinci Resolve" resize="900x900>" class="center" >}}

I probably won't be replacing this with any OSS tool yet. I know how to use this. It works on Linux. Yes it's hella annoying on Linux, but it works. 

I'm just too comfortable with it and owning the studio license makes it easy for me to keep it going. When they suck on the teat and go all in on some kind of LLM monthly subscription maybe I'll reconsider, but for now I'd be happy re-upping my license every few versions, to keep development going.

## VPN - [Tailscale](https://tailscale.com/)

{{< img src="tailscale.png" alt="Tailscale" resize="900x900>" class="center" >}}

I'm still flabbergasted by whatever witches and wizards put this thing together. It's just beautiful. There are very few cases of tech that bring a tear to my eye or that I would just say are so elegantly awesome. Tailscale is that unicorn right now.

Connecting all my various PCs together making it possible for me to connect from anywhere, no need to open up my network and just tunnel in and use the services when I need em.

The sheer simplicity and security this thing brings me. Don't gotta worry about some app's vibe-coded auth failing em. Don't gotta worry about someone just hammering some 3rd party service's 0-day. Stick em behind the VPN. Tunnel on when I need to access em. I'm good.

The fact that their free tier is so damn good has me recommending this for full on corporate/enterprise use for apps that require a secure VPN connectivity surface.
