#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Installing memcached and friends"

cd $INSTANCE_TMP
echo "+ Installing libevent"
LIBEVENT_VERSION="2.0.21-stable"
LIBEVENT_DIRNAME="libevent-${LIBEVENT_VERSION}"
LIBEVENT_TARBALL="${LIBEVENT_DIRNAME}.tar.gz"
LIBEVENT_URL="https://github.com/downloads/libevent/libevent/${LIBEVENT_TARBALL}"
fetch_and_expand $LIBEVENT_URL $LIBEVENT_DIRNAME

cd $LIBEVENT_DIRNAME
./configure --prefix=${LOCAL}
make
make install

cd $INSTANCE_TMP
echo "+ Cleaning up libevent build artifacts"
rm -rf $LIBEVET_DIRNAME

cd $INSTANCE_TMP
echo "+ Installing memcached"
MEMCACHED_VERSION="1.4.17"
MEMCACHED_DIRNAME="memcached-${MEMCACHED_VERSION}"
MEMCACHED_TARBALL="${MEMCACHED_DIRNAME}.tar.gz"
MEMCACHED_URL="http://www.memcached.org/files/${MEMCACHED_TARBALL}"

fetch_and_expand $MEMCACHED_URL $MEMCACHED_DIRNAME

cd $MEMCACHED_DIRNAME
./configure --prefix=${LOCAL} \
    --sysconfdir=${INSTANCE_ADNAUSEUM} \
    --localstatedir=${INSTANCE_CACHE} \
    --disable-docs \
    --with-libevent=${LOCAL} && \
        make && make install

cd $INSTANCE_TMP
echo "+ Cleaning up memcached server build artifacts"
rm -rf $MEMCACHED_DIRNAME

cd $INSTANCE_TMP
echo "+ Installing libmemcached"
LIBMEMCACHED_VERSION="1.0.18"
LIBMEMCACHED_VERSION_MINOR=$(echo $LIBMEMCACHED_VERSION | awk -F\. '{ printf("%d.%d", $1, $2) }')
LIBMEMCACHED_DIRNAME="libmemcached-${LIBMEMCACHED_VERSION}"
LIBMEMCACHED_TARBALL="${LIBMEMCACHED_DIRNAME}.tar.gz"
LIBMEMCACHED_URL="https://launchpad.net/libmemcached/${LIBMEMCACHED_VERSION_MINOR}/${LIBMEMCACHED_VERSION}/+download/${LIBMEMCACHED_TARBALL}"

fetch_and_expand $LIBMEMCACHED_URL $LIBMEMCACHED_DIRNAME

cd $LIBMEMCACHED_DIRNAME
# The patch comes straight from the homebrew formula,
# like it's practially `brew cat libmemcached | pbcopy`
echo "+ Patching libmemcached"
cat > .patch <<EOF
diff --git a/clients/memflush.cc b/clients/memflush.cc
index 8bd0dbf..cdba743 100644
--- a/clients/memflush.cc
+++ b/clients/memflush.cc
@@ -39,7 +39,7 @@ int main(int argc, char *argv[])
 {
   options_parse(argc, argv);

-  if (opt_servers == false)
+  if (*opt_servers != NULL)
   {
     char *temp;

@@ -48,7 +48,7 @@ int main(int argc, char *argv[])
       opt_servers= strdup(temp);
     }

-    if (opt_servers == false)
+    if (*opt_servers != NULL)
     {
       std::cerr << "No Servers provided" << std::endl;
       exit(EXIT_FAILURE);
diff --git a/libmemcached-1.0/memcached.h b/libmemcached-1.0/memcached.h
index bc16e73..dcee395 100644
--- a/libmemcached-1.0/memcached.h
+++ b/libmemcached-1.0/memcached.h
@@ -43,7 +43,11 @@
 #endif

 #ifdef __cplusplus
+#ifdef _LIBCPP_VERSION
 #  include <cinttypes>
+#else
+#  include <tr1/cinttypes>
+#endif
 #  include <cstddef>
 #  include <cstdlib>
 #else
EOF
patch -p1 < .patch && rm .patch

./configure --prefix=${LOCAL} \
    --sysconfdir=${INSTANCE_ADNAUSEUM} \
    --localstatedir=${INSTANCE_CACHE} \
    --disable-dependency-tracking \
    --disable-option-checking \
    --enable-fast-install \
    --disable-sasl \
    --with-memcached=${LOCAL} \
    --without-sphinx-build \
    --without-genhtml \
    --without-mysql \
    --without-lcov \
    --without-gearmand && \
        make && make install

cd $INSTANCE_TMP
echo "+ Cleaning up libmemcached server build artifacts"
rm -rf $LIBMEMCACHED_DIRNAME

cd $VIRTUAL_ENV
echo "+ Installing python native memcached driver 'pylibmc'"
# If we're on a mac with homebrew, try to unlink the brewed libmemcached before
# trying this shit, to maybe circumvent pylibmc's incorrigible system path ideas
[[ -x `which brew` ]] && brew unlink libmemcached
bin/pip install -U pylibmc --install-option="--with-libmemcached=${LOCAL}"
[[ -x `which brew` ]] && brew link libmemcached

