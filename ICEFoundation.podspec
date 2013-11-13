Pod::Spec.new do |spec|
  spec.name = 'ICEFoundation'
  spec.version  = '0.0.1'
  spec.summary  = 'Standard toolset classes and categories'
  spec.homepage = 'https://github.com/Intelity/ICEFoundation'
  spec.authors  = { 'Andrew Smith' => 'andrew.smith@intelitycorp.com',
                    'Greg Pardo' => 'greg.pardo@intelitycorp.com'}
  spec.source   = { :git => 'https://github.com/Intelity/ICEFoundation.git', :tag => spec.version.to_s }
  spec.license  = 'COMMERCIAL'
  spec.requires_arc = true

  spec.platform = :ios, '6.0'
  spec.source_files = 'ICEFoundation/*.{h,m}'

  spec.subspec 'UIKit' do |uikit|
    spec.source_files = 'ICEFoundation/UIKit/*.{h,m}'
  end
end
