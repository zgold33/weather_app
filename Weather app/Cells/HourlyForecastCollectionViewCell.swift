//
//  HourlyForecastCollectionViewCell.swift
//  Weather app
//
//  Created by Сергей Золотухин on 27.12.2021.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    let hourLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let conditionImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "01d")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCVCell(with model: HourlyWeather) {
        self.hourLabel.text = getHourForDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.conditionImage.image = UIImage(named: model.weather.first!.icon)
        self.temperatureLabel.text = "Temp: \(Int(model.temp))°"
    }
    
    private func getHourForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: inputDate)
    }
   
    func setConstraints() {
        
        self.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(3)
            make.left.equalTo(25)
        }
        
        self.addSubview(conditionImage)
        conditionImage.snp.makeConstraints { make in
            make.top.equalTo(5)
        }
        
        self.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-3)
            make.left.equalTo(15)
        }
    }
}
