//
//  MusicDetailViewController.swift
//  KoreanHymn
//
//  Created by Na jiwon on 2018. 9. 22..
//  Copyright © 2018년 Na jiwon. All rights reserved.
//

import UIKit
import RealmSwift

class MusicDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    var isItSpecialList = true
    var itemIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        var musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true)
        if isItSpecialList {
            musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true).filter("isItLike = true")
        }
        let nowMusic = musicData[itemIndex]
        titleLabel.text = nowMusic.title
        lyricsTextView.text = nowMusic.lyrics
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
