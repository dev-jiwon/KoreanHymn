//
//  ViewController.swift
//  KoreanHymn
//
//  Created by Na jiwon on 2018. 9. 22..
//  Copyright © 2018년 Na jiwon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Realm
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAllOfItems()
        
        
    }


}

extension ViewController {
    func addAllOfItems() {
        let realm = try! Realm()
        let itemData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true)
        if itemData.isEmpty {
            if let path = Bundle.main.path(forResource: "musicList", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [Dictionary<String, String>] {
                        for item in jsonResult{
                            addItem(itemIndex: item["itemIndex"] ?? "",
                                    title: item["title"] ?? "",
                                    typeOfMusic1: item["typeOfMusic1"] ?? "",
                                    typeOfMusic2: item["typeOfMusic2"] ?? "",
                                    songwriter: item["songwriter"] ?? "",
                                    lyrics: item["lyrics"] ?? "",
                                    mp3UrlNum: item["mp3UrlNum"] ?? "",
                                    pianoScore1: item["pianoScore1"] ?? "",
                                    pianoScore2: item["pianoScore2"] ?? "")
                        }
                    }
                } catch {
                    // handle error
                }
            }
        } else {
            print("데이터가 이미 있습니다")
        }
    }
    
    func addItem(itemIndex: String, title: String, typeOfMusic1: String, typeOfMusic2: String, songwriter: String, lyrics: String, mp3UrlNum: String, pianoScore1: String, pianoScore2: String) {
        let musicInfoModel = MusicInfoModel()
        musicInfoModel.itemIndex = itemIndex
        musicInfoModel.title = title
        musicInfoModel.typeOfMusic1 = typeOfMusic1
        musicInfoModel.typeOfMusic2 = typeOfMusic2
        musicInfoModel.songwriter = songwriter
        musicInfoModel.lyrics = lyrics
        musicInfoModel.mp3UrlNum = mp3UrlNum
        musicInfoModel.pianoScore1 = pianoScore1
        musicInfoModel.pianoScore2 = pianoScore2
        let realm = try! Realm()
        try! realm.write {
            realm.add(musicInfoModel)
        }
        print("success")
    }
}
