//
//  DogeTableViewCell.swift
//  iOSDogeCoin
//
//  Created by Furkan Ademoğlu on 28.10.2022.
//

import UIKit

struct DogeTableViewCellViewModel{
    let title:String
    let value:String
}

class DogeTableViewCell: UITableViewCell {
    
    private let label:UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let valuelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

   static let identifier = "DogeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(valuelabel)
        contentView.addSubview(label)
    }
    
    required init?(coder:NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        valuelabel.sizeToFit()
        label.frame = CGRect(x: 15, y: 0, width: label.frame.size.width, height: contentView.frame.size.height)
        valuelabel.frame = CGRect(x: contentView.frame.size.width - 15 - valuelabel.frame.size.width, y: 0, width: valuelabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    func configure(with viewmodel:DogeTableViewCellViewModel){
        label.text = viewmodel.title
        valuelabel.text = viewmodel.value
    }
    
    

}
