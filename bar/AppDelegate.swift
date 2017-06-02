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

    let statusBar = NSStatusBar.system()
    let menu = NSMenu()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var rssResponse = String()
    var rate = Float()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem = statusBar.statusItem(withLength: -1)
        refresh()
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(AppDelegate.refresh), userInfo: nil, repeats: true)
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared().terminate), keyEquivalent: "q"));
        statusBarItem.menu = menu
    }

    func refresh() {
        rssResponse = get()
        rate = getCurrency(rssResponse)
        if (rate > 1) {
            statusBarItem.title = NSString(format: "1$=%.4f PLN", rate) as String
        }
    }
    
    func getCurrency(_ rss: String) -> Float {
        if let from = rss.range(of: "1.00 USD =") {
            if let to = rss.range(of: "PLN<br/>") {
                let xyz = rss.substring(with: Range<String.Index>(from.upperBound..<to.lowerBound))
                return (xyz as NSString).floatValue
            }
        }
        return 0
    }
    
    func get() -> String {
        let myURLString = "http://pln.fxexchangerate.com/usd.xml";
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return ""
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL)
            return myHTMLString
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return ""
    }
}

