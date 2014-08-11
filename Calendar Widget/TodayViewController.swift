//
//  TodayViewController.swift
//  Calendar Widget
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
import NotificationCenter

class TodayViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!

    
    //MARK: Application LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registering for Notifications when The value changes in NSUserDefaults
        let notificationCenter: Void = NSNotificationCenter.defaultCenter().addObserver(self, selector: "calendarChanged", name: NSUserDefaultsDidChangeNotification, object: nil)
        setLabel()
        
    }
    
    func calendarChanged(notification : NSNotification){
        setLabel()
    }
    
    
    func setLabel(){
        let identifier = NSUserDefaults(suiteName: "group.calDefault").valueForKey("idSelected") as NSString!
        let formatter = NSDateFormatter(template: "yyyy-MMMM-dd")
        
        dateLabel.text = String.dateStringFrom(identifier, formatter: formatter)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Widget Methods
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}

extension NSDateFormatter{
    /**
    Convinience Initiazlizor.
    
    :param: template: String! (e.g. yyyy-MMMM-dddd).
    
    :returns: NSDateFormatter instance with the specified template, and the current locale.
    */
    convenience init(template : String!){
        self.init()
        self.setLocalizedDateFormatFromTemplate(template)
        self.locale = NSLocale.currentLocale()
    }
}

extension String{
    /**
    Static Function that returns a String for today's date using a Fromatter, and NSCalendarIdentifer.
    
    :param: identifier : NSString! (e.g. NSCalenderIdenitiferIndian)
    :param: formatter  : NSDateFromatter
    
    :returns: String
    */
    static func dateStringFrom(identifier : NSString! , formatter : NSDateFormatter) -> String{
        let calendar : NSCalendar = NSCalendar(identifier: identifier)
        formatter.calendar = calendar
        return  formatter.stringFromDate(NSDate.date())
    }
}


