require 'formula'

HOMEBREW_H2SPEC_VERSION='0.0.8'

class H2spec < Formula
  homepage 'https://github.com/summerwind/h2spec'

  if OS.mac?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2SPEC_VERSION}/h2spec_darwin_amd64.zip"
    sha1 "914ada1d9a02d12e12573259cfcad793845b28a5"
  elsif OS.linux?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2PSEC_VERSION}/h2spec_linux_amd64.zip"
    sha1 "a3320e03ffe4b607deb55c4660fed6564ee74d05"
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
