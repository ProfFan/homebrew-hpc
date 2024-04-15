# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gklib < Formula
  desc "A library of various helper routines and frameworks used by many of the lab's software"
  homepage ""
  url "https://github.com/KarypisLab/GKlib/archive/refs/tags/METIS-v5.1.1-DistDGL-0.5.tar.gz"
  sha256 "52aa0d383d42360f4faa0ae9537ba2ca348eeab4db5f2dfd6343192d0ff4b833"
  license "NOASSERTION"

  depends_on "cmake" => :build

  def install
    system "make config prefix=#{prefix}"
    system "make"
    system "make install"
  end

  test do
    system "true"
  end
end
