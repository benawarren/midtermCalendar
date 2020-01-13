//
//  CalendarView.swift
//  MidtermCalendar
//
//  Created by Benjamin Warren (student LM) on 1/10/20.
//  Copyright © 2020 Benjamin Warren (student LM). All rights reserved.
//

import Foundation
import UIKit

//CalendarView brings all of the other classes together and implements the overall strcuture of the calendar. It is a UIView and the delegate and data source for the collectionView and the delegate for the monthView, and it allows the collectionView to be formatted correctly in a grid with the UICollectionViewDelegateFlowLayout

class CalenderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate {
    
    //    variables needed throughout the class
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    //    the actual month and year of the current date
    var currentMonthIndex = 0
    var currentYear = 0
    //    the month and year that are being shown on the screen
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
    
    //    Initalizer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        calls the function that initializes the view itself
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        //        Gets current date information from the Calendar struct
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        //        calls function to get correct weekday for a month to start
        firstWeekDayOfMonth=getFirstWeekDay()
        
        //for leap years, make february 29 days
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
        }
        //end
        //Sets the shown month and year to the current month and year
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        
        //        calls the function to set up the view
        setupViews()
        
        //        sets up the collection view delegate as this class
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    //    Sets the number of items in each collectionView section to the necessary amount
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    //    Formats and creates the collectionView's cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //         declares cell correctly
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
        //        sets cell's background color to clear
        cell.backgroundColor=UIColor.clear
        
        //      Hides cells if necessary
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        }
        else {
            //            sets correct date
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.lbl.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=false
                cell.lbl.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.lbl.textColor = .white
            }
        }
        return cell
    }
    
    //    formats cell for when it is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .green
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor=UIColor.white
        
        ViewController().showPopUp()
    }
    
    //    formats cell for when it becomes unselected
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
        let lbl = cell?.subviews[1] as! UILabel
        lbl.textColor = .white
    }
    
    //    sets the size of the items in the collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        sets the width and height
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    //    Don't know if these two are necessary function, they do more layout stuff
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    //    Function for returning the correct first weekday in a month
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        //return day == 7 ? 1 : day
        return day
    }
    
    //    Called when the month changes, sets the month, year and other necessary info to the correct value
    func didChangeMonth(monthIndex: Int, year: Int) {
        //        sets month and year to the right ones
        currentMonthIndex=monthIndex+1
        currentYear = year
        
        //for leap year, make february month of 29 days
        if monthIndex == 1 {
            if currentYear % 4 == 0 {
                numOfDaysInMonth[monthIndex] = 29
            } else {
                numOfDaysInMonth[monthIndex] = 28
            }
        }
        //end
        
        //        sets firstWeekDay correctly
        firstWeekDayOfMonth=getFirstWeekDay()
        //        reloads the collectionView to display the first month
        myCollectionView.reloadData()
        
        
        //        monthView.backButton.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
    }
    
    //    Sets up the formatting of the view
    func setupViews() {
        //        adds the monthView to the UIView
        addSubview(monthView)
        //        constraints
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        monthView.heightAnchor.constraint(equalToConstant: 35).isActive=true
        monthView.delegate=self
        //        Adds the weekdayView to the UIView
        addSubview(weekdaysView)
        //        constraints
        weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive=true
        weekdaysView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        weekdaysView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        weekdaysView.heightAnchor.constraint(equalToConstant: 30).isActive=true
        
        //        adds the collectionView (for days of the month) to the UIView
        addSubview(myCollectionView)
        //        constraints
        myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0).isActive=true
        myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive=true
        myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
    }
    
    //    Just an interesting thing: this is a different way to declare a constant that I didn't know - You can perform functions with the object while it is being declared - useful
    //    declares the monthView and allows for custom constraints
    let monthView: MonthView = {
        let v=MonthView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    //    declares the weekdaysView and allows for custom constraints
    let weekdaysView: WeekdaysView = {
        let v=WeekdaysView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    //    declares the CollectionView and adds/formats the layout
    let myCollectionView: UICollectionView = {
        // layout formats the cells so that they flow from one to another
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        More formatting and constraints
        let myCollectionView=UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor=UIColor.clear
        myCollectionView.allowsMultipleSelection=false
        return myCollectionView
    }()
    

    
}

// This class sets up the individual cells
class dateCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.clear
        layer.cornerRadius=5
        layer.masksToBounds=true
        
        //        calls the function to set up formatting
        setupViews()
    }
    
    func setupViews() {
        //        adds a label into the cells

        addSubview(lbl)
        //        constraints
        lbl.topAnchor.constraint(equalTo: topAnchor).isActive=true
        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        lbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
     
    }
    
    //    declares and formats label
    let lbl: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font=UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
//    declares a button inside the cells
//    let button: UIButton = {
//        let btn = UIButton()
//        btn.addTarget(self, action: #selector(dailyEvent), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    The button's action
//    @objc func dailyEvent(){
//        addSubview(popUpView.init())
//        print("clicked")
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//get first day of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

//get date from string
//formats the date from the Calendar struct in a usable manner
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}


