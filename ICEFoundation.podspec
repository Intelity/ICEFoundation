Pod::Spec.new do |spec|
  spec.name = 'ICEFoundation'
  spec.version  = '0.0.2'
  spec.summary  = 'Standard toolset classes and categories'
  spec.homepage = 'https://github.com/Intelity/ICEFoundation'
  spec.authors  = { 'Andrew Smith' => 'andrew.smith@intelitycorp.com',
                    'Greg Pardo' => 'greg.pardo@intelitycorp.com'}
  spec.source   = { :git => 'https://github.com/Intelity/ICEFoundation.git', :tag => "#{spec.version}"}
  spec.license  = 'COMMERCIAL'
  spec.requires_arc = true

  spec.platform = :ios, '6.0'

  spec.subspec 'Core' do |ss|
    ss.source_files = 'ICEFoundation/*.{h,m}'
  end

  spec.subspec 'UIKit' do |ss|
    ss.dependency 'ICEFoundation/Core'
    ss.source_files = 'ICEFoundation/UIKit/*.{h,m}'
  end
end
