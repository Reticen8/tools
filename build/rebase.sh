#!/bin/sh

# Copyright (c) 2015-2022 Franco Fichtner <franco@reticen8.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

set -e

SELF=rebase

. ./common.sh

setup_stage ${STAGEDIR}

BASESET=$(find_set base)
OBSOLETE=/usr/local/reticen8/version/base.obsolete

tar -tf ${BASESET} | sed -e 's/^\.//g' -e '/\/$/d' | \
    grep -v -e '\.mtree\.sig$' -e '\.abi_hint$' | \
    sort > ${CONFIGDIR}/base.plist.${PRODUCT_ARCH}

tar -C ${STAGEDIR} -xf ${BASESET} .${OBSOLETE}
cp ${STAGEDIR}${OBSOLETE} ${CONFIGDIR}/base.obsolete.${PRODUCT_ARCH}
