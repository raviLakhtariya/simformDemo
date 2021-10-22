//
//  HistoryCells.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class HistoryCells: UITableViewCell {

    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
    @IBOutlet weak var lblPurchaseDate: UILabel!
    var onClickDelete:(()->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClickbtnDelete(_ sender: Any) {
        if(onClickDelete != nil){
            self.onClickDelete!()
        }
    }
    
}
