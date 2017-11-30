//
//  ViewController.swift
//  WhatIsTheWeatherRx
//
//  Created by Vladimir Nevinniy on 28.11.2017.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Binding the UI
        viewModel.cityName.bind(to: cityNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.degrees.bind(to: degreesLabel.rx.text)
            .disposed(by: disposeBag)
        
//        nameTextField.rx.text.orEmpty
//            .bind(to: viewModel.searchText)
//            .disposed(by: disposeBag)
        

        nameTextField.rx.controlEvent(UIControlEvents.editingDidEndOnExit).asObservable().subscribe(onNext: {print("editing state changed")
            self.viewModel.searchText.onNext(self.nameTextField.text)
        }, onError: { (error) in
            print(error.localizedDescription)
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
        
        //subscribe(onNext: {
//            print("editing state changed")
//    }, onError: { (error) in   print(error)}, onCompleted: nil, onDisposed: disposeBag)
//
        
        
//        nameTextField.rx.controlEvent(UIControlEvents.editingDidEndOnExit).asObservable().map {
//           self.nameTextField.text
//        }
            
//
//            { text in
//            self.viewModel.searchText.onNext(text)
//            }
//            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

