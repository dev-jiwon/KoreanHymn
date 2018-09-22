//
//  MusicInfoModel.swift
//  KoreanHymn
//
//  Created by Na jiwon on 2018. 9. 22..
//  Copyright © 2018년 Na jiwon. All rights reserved.
//

import Foundation
import RealmSwift

class MusicInfoModel: Object {
    @objc dynamic var itemIndex : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var typeOfMusic1: String = ""
    @objc dynamic var typeOfMusic2: String = ""
    @objc dynamic var songwriter: String = ""
    @objc dynamic var lyrics: String = ""
    @objc dynamic var mp3UrlNum: String = ""
    @objc dynamic var pianoScore1: String = ""
    @objc dynamic var pianoScore2: String = ""
    
    
}

public func addItem(itemIndex: String, title: String, typeOfMusic1: String, typeOfMusic2: String, songwriter: String, lyrics: String, mp3UrlNum: String, pianoScore1: String, pianoScore2: String) {
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


