hashicorp_verifier
===============

[![Build Status](https://travis-ci.org/mitchelldavis/terraform_verifier.svg?branch=master)](https://travis-ci.org/mitchelldavis/terraform_verifier)

This is a golang one stop shop for verifying [Hashicorp](https://www.hashicorp.com/) files.  The process of downloading and verifying hashicorp tools within builds, especially, [Bazel](https://bazel.build/) builds, is cumbersome across platforms.  This tool helps unify the functionality needed to verify [pgp](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) signatures and checksums.

According to Hashicorp's [security](https://www.hashicorp.com/security) documentation, the steps for each tool downloaded are:

- Download the binary, SHASUM, and SHASUM.sig files
- Verify the SHASUM file is properly signed
- Verify the SHASUM in the file matches the binary

Their documentation even has an example that requires [gpg](https://www.gnupg.org/) and [shasum](https://linux.die.net/man/1/shasum) to be installed.  This makes sense with popular linux distros, but get's difficult working with sandboxed environments.

---

```
# The Hashicorp_Verifier is easy to use given that we have 
# - terraform_0.11.11_SHA256SUM
# - terraform_0.11.11_SHA256SUM.sig
# - terraform_0.11.11_<os>_<arch>.zip
# - hashicorp.pub
#		This is the hashicorp public gpg key.
#		It's published at https://www.hashicorp.com/security

# To check the signature of the SHA256SUM files:
hashicorp_verifier signature \
	-key hashicorp.pub \
	-sig terraform_0.11.11_SHA256SUM.sig \
	-target terraform_0.11.11_SHA256SUM

# To check the checksum of the binary:
hashicorp_verifier checksum \
	-shasum terraform_0.11.11_SHA256SUM
	-target terraform_0.11.11_<os>_<arch>.zip
```

Build
-----

This tool was conceived when working through how to get hashicorp tools inside of Bazel builds, so it uses [Bazel](https://bazel.build/) to manage the build and to manage the cross compilation.

```
# At the root of the repository and 
# with Bazel installed and on the path

bazel build //...
```

The [TravisCi](https://travis-ci.org/mitchelldavis/terraform_verifier) build uses a `ci` configuration for when it runs.  So, please make sure this passes before submitting a pull request.

```
bazel \
  --host_jvm_args=-Xmx500m \
  --host_jvm_args=-Xms500m \
  build \
  --local_resources=400,1,1.0 \
  --config=ci \
  @hashicorp_verifier//...
```

Contribute
----------

Of course I'm open to pull requests!

License
=======

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
