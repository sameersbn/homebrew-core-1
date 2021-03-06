class Goreleaser < Formula
  desc "Deliver Go binaries as fast and easily as possible"
  homepage "https://goreleaser.com/"
  url "https://github.com/goreleaser/goreleaser/archive/v0.99.0.tar.gz"
  sha256 "4df888185cc1090b2c2421481554d9d32521a684c7239a058167e66d75029705"

  bottle do
    cellar :any_skip_relocation
    sha256 "a207727a45c8c11a8699e286a8fa8c09053f3ce233cad65b368e84b0957efe0e" => :mojave
    sha256 "11c8a13e3484d117ee47f06fb15056296b81702a2802eb66312a19b5a82f1765" => :high_sierra
    sha256 "04141a75c6fd616b016deea86a53c35def257ec0208fcc3cd1968a1b16a9b946" => :sierra
    sha256 "bf3c88998b1174194d0b5837d99a2079ad48a415730fcf7106c9c56f2af22b6a" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    (buildpath/"src/github.com/goreleaser/goreleaser").install buildpath.children
    cd "src/github.com/goreleaser/goreleaser" do
      system "go", "build", "-ldflags", "-X main.version=#{version}",
                   "-o", bin/"goreleaser"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goreleaser -v 2>&1")
    assert_match "config created", shell_output("#{bin}/goreleaser init 2>&1")
    assert_predicate testpath/".goreleaser.yml", :exist?
  end
end
