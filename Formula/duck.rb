class Duck < Formula
  homepage "https://duck.sh/"
  url "https://dist.duck.sh/duck-src-4.6.5.17000.tar.gz"
  sha1 "bd26842b09bf41f86791a7172b93ac88f029b354"
  head "https://svn.cyberduck.io/trunk/"

  bottle do
    cellar :any
    sha1 "1455577527b024dd1ddf28fba3ab11f91458e7e7" => :yosemite
    sha1 "cdbefd6d85244b658515fa639c07f2b05c37c4eb" => :mavericks
    sha1 "d67d55eabd017376079eaed8ded19bc4c28f83d0" => :mountain_lion
  end

  depends_on :java => ["1.7", :build]
  depends_on :xcode => :build
  depends_on "ant" => :build

  def install
    revision = version.to_s.rpartition(".").last
    system "ant", "-Dbuild.compile.target=1.7", "-Drevision=#{revision}", "cli"
    libexec.install Dir["build/duck.bundle/*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    filename = (testpath/"test")
    system "#{bin}/duck", "--download", stable.url, filename
    filename.verify_checksum stable.checksum
  end
end
