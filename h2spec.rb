require 'formula'

HOMEBREW_H2SPEC_VERSION='0.0.4'

class H2spec < Formula
  homepage 'https://github.com/summerwind/h2spec'

  if OS.mac?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2SPEC_VERSION}/h2spec_darwin_amd64.zip"
    sha1 "bbb81e9f6802a29c5bf8e1e57ba1c764d9a71eb0"
  elsif OS.linux?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2PSEC_VERSION}/h2spec_linux_amd64.zip"
    sha1 "6e915537093e3c13576a8f804492ecb3dcaf9a47"
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
