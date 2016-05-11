Pod::Spec.new do |s|

  s.name         = 'BRLocalize'
  s.version      = '0.11.0'
  s.summary      = 'Simple localization toolkit for UIKit.'

  s.description        = <<-DESC
                         BRLocalize provides a basic localization framework for application-wide
                         localized strings stored in a hierarchical JSON file format.
                         DESC

  s.homepage           = 'https://github.com/Blue-Rocket/BRLocalizable'
  s.license            = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author             = { 'Shawn McKee' => 'shawn@bluerocket.us', 'Matt Magoffin' => 'matt@bluerocket.us' }
  s.social_media_url   = 'http://twitter.com/bluerocketinc'
  s.platform           = :ios, '7.1'
  s.source             = { :git => 'https://github.com/Blue-Rocket/BRLocalizable.git',
                           :tag => s.version.to_s }
  
  s.requires_arc       = true

  s.default_subspecs = 'All'
  
  s.subspec 'All' do |sp|
    sp.source_files = 'BRLocalize/Code/BRLocalize.h'
    sp.dependency 'BRLocalize/Core'
	sp.dependency 'BRLocalize/UI'
  end
  
  s.subspec 'Core' do |sp|
    sp.source_files = 'BRLocalize/Code/Core.h', 'BRLocalize/Code/Core'
  end
  
  s.subspec 'UI' do |sp|
    sp.source_files = 'BRLocalize/Code/UI.h', 'BRLocalize/Code/UI'
    sp.dependency 'BRLocalize/Core'
  end

end
