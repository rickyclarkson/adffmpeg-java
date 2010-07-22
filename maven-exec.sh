#!/bin/sh

#Initialise script variables
cc="gcc"
configure_opts=""
extra_libs=""
jni_platform=""
linker_opts=""
output_filename=""

#Determine OS platform and set variables accordingly
os=`uname -s`
arch=`uname -p`
case $os in
    'Darwin')
        configure_opts="--disable-debug --disable-encoders --disable-decoders  --enable-encoder=mpeg4 --enable-encoder=mpeg2video --enable-decoder=mpeg4 --enable-decoder=h264 --enable-decoder=mjpeg --disable-parsers --disable-ffmpeg --disable-ffserver --disable-ffplay --disable-network --disable-ipv6 --disable-zlib --disable-vhook --enable-static --enable-shared --enable-pthreads --extra-cflags=-isysroot --extra-cflags=/Developer/SDKs/MacOSX10.4u.sdk --extra-cflags=-mmacosx-version-min=10.3.9 --extra-ldflags=-isysroot --extra-ldflags=/Developer/SDKs/MacOSX10.4u.sdk --extra-ldflags=-mmacosx-version-min=10.3.9"
        linker_opts="-Wl,-dynamic -dynamiclib"
        output_filename="libadffmpeg.jnilib"
        ;;
    'Linux')
        extra_libs="-lz"
        jni_platform="linux"
        linker_opts="-shared"
        output_filename="libadffmpeg.so"
        ;;
    'SunOS')
	if [ $arch = "i386" ]; then
        	cc="/usr/sfw/bin/gcc"
        	configure_opts="--cc=/usr/sfw/bin/gcc --extra-cflags=-fPIC --extra-ldflags=-fPIC"
 	fi	
        extra_libs="-lm -lz -R/usr/local/lib"
        jni_platform="solaris"
        linker_opts="-mimpure-text -shared -fPIC"
        output_filename="libadffmpeg.so"
        ;;
    *)
        configure_opts="--enable-memalign-hack --extra-cflags=-D__NO_ISOCEXT"
        extra_libs="-lws2_32"
        jni_platform="win32"
        linker_opts="-Wl,--add-stdcall-alias -shared"
        output_filename="adffmpeg.dll"
        ;;
esac

mkdir -p gensrc/native
mkdir -p gensrc/java/uk/org/netvu/adffmpeg/

case $1 in
    'clean')
        #Clean ADFFMPEG
        cd src/main/adffmpeg
        make clean
        cd ../../..
        
        #Clean SWIG generated source
        rm -f gensrc/native/*.c
        rm -f gensrc/java/uk/org/netvu/adffmpeg/*.java
        ;;
    'generate-sources')
        #Run SWIG
        swig -java -Isrc/main/adffmpeg/libavformat -Isrc/main/adffmpeg/libavcodec -Isrc/main/adffmpeg/libavutil -module ADFFMPEG -package uk.org.netvu.adffmpeg -o gensrc/native/adffmpeg.c -outdir gensrc/java/uk/org/netvu/adffmpeg src/main/swig/adffmpeg.i
        ;;
    'compile')
        #Compile ADFFMPEG static libraries
        case $os in
        'Darwin')
            #
            # Build for Intel
            #
            cd src/main/adffmpeg
	        ./configure $configure_opts --arch=i386
            make clean
	        make
	        cd ../../..
	        #Create output folder for JNI library
	        mkdir -p target/classes/META-INF/lib/i386
	        #Compile JNI code
            gcc -c -O3 -arch i386 -mmacosx-version-min=10.3.9 -Isrc/main/adffmpeg/libavformat -Isrc/main/adffmpeg/libavcodec -Isrc/main/adffmpeg/libavutil -I"$JAVA_HOME"/include -I"$JAVA_HOME"/include/$jni_platform -o target/adffmpeg.o gensrc/native/adffmpeg.c
	        #Build JNI library
            ld -dylib -read_only_relocs suppress -single_module -arch i386 -o target/classes/META-INF/lib/i386/$output_filename target/adffmpeg.o src/main/adffmpeg/libavformat/libavformat.a src/main/adffmpeg/libavcodec/libavcodec.a src/main/adffmpeg/libavutil/libavutil.a -lSystem -lz -L/usr/lib/gcc/i686-apple-darwin9/4.0.1 -lgcc
            #
            # Build for PowerPC
            #
            cd src/main/adffmpeg
	        ./configure $configure_opts --arch=ppc --extra-cflags='-arch ppc' --extra-ldflags='-arch ppc' --cross-compile
	        make clean
            make
	        cd ../../..
	        #Create output folder for JNI library
	        mkdir -p target/classes/META-INF/lib/ppc
	        #Compile JNI code
            gcc -c -O3 -arch ppc -force_cpusubtype_ALL -mmacosx-version-min=10.3.9 -Isrc/main/adffmpeg/libavformat -Isrc/main/adffmpeg/libavcodec -Isrc/main/adffmpeg/libavutil -I"$JAVA_HOME"/include -I"$JAVA_HOME"/include/$jni_platform -o target/adffmpeg.o gensrc/native/adffmpeg.c
	        #Build JNI library
            ld -dylib -read_only_relocs suppress -single_module -arch ppc -o target/classes/META-INF/lib/ppc/$output_filename target/adffmpeg.o src/main/adffmpeg/libavformat/libavformat.a src/main/adffmpeg/libavcodec/libavcodec.a src/main/adffmpeg/libavutil/libavutil.a -lSystem -lz -L/usr/lib/gcc/powerpc-apple-darwin9/4.0.1 -lgcc -lSystemStubs /usr/lib/dylib1.o
            #
            # Create universal binary
            #
            lipo -create -output target/classes/META-INF/lib/$output_filename target/classes/META-INF/lib/i386/$output_filename target/classes/META-INF/lib/ppc/$output_filename
            rm -rf target/classes/META-INF/lib/i386
            rm -rf target/classes/META-INF/lib/ppc
	        ;;
        *)
            cd src/main/adffmpeg
	        ./configure $configure_opts --disable-debug --disable-encoders --disable-decoders --enable-encoder=mpeg2video --enable-encoder=mpeg4 --enable-decoder=mpeg4 --enable-decoder=h264 --enable-decoder=mjpeg --disable-parsers --disable-ffmpeg --disable-ffserver --disable-ffplay
	        make
	        cd ../../..
	        #Create output folder for JNI library
	        mkdir -p target/classes/META-INF/lib
	        #Compile JNI code
	        $cc -Isrc/main/adffmpeg/libavformat -Isrc/main/adffmpeg/libavcodec -Isrc/main/adffmpeg/libavutil -I"$JAVA_HOME"/include -I"$JAVA_HOME"/include/$jni_platform -O3 -Wall -fmessage-length=0 -fno-strict-aliasing -D_REENTRANT -D_GNU_SOURCE -c gensrc/native/adffmpeg.c -o target/adffmpeg.o
	        #Build JNI library
	        $cc -Lsrc/main/adffmpeg/libavformat -Lsrc/main/adffmpeg/libavcodec -Lsrc/main/adffmpeg/libavutil $linker_opts -fno-strict-aliasing -o target/classes/META-INF/lib/$output_filename target/adffmpeg.o -lavformat -lavcodec -lavutil $extra_libs
	        ;;
        esac
        ;;
esac

