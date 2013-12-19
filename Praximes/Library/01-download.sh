
# download_to, expand_tarball_to, download_and_expand

download_to() {
    in_url="${1:?URL expected}"
    out_file="${2:?pathname expected}"
    [[ -r $out_file ]] && echo "- Already exists: ${out_file}" && return
    echo "+ Fetching URL: ${in_url}"
    echo "+ Downloading to file: ${out_file}"
    test ! -r $out_file && test -x `which wget` && wget $in_url -O $out_file
    test ! -r $out_file && test -x `which curl` && curl -L $in_url -o $out_file
    test ! -r $out_file && test -x `which http` && http -d $in_url -o $out_file
    test ! -r $out_file && "- Couldn't download. Tried: wget, curl, httpie"
}

expand_tarball_to() {
    in_tarball="${1:?tarball expected}"
    out_directory="${2:?pathname expected}"
    [[ ! -r $in_tarball ]] && echo "- Can't read tarball: ${in_tarball}" && return
    [[ -d $out_directory ]] && rm -rf $out_directory
    mkdir -p $out_directory
    echo "+ Expanding tarball: ${in_tarball}"
    tar xzf $in_tarball --strip-components=1 --directory=$out_directory
}

download_and_expand() {
    url="${1:?URL expected}"
    url_basename="$(basename ${url})"
    src_directory="${2:?pathname expected}"
    tmp_tarball="/tmp/${url_basename}"
    download_to $url $tmp_tarball
    expand_tarball_to $tmp_tarball $src_directory
    rm $tmp_tarball
}