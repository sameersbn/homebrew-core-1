class Scamper < Formula
  desc "Advanced traceroute and network measurement utility"
  homepage "https://www.caida.org/tools/measurement/scamper/"
  url "https://www.caida.org/tools/measurement/scamper/code/scamper-cvs-20180504.tar.gz"
  sha256 "f8e192a12439ccba712870a47fb0a239715f2c43a98df3d1ae6761fa688fe189"

  bottle do
    cellar :any
    sha256 "8eebcd5d3451744d3020a8925c49988271e8c96f1ade51692362eb0f401fccc7" => :high_sierra
    sha256 "5c0144da8cbe504095f8613d64134dabb97a1a1478ba1104519ab9f77c0fa725" => :sierra
    sha256 "49389540e24b1bb0a606569a1c3cda007cc86e7a1abda920089a326f35ce5d0f" => :el_capitan
    sha256 "e5ee0f6a175ca5e9a99b5ac40cd879a1dbca4b3e66c5672ea829df719c6dbe1c" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
