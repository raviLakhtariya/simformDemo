//
//  BookCells.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class BookCells: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var btnPurchase: UIButton!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btncollpaseExpands: UIButton!
    
    var onClickPurchase:(()->Void)? = nil
    var onClickOpenExpanded:(()->Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.dropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClickBtnPurchase(_ sender: Any) {
        if(onClickPurchase != nil){
            self.onClickPurchase!()
        }
    }
    @IBAction func onClickBtnExpand(_ sender: Any) {
        if(onClickOpenExpanded != nil){
            self.onClickOpenExpanded!()
        }
    }
    
}
