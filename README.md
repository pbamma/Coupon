# saver
iOS Swift MVVM coupon app.

# Major functions
- Master - Display list of coupon items
- Detail - Display large coupon item with more details
- User may favorite item from Detail view, which will be reflected in Master

# Requirements
iOS 1.3.1+ 
Xcode 11.1+
Swift 5.1+

# Installation
- all pods are checked in to the repo, no need for any pod install

# Build notes
- after github co, simply run project from XCode IDE in Simulator.

# Notes
- The application recieves mock data from the app bundle.
- line 56 MasterViewController.setupFeed() - a call to an actual API can be uncommented to view the app work from an external API online.
- The application has no persistence model.  A real world app would.
