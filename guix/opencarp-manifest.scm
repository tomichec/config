;; What follows is a "manifest" equivalent to the command line you gave.
;; You can store it in a file that you may then pass to any 'guix' command
;; that accepts a '--manifest' (or '-m') option.

(specifications->manifest
  (list "petsc-openmpi"
        "openmpi"
        "binutils"
        "gcc-toolchain"
        "pkg-config"
        "fftw"
        "cmake"
        "gengetopt"
        "git"
        "make"
        "python"
        "perl"
        "zlib"))
