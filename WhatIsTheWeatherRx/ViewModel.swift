//
//  ViewModel.swift
//  WhatIsTheWeatherRx
//
//  Created by Vladimir Nevinniy on 28.11.2017.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import RxSwift
import RxCocoa


class ViewModel {
    
    var cityName = PublishSubject<String>()
    var degrees = PublishSubject<String>()
    
    
    var weather:Weather? {
        didSet {
            if let name = weather?.name {
                DispatchQueue.main.async() {
                    self.cityName.onNext(name)
                }
            }
            if let temp = weather?.degrees {
                DispatchQueue.main.async() {
                    self.degrees.onNext("\(temp)°F")
                }
            }
        }
    }
    
    
    private struct Constants {
        static let URLPrefix = "http://api.openweathermap.org/data/2.5/weather?q="
        static let URLPostfix = "1497054d9600a1fa053839df0b9af942"
    }
    
    let disposeBag = DisposeBag()
    
    var searchText = PublishSubject<String?>()
    
    
    func getURLForString(_ text: String?) -> URL? {
        
        guard text != nil else { return nil }
        
        
        let url = Constants.URLPrefix+text!+"&APPID="+Constants.URLPostfix
        return URL(string: url)
    }
    
    init() {
        let jsonRequest = searchText
            .map { (text) -> Observable<Any> in
                let url = self.getURLForString(text)
                
                print(url)
                
                return URLSession.shared.rx.json(url: url!)
            }
            .switchLatest()
        
        jsonRequest.subscribe(onNext: { (json) in
            self.weather = Weather(json: json as AnyObject)
        }, onError: { (error) in
            print(error.localizedDescription)
        }, onCompleted: {
            
        }) {
            
        }.disposed(by: disposeBag)
        
        
        
        
        
        
//        (onNext: {
//            self.weather = Weather(json: jsonRequest as AnyObject)
//        }, onError: { (error) in
//            print(error)
//        }, onCompleted: {
//
//        }) {
//
//        }.disposed(by: disposeBag)
        
        
      
    }
    
    
}
