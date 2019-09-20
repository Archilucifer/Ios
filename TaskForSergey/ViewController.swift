//
//  ViewController.swift
//  searchBar
//
//  Created by Alina on 20/09/2019.
//  Copyright © 2019 Alina. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let label1 = UILabel()
    let label2 = UILabel(frame: CGRect(x:0,y:0,width: 202,height: 27))
    
    let url = "http://195.201.225.252/projects/test_ios/test.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    @objc func handleShowSearchBar(){
        search(show: true)
        searchBar.becomeFirstResponder()
    }
    
    func configUI(){
        view.backgroundColor = .white
        
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        
        label2.center = CGPoint(x: 210,y: 350)
        label2.textAlignment = .center
        
        self.view.addSubview(label2)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .blue
        showSearchBar(show: true)
    }
    
    func showSearchBar(show:Bool){
        if show{
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        }else {
            navigationItem.leftBarButtonItem = nil
            searchBar.text = nil
            label2.text = nil	
        }
    }
    
    func search(show : Bool){
        showSearchBar(show: !show)
        if searchBar.text != ""{
            let searchBarText = searchBar.text!
            makeGetRequest(searchBarText: searchBarText)
            label1.text = searchBarText
            navigationItem.titleView = show ? searchBar : label1
        }else{
            navigationItem.titleView = show ? searchBar : nil
        }
    }
    
    func makeGetRequest(searchBarText: String){
        
        let params = [
            "AccessKey":"test_05fc5ed1-0199-4259-92a0-2cd58214b29",
            "IDCategory":"null",
            "IDClient":"null",
            "pageNumberIncome":"1",
            "pageSizeIncome":"12",
            "SearchString":searchBarText
        ]
        
        request(url, method: .get, parameters: params).responseJSON{
            (response) in
            switch response.result{
            case.success(_):
                if let json = response.result.value as? [String:Any]{
                    self.printDataFromRequest(data: json)
                }
            case .failure(_):
                break
            }
        }
    }
    
    func printDataFromRequest(data: [String:Any]){
        if let req = data["goods_in_stock"]{
            label2.text = "\(req)"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        search(show: false)
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(show: false)
    }
    
}
