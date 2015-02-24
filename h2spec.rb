require 'formula'

HOMEBREW_H2SPEC_VERSION='0.0.7'

class H2spec < Formula
  homepage 'https://github.com/summerwind/h2spec'

  if OS.mac?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2SPEC_VERSION}/h2spec_darwin_amd64.zip"
    sha1 "3dbee4dae69b75760695f3b6487f9c3038ce47e5"
  elsif OS.linux?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2PSEC_VERSION}/h2spec_linux_amd64.zip"
    sha1 "0cb1e787f664eff2013b34627d5ab0003aaadcbf"
  end

  version HOMEBREW_H2SPEC_VERSION
  head 'https://github.com/summerwind/h2spec.git', :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath
      mkdir_p buildpath/'src/github.com/summerwind'
      ln_s buildpath, buildpath/'src/github.com/summerwind/h2spec'
      system 'go', 'get', 'github.com/bradfitz/http2'
      system 'go', 'get', 'github.com/summerwind/h2spec'
      system 'go', 'build', 'cmd/h2spec.go'
    end

    bin.install 'h2spec'
  end
end
