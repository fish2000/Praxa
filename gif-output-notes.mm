
std::vector<byte_sink*> GIF_me_in_the_face(std::vector<HalideImage<uint8_t>> frame_vector)
{
    gif::GIF *g = gif::newGIF(3);
    const int W = 200, H = 200;
    
    unsigned char rgbImage[W * H * 3];
    
    /// overflow is not really *here*,
    /// it's used internally in shit called by gif::addFrame
    /// and resized/reallocated anew for each frame image
    std::vector<byte> overflow; 
    
    /// out is our return value:
    /// it's a vector of byte_sink pointers, each one pointing
    /// to the new byte_sink that the memory::buffer tied to the 
    /// overflow vector has to get released into somehow
    /// at the end of each frame.
    /// ... YOU GOT ALL THAT ???
    std::vector<byte_sink*> out;
    out.reserve(frame_vector.size())
    
    for (int i = 0; i < frame_vector.size(); i++) {
        
        HalideImage<uint8_t> frame = frame_vector.at(i);
        
        for () {{{{...}}}} /// rearrange frame data as per youge,
                          /// into rgbImage[] buffer
        
        gif::addFrame(g, W, H, rgbImage, 0); /// 
    }
    gif::write(g, NULL);
    gif::dispose(g);
    g = NULL;
    return 0;
}
