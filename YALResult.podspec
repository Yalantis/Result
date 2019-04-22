Pod::Spec.new do |s|
  s.name             = 'YALResult'
  s.version          = '1.4'
  s.summary          = 'Result type '
  s.swift_version    = '5.0'
  s.description      = 'Result type'
  s.homepage         = 'https://github.com/Yalantis/Result'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Anton Vodolazkyi' => 'vodolazky@me.com' }
  s.platform         = :ios, '9.0'
  s.source           = { git: 'https://github.com/Yalantis/Result.git', tag: s.version.to_s }
  s.source_files     = 'Result/*.swift'
end
