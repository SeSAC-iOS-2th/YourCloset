//
//  StoreItemToBuyViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/18.
//

import Foundation
import SnapKit
import UIKit
import Toast
import DropDown

enum ItemToBuyTextFieldData: Int {
    case categoryTextField = 0
    case nameTextField
    case brandTextField
    case sizeTextField
}

struct ItemToBuyInfo {
    var category = ""
    var name = ""
    var brand = ""
    var size = ""
    
//    init(category: String, name: String, brand: String, size: String) {
//        self.category = category
//        self.name = name
//        self.brand = brand
//        self.size = size
//    }
}

class StoreItemToBuyViewController: BaseViewController {
    
    let dropDown = DropDown()
    
    let itemRepo = ItemRepository()
    
    lazy var itemToBuyInfo = ItemToBuyInfo()
    
    lazy var itemInfoArray: [String] = []
    
    let infoNameArray = ["카테고리", "제품명", "브랜드", "사이즈"]
    let infoPlaceholderArray = ["Category", "Name", "Brand", "Size"]
    
    let categoryArray = ["아우터", "상의", "하의", "신발", "악세서리"]
    
    lazy var leftBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClikced))
        barButton.tintColor = .black
        return barButton
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(storeButtonClicked))
        barButton.tintColor = .black
        return barButton
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    @objc func backButtonClikced() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func storeButtonClicked() {
        let alert = UIAlertController(title: nil, message: "옷을 구매 예정 목록에 추가하시겠습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
            
            print(self.itemToBuyInfo.category, self.itemToBuyInfo.name, self.itemToBuyInfo.brand, self.itemToBuyInfo.size)
            
            let item = Item(category: self.itemToBuyInfo.category, name: self.itemToBuyInfo.name, brand: self.itemToBuyInfo.brand, size: self.itemToBuyInfo.size, purchasingStatus: false, checkBoxStatus: false)
            
            self.itemRepo.createItem(item: item)
            self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            self.navigationController?.popViewController(animated: true)
            
        })
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        navigationItem.title = "구매 예정 아이템 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoreItemTableViewCell1.self, forCellReuseIdentifier: "StoreItemTableViewCell1")
        tableView.register(StoreItemTableViewCell2.self, forCellReuseIdentifier: "StoreItemTableViewCell2")

    }
    
    override func configure() {
        [tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalToSuperview()
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
            
            cell.dropDownView.dropTextField.delegate = self
            
            cell.selectionStyle = .none
            cell.infoLabel.text = infoNameArray[indexPath.row]
            cell.dropDownView.dropTextField.tag = indexPath.row

            setDropDown(cell.dropDownView, cell.dropDownView.dropTextField, cell.dropDownView.iconImageView)

            cell.dropDownView.selectButton.addTarget(self, action: #selector(dropDownClicked), for: .touchUpInside)
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemTableViewCell2", for: indexPath) as? StoreItemTableViewCell2 else { return UITableViewCell() }
            
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
        case ItemToBuyTextFieldData.categoryTextField.rawValue:
            itemToBuyInfo.category = textField.text ?? "없음"
        case ItemToBuyTextFieldData.nameTextField.rawValue:
            itemToBuyInfo.name = textField.text ?? "없음"
        case ItemToBuyTextFieldData.brandTextField.rawValue:
            itemToBuyInfo.brand = textField.text ?? "없음"
        case ItemToBuyTextFieldData.sizeTextField.rawValue:
            itemToBuyInfo.size = textField.text ?? "없음"
        default:
            break
        }
    }

    
    func setDropDown(_ dropView: UIView, _ dropTextField: UITextField, _ iconImageView: UIImageView) {
        dropView.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        dropView.layer.cornerRadius = 8
        
        dropTextField.text = "Category"
        dropTextField.textColor = .black
        
        iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        iconImageView.tintColor = .gray
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.blue
        DropDown.appearance().backgroundColor = UIColor.white
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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

