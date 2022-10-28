//
//  ViewController.swift
//  iOSDogeCoin
//
//  Created by Furkan Ademoğlu on 28.10.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DogeTableViewCell.self, forCellReuseIdentifier: DogeTableViewCell.identifier)
        return table
    }()
    
    private var viewModels=[DogeTableViewCellViewModel]()
    
    static let formatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    private var data:DogeCoinData?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DogeCoin"
       //setUpTable()
        fetchData()
    }
    
    private func fetchData(){
        APICaller.shared.getDogeCoindata{[weak self]result in
            switch result{
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.setUpViewModels()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpViewModels(){
        guard let model = data else{
            return
        }
      
        viewModels = [
        DogeTableViewCellViewModel(
            title: "Name",
            value: model.name),
        
        DogeTableViewCellViewModel(
            title: "Symbol",
            value: model.symbol),
        
        DogeTableViewCellViewModel(
            title: "Identifier",
            value: String(model.id)),
        
        DogeTableViewCellViewModel(
            title: "Date Added",
            value: model.date_added),
        
        DogeTableViewCellViewModel(
            title: "Total supply",
            value: String(model.total_supply)),]
        setUpTable()
    }
    
    private func setUpTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createTableHeader()
    }
    
    private func createTableHeader(){
        guard let price = data?.quote["USD"]?.price else{
            return
        }
        
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        header.clipsToBounds = true
        let size:CGFloat = view.frame.size.width/4
        //PRİCE LABEL
        let number = NSNumber(value: price)
        let string = Self.formatter.string(from: number)

        let label = UILabel()
        label.text = string
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 42, weight: .medium)
        label.frame = CGRect(x: 10, y: 20 + size, width: view.frame.size.width - 20, height: 120)
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogeTableViewCell.identifier, for: indexPath) as? DogeTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

}

