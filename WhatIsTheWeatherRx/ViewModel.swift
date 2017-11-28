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
            .map { text in
                return URLSession.shared.rx.json(url: self.getURLForString(text)!)
            }
            .switchLatest()
        
        jsonRequest.subscribe({ (json) in
            self.weather = Weather(json: json as AnyObject)
        }).disposed(by: disposeBag)
    }
    
    
}
