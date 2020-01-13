//
//  WeekdaysView.swift
//  MidtermCalendar
//
//  Created by Benjamin Warren (student LM) on 1/10/20.
//  Copyright © 2020 Benjamin Warren (student LM). All rights reserved.
//

import Foundation
import UIKit

//This class uses a UIStackView to horizontally stack 7 views across the top of the calendar. Each view has a label which displays the day of the week it represents
class WeekdaysView: UIView {
//    initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        
        setUpViews()

}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    declares stackView
    let stackView = UIStackView()
    
    func setUpViews(){
//      adds stackView to the view
        addSubview(stackView)
//        spaces the views equally across the screen
        stackView.distribution = .fillEqually
        
//        constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
//        array of day identifiers
        var daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
//        sets up labels in individual views within stack views
        for i in 0..<7 {
            let label=UILabel()
            label.text=daysArr[i]
            label.textAlignment = .center
            label.textColor = .white
            stackView.addArrangedSubview(label)
        }
        }
    
    
    
    
}
