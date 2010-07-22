%{
#include <avformat.h>
%}

/* ###### SWIG TYPEMAPS ###### */
%typemap(memberin) uint8_t *extradata
%{
    $1 = (*jenv)->GetDirectBufferAddress(jenv, jarg2);
%}
%typemap(jtype) uint8_t *extradata "java.nio.ByteBuffer"
%typemap(jstype) uint8_t *extradata "java.nio.ByteBuffer"
%typemap(javain) uint8_t *extradata "$javainput"
%typemap(out) uint8_t *extradata
%{
    $result = (*jenv)->NewDirectByteBuffer(jenv, $1, arg1->extradata_size);
%}
%typemap(javaout) uint8_t *extradata {
    return $jnicall;
}

%typemap(memberin) uint8_t *data
%{
    $1 = (*jenv)->GetDirectBufferAddress(jenv, $input);
%}
%typemap(jtype) uint8_t *data "java.nio.ByteBuffer"
%typemap(jstype) uint8_t *data "java.nio.ByteBuffer"
%typemap(javain) uint8_t *data "$javainput"
%typemap(out) uint8_t *data
%{
    $result = (*jenv)->NewDirectByteBuffer(jenv, $1, arg1->size);
%}
%typemap(javaout) uint8_t *data {
    return $jnicall;
}

%typemap(in) (uint8_t *buf, int buf_size)
%{
    jobject byteBuffer = $input;
    jclass byteBufferClass = (*jenv)->GetObjectClass(jenv, byteBuffer);
    jmethodID remaining = (*jenv)->GetMethodID(jenv, byteBufferClass, "remaining", "()I");
    
    $1 = (*jenv)->GetDirectBufferAddress(jenv, byteBuffer);
    $2 = (*jenv)->CallIntMethod(jenv, byteBuffer, remaining);
%}
%typemap(jni) (uint8_t *buf, int buf_size) "jobject"
%typemap(jtype) (uint8_t *buf, int buf_size) "java.nio.ByteBuffer"
%typemap(jstype) (uint8_t *buf, int buf_size) "java.nio.ByteBuffer"
%typemap(javain) (uint8_t *buf, int buf_size) "$javainput"

%typemap(in) int *got_picture_ptr
%{
    $1 = (*jenv)->GetDirectBufferAddress(jenv, $input);
%}
%typemap(jni) int *got_picture_ptr "jobject"
%typemap(jtype) int *got_picture_ptr "java.nio.IntBuffer"
%typemap(jstype) int *got_picture_ptr "java.nio.IntBuffer"
%typemap(javain) int *got_picture_ptr "$javainput"

%typemap(in) uint32_t *pixelBuffer
%{
    $1 = (*jenv)->GetDirectBufferAddress(jenv, $input);
%}
%typemap(jni) uint32_t *pixelBuffer "jobject"
%typemap(jtype) uint32_t *pixelBuffer "java.nio.IntBuffer"
%typemap(jstype) uint32_t *pixelBuffer "java.nio.IntBuffer"
%typemap(javain) uint32_t *pixelBuffer "$javainput"

%typemap(javabase) SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE [], 
                                                         SWIGTYPE (CLASS::*) "SWIG"

%typemap(javacode) SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE [], 
                                                         SWIGTYPE (CLASS::*) %{
  protected long getPointer() {
    return swigCPtr;
  }
%}

/* ###### DEFINES ###### */
#define AVFMT_RAWPICTURE    0x0020 /* format wants AVPicture structure for
                                      raw picture data */
#define AVFMT_GLOBALHEADER  0x0040 /* format wants global header */
#define AVFMT_NOFILE        0x0001
#define AV_NOPTS_VALUE          0x8000000000000000
#define CODEC_FLAG_QSCALE 0x0002  ///< use fixed qscale
#define CODEC_FLAG_4MV    0x0004  ///< 4 MV per MB allowed / Advanced prediction for H263
#define CODEC_FLAG_QPEL   0x0010  ///< use qpel MC
#define CODEC_FLAG_GMC    0x0020  ///< use GMC
#define CODEC_FLAG_MV0    0x0040  ///< always try a MB with MV=<0,0>
#define CODEC_FLAG_PART   0x0080  ///< use data partitioning
/* parent program gurantees that the input for b-frame containing streams is not written to
   for at least s->max_b_frames+1 frames, if this is not set than the input will be copied */
#define CODEC_FLAG_INPUT_PRESERVED 0x0100
#define CODEC_FLAG_PASS1 0x0200   ///< use internal 2pass ratecontrol in first  pass mode
#define CODEC_FLAG_PASS2 0x0400   ///< use internal 2pass ratecontrol in second pass mode
#define CODEC_FLAG_EXTERN_HUFF 0x1000 ///< use external huffman table (for mjpeg)
#define CODEC_FLAG_GRAY  0x2000   ///< only decode/encode grayscale
#define CODEC_FLAG_EMU_EDGE 0x4000///< don't draw edges
#define CODEC_FLAG_PSNR           0x8000 ///< error[?] variables will be set during encoding
#define CODEC_FLAG_TRUNCATED  0x00010000 /** input bitstream might be truncated at a random location instead
                                            of only at frame boundaries */
#define CODEC_FLAG_NORMALIZE_AQP  0x00020000 ///< normalize adaptive quantization
#define CODEC_FLAG_INTERLACED_DCT 0x00040000 ///< use interlaced dct
#define CODEC_FLAG_LOW_DELAY      0x00080000 ///< force low delay
#define CODEC_FLAG_ALT_SCAN       0x00100000 ///< use alternate scan
#define CODEC_FLAG_TRELLIS_QUANT  0x00200000 ///< use trellis quantization
#define CODEC_FLAG_GLOBAL_HEADER  0x00400000 ///< place global headers in extradata instead of every keyframe
#define CODEC_FLAG_BITEXACT       0x00800000 ///< use only bitexact stuff (except (i)dct)
/* Fx : Flag for h263+ extra options */
#define CODEC_FLAG_H263P_AIC      0x01000000 ///< H263 Advanced intra coding / MPEG4 AC prediction (remove this)
#define CODEC_FLAG_AC_PRED        0x01000000 ///< H263 Advanced intra coding / MPEG4 AC prediction
#define CODEC_FLAG_H263P_UMV      0x02000000 ///< Unlimited motion vector
#define CODEC_FLAG_CBP_RD         0x04000000 ///< use rate distortion optimization for cbp
#define CODEC_FLAG_QP_RD          0x08000000 ///< use rate distortion optimization for qp selectioon
#define CODEC_FLAG_H263P_AIV      0x00000008 ///< H263 Alternative inter vlc
#define CODEC_FLAG_OBMC           0x00000001 ///< OBMC
#define CODEC_FLAG_LOOP_FILTER    0x00000800 ///< loop filter
#define CODEC_FLAG_H263P_SLICE_STRUCT 0x10000000
#define CODEC_FLAG_INTERLACED_ME  0x20000000 ///< interlaced motion estimation
#define CODEC_FLAG_SVCD_SCAN_OFFSET 0x40000000 ///< will reserve space for SVCD scan offset user data
#define CODEC_FLAG_CLOSED_GOP     ((int)0x80000000)
#define CODEC_FLAG2_FAST          0x00000001 ///< allow non spec compliant speedup tricks
#define CODEC_FLAG2_STRICT_GOP    0x00000002 ///< strictly enforce GOP size
#define CODEC_FLAG2_NO_OUTPUT     0x00000004 ///< skip bitstream encoding
#define CODEC_FLAG2_LOCAL_HEADER  0x00000008 ///< place global headers at every keyframe instead of in extradata
#define CODEC_FLAG2_BPYRAMID      0x00000010 ///< H.264 allow b-frames to be used as references
#define CODEC_FLAG2_WPRED         0x00000020 ///< H.264 weighted biprediction for b-frames
#define CODEC_FLAG2_MIXED_REFS    0x00000040 ///< H.264 one reference per partition, as opposed to one reference per macroblock
#define CODEC_FLAG2_8X8DCT        0x00000080 ///< H.264 high profile 8x8 transform
#define CODEC_FLAG2_FASTPSKIP     0x00000100 ///< H.264 fast pskip
#define CODEC_FLAG2_AUD           0x00000200 ///< H.264 access unit delimiters
#define CODEC_FLAG2_BRDO          0x00000400 ///< b-frame rate-distortion optimization
#define CODEC_FLAG2_INTRA_VLC     0x00000800 ///< use MPEG-2 intra VLC table
#define CODEC_FLAG2_MEMC_ONLY     0x00001000 ///< only do ME/MC (I frames -> ref, P frame -> ME+MC)
#define CODEC_FLAG2_DROP_FRAME_TIMECODE 0x00002000 ///< timecode is in drop frame format
#define CODEC_FLAG2_SKIP_RD       0x00004000 ///< RD optimal MB level residual skiping

#define FF_BUG_AUTODETECT       1
#define FF_BUG_OLD_MSMPEG4      2
#define FF_BUG_XVID_ILACE       4
#define FF_BUG_UMP4             8
#define FF_BUG_NO_PADDING       16
#define FF_BUG_AMV              32
#define FF_BUG_QPEL_CHROMA      64
#define FF_BUG_STD_QPEL         128
#define FF_BUG_QPEL_CHROMA2     256
#define FF_BUG_DIRECT_BLOCKSIZE 512
#define FF_BUG_EDGE             1024
#define FF_BUG_HPEL_CHROMA      2048
#define FF_BUG_DC_CLIP          4096
#define FF_BUG_MS               8192

#define PKT_FLAG_KEY   0x0001

#define URL_RDONLY 0
#define URL_WRONLY 1
#define URL_RDWR   2

/* ###### TYPEDEFS ###### */
typedef long long int64_t;
typedef AVFrame AVPicture;

/* ###### ENUMS ###### */
enum CodecID {
    CODEC_ID_NONE,
    CODEC_ID_MPEG1VIDEO,
    CODEC_ID_MPEG2VIDEO, /* prefered ID for MPEG Video 1 or 2 decoding */
    CODEC_ID_MPEG2VIDEO_XVMC,
    CODEC_ID_H261,
    CODEC_ID_H263,
    CODEC_ID_RV10,
    CODEC_ID_RV20,
    CODEC_ID_MJPEG,
    CODEC_ID_MJPEGB,
    CODEC_ID_LJPEG,
    CODEC_ID_SP5X,
    CODEC_ID_JPEGLS,
    CODEC_ID_MPEG4,
    CODEC_ID_RAWVIDEO,
    CODEC_ID_MSMPEG4V1,
    CODEC_ID_MSMPEG4V2,
    CODEC_ID_MSMPEG4V3,
    CODEC_ID_WMV1,
    CODEC_ID_WMV2,
    CODEC_ID_H263P,
    CODEC_ID_H263I,
    CODEC_ID_FLV1,
    CODEC_ID_SVQ1,
    CODEC_ID_SVQ3,
    CODEC_ID_DVVIDEO,
    CODEC_ID_HUFFYUV,
    CODEC_ID_CYUV,
    CODEC_ID_H264,
    CODEC_ID_INDEO3,
    CODEC_ID_VP3,
    CODEC_ID_THEORA,
    CODEC_ID_ASV1,
    CODEC_ID_ASV2,
    CODEC_ID_FFV1,
    CODEC_ID_4XM,
    CODEC_ID_VCR1,
    CODEC_ID_CLJR,
    CODEC_ID_MDEC,
    CODEC_ID_ROQ,
    CODEC_ID_INTERPLAY_VIDEO,
    CODEC_ID_XAN_WC3,
    CODEC_ID_XAN_WC4,
    CODEC_ID_RPZA,
    CODEC_ID_CINEPAK,
    CODEC_ID_WS_VQA,
    CODEC_ID_MSRLE,
    CODEC_ID_MSVIDEO1,
    CODEC_ID_IDCIN,
    CODEC_ID_8BPS,
    CODEC_ID_SMC,
    CODEC_ID_FLIC,
    CODEC_ID_TRUEMOTION1,
    CODEC_ID_VMDVIDEO,
    CODEC_ID_MSZH,
    CODEC_ID_ZLIB,
    CODEC_ID_QTRLE,
    CODEC_ID_SNOW,
    CODEC_ID_TSCC,
    CODEC_ID_ULTI,
    CODEC_ID_QDRAW,
    CODEC_ID_VIXL,
    CODEC_ID_QPEG,
    CODEC_ID_XVID,
    CODEC_ID_PNG,
    CODEC_ID_PPM,
    CODEC_ID_PBM,
    CODEC_ID_PGM,
    CODEC_ID_PGMYUV,
    CODEC_ID_PAM,
    CODEC_ID_FFVHUFF,
    CODEC_ID_RV30,
    CODEC_ID_RV40,
    CODEC_ID_VC1,
    CODEC_ID_WMV3,
    CODEC_ID_LOCO,
    CODEC_ID_WNV1,
    CODEC_ID_AASC,
    CODEC_ID_INDEO2,
    CODEC_ID_FRAPS,
    CODEC_ID_TRUEMOTION2,
    CODEC_ID_BMP,
    CODEC_ID_CSCD,
    CODEC_ID_MMVIDEO,
    CODEC_ID_ZMBV,
    CODEC_ID_AVS,
    CODEC_ID_SMACKVIDEO,
    CODEC_ID_NUV,
    CODEC_ID_KMVC,
    CODEC_ID_FLASHSV,
    CODEC_ID_CAVS,
    CODEC_ID_JPEG2000,
    CODEC_ID_VMNC,
    CODEC_ID_VP5,
    CODEC_ID_VP6,
    CODEC_ID_VP6F,
    CODEC_ID_TARGA,
    CODEC_ID_DSICINVIDEO,
    CODEC_ID_TIERTEXSEQVIDEO,
    CODEC_ID_TIFF,
    CODEC_ID_GIF,
    CODEC_ID_FFH264,

    /* various pcm "codecs" */
    CODEC_ID_PCM_S16LE= 0x10000,
    CODEC_ID_PCM_S16BE,
    CODEC_ID_PCM_U16LE,
    CODEC_ID_PCM_U16BE,
    CODEC_ID_PCM_S8,
    CODEC_ID_PCM_U8,
    CODEC_ID_PCM_MULAW,
    CODEC_ID_PCM_ALAW,
    CODEC_ID_PCM_S32LE,
    CODEC_ID_PCM_S32BE,
    CODEC_ID_PCM_U32LE,
    CODEC_ID_PCM_U32BE,
    CODEC_ID_PCM_S24LE,
    CODEC_ID_PCM_S24BE,
    CODEC_ID_PCM_U24LE,
    CODEC_ID_PCM_U24BE,
    CODEC_ID_PCM_S24DAUD,

    /* various adpcm codecs */
    CODEC_ID_ADPCM_IMA_QT= 0x11000,
    CODEC_ID_ADPCM_IMA_WAV,
    CODEC_ID_ADPCM_IMA_DK3,
    CODEC_ID_ADPCM_IMA_DK4,
    CODEC_ID_ADPCM_IMA_WS,
    CODEC_ID_ADPCM_IMA_SMJPEG,
    CODEC_ID_ADPCM_MS,
    CODEC_ID_ADPCM_4XM,
    CODEC_ID_ADPCM_XA,
    CODEC_ID_ADPCM_ADX,
    CODEC_ID_ADPCM_EA,
    CODEC_ID_ADPCM_G726,
    CODEC_ID_ADPCM_CT,
    CODEC_ID_ADPCM_SWF,
    CODEC_ID_ADPCM_YAMAHA,
    CODEC_ID_ADPCM_SBPRO_4,
    CODEC_ID_ADPCM_SBPRO_3,
    CODEC_ID_ADPCM_SBPRO_2,

    /* AMR */
    CODEC_ID_AMR_NB= 0x12000,
    CODEC_ID_AMR_WB,

    /* RealAudio codecs*/
    CODEC_ID_RA_144= 0x13000,
    CODEC_ID_RA_288,

    /* various DPCM codecs */
    CODEC_ID_ROQ_DPCM= 0x14000,
    CODEC_ID_INTERPLAY_DPCM,
    CODEC_ID_XAN_DPCM,
    CODEC_ID_SOL_DPCM,

    CODEC_ID_MP2= 0x15000,
    CODEC_ID_MP3, /* prefered ID for MPEG Audio layer 1, 2 or3 decoding */
    CODEC_ID_AAC,
#if LIBAVCODEC_VERSION_INT < ((52<<16)+(0<<8)+0)
    CODEC_ID_MPEG4AAC,
#endif
    CODEC_ID_AC3,
    CODEC_ID_DTS,
    CODEC_ID_VORBIS,
    CODEC_ID_DVAUDIO,
    CODEC_ID_WMAV1,
    CODEC_ID_WMAV2,
    CODEC_ID_MACE3,
    CODEC_ID_MACE6,
    CODEC_ID_VMDAUDIO,
    CODEC_ID_SONIC,
    CODEC_ID_SONIC_LS,
    CODEC_ID_FLAC,
    CODEC_ID_MP3ADU,
    CODEC_ID_MP3ON4,
    CODEC_ID_SHORTEN,
    CODEC_ID_ALAC,
    CODEC_ID_WESTWOOD_SND1,
    CODEC_ID_GSM,
    CODEC_ID_QDM2,
    CODEC_ID_COOK,
    CODEC_ID_TRUESPEECH,
    CODEC_ID_TTA,
    CODEC_ID_SMACKAUDIO,
    CODEC_ID_QCELP,
    CODEC_ID_WAVPACK,
    CODEC_ID_DSICINAUDIO,
    CODEC_ID_IMC,
    CODEC_ID_MUSEPACK7,
    CODEC_ID_MLP,

    /* subtitle codecs */
    CODEC_ID_DVD_SUBTITLE= 0x17000,
    CODEC_ID_DVB_SUBTITLE,

    CODEC_ID_MPEG2TS= 0x20000, /* _FAKE_ codec to indicate a raw MPEG2 transport
                         stream (only used by libavformat) */
};

enum CodecType {
    CODEC_TYPE_UNKNOWN = -1,
    CODEC_TYPE_VIDEO,
    CODEC_TYPE_AUDIO,
    CODEC_TYPE_DATA,
    CODEC_TYPE_SUBTITLE,
};

enum PixelFormat {
    PIX_FMT_NONE= -1,
    PIX_FMT_YUV420P,   ///< Planar YUV 4:2:0, 12bpp, (1 Cr & Cb sample per 2x2 Y samples)
    PIX_FMT_YUYV422,   ///< Packed YUV 4:2:2, 16bpp, Y0 Cb Y1 Cr
    PIX_FMT_RGB24,     ///< Packed RGB 8:8:8, 24bpp, RGBRGB...
    PIX_FMT_BGR24,     ///< Packed RGB 8:8:8, 24bpp, BGRBGR...
    PIX_FMT_YUV422P,   ///< Planar YUV 4:2:2, 16bpp, (1 Cr & Cb sample per 2x1 Y samples)
    PIX_FMT_YUV444P,   ///< Planar YUV 4:4:4, 24bpp, (1 Cr & Cb sample per 1x1 Y samples)
    PIX_FMT_RGB32,     ///< Packed RGB 8:8:8, 32bpp, (msb)8A 8R 8G 8B(lsb), in cpu endianness
    PIX_FMT_YUV410P,   ///< Planar YUV 4:1:0,  9bpp, (1 Cr & Cb sample per 4x4 Y samples)
    PIX_FMT_YUV411P,   ///< Planar YUV 4:1:1, 12bpp, (1 Cr & Cb sample per 4x1 Y samples)
    PIX_FMT_RGB565,    ///< Packed RGB 5:6:5, 16bpp, (msb)   5R 6G 5B(lsb), in cpu endianness
    PIX_FMT_RGB555,    ///< Packed RGB 5:5:5, 16bpp, (msb)1A 5R 5G 5B(lsb), in cpu endianness most significant bit to 0
    PIX_FMT_GRAY8,     ///<        Y        ,  8bpp
    PIX_FMT_MONOWHITE, ///<        Y        ,  1bpp, 1 is white
    PIX_FMT_MONOBLACK, ///<        Y        ,  1bpp, 0 is black
    PIX_FMT_PAL8,      ///< 8 bit with PIX_FMT_RGB32 palette
    PIX_FMT_YUVJ420P,  ///< Planar YUV 4:2:0, 12bpp, full scale (jpeg)
    PIX_FMT_YUVJ422P,  ///< Planar YUV 4:2:2, 16bpp, full scale (jpeg)
    PIX_FMT_YUVJ444P,  ///< Planar YUV 4:4:4, 24bpp, full scale (jpeg)
    PIX_FMT_XVMC_MPEG2_MC,///< XVideo Motion Acceleration via common packet passing(xvmc_render.h)
    PIX_FMT_XVMC_MPEG2_IDCT,
    PIX_FMT_UYVY422,   ///< Packed YUV 4:2:2, 16bpp, Cb Y0 Cr Y1
    PIX_FMT_UYYVYY411, ///< Packed YUV 4:1:1, 12bpp, Cb Y0 Y1 Cr Y2 Y3
    PIX_FMT_BGR32,     ///< Packed RGB 8:8:8, 32bpp, (msb)8A 8B 8G 8R(lsb), in cpu endianness
    PIX_FMT_BGR565,    ///< Packed RGB 5:6:5, 16bpp, (msb)   5B 6G 5R(lsb), in cpu endianness
    PIX_FMT_BGR555,    ///< Packed RGB 5:5:5, 16bpp, (msb)1A 5B 5G 5R(lsb), in cpu endianness most significant bit to 1
    PIX_FMT_BGR8,      ///< Packed RGB 3:3:2,  8bpp, (msb)2B 3G 3R(lsb)
    PIX_FMT_BGR4,      ///< Packed RGB 1:2:1,  4bpp, (msb)1B 2G 1R(lsb)
    PIX_FMT_BGR4_BYTE, ///< Packed RGB 1:2:1,  8bpp, (msb)1B 2G 1R(lsb)
    PIX_FMT_RGB8,      ///< Packed RGB 3:3:2,  8bpp, (msb)2R 3G 3B(lsb)
    PIX_FMT_RGB4,      ///< Packed RGB 1:2:1,  4bpp, (msb)2R 3G 3B(lsb)
    PIX_FMT_RGB4_BYTE, ///< Packed RGB 1:2:1,  8bpp, (msb)2R 3G 3B(lsb)
    PIX_FMT_NV12,      ///< Planar YUV 4:2:0, 12bpp, 1 plane for Y and 1 for UV
    PIX_FMT_NV21,      ///< as above, but U and V bytes are swapped

    PIX_FMT_RGB32_1,   ///< Packed RGB 8:8:8, 32bpp, (msb)8R 8G 8B 8A(lsb), in cpu endianness
    PIX_FMT_BGR32_1,   ///< Packed RGB 8:8:8, 32bpp, (msb)8B 8G 8R 8A(lsb), in cpu endianness

    PIX_FMT_GRAY16BE,  ///<        Y        , 16bpp, big-endian
    PIX_FMT_GRAY16LE,  ///<        Y        , 16bpp, little-endian
    PIX_FMT_NB,        ///< number of pixel formats, DO NOT USE THIS if you want to link with shared libav* because the number of formats might differ between versions
};

enum Motion_Est_ID {
    ME_ZERO = 1,
    ME_FULL,
    ME_LOG,
    ME_PHODS,
    ME_EPZS,
    ME_X1,
    ME_HEX,
    ME_UMH,
    ME_ITER
};

/* ###### STRUCTS ###### */
typedef struct AVCodec {
} AVCodec;

typedef struct AVCodecContext {
    int bit_rate;
    enum CodecID codec_id;
    unsigned int codec_tag;
    enum CodecType codec_type;
    AVFrame *coded_frame;
    uint8_t *extradata;
    int extradata_size;
    int flags;
    enum Motion_Est_ID me_method;
    int gop_size;
    int height;
    enum PixelFormat pix_fmt;
    AVRational time_base;
    int width;
    int workaround_bugs;
} AVCodecContext;

typedef struct AVFormatContext {
    char filename[1024];
    struct AVOutputFormat *oformat;
    ByteIOContext pb;
    int flags;
} AVFormatContext;

typedef struct AVFrame {
    uint8_t *data[4];
    int linesize[4];
    int64_t pts;
    int key_frame;
} AVFrame;

typedef struct AVOutputFormat {
    enum CodecID video_codec;
    int flags;
} AVOutputFormat;

typedef struct AVPacket {
    uint8_t *data;
    int   flags;
    int64_t pts;                            ///< presentation time stamp in time_base units
    int   size;
    int   stream_index;
} AVPacket;

typedef struct AVRational{
    int num; ///< numerator
    int den; ///< denominator
} AVRational;

typedef struct AVStream {
    AVCodecContext *codec;
    int index;
    /**
     * this is the fundamental unit of time (in seconds) in terms
     * of which frame timestamps are represented. for fixed-fps content,
     * timebase should be 1/framerate and timestamp increments should be
     * identically 1.
     */
    AVRational time_base;
} AVStream;

typedef struct ByteIOContext {
} ByteIOContext;

/* ###### FUNCTIONS ###### */
AVFormatContext *av_alloc_format_context(void);
void av_free(void *ptr);
void av_init_packet(AVPacket *pkt);
void *av_malloc(unsigned int size);
AVStream *av_new_stream(AVFormatContext *s, int id);
void av_register_all(void);
/**
 * rescale a 64bit integer by 2 rational numbers.
 */
int64_t av_rescale_q(int64_t a, AVRational bq, AVRational cq);
int av_set_parameters(AVFormatContext *s, AVFormatParameters *ap);
int av_write_frame(AVFormatContext *s, AVPacket *pkt);
int av_write_header(AVFormatContext *s);
int av_write_trailer(AVFormatContext *s);
AVCodecContext *avcodec_alloc_context(void);
AVFrame *avcodec_alloc_frame(void);
int avcodec_close(AVCodecContext *avctx);
int avcodec_decode_video(AVCodecContext *avctx, AVFrame *picture,
        int *got_picture_ptr, uint8_t *buf, int buf_size);
int avcodec_encode_video(AVCodecContext *avctx, uint8_t *buf, int buf_size,
        const AVFrame *pict);
AVCodec *avcodec_find_decoder_by_name(const char *name);
AVCodec *avcodec_find_encoder(enum CodecID id);
AVCodec *avcodec_find_encoder_by_name(const char *name);
void avcodec_get_frame_defaults(AVFrame *pic);
void avcodec_init(void);
int avcodec_open(AVCodecContext *avctx, AVCodec *codec);
void avcodec_register_all(void);
int avpicture_alloc(AVPicture *picture, enum PixelFormat pix_fmt, int width, int height); 
void avpicture_free(AVPicture *picture);
int ff_get_fourcc(const char *s);
AVOutputFormat *guess_format(const char *short_name,
        const char *filename, const char *mime_type);
int img_convert(AVPicture *dst, int dst_pix_fmt, const AVPicture *src, 
        int pix_fmt, int width, int height);
void img_resample(ImgReSampleContext *s, AVPicture *output, 
        const AVPicture *input);
void img_resample_close(ImgReSampleContext *s);
ImgReSampleContext *img_resample_init(int output_width, int output_height,
        int input_width, int input_height);
int url_fclose(ByteIOContext *s);
int url_fopen(ByteIOContext *s, const char *filename, int flags);

/* ###### HELPER FUNCTIONS ###### */
%inline %{
extern void extractPixelData(AVFrame *src, AVCodecContext *codecContext, uint32_t *pixelBuffer) {
	AVPicture temp;
	uint32_t *temp_ptr;
	int width, height, w, h, p;
	int pix_fmt;

	width = codecContext->width;
	height = codecContext->height;
	if (avpicture_alloc(&temp, PIX_FMT_RGBA32, width, height) < 0) {
		return;
	}
	switch (codecContext->pix_fmt) {
	    case PIX_FMT_YUVJ420P:
	    	pix_fmt = PIX_FMT_YUV420P;
	    	break;
	    case PIX_FMT_YUVJ422P:
	    	pix_fmt = PIX_FMT_YUV422P;
	    	break;
	    case PIX_FMT_YUVJ444P:
	    	pix_fmt = PIX_FMT_YUV444P;
	    	break;
	    default:
	    	pix_fmt = codecContext->pix_fmt;
	}
	if (img_convert(&temp, PIX_FMT_RGBA32, (AVPicture *)src, pix_fmt, width, height) < 0) {
		return;
	}
	for (h = 0; h < height; h++) {
		temp_ptr = (uint32_t *)(temp.data[0] + (h * temp.linesize[0]));
		for (w = 0; w < width; w++) {
			p = (h * width) + w;
			pixelBuffer[p] = *temp_ptr++;
		}
	}
	avpicture_free(&temp);
}

extern int *alloc_int(void) {
    return (int *)av_malloc(sizeof(int));
}
%}

/* ###### INTERMEDIARY JNI CLASS PRAGMAS ####### */
%pragma(java) jniclassimports = %{
import java.io.*;
import java.nio.channels.FileLock;
%}
%pragma(java) jniclassclassmodifiers="public class"
%pragma(java) jniclasscode = %{
	private static int opFileIndex = 0;

    private static void load( Class anchorClass, String libraryName )
            throws SecurityException, UnsatisfiedLinkError
    {
        final int RETRY_MAX = 5;
        String systemLibraryName = System.mapLibraryName( libraryName );
        String systemLibraryPathInJar = "META-INF/lib/" + systemLibraryName;
        ClassLoader classLoader = anchorClass.getClassLoader();
        InputStream resourceStream;
        FileOutputStream outputStream;
        BufferedInputStream input;
        File outputFile = null;
        BufferedOutputStream output;
        boolean retry = false;
        int retryCount = 0;
        int b;
        
        do
        {
            try
            {
                if ( (outputFile = checkLibraryFileStatus(systemLibraryName) ) != null )
                {
                    if ( classLoader == null )
                    {
                        throw new UnsatisfiedLinkError(
                                "Supplied anchor class has no classloader: "
                                        + anchorClass.getName() );
                    }
                    resourceStream = classLoader.getResourceAsStream( systemLibraryPathInJar );
                    if ( resourceStream == null )
                    {
                        throw new UnsatisfiedLinkError(
                                "Cannot find library on classpath: "
                                        + systemLibraryName );
                    }
                    input = new BufferedInputStream( resourceStream );
                    outputStream = new FileOutputStream(
                            outputFile );
                    FileLock fl = outputStream.getChannel().lock();
                    output = new BufferedOutputStream( outputStream );
                    b = input.read();
                    while ( b != -1 )
                    {
                        output.write( b );
                        b = input.read();
                    }
                    input.close();
                    output.flush();
                    fl.release();
                    output.close();
                    retry = false;
                }
            }
            catch ( FileNotFoundException ex )
            {
                // Have found this indicates that we've got a problem
                // with codec dll creation. We must retry...
                retry = true;
            }
            catch ( IOException ex )
            {
                ex.printStackTrace();
                throw new UnsatisfiedLinkError(
                        "Unable to extract library from JAR: " + systemLibraryName );
            }
            try
            {
                System.load( outputFile.getAbsolutePath() );
            }
            catch (UnsatisfiedLinkError ex)
            {
                retry = true;
                //ex.printStackTrace();
            }
            finally
            {
                if (outputFile != null)
                {
                    outputFile.deleteOnExit();
                }
            }            
        } while ( retry && (++retryCount < RETRY_MAX));
        
        // Tried to resolve dll reference and failed.
        // Now inform operator that no can do...
        if (retryCount == RETRY_MAX)
        {
            throw new UnsatisfiedLinkError(
                    "Unable to extract library from JAR: " + systemLibraryName );            
        }
    }
    
    /**
     * Check if codec library file already exists and if so remove.
     * @param outputFile
     */
    private static File checkLibraryFileStatus(String systemLibraryName)
    {
        int index = 0;
        boolean fileStatusOk = false;
        int extIndex = systemLibraryName.indexOf( '.' );
        String fileName = systemLibraryName.substring( 0,  systemLibraryName.indexOf( '.' ) );
        String fileExt = systemLibraryName.substring( extIndex, systemLibraryName.length() );
        StringBuffer fileBuffer = new StringBuffer(systemLibraryName.substring( 0,  systemLibraryName.indexOf( '.' )));
        File outputFile = null;
        
        while ( !fileStatusOk )
        {
            if ( index > 0 )
            {
                fileBuffer.delete( fileName.length(), fileBuffer.length() );
                fileBuffer.append(index);
            }
            fileBuffer.append( fileExt );
            File file = new File(System.getProperty( "java.io.tmpdir" ),
                    fileBuffer.toString());
            if ( !file.exists() )
            {
                outputFile = file;
                outputFile.deleteOnExit();
                fileStatusOk = true;
            }
            index++;
        }
        opFileIndex++;
        return outputFile; 
    }

	static 
	{
		load(ADFFMPEGJNI.class, "adffmpeg");            
		av_register_all();
	}
%}
