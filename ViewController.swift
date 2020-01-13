//
//  ViewController.swift
//  MidtermCalendar
//
//  Created by Benjamin Warren (student LM) on 1/10/20.
//  Copyright © 2020 Benjamin Warren (student LM). All rights reserved.
//

import UIKit

//This class implements the very top layer of formatting and declarations
class ViewController: UIViewController {
    
    let popUp = popUpView()
    
    //    declares the calendar view and allows custom constraints
    let calenderView: CalenderView = {
        let v=CalenderView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor = .blue
//        adds the calendar view to the view
        view.addSubview(calenderView)
        view.addSubview(popUp)
        popUp.isHidden = true
        
//        constraints
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
    
    }
//      allows the layout functions in Calendarview provide the layout for the collection view and not the default layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func showPopUp(){
        popUp.isHidden = false
    }
    
    
    
    //        addSubview(button)
    //
    //        button.topAnchor.constraint(equalTo: topAnchor).isActive=true
    //        button.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
    //        button.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
    //        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    //
    
    
    
}

