require 'formula'

HOMEBREW_H2SPEC_VERSION='0.0.3'

class H2spec < Formula
  homepage 'https://github.com/summerwind/h2spec'

  if OS.mac?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2SPEC_VERSION}/h2spec_darwin_amd64.zip"
    sha1 "e59922fb0f93b70a4e2ca3fbf713d8fc08960822"
  elsif OS.linux?
    url "https://github.com/summerwind/h2spec/releases/download/v#{HOMEBREW_H2PSEC_VERSION}/h2spec_linux_amd64.zip"
    sha1 "3c7e8363d5ad97d5e49c2a01197a8c3be4cb9aa6"
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
