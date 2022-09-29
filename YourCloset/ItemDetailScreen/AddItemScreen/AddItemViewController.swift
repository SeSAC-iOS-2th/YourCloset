//
//  AddItemViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/21.
//

import Foundation
import SnapKit
import UIKit
import DropDown
import RealmSwift
import Toast
import YPImagePicker

enum MyItemTextFieldData: Int {
    case nameTextField = 0
    case brandTextField
    case sizeTextField
    case groupTextField
}

struct MyItemInfo {
    var name: String?
    var brand: String?
    var size: String?
    var group: String?
}

class AddItemViewController: BaseViewController {
    
    let dropDown = DropDown()
        
    let groupRepo = GroupRepository()
    let itemRepo = ItemRepository()
    
    var beforeModifyInfo: [String] = []
    
    var groupByCategory: Results<Group>! {
        didSet {
            if groupByCategory.count != 0 {
                for element in groupByCategory {
                    groupArray.append(element.group)
                }
            }
            tableView.reloadData()
        }
    }
    
    var transitionItem = Item()
    
    lazy var myItemInfo = MyItemInfo()
        
    var groupArray: [String] = []

    var categoryInfo = ""
    
    let infoNameArray = ["이미지", "제품명", "브랜드", "사이즈", "그룹"]
    let infoPlaceholderArray = ["Image", "Name", "Brand", "Size", "Group"]
    
    var pickImage: UIImage?
        
    weak var sendDelegate: SendDataDelegate?
    
    lazy var addItemTopView: AddItemTopView = {
        let addItemTopView = AddItemTopView()
        addItemTopView.nameLabel.text = isAddNotModify() ? "내 아이템 추가" : "내 아이템 수정"
        addItemTopView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        addItemTopView.storeButton.addTarget(self, action: #selector(storeButtonClikced), for: .touchUpInside)
        return addItemTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.projectColor(.backgroundColor)
        return tableView
    }()
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func storeButtonClikced() {
        if !isInputEmpty() {
            self.view.makeToast("정보를 모두 입력해주세요.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            let alertMessage = isAddNotModify() ? "아이템을\n 내 옷장에 추가하시겠습니까?" : "아이템 정보를\n 수정하시겠습니까?"
            let toastMessage = isAddNotModify() ? "추가되었습니다." : "수정되었습니다."
            
            let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
                            
                if self.isAddNotModify() {
                    
                    let item = Item(category: self.categoryInfo, group: self.myItemInfo.group!, imageURL: "", name: self.myItemInfo.name!, brand: self.myItemInfo.brand!, size: self.myItemInfo.size!, purchasingStatus: true)
                    self.itemRepo.createItem(item: item)
                    if self.pickImage != nil {
                        self.saveImageToDocumentDirectory(imageName: "\(item.objectId).png", image: self.pickImage!)
                        print("그냥 id: \(item.objectId)")
                    }
                } else {
                    
                    self.itemRepo.modifyItemInfo(item: self.transitionItem, group: self.myItemInfo.group!, name: self.myItemInfo.name!, brand: self.myItemInfo.brand!, size: self.myItemInfo.size!)
                    if self.pickImage != nil {
                        
                        self.saveImageToDocumentDirectory(imageName: "\(self.transitionItem.objectId).png", image: self.pickImage!)
                        print("바뀐 id: \(self.transitionItem.objectId)")
                        
                    } else {
                        
                        self.deleteImageFromDocumentDirectory(imageName: "\(self.transitionItem.objectId).png")
                        print("갤러리 이미지 -> 디폴트 이미지, 갤러리 이미지 도큐먼트에서 삭제 완료")
                        
                    }
                    
                    self.sendDelegate?.sendModifyData(name: self.myItemInfo.name!, brand: self.myItemInfo.brand!, size: self.myItemInfo.size!, image: self.pickImage ?? UIImage())
                    
                    self.sendDelegate?.reload()
                }
                self.groupRepo.plusCount(self.groupRepo.fetchSpecificGroup(self.categoryInfo, self.myItemInfo.group!))
                self.view.makeToast(toastMessage, duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                self.presentingViewController?.dismiss(animated: true)
            })
            let noAction = UIAlertAction(title: "아니오", style: .cancel)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true)

        }
    }
    
    func isInputEmpty() -> Bool {
        if self.myItemInfo.group == nil || self.myItemInfo.group == "" {
            return false
        }
        if self.myItemInfo.name == nil || self.myItemInfo.name == "" {
            return false
        }
        if self.myItemInfo.brand == nil || self.myItemInfo.brand == "" {
            return false
        }
        if self.myItemInfo.size == nil || self.myItemInfo.size == "" {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedBackground()
        
        groupByCategory = groupRepo.fetchByCategory(categoryInfo)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddItemTableViewCell1.self, forCellReuseIdentifier: "AddItemTableViewCell1")
        tableView.register(AddItemTableViewCell2.self, forCellReuseIdentifier: "AddItemTableViewCell2")
        tableView.register(AddItemTableViewCell3.self, forCellReuseIdentifier: "AddItemTableViewCell3")
            
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        
        if !isAddNotModify() { initMyItemInfo() }
        
    }
    
    func initMyItemInfo() {
        myItemInfo.group = transitionItem.group!
        myItemInfo.name = transitionItem.name
        myItemInfo.brand = transitionItem.brand
        myItemInfo.size = transitionItem.size
    }
        
    override func configure() {
        [addItemTopView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        addItemTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalToSuperview().multipliedBy(0.12)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.bottom.equalTo(0)
        }
    }
    
    func isAddNotModify() -> Bool {
        return UserDefaults.standard.string(forKey: "addOrModify") == "add"
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        print("경로: \(documentDirectory)")
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        guard let data = image.pngData() else {
            print("압축이 실패했습니다.")
            return
        }
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제")
            } catch {
                print("이미지를 삭제하지 못함")
            }
        }
        
        do {
            try data.write(to: imageURL)
            print("이미지 저장 완료")
        } catch {
            print("이미지를 저장하지 못함")
        }
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제하지 못함")
            }
        }
    }
    
}

extension AddItemViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoNameArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 300 : 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemTableViewCell1", for: indexPath) as? AddItemTableViewCell1 else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.projectColor(.backgroundColor)
            cell.galaryButton.addTarget(self, action: #selector(galaryButtonClicked(_:)), for: .touchUpInside)
            
            if self.pickImage != nil {
                cell.itemImageView.image = self.pickImage
            } else {
                cell.itemImageView.image = showCategoryImage()
            }
                        
            return cell
            
        } else if indexPath.row == infoNameArray.count - 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemTableViewCell3", for: indexPath) as? AddItemTableViewCell3 else { return UITableViewCell() }
            
            cell.dropDownView.dropTextField.delegate = self
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.projectColor(.backgroundColor)
            cell.infoLabel.text = infoNameArray[indexPath.row]
            cell.dropDownView.dropTextField.tag = indexPath.row - 1
            
            setDropDown(cell.dropDownView, cell.dropDownView.dropTextField, cell.dropDownView.iconImageView)
            
            cell.dropDownView.selectButton.addTarget(self, action: #selector(dropDownClicked), for: .touchUpInside)

            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemTableViewCell2", for: indexPath) as? AddItemTableViewCell2 else { return UITableViewCell() }
            
            cell.infoTextField.delegate = self
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.projectColor(.backgroundColor)
            cell.infoLabel.text = infoNameArray[indexPath.row]
            
            cell.infoTextField.placeholder = infoPlaceholderArray[indexPath.row]
            cell.infoTextField.tag = indexPath.row - 1
            
            if !isAddNotModify() {
                cell.infoTextField.text = beforeModifyInfo[indexPath.row - 1]
            }
            
            return cell
        }
    }
    
    @objc func galaryButtonClicked(_ sender: CameraAndGalaryButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let defaultImageAction = UIAlertAction(title: "디폴트 이미지", style: .default) { _ in
            self.pickImage = nil
            self.tableView.reloadData()
        }
        let galaryImageAction = UIAlertAction(title: "갤러리 및 카메라", style: .default) { _ in
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    print("이미지: \(photo.image)")
                    print("url: \(photo.image.hashValue)")
                    
                    self.pickImage = photo.image
                    self.tableView.reloadData()
                }
                picker.dismiss(animated: true)
            }
            self.present(picker, animated: true)
        }
        
        let noAction = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(defaultImageAction)
        actionSheet.addAction(galaryImageAction)
        actionSheet.addAction(noAction)
        
        self.present(actionSheet, animated: true)
    }
    
    func showCategoryImage() -> UIImage {
        switch categoryInfo {
        case "아우터":
            return UIImage(named: "Jacket")!
        case "상의":
            return UIImage(named: "T-Shirt")!
        case "하의":
            return UIImage(named: "Pants")!
        case "신발":
            return UIImage(named: "Shoes")!
        case "악세서리":
            return UIImage(named: "Ring")!
        default:
            return UIImage()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged(_:)), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        
        switch textField.tag {
        case MyItemTextFieldData.nameTextField.rawValue:
            myItemInfo.name = textField.text
        case MyItemTextFieldData.brandTextField.rawValue:
            myItemInfo.brand = textField.text
        case MyItemTextFieldData.sizeTextField.rawValue:
            myItemInfo.size = textField.text
        case MyItemTextFieldData.groupTextField.rawValue:
            myItemInfo.group = textField.text
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changeText = currentText.replacingCharacters(in: stringRange, with: string)
        return changeText.count <= 14
    }
        
    func setDropDown(_ dropView: UIView, _ dropTextField: UITextField, _ iconImageView: UIImageView) {
        dropView.backgroundColor = UIColor.lightGray
        dropView.layer.cornerRadius = 8
        
        if !isAddNotModify() {
            dropTextField.text = myItemInfo.group
        } else {
            dropTextField.text = "Group"
        }
        dropTextField.textColor = .black
        
        iconImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        iconImageView.tintColor = .gray
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.projectColor(.backgroundColor)
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic
        dropDown.dataSource = groupArray
        dropDown.anchorView = dropView
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        dropDown.selectionAction = {(index, item) in
            dropTextField.text = item
            self.myItemInfo.group = item
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

