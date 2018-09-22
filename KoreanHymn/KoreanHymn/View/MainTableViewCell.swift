//
//  MainTableViewCell.swift
//  KoreanHymn
//
//  Created by Na jiwon on 2018. 9. 22..
//  Copyright © 2018년 Na jiwon. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var isItLike = false{
        didSet{
            if isItLike {
                likeButton.setImage(UIImage(named: "heart_selected"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
    var itemIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func playOrPauseButtonTouched(_ sender: UIButton) {
        print("play")
        
    }
    @IBAction func likeButtonTouched(_ sender: UIButton) {
        let realm = try! Realm()
        let musicData = realm.objects(MusicInfoModel.self).sorted(byKeyPath: "itemIndex", ascending: true)
        
        let nowData = musicData[itemIndex]
        try! realm.write {
            nowData.isItLike = !nowData.isItLike
            isItLike = nowData.isItLike
        }
    }
}
