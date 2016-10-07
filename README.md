# happyt

Happyt is an app to track habits. Bringing awareness to the amount of activities that we do, whether they are good or bad.

Steps to install:
- Clone the repo: **$ git clone https://github.com/maxsayenko/happyt.git**
- CD into the directory: **$ cd happyt**
- install Cocoa Pods: **$ pod install** and you should see something like this
```
Analyzing dependencies
Downloading dependencies
Installing Alamofire (3.2.1)
Installing AlamofireImage (2.3.1)
Installing OMGHTTPURLRQ (3.2.0)
Installing PromiseKit (3.5.1)
Installing SCLAlertView (0.6.0)
Installing SwiftCharts (0.4)
Generating Pods project
Integrating client project
Sending stats
Pod installation complete! There are 5 dependencies from the Podfile and 6 total
pods installed.
```
Now you are ready to lunch the app by openning **happyt.xcworkspace** file. 


Steps to use:
- To Login user needs to use FB login. (There are no postings on the wall or sharing of that data taken place)
- On the Dashboard view user can tap plus icon (top right) to add more habits. And choose whether this habit has only positive events, negative or both
- Once habits are added. User can track their activity by tapping plus or minus button. Given that habit supports that event
- To view the reports user needs to tap on the TabBar Stats icon
- There are 2 types of the reports: Today and This week. **Today** shows events and their placements on charts (per habit) starting from midnight today, and until the end of the current day. **Week** report does the same thing only for the week. And uses bar charts rather than line, to account for large amount of events
- To delete a habit user can swipe in the table to the left, and choose delete
- There is also some stubbed data to test the app. As it's much better to see reports with some data in them, and adding a lot of events withing the same hour won't show the spread. To use that, reviewer can enable adding of dummy events in the **AppDelegate.swift** fie

This project was build using XCode 7.3.1.
