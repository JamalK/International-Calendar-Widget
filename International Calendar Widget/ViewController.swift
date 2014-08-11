//
//  ViewController.swift
//  International Calendar Widget
//
//  Created by Jamal Kharrat on 8/9/14.
//  Copyright (c) 2014 Jamal Kharrat. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit





class CalendarsTableViewController: UITableViewController {

    
    
    let calendars=[NSCalendarIdentifierBuddhist, NSCalendarIdentifierChinese, NSCalendarIdentifierCoptic, NSCalendarIdentifierEthiopicAmeteAlem, NSCalendarIdentifierEthiopicAmeteMihret, NSCalendarIdentifierGregorian, NSCalendarIdentifierHebrew, NSCalendarIdentifierIndian , NSCalendarIdentifierIslamic, NSCalendarIdentifierIslamicCivil, NSCalendarIdentifierIslamicTabular, NSCalendarIdentifierIslamicUmmAlQura, NSCalendarIdentifierJapanese, NSCalendarIdentifierPersian , NSCalendarIdentifierRepublicOfChina];
    
    
    //Instance of UserDefaults using a Suit to enable sharing data with the extension (widget)
    let defaults : NSUserDefaults = NSUserDefaults(suiteName: "group.calDefault")

    
    //MARK: Application LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 0.32, green: 0.23, blue: 0.34, alpha: 1)
        tableView.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView Data Source
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel.text = calendars[indexPath.row].capitalizedStringWithLocale(NSLocale.currentLocale()) as String
        
        cell.textLabel.tintColor = UIColor.whiteColor()
        cell.textLabel.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(red: 0.32, green: 0.23, blue: 0.34, alpha: 1)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return calendars.count
    }
    
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return "Select a Calendar to be shown in the widget"
    }
    
    override func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //MARK: TableView Delegate
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //TODO: Fix it to be less buggy with checkmarks with invisible cells.
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var cell = tableView.cellForRowAtIndexPath(indexPath)
            for cellAtIndex:UITableViewCell in tableView.visibleCells() as [UITableViewCell]
            {
                cellAtIndex.accessoryType = .None
            }
            cell.accessoryType = .Checkmark
        //Saving Data in NSUserFeaults
        defaults.setValue(calendars[indexPath.row] as NSString!, forKey: "idSelected")
        defaults.synchronize()
    }
    

}



