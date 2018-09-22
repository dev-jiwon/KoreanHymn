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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAllOfItems()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        var musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true)
        if listButton.isEnabled {
            musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true).filter("isItLike = true")
        }
        
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()
        var musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true)
        if listButton.isEnabled {
            musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true).filter("isItLike = true")
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let nowMusic = musicData[indexPath.row]
        cell.titleLabel.text = "\(nowMusic.itemIndex).  \(nowMusic.title)"
        cell.isItLike = nowMusic.isItLike
        cell.itemIndex = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    @IBAction func someMenuSelected(_ sender: UIButton) {
        listButton.isEnabled = !listButton.isEnabled
        heartButton.isEnabled = !heartButton.isEnabled
        tableView.reloadData()
    }
    
}


//json의 모든 데이터를 Realm에 저장
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
                            addItem(itemIndex: Int(item["itemIndex"] ?? "0") ?? 0,
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
}
