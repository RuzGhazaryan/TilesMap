//
//  TilesetsVC.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import UIKit
import DataSource

class TilesetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyInfoLabel: UILabel!
    
    private var viewModel: TilesetsViewModel!
    private var dataSource: TableViewDataSource<TilesetTVCell, Tile>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TilesetsViewModel()
        self.viewModel.bind = { [weak self] success in
            if success {
                self?.updateDataSource()
            }  else {
                self?.showFailureMessage()
            }
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.emptyInfoLabel.isHidden = success
            }
        }
    }
    
    private func updateDataSource(){
        self.dataSource = TableViewDataSource(cellIdentifier: TilesetTVCell.cellId, items: self.viewModel.farmData.tilesets ?? [], configureCell: { (cell, tileset) in
            cell.fill(tileName: tileset.name, thumbnail: tileset.thumbnail)
        })
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }
    
    private func showFailureMessage() {
        let alert = UIAlertController(title: "¯\\_(ツ)_/¯", message: "Something went wrong!\n Plaese, try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension TilesetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tile = viewModel.farmData.tilesets?[indexPath.row]
        let vc = MapViewController(farm: viewModel.farmData, tilePath: tile?.path)
        vc.title = tile?.name
        self.navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
