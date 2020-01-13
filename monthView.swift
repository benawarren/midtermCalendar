//
//  monthView.swift
//  MidtermCalendar
//
//  Created by Benjamin Warren (student LM) on 1/10/20.
//  Copyright © 2020 Benjamin Warren (student LM). All rights reserved.
//

import Foundation
import UIKit

//declares protocol for changing the month
protocol MonthViewDelegate: class{
    func didChangeMonth(monthIndex: Int, year: Int)
}

//This class uses a normal UIView to display the Month and year in a label and a forward and backward button for said month in buttons

class MonthView: UIView {
    //    array of months
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    //    current month
    var currentMonthIndex = 0
    //    current year
    var currentYear: Int = 0
    //    delegate of type declared by protocol above
    var delegate: MonthViewDelegate?
    
    //    initializer for view
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        //        sets the current month and year correctly using the Calendar struct
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        //        calls the functions to set up views
        setUpLabel()
        setUpForwardButton()
        setUpBackButton()
        
    }
    //    Don't really know what this is, but it said I needed it
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    label for the name of the month & year
    let monthLabel = UILabel()
    //    back button
    let backButton = UIButton()
    //    forward button
    let forwardButton = UIButton()
    
    //    sets up necessary attributes of back button
    func setUpBackButton(){
        //        adds button to view
        self.addSubview(backButton)
        //        formats how the button looks
        backButton.setTitle("<", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        //        targets the necessary function
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        //        button constraints
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: topAnchor).isActive=true
        backButton.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive=true
        backButton.heightAnchor.constraint(equalTo: heightAnchor).isActive=true
        
    }
    //    sets up necessary attributes of forward button
    func setUpForwardButton(){
        //        adds button to view
        self.addSubview(forwardButton)
        //        formats how the button looks
        forwardButton.setTitle(">", for: .normal)
        forwardButton.setTitleColor(.white, for: .normal)
        //        targets the necessary function
        forwardButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        //        button constraints
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.topAnchor.constraint(equalTo: topAnchor).isActive=true
        forwardButton.leftAnchor.constraint(equalTo: rightAnchor).isActive=true
        forwardButton.widthAnchor.constraint(equalToConstant: 50).isActive=true
        forwardButton.heightAnchor.constraint(equalTo: heightAnchor).isActive=true
    }
    //    sets up necessary attributes of label
    func setUpLabel(){
        //        adds label to the view
        self.addSubview(monthLabel)
        //        formats the label
        monthLabel.text = "Default month/year"
        monthLabel.textColor = .white
        monthLabel.textAlignment = .center
        monthLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        
        //        constraints
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive=true
        monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        monthLabel.widthAnchor.constraint(equalToConstant: 150).isActive=true
        monthLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive=true
        //        sets the month to the correct date
        monthLabel.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        
    }
    
    @objc func goBack(){
        //        performs necessary operations to update month
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
        //        sets month label to updated month
        monthLabel.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        //        informs delegate that the month has changed
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        
    }
    
    @objc func goForward(){
        //        performs necessary operations to update month
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
        //        sets month label to updated month
        monthLabel.text="\(monthsArr[currentMonthIndex]) \(currentYear)"
        //        informs delegate that the month has changed
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
        
    }
    
    
}
