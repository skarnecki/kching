//
//  AppDelegate.swift
//  bar
//
//  Created by Szymon Karnecki on 15/11/16.
//  Copyright © 2016 Szymon Karnecki. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.title = "Presses"
        refresh()
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("refresh"), userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


    func refresh() {
        let rnd = Int(arc4random_uniform(1000) + 1)
        statusBarItem.title = NSString(format: "1$=%.2f PLN", Float(rnd)/Float(100)) as String
    }
    
}

