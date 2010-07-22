package uk.org.netvu.adffmpeg;

import static org.junit.Assert.*;

import org.junit.Test;


public class ADFFMPEGTest
{
    @Test
    public void loadADFFMPEGNativeLibrary()
    {
        ADFFMPEG.av_register_all();
    }
    
    @Test
    public void findMpeg4Codec()
    {
        assertNotNull( ADFFMPEG.avcodec_find_decoder_by_name( "mpeg4" ) );
    }
    
    @Test
    public void allocateCodecContext()
    {
        assertNotNull( ADFFMPEG.avcodec_alloc_context() );
    }
    
    @Test
    public void allocateFrame()
    {
        assertNotNull( ADFFMPEG.avcodec_alloc_frame() );
    }
}
