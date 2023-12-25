#!/bin/sh

# Copyright (c) 2021-2023 Franco Fichtner <franco@reticen8.org>
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

SELF=clone

. ./common.sh

if [ -z "${TO}" ]; then
	echo ">>> Missing target, please set TO=xx.x"
	exit 1
fi

if [ ${TO} = ${PRODUCT_ABI} ]; then
	echo ">>> Wrong target, please correct TO=xx.x"
	exit 1
fi

for ARG in ${@}; do
	case ${ARG} in
	base|distfiles|kernel|packages)
		SRC=$(find_set ${ARG})
		if [ -f "${SRC}" ]; then
			DST=$(echo ${SRC} | sed "s:/${PRODUCT_ABI}/:/${TO}/:")
			echo -n ">>> Cloning ${DST}... "
			rm -f $(dirname ${DST})/${ARG}-*
			cp ${SRC} ${DST}
			echo "done"
		fi
		;;
	esac
done

