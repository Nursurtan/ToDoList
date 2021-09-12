//
//  ViewViewController.swift
//  ToDoList
//
//  Created by нурсултан арапов on 9/10/21.
//


import RealmSwift
import UIKit

class ViewViewController: UIViewController {
    
    public var item: ToDoListItem?
    public var deletionHander: (()->Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    
    private let realm = try! Realm()
    static let dateFormatter:  DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return DateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete(){
        guard let myItem = self.item else {
            return
        }
        
        realm.begin()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHander?()
        navigationController?.popToRootViewController(animated: true)
       
        
    }

    
}
