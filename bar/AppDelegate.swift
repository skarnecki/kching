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
    var rssResponse = String()
    var rate = Float()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusBarItem = statusBar.statusItemWithLength(-1)
        refresh()
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(AppDelegate.refresh), userInfo: nil, repeats: true)
    }

    func refresh() {
        rssResponse = get()
        rate = getCurrency(rssResponse)
        if (rate > 1) {
            statusBarItem.title = NSString(format: "1$=%.4f PLN", rate) as String
        }
    }
    
    func getCurrency(rss: String) -> Float {
        if let from = rss.rangeOfString("1.00 USD =") {
            if let to = rss.rangeOfString("PLN<br/>") {
                let xyz = rss.substringWithRange(Range<String.Index>(from.endIndex..<to.startIndex))
                return (xyz as NSString).floatValue
            }
        }
        return 0
    }
    
    func get() -> String {
        let myURLString = "http://pln.fxexchangerate.com/usd.xml";
        guard let myURL = NSURL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return ""
        }
        
        do {
            let myHTMLString = try String(contentsOfURL: myURL)
            return myHTMLString
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return ""
    }
}

