
class $NAME < Formula
  homepage "$PAGE"
  head "$HEAD", :using => :git
  
  depends_on "cmake" => :build
  depends_on "llvm"  => :build
  
  def install
    # Use brewed clang
    ENV['CC'] = Formula['llvm'].opt_prefix/"bin/clang"
    ENV['CXX'] = Formula['llvm'].opt_prefix/"bin/clang++"
    
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
    
  end
end
