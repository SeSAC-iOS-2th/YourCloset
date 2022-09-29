//
//  StoreItemViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import UIKit
import SnapKit
import Toast
import DropDown

enum ItemToBuyTextFieldData: Int {
    case categoryTextField = 0
    case nameTextField
    case brandTextField
    case sizeTextField
}

struct ItemToBuyInfo {
    var category: String?
    var name: String?
    var brand: String?
    var size: String?
}

class StoreItemToBuyViewController: BaseViewController {
    
    let dropDown = DropDown()
    
    let itemRepo = ItemRepository()
    
    lazy var itemToBuyInfo = ItemToBuyInfo()
    
    lazy var itemInfoArray: [String] = []
    
    let infoNameArray = ["카테고리", "제품명", "브랜드", "사이즈"]
    let infoPlaceholderArray = ["Category", "Name", "Brand", "Size"]
    
    let categoryArray = ["아우터", "상의", "하의", "신발", "악세서리"]
    
    weak var reloadDelegate: reloadTableDelegate?
    
    let storeItemView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "구매 예정 아이템 추가"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var storeButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(storeButtonClicked), for: .touchUpInside)
        return button
    }()
        
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.projectColor(.backgroundColor)
        return tableView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(xButtonClikced), for: .touchUpInside)
        return button
    }()
    
    @objc func xButtonClikced() {
        self.dismiss(animated: true)
    }
    
    @objc func storeButtonClicked() {
        if !isInputEmpty() {
            self.view.makeToast("정보를 모두 입력해주세요.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "옷을 구매 예정 목록에 추가하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
                
                let item = Item(category: self.itemToBuyInfo.category!, name: self.itemToBuyInfo.name!, brand: self.itemToBuyInfo.brand!, size: self.itemToBuyInfo.size!, purchasingStatus: false, checkBoxStatus: false)
                
                self.itemRepo.createItem(item: item)
                self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                
                self.reloadDelegate?.reload()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.dismiss(animated: true)
                })
            })
            let noAction = UIAlertAction(title: "아니오", style: .cancel)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true)
        }
    }
    
    func isInputEmpty() -> Bool {
        if self.itemToBuyInfo.category == nil || self.itemToBuyInfo.category == "" {
            return false
        }
        if self.itemToBuyInfo.name == nil || self.itemToBuyInfo.name == "" {
            return false
        }
        if self.itemToBuyInfo.brand == nil || self.itemToBuyInfo.brand == "" {
            return false
        }
        if self.itemToBuyInfo.size == nil || self.itemToBuyInfo.category == "" {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        hideKeyboardWhenTappedBackground()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(StoreItemTableViewCell1.self, forCellReuseIdentifier: "StoreItemTableViewCell1")
        tableView.register(StoreItemTableViewCell2.self, forCellReuseIdentifier: "StoreItemTableViewCell2")
    }
    
    override func configure() {
        [storeItemView, titleLabel, storeButton, tableView, xButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        storeItemView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.width.equalTo(280)
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(storeItemView).offset(15)
            make.centerX.equalTo(storeItemView)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(storeItemView)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.height.equalTo(180)
        }
        storeButton.snp.makeConstraints { make in
            make.centerX.equalTo(storeItemView)
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.bottom.equalTo(storeItemView).offset(-10)
        }
        xButton.snp.makeConstraints { make in
            make.trailing.equalTo(storeItemView.snp.leading).offset(-10)
            make.bottom.equalTo(storeItemView.snp.top).offset(-10)
            make.height.width.equalTo(20)
        }
    }
}

extension StoreItemToBuyViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemTableViewCell1", for: indexPath) as? StoreItemTableViewCell1 else { return UITableViewCell() }
            
            cell.backgroundColor = UIColor.projectColor(.backgroundColor)
            cell.dropDownView.dropTextField.delegate = self
            cell.selectionStyle = .none
            cell.infoLabel.text = infoNameArray[indexPath.row]
            cell.dropDownView.dropTextField.tag = indexPath.row

            setDropDown(cell.dropDownView, cell.dropDownView.dropTextField, cell.dropDownView.iconImageView)

            cell.dropDownView.selectButton.addTarget(self, action: #selector(dropDownClicked), for: .touchUpInside)
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemTableViewCell2", for: indexPath) as? StoreItemTableViewCell2 else { return UITableViewCell() }
            
            cell.backgroundColor = UIColor.projectColor(.backgroundColor)
            cell.infoTextField.delegate = self
            cell.selectionStyle = .none
            cell.infoLabel.text = infoNameArray[indexPath.row]
            cell.infoTextField.placeholder = infoPlaceholderArray[indexPath.row]
            cell.infoTextField.tag = indexPath.row
            
            return cell
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged(_:)), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        
        switch textField.tag {
        case ItemToBuyTextFieldData.nameTextField.rawValue:
            itemToBuyInfo.name = textField.text
        case ItemToBuyTextFieldData.brandTextField.rawValue:
            itemToBuyInfo.brand = textField.text
        case ItemToBuyTextFieldData.sizeTextField.rawValue:
            itemToBuyInfo.size = textField.text
        default:
            break
        }
    }

    
    func setDropDown(_ dropView: UIView, _ dropTextField: UITextField, _ iconImageView: UIImageView) {
        dropView.backgroundColor = UIColor.lightGray
        dropView.layer.cornerRadius = 8
        
        dropTextField.text = "Category"
        dropTextField.textColor = .black
        
        iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        iconImageView.tintColor = .gray
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.projectColor(.backgroundColor)
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic

        dropDown.dataSource = categoryArray
        dropDown.anchorView = dropView
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        dropDown.selectionAction = {(index, item) in
            dropTextField.text = item
            self.itemToBuyInfo.category = item
            iconImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        }
        
        dropDown.cancelAction = { [] in
            iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    }
    
    @objc func dropDownClicked() {
        dropDown.show()
    }
}
