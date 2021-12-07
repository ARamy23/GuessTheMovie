# ARamy23-Mobile-App

## Brief Description
A Quick Drag and Drop Source of files that automates the first week of bootstraping things up

## Purpose
The purpose of this repo is to provide me with already implemented and tested solutions that worked for me in couple of projects with different use cases, appraoches, design patterns and lastly, architectures

It immitates the same solution used there and also gives me and my team less time in getting up to speed with our work by providing essential, time consuming and sometimes a less-prioritized-by-the-business solutions to have a great app from day 1

## How do I use this in my workflow?
I'd first use the repo as a headstart, then run the scripts so it changes all the apps to basically a brand-new project ready to be developed with the below components

1. Automated-Localization connected to POEditor that is 2-way-binded with Github's Project
2. Fully Configurable and automated Design system that provides Fonts, Colors and Images to the app's project
3. Onboarding script that sets up Fastlane in a matter of seconds so I have a non-vendor-locked CI/CD solution that I can use for free across different CI/CD Providers without paying a penny because I'll be deactivating and enabling the providers based on whether I have credit or not and then fallback to manually running the pipelines on my local machine
4. Flexible UIBuilders to build basic UIs by just giving them basic UI Components that can be modified based on the design
5. Flexible Configuration System that controls all the UI aspects and sometimes Business Requirements
6. Pluggable Files, I just put those into their places and they work, am mostly talking about Lazy Loading, Pull to refresh, Swipe to dismiss
7. Repository (Basic and Advanced) pattern that allows me to easily add Offline First approach to the app with a mediator in the middle to force the source to be always from the Cache
8. BDD-Driven-Development Using Quick & Nimble
9. Automated Sync of Assets and Strings using SwiftGen to allow for strong-typed referencing and avoid hardcoded 'typos'

## Scripts
### Onboarding Script 
1. Responsible for bootstraping teammates and the project itself if needed
2. Generates a GitIgnored local config file that you can fill with your own secrets ;)

### Fonts Configurations
Responsible for Configuring the Project's Fonts (Localizable)

### Colors Configurations
Responsible for Configuring the Project's Fonts (Dark Mode Supported)

## Docs
### Pull Request Template
Helps me and the team to focus our thought process into what needs to be written so reviewers can know what to look for and what's been done, so the review is easier

## Fastlane
1. Generates CHANGELOG.md
2. Generate Test Coverage and Test Reports
3. Generate Localized App Store Updates
4. Generate Screenshots (WIP)
5. Upload to TF
6. Upload to AppStore
7. Automated Semantics (Optional)

## Configurations
### Fonts
1. What Font Family?
2. San-Serif or just 'Serif'?
3. Suitable to which Language?

### Colors
1. Supports Light and Dark Mode
2. Supports Multiple Themes with automated Settings Section (WIP)
