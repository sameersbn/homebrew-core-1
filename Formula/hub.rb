class Hub < Formula
  desc "Add GitHub support to git on the command-line"
  homepage "https://hub.github.com/"
  url "https://github.com/github/hub/archive/v2.8.4.tar.gz"
  sha256 "0aa1342ac5701dc9b7e787ad69640ede06fc84cbe88fb63440b81aca4d4b6273"
  head "https://github.com/github/hub.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7efd9e739cb8706d68d15040333813b9240a0b667135d5f11adc7ac4528c112c" => :mojave
    sha256 "1eff062950b6c79267bb857cffa5220ead3aef8fd6bbe5bb676d752d61ebda7b" => :high_sierra
    sha256 "3fc73ef3c073fbbc43c59552799abc87c81a65594a6ee922f2078581432b2b34" => :sierra
    sha256 "af0d86a139c9361aa2f30c55f832d66e7f1a0a30ee930855f0b722b79cd749a3" => :x86_64_linux
  end

  depends_on "go" => :build
  unless OS.mac?
    depends_on "util-linux" => :build # for col
    depends_on "groff" => :build
    depends_on "ruby" => :build
  end

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/github/hub").install buildpath.children
    cd "src/github.com/github/hub" do
      system "make", "install", "prefix=#{prefix}"

      prefix.install_metafiles

      bash_completion.install "etc/hub.bash_completion.sh"
      zsh_completion.install "etc/hub.zsh_completion" => "_hub"
      fish_completion.install "etc/hub.fish_completion" => "hub.fish"
    end
  end

  test do
    system "git", "init"

    # Test environment has no git configuration, which prevents commiting
    system "git", "config", "user.email", "you@example.com"
    system "git", "config", "user.name", "Your Name"

    %w[haunted house].each { |f| touch testpath/f }
    system "git", "add", "haunted", "house"
    system "git", "commit", "-a", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("#{bin}/hub ls-files").strip
  end
end
