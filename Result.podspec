Pod::Spec.new do |s|
  s.name             = 'Result'
  s.version          = '1.0'
  s.summary          = 'Result operator'
  s.swift_version    = '4.2'

  s.description      = <<-DESC
Result operator
                       DESC

  s.homepage         = 'https://github.com/Yalantis/Result'
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { 'Anton Vodolazkyi' => 'vodolazky@me.com' }
  s.platform         = :ios, '10.0'
  s.source           = { :git => 'https://github.com/Yalantis/Result.git', :tag => s.version.to_s }
  s.source_files     = 'Result/*.swift'

end