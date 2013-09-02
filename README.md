filmulator
==========

A film emulator with all of the positives and none of the negatives

# Building Filmulator

This program depends on:
libtiff
libexiv2
libjpeg
libgomp
libraw

Some libraw packagers do not include the GPL demosaic packs, so we highly
encourage you to compile and install it yourself with the GPLv3 flag enabled.

Filmulator by default tries to use AMAZE, but if libraw is compiled without
it it will fall back to AHD demosaicing.

To build and install filmulator, run

`make` (-j[number of cores your processor has])
`make installconf`
`make install` (requires sudo)

# Running Filmulator

For general purpose batch raw conversion, `cd` to a directory containing your raw files, and run `batch-filmulator .DNG` with `.DNG` replaced by whatever the file extension of your raw files.

Filmulator will create 16-bit TIFF files with -output.tif appended to the filenames of all of the raw files in the current directory.

Process these in whatever photo editing program you like.
