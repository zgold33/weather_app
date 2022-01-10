//
//  tenDaysForecastCellTableViewCell.swift
//  Weather app
//
//  Created by Сергей Золотухин on 27.12.2021.
//

import UIKit
import SnapKit

class tenDaysForecastCellTableViewCell: UITableViewCell {
    
    var dayNameLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Monday"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "min.t : -20 C"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "max.t : +20 C"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: DayWeather) {
        self.dayNameLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))
        self.weatherConditionLabel.text = model.weather.first!.main
        self.conditionImage.image = UIImage(named: model.weather.first!.icon)
        self.minTemperatureLabel.text = "min: \(Int(model.temp.min))°"
        self.maxTemperatureLabel.text = "max: \(Int(model.temp.max))°"
    }
    
    private func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: inputDate)
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor(red: 107/255, green: 177/255, blue: 218/255, alpha: 1)
        self.selectionStyle = .none
        
        self.addSubview(dayNameLabel)
        self.addSubview(weatherConditionLabel)
        self.addSubview(conditionImage)
        self.addSubview(minTemperatureLabel)
        self.addSubview(maxTemperatureLabel)
    }
    
    private func setConstraints() {
        
        dayNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(5)
            make.left.equalTo(10)
            make.width.equalTo(100)
        }
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(5)
            make.left.equalTo(dayNameLabel.snp.right).offset(10)
        }
        
        conditionImage.snp.makeConstraints { make in
            make.top.bottom.equalTo(5)
            make.left.equalTo(dayNameLabel.snp.right).offset(40)
        }
        
        minTemperatureLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(5)
            make.left.equalTo(conditionImage.snp.right).offset(1)
        }
        
        maxTemperatureLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(5)
            make.left.equalTo(minTemperatureLabel.snp.right).offset(1)
        }
        
    }
    
}
