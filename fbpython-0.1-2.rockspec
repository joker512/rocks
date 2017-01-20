--
--  Copyright (c) 2014, Facebook, Inc.
--  All rights reserved.
--
--  This source code is licensed under the BSD-style license found in the
--  LICENSE file in the root directory of this source tree. An additional grant
--  of patent rights can be found in the PATENTS file in the same directory.
--

package = 'fbpython'
version = '0.1-2'
source = {
    url = 'git://github.com/facebook/fblualib',
}
description = {
    summary = 'FB Lua - Python Bridge',
    detailed = [[
      Allows for calling python functions from Lua. Torch Tensors
      and numpy arrays are also automatically transferred between each
      other.
    ]],
    homepage = 'https://github.com/facebook/fblualib',
    license = 'BSD',
}
supported_platforms = {
    'unix',
}
dependencies = {
    'torch >= 7.0',
    'penlight >= 1.3.1',
}
build = {
    type = 'command',
    build_command = [[
        git clone https://github.com/facebook/thpp/
        cd thpp/thpp; THPP_NOFB=; FB="-DNO_TESTS=ON -DNO_THRIFT=ON -DNO_FOLLY=ON"; ./build.sh; cd ../..

        cd fblualib/python
        cmake -E make_directory build &&
        cd build &&
        cmake -DROCKS_PREFIX=$(PREFIX) \
              -DROCKS_LUADIR=$(LUADIR) \
              -DROCKS_LIBDIR=$(LIBDIR) \
              .. &&
        $(MAKE)
    ]],
    install_command = [[
        cd fblualib/python/build && $(MAKE) install
    ]],
}

