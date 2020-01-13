//
//  popUpView.swift
//  MidtermCalendar
//
//  Created by Benjamin Warren (student LM) on 1/13/20.
//  Copyright © 2020 Benjamin Warren (student LM). All rights reserved.
//

import Foundation
import UIKit

//This class implements a view that would pop up from the calendar when a date is selected (hopefully)
class popUpView: UIView{
    //    initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    label and button variables
    let label = UILabel()
    let button = UIButton()
    let textField = UITextField()
    
    //    function to set up the View
    func setUpViews(){
        //        Adds the label to the view
        self.addSubview(label)
        //        formats the label
        label.text = "New event"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.backgroundColor = .lightGray
        label.textAlignment = .center
        
        //        constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 300).isActive = true
        
        
        //        Adds the button to the view
        self.addSubview(button)
        //        formats the button
        button.titleLabel?.text = "Done"
        button.titleLabel?.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        
        //        adds the button's functionality
        button.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        
        //        constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //        adds the textField to the view
        self.addSubview(textField)
        
        textField.placeholder = "Enter Event"
        textField.font = UIFont(name: "Helvetica Neue", size: 16)
        
        
        
        
        
        
    }
    
    @objc func closePopUp(){
        
    }
    
    
}
