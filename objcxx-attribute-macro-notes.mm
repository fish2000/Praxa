__has_feature(objc_arc);
__has_feature(objc_arc_weak);
__has_extension(blocks);
 
 
__attribute__((__noreturn__));
__attribute__((__warn_unused_result__));
__attribute__((__unused__));
__attribute__((__format_arg__(x)));
__attribute__((__const__));
__attribute__((__malloc__));
__attribute__((__noinline__));
__attribute__((__always_inline__));

__attribute__((__nonnull__));
__attribute__((__nonnull__ (1)));
__attribute__((__nonnull__ (3, 4)));

__attribute__((__externally_visible__));
__attribute__((visibility("default")));
__attribute__((visibility("hidden")));
__attribute__((visibility("protected")));
__attribute__((visibility("internal")));
__attribute__((__unavailable__(\
            "This function is not exported by libpng.")));

#define likely(x)       __builtin_expect(!!(x), 1)
#define unlikely(x)     __builtin_expect(!!(x), 0)


typedef union
  {
    union wait *__uptr;
    int *__iptr;
  } __WAIT_STATUS __attribute__ ((__transparent_union__));




#pragma clang loop unroll_count(8)
#pragma clang loop unroll(full)
for(...) {
  ...
}


/// -faltivec 
 __has_extension(attribute_ext_vector_type)
 typedef float float4 __attribute__((ext_vector_type(4)));
 typedef float float2 __attribute__((ext_vector_type(2)));

 float4 foo(float2 a, float2 b) {
   float4 c;
   c.xz = a;
   c.yw = b;
   return c;
 }
 
typedef __attribute__((neon_vector_type(8))) int8_t int8x8_t;
typedef __attribute__((neon_polyvector_type(16))) poly8_t poly8x16_t;

typedef int v4si __attribute__((__vector_size__(16)));
typedef float float4 __attribute__((ext_vector_type(4)));
typedef float float2 __attribute__((ext_vector_type(2)));

v4si vsi = (v4si){1, 2, 3, 4};
float4 vf = (float4)(1.0f, 2.0f, 3.0f, 4.0f);
vector int vi1 = (vector int)(1);    // vi1 will be (1, 1, 1, 1).
vector int vi2 = (vector int){1};    // vi2 will be (1, 0, 0, 0).
vector int vi3 = (vector int)(1, 2); // error
vector int vi4 = (vector int){1, 2}; // vi4 will be (1, 2, 0, 0).
vector int vi5 = (vector int)(1, 2, 3, 4);
float4 vf = (float4)((float2)(1.0f, 2.0f), (float2)(3.0f, 4.0f));

__builtin_shufflevector(vec1, vec2, index1, index2, ...)
__builtin_convertvector(src_vec, dst_vec_type)

typedef double vector4double __attribute__((__vector_size__(32)));
typedef float  vector4float  __attribute__((__vector_size__(16)));
typedef short  vector4short  __attribute__((__vector_size__(8)));
vector4float vf; vector4short vs;

// convert from a vector of 4 floats to a vector of 4 doubles.
__builtin_convertvector(vf, vector4double)
// equivalent to:
(vector4double) { (double) vf[0], (double) vf[1], (double) vf[2], (double) vf[3] }

// convert from a vector of 4 shorts to a vector of 4 floats.
__builtin_convertvector(vs, vector4float)
// equivalent to:
(vector4float) { (float) vs[0], (float) vs[1], (float) vs[2], (float) vs[3] }