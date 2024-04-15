class Ddd < Formula
  desc "Graphical front-end for command-line debuggers"
  homepage "https://www.gnu.org/s/ddd/"
  url "https://ftp.gnu.org/gnu/ddd/ddd-3.4.0.tar.gz"
  mirror "https://ftpmirror.gnu.org/ddd/ddd-3.4.0.tar.gz"
  sha256 "5d4cbc8a0bb0458543866d679308c53a3ef066e402fe5a1918e19698a3d3580f"
  license all_of: ["GPL-3.0-only", "GFDL-1.1-or-later"]

  depends_on "gdb" => [:test,:optional]
  depends_on "libice"
  depends_on "libsm"
  depends_on "libx11"
  depends_on "libxau"
  depends_on "libxaw"
  depends_on "libxext"
  depends_on "libxp"
  depends_on "libxpm"
  depends_on "libxt"
  depends_on "openmotif"

  def install
    # ioctl is not found without this flag
    # Upstream issue ref: https://savannah.gnu.org/bugs/index.php?64188
    ENV.append_to_cflags "-DHAVE_SYS_IOCTL_H" if OS.mac?

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-builtin-app-defaults",
                          "--enable-builtin-manual",
                          "--prefix=#{prefix}"

    # From MacPorts: make will build the executable "ddd" and the X resource
    # file "Ddd" in the same directory, as HFS+ is case-insensitive by default
    # this will loosely FAIL
    system "make", "EXEEXT=exe"

    ENV.deparallelize
    system "make", "install", "EXEEXT=exe"
    mv bin/"dddexe", bin/"ddd"
  end

  test do
    output = shell_output("#{bin}/ddd --version")
    output.force_encoding("ASCII-8BIT") if output.respond_to?(:force_encoding)
    assert_match version.to_s, output
    assert_match testpath.to_s, pipe_output("#{bin}/ddd --gdb --nw true 2>&1", "pwd\nquit")
  end
end
