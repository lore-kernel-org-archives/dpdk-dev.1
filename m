Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0889C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0DC2402DB;
	Fri, 28 Mar 2025 14:19:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03F00402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 14:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743167958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0BtEoXI5SoO2uBXCYDNq2i0Dr7RgqeOVXQUywxiYjk=;
 b=gq7cHxAO4sOERcgfISBUynmurlLAc4atY0qZtkrAoCZ2JX40FJubSrBFnAsBRuy3FmIOel
 FE+eW2qTg+1V1HCq2825oVTPa+wO9LBxwf57N8LGIvXV6aPlhND/xV4bMuA07a6jC5RIp3
 3kGDXs+ZAMjoXOtMDtRWu/nFk8lFL9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-CtrSjRRaOo2TAwqz0XpKig-1; Fri,
 28 Mar 2025 09:19:12 -0400
X-MC-Unique: CtrSjRRaOo2TAwqz0XpKig-1
X-Mimecast-MFC-AGG-ID: CtrSjRRaOo2TAwqz0XpKig_1743167951
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11AF91800260; Fri, 28 Mar 2025 13:19:11 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.226])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE46D19560AB; Fri, 28 Mar 2025 13:19:07 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net,  bruce.richardson@intel.com,
 andremue@linux.microsoft.com,  Michael Santana
 <maicolgabriel@hotmail.com>,  Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v5 6/8] build: use dynamically generated version maps
In-Reply-To: <20250327133638.2983276-7-david.marchand@redhat.com> (David
 Marchand's message of "Thu, 27 Mar 2025 14:36:26 +0100")
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250327133638.2983276-1-david.marchand@redhat.com>
 <20250327133638.2983276-7-david.marchand@redhat.com>
Date: Fri, 28 Mar 2025 09:19:05 -0400
Message-ID: <f7tzfh5qomu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RFM4Q-xv--xh-D4hhmcVy3uY-aduaXkj_SD_L-1MN6M_1743167951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

David Marchand <david.marchand@redhat.com> writes:

> Switch to dynamically generated version maps.
>
> As the map files get generated, tooling around checking, converting,
> updating etc.. static version maps can be removed.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Just a minor (non-blocking) nit below.

Otherwise,
Acked-by: Aaron Conole <aconole@redhat.com>

>  .github/workflows/build.yml                   |   1 -
>  MAINTAINERS                                   |   7 -
>  buildtools/check-symbols.sh                   |  33 +-
>  buildtools/map-list-symbol.sh                 |   7 +-
>  buildtools/map_to_win.py                      |  41 ---
>  buildtools/meson.build                        |   1 -
>  devtools/check-symbol-change.sh               | 186 -----------
>  devtools/check-symbol-maps.sh                 | 101 ------
>  devtools/checkpatches.sh                      |   2 +-
>  devtools/update-abi.sh                        |  46 ---
>  devtools/update_version_map_abi.py            | 210 ------------
>  doc/guides/contributing/abi_policy.rst        |  21 +-
>  doc/guides/contributing/coding_style.rst      |   7 -
>  .../contributing/img/patch_cheatsheet.svg     | 303 ++++++++----------
>  doc/guides/contributing/patches.rst           |   6 +-
>  drivers/meson.build                           |  74 ++---
>  lib/meson.build                               |  73 ++---
>  17 files changed, 188 insertions(+), 931 deletions(-)
>  delete mode 100644 buildtools/map_to_win.py
>  delete mode 100755 devtools/check-symbol-change.sh
>  delete mode 100755 devtools/check-symbol-maps.sh
>  delete mode 100755 devtools/update-abi.sh
>  delete mode 100755 devtools/update_version_map_abi.py
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index 0cc4d12b0b..7a6b679fe5 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -31,7 +31,6 @@ jobs:
>          failed=
>          devtools/check-doc-vs-code.sh upstream/${{ env.REF_GIT_BRANCH }} || failed=true
>          devtools/check-meson.py || failed=true
> -        devtools/check-symbol-maps.sh || failed=true
>          [ -z "$failed" ]
>    ubuntu-vm-builds:
>      name: ${{ join(matrix.config.*, '-') }}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42ea07854b..480972ef1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -88,7 +88,6 @@ M: Thomas Monjalon <thomas@monjalon.net>
>  F: MAINTAINERS
>  F: devtools/build-dict.sh
>  F: devtools/check-abi.sh
> -F: devtools/check-abi-version.sh
>  F: devtools/check-doc-vs-code.sh
>  F: devtools/check-dup-includes.sh
>  F: devtools/check-maintainers.sh
> @@ -96,17 +95,13 @@ F: devtools/check-forbidden-tokens.awk
>  F: devtools/check-git-log.sh
>  F: devtools/check-spdx-tag.sh
>  F: devtools/check-symbol-change.py
> -F: devtools/check-symbol-change.sh
> -F: devtools/check-symbol-maps.sh
>  F: devtools/checkpatches.sh
>  F: devtools/get-maintainer.sh
>  F: devtools/git-log-fixes.sh
>  F: devtools/load-devel-config
>  F: devtools/parse-flow-support.sh
>  F: devtools/process-iwyu.py
> -F: devtools/update-abi.sh
>  F: devtools/update-patches.py
> -F: devtools/update_version_map_abi.py
>  F: devtools/libabigail.abignore
>  F: devtools/words-case.txt
>  F: license/
> @@ -166,7 +161,6 @@ M: Tyler Retzlaff <roretzla@linux.microsoft.com>
>  F: lib/eal/common/
>  F: lib/eal/unix/
>  F: lib/eal/include/
> -F: lib/eal/version.map
>  F: doc/guides/prog_guide/env_abstraction_layer.rst
>  F: app/test/test_alarm.c
>  F: app/test/test_atomic.c
> @@ -396,7 +390,6 @@ Windows support
>  M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
>  M: Tyler Retzlaff <roretzla@linux.microsoft.com>
>  F: lib/eal/windows/
> -F: buildtools/map_to_win.py
>  F: doc/guides/windows_gsg/
>  
>  Windows memory allocation
> diff --git a/buildtools/check-symbols.sh b/buildtools/check-symbols.sh
> index b8ac24391e..0d6745ec14 100755
> --- a/buildtools/check-symbols.sh
> +++ b/buildtools/check-symbols.sh
> @@ -7,29 +7,12 @@ OBJFILE=$2
>  
>  ROOTDIR=$(readlink -f $(dirname $(readlink -f $0))/..)
>  LIST_SYMBOL=$ROOTDIR/buildtools/map-list-symbol.sh
> -CHECK_SYMBOL_MAPS=$ROOTDIR/devtools/check-symbol-maps.sh
> -
> -# added check for "make -C test/" usage
> -if [ ! -e $MAPFILE ] || [ ! -f $OBJFILE ]
> -then
> -	exit 0
> -fi
> -
> -if [ -d $MAPFILE ]
> -then
> -	exit 0
> -fi
> -
>  DUMPFILE=$(mktemp -t dpdk.${0##*/}.objdump.XXXXXX)
>  trap 'rm -f "$DUMPFILE"' EXIT
>  objdump -t $OBJFILE >$DUMPFILE
>  
>  ret=0
>  
> -if ! $CHECK_SYMBOL_MAPS $MAPFILE; then
> -	ret=1
> -fi
> -
>  for SYM in `$LIST_SYMBOL -S EXPERIMENTAL $MAPFILE |cut -d ' ' -f 3`
>  do
>  	if grep -q "\.text.*[[:space:]]$SYM$" $DUMPFILE &&
> @@ -37,8 +20,7 @@ do
>  		$LIST_SYMBOL -s $SYM $MAPFILE | grep -q EXPERIMENTAL
>  	then
>  		cat >&2 <<- END_OF_MESSAGE
> -		$SYM is not flagged as experimental
> -		but is listed in version map
> +		$SYM is not flagged as experimental but is exported as an experimental symbol
>  		Please add __rte_experimental to the definition of $SYM
>  		END_OF_MESSAGE
>  		ret=1
> @@ -53,9 +35,8 @@ for SYM in `awk '{
>  do
>  	$LIST_SYMBOL -S EXPERIMENTAL -s $SYM -q $MAPFILE || {
>  		cat >&2 <<- END_OF_MESSAGE
> -		$SYM is flagged as experimental
> -		but is not listed in version map
> -		Please add $SYM to the version map
> +		$SYM is flagged as experimental but is not exported as an experimental symbol
> +		Please add RTE_EXPORT_EXPERIMENTAL_SYMBOL to the definition of $SYM
>  		END_OF_MESSAGE
>  		ret=1
>  	}
> @@ -67,8 +48,7 @@ do
>  		! grep -q "\.text\.internal.*[[:space:]]$SYM$" $DUMPFILE
>  	then
>  		cat >&2 <<- END_OF_MESSAGE
> -		$SYM is not flagged as internal
> -		but is listed in version map
> +		$SYM is not flagged as internal but is exported as an internal symbol
>  		Please add __rte_internal to the definition of $SYM
>  		END_OF_MESSAGE
>  		ret=1
> @@ -83,9 +63,8 @@ for SYM in `awk '{
>  do
>  	$LIST_SYMBOL -S INTERNAL -s $SYM -q $MAPFILE || {
>  		cat >&2 <<- END_OF_MESSAGE
> -		$SYM is flagged as internal
> -		but is not listed in version map
> -		Please add $SYM to the version map
> +		$SYM is flagged as internal but is not exported as an internal symbol
> +		Please add RTE_EXPORT_INTERNAL_SYMBOL to the definition of $SYM
>  		END_OF_MESSAGE
>  		ret=1
>  	}
> diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol.sh
> index 0829df4be5..962d5f3271 100755
> --- a/buildtools/map-list-symbol.sh
> +++ b/buildtools/map-list-symbol.sh
> @@ -42,7 +42,6 @@ for file in $@; do
>  	cat "$file" |awk '
>  	BEGIN {
>  		current_section = "";
> -		current_version = "";
>  		if ("'$section'" == "all" && "'$symbol'" == "all" && "'$version'" == "") {
>  			ret = 0;
>  		} else {
> @@ -54,15 +53,11 @@ for file in $@; do
>  			current_section = $1;
>  		}
>  	}
> -	/.*}/ { current_section = ""; current_version = ""; }
> -	/^\t# added in / {
> -		current_version=$4;
> -	}
> +	/.*}/ { current_section = ""; }
>  	/^[^}].*[^:*];/ {
>  		if (current_section == "") {
>  			next;
>  		}
> -		symbol_version = current_version
>  		if (/^[^}].*[^:*]; # added in /) {
>  			symbol_version = $5
>  		}
> diff --git a/buildtools/map_to_win.py b/buildtools/map_to_win.py
> deleted file mode 100644
> index aa1752cacd..0000000000
> --- a/buildtools/map_to_win.py
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#!/usr/bin/env python3
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2019 Intel Corporation
> -
> -import sys
> -
> -
> -def is_function_line(ln):
> -    return ln.startswith('\t') and ln.endswith(';\n') and ":" not in ln and "# WINDOWS_NO_EXPORT" not in ln
> -
> -# MinGW keeps the original .map file but replaces per_lcore* to __emutls_v.per_lcore*
> -def create_mingw_map_file(input_map, output_map):
> -    with open(input_map) as f_in, open(output_map, 'w') as f_out:
> -        f_out.writelines([lines.replace('per_lcore', '__emutls_v.per_lcore') for lines in f_in.readlines()])
> -
> -def main(args):
> -    if not args[1].endswith('version.map') or \
> -            not args[2].endswith('exports.def') and \
> -            not args[2].endswith('mingw.map'):
> -        return 1
> -
> -    if args[2].endswith('mingw.map'):
> -        create_mingw_map_file(args[1], args[2])
> -        return 0
> -
> -# generate def file from map file.
> -# This works taking indented lines only which end with a ";" and which don't
> -# have a colon in them, i.e. the lines defining functions only.
> -    else:
> -        with open(args[1]) as f_in:
> -            functions = [ln[:-2] + '\n' for ln in sorted(f_in.readlines())
> -                         if is_function_line(ln)]
> -            functions = ["EXPORTS\n"] + functions
> -
> -    with open(args[2], 'w') as f_out:
> -        f_out.writelines(functions)
> -    return 0
> -
> -
> -if __name__ == "__main__":
> -    sys.exit(main(sys.argv))
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index b745e9afa4..1cd1ce02fd 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -18,7 +18,6 @@ endif
>  echo = py3 + ['-c', 'import sys; print(*sys.argv[1:])']
>  gen_version_map = py3 + files('gen-version-map.py')
>  list_dir_globs = py3 + files('list-dir-globs.py')
> -map_to_win_cmd = py3 + files('map_to_win.py')
>  sphinx_wrapper = py3 + files('call-sphinx-build.py')
>  get_cpu_count_cmd = py3 + files('get-cpu-count.py')
>  get_numa_count_cmd = py3 + files('get-numa-count.py')
> diff --git a/devtools/check-symbol-change.sh b/devtools/check-symbol-change.sh
> deleted file mode 100755
> index 8992214ac8..0000000000
> --- a/devtools/check-symbol-change.sh
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2018 Neil Horman <nhorman@tuxdriver.com>
> -
> -build_map_changes()
> -{
> -	local fname="$1"
> -	local mapdb="$2"
> -
> -	cat "$fname" | awk '
> -		# Initialize our variables
> -		BEGIN {map="";sym="";ar="";sec=""; in_sec=0; in_map=0}
> -
> -		# Anything that starts with + or -, followed by an a
> -		# and ends in the string .map is the name of our map file
> -		# This may appear multiple times in a patch if multiple
> -		# map files are altered, and all section/symbol names
> -		# appearing between a triggering of this rule and the
> -		# next trigger of this rule are associated with this file
> -		/[-+] [ab]\/.*\.map/ {map=$2; in_map=1; next}
> -
> -		# The previous rule catches all .map files, anything else
> -		# indicates we left the map chunk.
> -		/[-+] [ab]\// {in_map=0}
> -
> -		# Triggering this rule, which starts a line and ends it
> -		# with a { identifies a versioned section.  The section name is
> -		# the rest of the line with the + and { symbols removed.
> -		# Triggering this rule sets in_sec to 1, which actives the
> -		# symbol rule below
> -		/^.*{/ {
> -			gsub("+", "");
> -			if (in_map == 1) {
> -				sec=$(NF-1); in_sec=1;
> -			}
> -		}
> -
> -		# This rule identifies the end of a section, and disables the
> -		# symbol rule
> -		/.*}/ {in_sec=0}
> -
> -		# This rule matches on a + followed by any characters except a :
> -		# (which denotes a global vs local segment), and ends with a ;.
> -		# The semicolon is removed and the symbol is printed with its
> -		# association file name and version section, along with an
> -		# indicator that the symbol is a new addition.  Note this rule
> -		# only works if we have found a version section in the rule
> -		# above (hence the in_sec check) And found a map file (the
> -		# in_map check).  If we are not in a map chunk, do nothing.  If
> -		# we are in a map chunk but not a section chunk, record it as
> -		# unknown.
> -		/^+[^}].*[^:*];/ {gsub(";","");sym=$2;
> -			if (in_map == 1) {
> -				if (in_sec == 1) {
> -					print map " " sym " " sec " add"
> -				} else {
> -					print map " " sym " unknown add"
> -				}
> -			}
> -		}
> -
> -		# This is the same rule as above, but the rule matches on a
> -		# leading - rather than a +, denoting that the symbol is being
> -		# removed.
> -		/^-[^}].*[^:*];/ {gsub(";","");sym=$2;
> -			if (in_map == 1) {
> -				if (in_sec == 1) {
> -					print map " " sym " " sec " del"
> -				} else {
> -					print map " " sym " unknown del"
> -				}
> -			}
> -		}' > "$mapdb"
> -
> -		sort -u "$mapdb" > "$mapdb.2"
> -		mv -f "$mapdb.2" "$mapdb"
> -
> -}
> -
> -is_stable_section() {
> -	[ "$1" != 'EXPERIMENTAL' ] && [ "$1" != 'INTERNAL' ]
> -}
> -
> -check_for_rule_violations()
> -{
> -	local mapdb="$1"
> -	local mname
> -	local symname
> -	local secname
> -	local ar
> -	local ret=0
> -
> -	while read mname symname secname ar
> -	do
> -		if [ "$ar" = "add" ]
> -		then
> -
> -			if [ "$secname" = "unknown" ]
> -			then
> -				# Just inform the user of this occurrence, but
> -				# don't flag it as an error
> -				echo -n "INFO: symbol $symname is added but "
> -				echo -n "patch has insufficient context "
> -				echo -n "to determine the section name "
> -				echo -n "please ensure the version is "
> -				echo "EXPERIMENTAL"
> -				continue
> -			fi
> -
> -			oldsecname=$(sed -n \
> -			"s#$mname $symname \(.*\) del#\1#p" "$mapdb")
> -
> -			# A symbol can not enter a stable section directly
> -			if [ -z "$oldsecname" ]
> -			then
> -				if ! is_stable_section $secname
> -				then
> -					echo -n "INFO: symbol $symname has "
> -					echo -n "been added to the "
> -					echo -n "$secname section of the "
> -					echo "version map"
> -					continue
> -				else
> -					echo -n "ERROR: symbol $symname "
> -					echo -n "is added in the $secname "
> -					echo -n "section, but is expected to "
> -					echo -n "be added in the EXPERIMENTAL "
> -					echo "section of the version map"
> -					ret=1
> -					continue
> -				fi
> -			fi
> -
> -			# This symbol is moving inside a section, nothing to do
> -			if [ "$oldsecname" = "$secname" ]
> -			then
> -				continue
> -			fi
> -
> -			# This symbol is moving between two sections (the
> -			# original section is a stable section).
> -			# This can be legit, just warn.
> -			if is_stable_section $oldsecname
> -			then
> -				echo -n "INFO: symbol $symname is being "
> -				echo -n "moved from $oldsecname to $secname. "
> -				echo -n "Ensure that it has gone through the "
> -				echo "deprecation process"
> -				continue
> -			fi
> -		else
> -
> -			if ! grep -q "$mname $symname .* add" "$mapdb" && \
> -			   is_stable_section $secname
> -			then
> -				# Just inform users that stable
> -				# symbols need to go through a deprecation
> -				# process
> -				echo -n "INFO: symbol $symname is being "
> -				echo -n "removed, ensure that it has "
> -				echo "gone through the deprecation process"
> -			fi
> -		fi
> -	done < "$mapdb"
> -
> -	return $ret
> -}
> -
> -trap clean_and_exit_on_sig EXIT
> -
> -mapfile=`mktemp -t dpdk.mapdb.XXXXXX`
> -patch=$1
> -exit_code=1
> -
> -clean_and_exit_on_sig()
> -{
> -	rm -f "$mapfile"
> -	exit $exit_code
> -}
> -
> -build_map_changes "$patch" "$mapfile"
> -check_for_rule_violations "$mapfile"
> -exit_code=$?
> -rm -f "$mapfile"
> -
> -exit $exit_code
> diff --git a/devtools/check-symbol-maps.sh b/devtools/check-symbol-maps.sh
> deleted file mode 100755
> index fcd3931e5d..0000000000
> --- a/devtools/check-symbol-maps.sh
> +++ /dev/null
> @@ -1,101 +0,0 @@
> -#! /bin/sh -e
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright 2018 Mellanox Technologies, Ltd
> -
> -cd $(dirname $0)/..
> -
> -# speed up by ignoring Unicode details
> -export LC_ALL=C
> -
> -if [ $# = 0 ] ; then
> -    set -- $(find lib drivers -name '*.map' -a ! -path drivers/version.map)
> -fi
> -
> -ret=0
> -
> -find_orphan_symbols ()
> -{
> -    for map in $@ ; do
> -        for sym in $(sed -rn 's,^([^}]*_.*);.*$,\1,p' $map) ; do
> -            if echo $sym | grep -q '^per_lcore_' ; then
> -                symsrc=${sym#per_lcore_}
> -            elif echo $sym | grep -q '^__rte_.*_trace_' ; then
> -                symsrc=${sym#__}
> -            else
> -                symsrc=$sym
> -            fi
> -            if [ -z "$(grep -rlw $symsrc $(dirname $map) | grep -v $map)" ] ; then
> -                echo "$map: $sym"
> -            fi
> -        done
> -    done
> -}
> -
> -orphan_symbols=$(find_orphan_symbols $@)
> -if [ -n "$orphan_symbols" ] ; then
> -    echo "Found only in symbol map file:"
> -    echo "$orphan_symbols" | sed 's,^,\t,'
> -    ret=1
> -fi
> -
> -find_duplicate_symbols ()
> -{
> -    for map in $@ ; do
> -        buildtools/map-list-symbol.sh $map | \
> -            sort | uniq -c | grep -v " 1 $map" || true
> -    done
> -}
> -
> -duplicate_symbols=$(find_duplicate_symbols $@)
> -if [ -n "$duplicate_symbols" ] ; then
> -    echo "Found duplicates in symbol map file:"
> -    echo "$duplicate_symbols"
> -    ret=1
> -fi
> -
> -local_miss_maps=$(grep -L 'local: \*;' $@ || true)
> -if [ -n "$local_miss_maps" ] ; then
> -    echo "Found maps without local catch-all:"
> -    echo "$local_miss_maps"
> -    ret=1
> -fi
> -
> -find_bad_format_maps ()
> -{
> -    abi_version=$(cut -d'.' -f 1 ABI_VERSION)
> -    next_abi_version=$((abi_version + 1))
> -    for map in $@ ; do
> -        cat $map | awk '
> -            /^(DPDK_('$abi_version'|'$next_abi_version')|EXPERIMENTAL|INTERNAL) \{$/ { next; } # start of a section
> -            /^}( DPDK_'$abi_version')?;$/ { next; } # end of a section
> -            /^$/ { next; } # empty line
> -            /^\t(global:|local: \*;)$/ { next; } # qualifiers
> -            /^\t[a-zA-Z_0-9]*;( # WINDOWS_NO_EXPORT)?$/ { next; } # symbols
> -            /^\t# added in [0-9]*\.[0-9]*$/ { next; } # version comments
> -            { print $0; }' || echo $map
> -    done
> -}
> -
> -bad_format_maps=$(find_bad_format_maps $@)
> -if [ -n "$bad_format_maps" ] ; then
> -    echo "Found badly formatted maps:"
> -    echo "$bad_format_maps"
> -    ret=1
> -fi
> -
> -find_non_versioned_maps ()
> -{
> -    for map in $@ ; do
> -        [ $(buildtools/map-list-symbol.sh -S EXPERIMENTAL -V unset $map | wc -l) = '0' ] ||
> -            echo $map
> -    done
> -}
> -
> -non_versioned_maps=$(find_non_versioned_maps $@)
> -if [ -n "$non_versioned_maps" ] ; then
> -    echo "Found non versioned maps:"
> -    echo "$non_versioned_maps"
> -    ret=1
> -fi
> -
> -exit $ret
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index 9180c2b070..c111b0fef3 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -9,7 +9,7 @@
>  # - DPDK_CHECKPATCH_OPTIONS
>  . $(dirname $(readlink -f $0))/load-devel-config
>  
> -VALIDATE_NEW_API=$(dirname $(readlink -f $0))/check-symbol-change.sh
> +VALIDATE_NEW_API=$(dirname $(readlink -f $0))/check-symbol-change.py
>  
>  # Enable codespell by default. This can be overwritten from a config file.
>  # Codespell can also be enabled by setting DPDK_CHECKPATCH_CODESPELL to a valid path
> diff --git a/devtools/update-abi.sh b/devtools/update-abi.sh
> deleted file mode 100755
> index 45437f3c3b..0000000000
> --- a/devtools/update-abi.sh
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -#!/bin/sh -e
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2019 Intel Corporation
> -
> -abi_version=$1
> -abi_version_file="./ABI_VERSION"
> -update_path="lib drivers"
> -
> -# check ABI version format string
> -check_abi_version() {
> -      echo $1 | grep -q -e "^[[:digit:]]\{1,2\}\.[[:digit:]]\{1,2\}$"
> -}
> -
> -if [ -z "$1" ]; then
> -      # output to stderr
> -      >&2 echo "Please provide ABI version"
> -      exit 1
> -fi
> -
> -# check version string format
> -if ! check_abi_version $abi_version ; then
> -      # output to stderr
> -      >&2 echo "ABI version must be formatted as MAJOR.MINOR version"
> -      exit 1
> -fi
> -
> -if [ -n "$2" ]; then
> -      abi_version_file=$2
> -fi
> -
> -if [ -n "$3" ]; then
> -      # drop $1 and $2
> -      shift 2
> -      # assign all other arguments as update paths
> -      update_path=$@
> -fi
> -
> -echo "New ABI version:" $abi_version
> -echo "ABI_VERSION path:" $abi_version_file
> -echo "Path to update:" $update_path
> -
> -echo $abi_version > $abi_version_file
> -
> -find $update_path -name version.map -exec \
> -      devtools/update_version_map_abi.py {} \
> -      $abi_version \; -print
> diff --git a/devtools/update_version_map_abi.py b/devtools/update_version_map_abi.py
> deleted file mode 100755
> index d17b02a327..0000000000
> --- a/devtools/update_version_map_abi.py
> +++ /dev/null
> @@ -1,210 +0,0 @@
> -#!/usr/bin/env python3
> -# SPDX-License-Identifier: BSD-3-Clause
> -# Copyright(c) 2019 Intel Corporation
> -
> -"""
> -A Python program that updates and merges all available stable ABI versions into
> -one ABI version, while leaving experimental ABI exactly as it is. The intended
> -ABI version is supplied via command-line parameter. This script is to be called
> -from the devtools/update-abi.sh utility.
> -"""
> -
> -import argparse
> -import sys
> -import re
> -
> -
> -def __parse_map_file(f_in):
> -    # match function name, followed by semicolon, followed by EOL or comments,
> -    # optionally with whitespace in between each item
> -    func_line_regex = re.compile(r"\s*"
> -                                 r"(?P<line>"
> -                                 r"(?P<func>[a-zA-Z_0-9]+)"
> -                                 r"\s*"
> -                                 r";"
> -                                 r"\s*"
> -                                 r"(?P<comment>#.+)?"
> -                                 r")"
> -                                 r"\s*"
> -                                 r"$")
> -    # match section name, followed by opening bracked, followed by EOL,
> -    # optionally with whitespace in between each item
> -    section_begin_regex = re.compile(r"\s*"
> -                                     r"(?P<version>[a-zA-Z0-9_\.]+)"
> -                                     r"\s*"
> -                                     r"{"
> -                                     r"\s*"
> -                                     r"$")
> -    # match closing bracket, optionally followed by section name (for when we
> -    # inherit from another ABI version), followed by semicolon, followed by
> -    # EOL, optionally with whitespace in between each item
> -    section_end_regex = re.compile(r"\s*"
> -                                   r"}"
> -                                   r"\s*"
> -                                   r"(?P<parent>[a-zA-Z0-9_\.]+)?"
> -                                   r"\s*"
> -                                   r";"
> -                                   r"\s*"
> -                                   r"$")
> -
> -    # for stable ABI, we don't care about which version introduced which
> -    # function, we just flatten the list. there are dupes in certain files, so
> -    # use a set instead of a list
> -    stable_lines = set()
> -    # copy experimental section as is
> -    experimental_lines = []
> -    # copy internal section as is
> -    internal_lines = []
> -    in_experimental = False
> -    in_internal = False
> -    has_stable = False
> -
> -    # gather all functions
> -    for line in f_in:
> -        # clean up the line
> -        line = line.strip('\n').strip()
> -
> -        # is this an end of section?
> -        match = section_end_regex.match(line)
> -        if match:
> -            # whatever section this was, it's not active any more
> -            in_experimental = False
> -            in_internal = False
> -            continue
> -
> -        # if we're in the middle of experimental section, we need to copy
> -        # the section verbatim, so just add the line
> -        if in_experimental:
> -            experimental_lines += [line]
> -            continue
> -
> -        # if we're in the middle of internal section, we need to copy
> -        # the section verbatim, so just add the line
> -        if in_internal:
> -            internal_lines += [line]
> -            continue
> -
> -        # skip empty lines
> -        if not line:
> -            continue
> -
> -        # is this a beginning of a new section?
> -        match = section_begin_regex.match(line)
> -        if match:
> -            cur_section = match.group("version")
> -            # is it experimental?
> -            in_experimental = cur_section == "EXPERIMENTAL"
> -            # is it internal?
> -            in_internal = cur_section == "INTERNAL"
> -            if not in_experimental and not in_internal:
> -                has_stable = True
> -            continue
> -
> -        # is this a function?
> -        match = func_line_regex.match(line)
> -        if match:
> -            stable_lines.add(match.group("line"))
> -
> -    return has_stable, stable_lines, experimental_lines, internal_lines
> -
> -
> -def __generate_stable_abi(f_out, abi_major, lines):
> -    # print ABI version header
> -    print("DPDK_{} {{".format(abi_major), file=f_out)
> -
> -    # print global section if it exists
> -    if lines:
> -        print("\tglobal:", file=f_out)
> -        # blank line
> -        print(file=f_out)
> -
> -        # print all stable lines, alphabetically sorted
> -        for line in sorted(lines):
> -            print("\t{}".format(line), file=f_out)
> -
> -        # another blank line
> -        print(file=f_out)
> -
> -    # print local section
> -    print("\tlocal: *;", file=f_out)
> -
> -    # end stable version
> -    print("};", file=f_out)
> -
> -
> -def __generate_experimental_abi(f_out, lines):
> -    # start experimental section
> -    print("EXPERIMENTAL {", file=f_out)
> -
> -    # print all experimental lines as they were
> -    for line in lines:
> -        # don't print empty whitespace
> -        if not line:
> -            print("", file=f_out)
> -        else:
> -            print("\t{}".format(line), file=f_out)
> -
> -    # end section
> -    print("};", file=f_out)
> -
> -def __generate_internal_abi(f_out, lines):
> -    # start internal section
> -    print("INTERNAL {", file=f_out)
> -
> -    # print all internal lines as they were
> -    for line in lines:
> -        # don't print empty whitespace
> -        if not line:
> -            print("", file=f_out)
> -        else:
> -            print("\t{}".format(line), file=f_out)
> -
> -    # end section
> -    print("};", file=f_out)
> -
> -def __main():
> -    arg_parser = argparse.ArgumentParser(
> -        description='Merge versions in linker version script.')
> -
> -    arg_parser.add_argument("map_file", type=str,
> -                            help='path to linker version script file '
> -                                 '(pattern: version.map)')
> -    arg_parser.add_argument("abi_version", type=str,
> -                            help='target ABI version (pattern: MAJOR.MINOR)')
> -
> -    parsed = arg_parser.parse_args()
> -
> -    if not parsed.map_file.endswith('version.map'):
> -        print("Invalid input file: {}".format(parsed.map_file),
> -              file=sys.stderr)
> -        arg_parser.print_help()
> -        sys.exit(1)
> -
> -    if not re.match(r"\d{1,2}\.\d{1,2}", parsed.abi_version):
> -        print("Invalid ABI version: {}".format(parsed.abi_version),
> -              file=sys.stderr)
> -        arg_parser.print_help()
> -        sys.exit(1)
> -    abi_major = parsed.abi_version.split('.')[0]
> -
> -    with open(parsed.map_file) as f_in:
> -        has_stable, stable_lines, experimental_lines, internal_lines = __parse_map_file(f_in)
> -
> -    with open(parsed.map_file, 'w') as f_out:
> -        need_newline = has_stable and experimental_lines
> -        if has_stable:
> -            __generate_stable_abi(f_out, abi_major, stable_lines)
> -        if need_newline:
> -            # separate sections with a newline
> -            print(file=f_out)
> -        if experimental_lines:
> -            __generate_experimental_abi(f_out, experimental_lines)
> -        if internal_lines:
> -            if has_stable or experimental_lines:
> -              # separate sections with a newline
> -              print(file=f_out)
> -            __generate_internal_abi(f_out, internal_lines)
> -
> -
> -if __name__ == "__main__":
> -    __main()
> diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
> index d96153c6b2..f03a7467ac 100644
> --- a/doc/guides/contributing/abi_policy.rst
> +++ b/doc/guides/contributing/abi_policy.rst
> @@ -330,31 +330,14 @@ become part of a tracked ABI version.
>  
>  Note that marking an API as experimental is a multi step process.
>  To mark an API as experimental, the symbols which are desired to be exported
> -must be placed in an EXPERIMENTAL version block in the corresponding libraries'
> -version map script.
> +must be annotated with a RTE_EXPORT_EXPERIMENTAL_SYMBOL call in the corresponding libraries'
> +sources.

When reading through, this line stuck out as getting very long (92
characters).  I know it's .rst file so generally more like a markup
language, but maybe consider breaking ~79 characters region.  If you
agree, it's okay for this to be on apply.

>  Experimental symbols must be commented so that it is clear in which DPDK
>  version they were introduced.
>  
> -.. code-block:: none
> -
> -   EXPERIMENTAL {
> -           global:
> -
> -           # added in 20.11
> -           rte_foo_init;
> -           rte_foo_configure;
> -
> -           # added in 21.02
> -           rte_foo_cleanup;
> -   ...
> -
>  Secondly, the corresponding prototypes of those exported functions (in the
>  development header files), must be marked with the ``__rte_experimental`` tag
>  (see ``rte_compat.h``).
> -The DPDK build makefiles perform a check to ensure that the map file and the
> -C code reflect the same list of symbols.
> -This check can be circumvented by defining ``ALLOW_EXPERIMENTAL_API``
> -during compilation in the corresponding library Makefile.
>  
>  In addition to tagging the code with ``__rte_experimental``,
>  the doxygen markup must also contain the EXPERIMENTAL string,
> diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
> index 1ebc79ca3c..43e27bbd0a 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -1018,13 +1018,6 @@ name
>  	sources are stored in a directory ``lib/xyz``, this value should
>  	never be needed for new libraries.
>  
> -.. note::
> -
> -	The name value also provides the name used to find the function version
> -	map file, as part of the build process, so if the directory name and
> -	library names differ, the ``version.map`` file should be named
> -	consistently with the library, not the directory
> -
>  objs
>  	**Default Value = []**.
>  	This variable can be used to pass to the library build some pre-built
> diff --git a/doc/guides/contributing/img/patch_cheatsheet.svg b/doc/guides/contributing/img/patch_cheatsheet.svg
> index 4debb07b98..a06d8a2a3b 100644
> --- a/doc/guides/contributing/img/patch_cheatsheet.svg
> +++ b/doc/guides/contributing/img/patch_cheatsheet.svg
> @@ -1,18 +1,18 @@
>  <?xml version="1.0" encoding="UTF-8" standalone="no"?>
>  <svg
> -   xmlns:dc="http://purl.org/dc/elements/1.1/"
> -   xmlns:cc="http://creativecommons.org/ns#"
> -   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> -   xmlns:svg="http://www.w3.org/2000/svg"
> -   xmlns="http://www.w3.org/2000/svg"
> -   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> -   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
>     version="1.1"
>     width="210mm"
>     height="297mm"
>     id="svg2985"
> -   inkscape:version="1.0.1 (3bc2e813f5, 2020-09-07)"
> -   sodipodi:docname="patch_cheatsheet.svg">
> +   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
> +   sodipodi:docname="patch_cheatsheet.svg"
> +   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
> +   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
> +   xmlns="http://www.w3.org/2000/svg"
> +   xmlns:svg="http://www.w3.org/2000/svg"
> +   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
> +   xmlns:cc="http://creativecommons.org/ns#"
> +   xmlns:dc="http://purl.org/dc/elements/1.1/">
>    <sodipodi:namedview
>       pagecolor="#ffffff"
>       bordercolor="#666666"
> @@ -23,18 +23,22 @@
>       inkscape:pageopacity="0"
>       inkscape:pageshadow="2"
>       inkscape:window-width="1920"
> -     inkscape:window-height="1017"
> +     inkscape:window-height="975"
>       id="namedview274"
>       showgrid="false"
>       inkscape:zoom="0.89702958"
> -     inkscape:cx="246.07409"
> -     inkscape:cy="416.76022"
> -     inkscape:window-x="1072"
> -     inkscape:window-y="-8"
> +     inkscape:cx="546.24732"
> +     inkscape:cy="385.71749"
> +     inkscape:window-x="0"
> +     inkscape:window-y="0"
>       inkscape:window-maximized="1"
>       inkscape:current-layer="layer1"
>       inkscape:document-rotation="0"
> -     inkscape:snap-grids="false" />
> +     inkscape:snap-grids="false"
> +     inkscape:showpageshadow="2"
> +     inkscape:pagecheckerboard="0"
> +     inkscape:deskcolor="#d1d1d1"
> +     inkscape:document-units="mm" />
>    <defs
>       id="defs3">
>      <linearGradient
> @@ -906,7 +910,7 @@
>               style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:11.5613px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start"
>               id="tspan4092-8-7-6-9-7"
>               y="855.79816"
> -             x="460.18405">****</tspan></text>
> +             x="460.18405">***</tspan></text>
>        </g>
>      </g>
>      <text
> @@ -1132,161 +1136,126 @@
>             id="tspan4092-8-6-3-1-8-4-4-55-7"
>             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">*</tspan></text>
>      </g>
> +    <text
> +       x="424.10629"
> +       y="363.21423"
> +       id="text4090-8"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="424.10629"
> +         y="363.21423"
> +         id="tspan4092-8"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ Rebase to git  </tspan></text>
> +    <text
> +       x="424.10629"
> +       y="393.60123"
> +       id="text4090-8-5"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="424.10629"
> +         y="393.60123"
> +         id="tspan4092-8-5"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ Checkpatch </tspan></text>
> +    <text
> +       x="424.10629"
> +       y="424.20575"
> +       id="text4090-8-5-6"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="424.10629"
> +         y="424.20575"
> +         id="tspan4092-8-5-5"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ ABI breakage </tspan></text>
> +    <text
> +       x="424.10629"
> +       y="453.10339"
> +       id="text4090-8-5-6-9-4"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="424.10629"
> +         y="453.10339"
> +         id="tspan4092-8-5-5-3-4"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ Maintainers file</tspan></text>
> +    <text
> +       x="424.10629"
> +       y="514.09497"
> +       id="text4090-8-5-6-9-4-6"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="424.10629"
> +         y="514.09497"
> +         id="tspan4092-8-5-5-3-4-0"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ Release notes</tspan></text>
> +    <text
> +       x="425.12708"
> +       y="544.91718"
> +       id="text4090-8-5-6-9-4-6-6"
> +       xml:space="preserve"
> +       style="font-style:normal;font-weight:normal;font-size:40.4213px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1.01053"
> +       transform="scale(1.0105317,0.98957807)"><tspan
> +         x="425.12708"
> +         y="544.91718"
> +         id="tspan4092-8-5-5-3-4-0-6"
> +         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21.2212px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start;stroke-width:1.01053">+ Documentation</tspan></text>
>      <g
> -       transform="translate(1.0962334,-2.7492248)"
> -       id="g3605">
> -      <text
> -         x="42.176418"
> -         y="1020.4383"
> -         id="text4090-8-7-8-7-6-3-8-4"
> -         xml:space="preserve"
> -         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:0%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -           x="42.176418"
> -           y="1020.4383"
> -           id="tspan4092-8-6-3-1-8-4-4-55"
> -           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:11px;line-height:125%;font-family:monospace;-inkscape-font-specification:Monospace;text-align:start;writing-mode:lr-tb;text-anchor:start">The version.map function names must be in alphabetical order.</tspan></text>
> -      <text
> -         x="30.942892"
> -         y="1024.2014"
> -         id="text4090-8-7-8-7-6-3-8-4-1-5"
> -         xml:space="preserve"
> -         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:0%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -           x="30.942892"
> -           y="1024.2014"
> -           id="tspan4092-8-6-3-1-8-4-4-55-7-2"
> -           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">*</tspan></text>
> -      <text
> -         x="25.247679"
> -         y="1024.2014"
> -         id="text4090-8-7-8-7-6-3-8-4-1-5-6"
> -         xml:space="preserve"
> -         style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:0%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -           x="25.247679"
> -           y="1024.2014"
> -           id="tspan4092-8-6-3-1-8-4-4-55-7-2-8"
> -           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">*</tspan></text>
> -    </g>
> -    <g
> -       transform="matrix(1.0211743,0,0,1,25.427515,-30.749225)"
> -       id="g3275">
> +       transform="matrix(1.0211743,0,0,1,25.427515,-31.583927)"
> +       id="g3334">
>        <g
> -         id="g3341">
> +         id="g3267"
> +         transform="translate(-13.517932,3.1531035)">
>          <text
> -           x="394.78601"
> -           y="390.17807"
> -           id="text4090-8"
> -           xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="394.78601"
> -             y="390.17807"
> -             id="tspan4092-8"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Rebase to git  </tspan></text>
> -        <text
> -           x="394.78601"
> -           y="420.24835"
> -           id="text4090-8-5"
> +           x="660.46729"
> +           y="468.01297"
> +           id="text4090-8-1-8-9-1-4-1"
>             xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="394.78601"
> -             y="420.24835"
> -             id="tspan4092-8-5"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Checkpatch </tspan></text>
> -        <text
> -           x="394.78601"
> -           y="450.53394"
> -           id="text4090-8-5-6"
> -           xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="394.78601"
> -             y="450.53394"
> -             id="tspan4092-8-5-5"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ ABI breakage </tspan></text>
> -        <text
> +           style="font-style:normal;font-weight:normal;font-size:25.6917px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> +             x="660.46729"
> +             y="468.01297"
> +             id="tspan4092-8-7-6-9-7-0-7"
> +             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:11.5613px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start" /></text>
> +      </g>
> +      <text
> +         x="394.78601"
> +         y="483.59955"
> +         id="text4090-8-5-6-9"
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
>             x="394.78601"
> -           y="513.13031"
> -           id="text4090-8-5-6-9-4"
> -           xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="394.78601"
> -             y="513.13031"
> -             id="tspan4092-8-5-5-3-4"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Maintainers file</tspan></text>
> -        <text
> +           y="483.59955"
> +           id="tspan4092-8-5-5-3"
> +           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start" /></text>
> +    </g>
> +    <g
> +       id="g3428"
> +       transform="matrix(1.0211743,0,0,1,25.427515,-63.867847)">
> +      <text
> +         x="394.78601"
> +         y="541.38928"
> +         id="text4090-8-5-6-9-4-6-1"
> +         xml:space="preserve"
> +         style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
>             x="394.78601"
> -           y="573.48621"
> -           id="text4090-8-5-6-9-4-6"
> -           xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="394.78601"
> -             y="573.48621"
> -             id="tspan4092-8-5-5-3-4-0"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Release notes</tspan></text>
> +           y="541.38928"
> +           id="tspan4092-8-5-5-3-4-0-7"
> +           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Doxygen</tspan></text>
> +      <g
> +         transform="translate(-119.92979,57.949844)"
> +         id="g3267-9">
>          <text
> -           x="395.79617"
> -           y="603.98718"
> -           id="text4090-8-5-6-9-4-6-6"
> +           x="628.93628"
> +           y="473.13675"
> +           id="text4090-8-1-8-9-1-4-1-4"
>             xml:space="preserve"
> -           style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -             x="395.79617"
> -             y="603.98718"
> -             id="tspan4092-8-5-5-3-4-0-6"
> -             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Documentation</tspan></text>
> -        <g
> -           transform="translate(0,-0.83470152)"
> -           id="g3334">
> -          <g
> -             id="g3267"
> -             transform="translate(-13.517932,3.1531035)">
> -            <text
> -               x="660.46729"
> -               y="468.01297"
> -               id="text4090-8-1-8-9-1-4-1"
> -               xml:space="preserve"
> -               style="font-style:normal;font-weight:normal;font-size:25.6917px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -                 x="660.46729"
> -                 y="468.01297"
> -                 id="tspan4092-8-7-6-9-7-0-7"
> -                 style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:11.5613px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">**</tspan></text>
> -          </g>
> -          <text
> -             x="394.78601"
> -             y="483.59955"
> -             id="text4090-8-5-6-9"
> -             xml:space="preserve"
> -             style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -               x="394.78601"
> -               y="483.59955"
> -               id="tspan4092-8-5-5-3"
> -               style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Update version.map</tspan></text>
> -        </g>
> -        <g
> -           id="g3428"
> -           transform="translate(0,0.88137813)">
> -          <text
> -             x="394.78601"
> -             y="541.38928"
> -             id="text4090-8-5-6-9-4-6-1"
> -             xml:space="preserve"
> -             style="font-style:normal;font-weight:normal;font-size:40px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -               x="394.78601"
> -               y="541.38928"
> -               id="tspan4092-8-5-5-3-4-0-7"
> -               style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+ Doxygen</tspan></text>
> -          <g
> -             transform="translate(-119.92979,57.949844)"
> -             id="g3267-9">
> -            <text
> -               x="628.93628"
> -               y="473.13675"
> -               id="text4090-8-1-8-9-1-4-1-4"
> -               xml:space="preserve"
> -               style="font-style:normal;font-weight:normal;font-size:25.6917px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> -                 x="628.93628"
> -                 y="473.13675"
> -                 id="tspan4092-8-7-6-9-7-0-7-8"
> -                 style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:11.5613px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">***</tspan></text>
> -          </g>
> -        </g>
> +           style="font-style:normal;font-weight:normal;font-size:25.6917px;line-height:0%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none"><tspan
> +             x="628.93628"
> +             y="473.13675"
> +             id="tspan4092-8-7-6-9-7-0-7-8"
> +             style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:11.5613px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">**</tspan></text>
>        </g>
>      </g>
>      <text
> @@ -1301,7 +1270,7 @@
>           id="tspan4092-8-5-5-3-4-0-6-2-11-0"
>           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:21px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">+</tspan></text>
>      <g
> -       transform="translate(1.0962334,-2.7492248)"
> +       transform="translate(1.0962334,-14.749225)"
>         id="g3595">
>        <text
>           x="30.942892"
> @@ -1332,7 +1301,7 @@
>             x="19.552465"
>             y="1037.0271"
>             id="tspan4092-8-6-3-1-8-4-4-55-7-3-9"
> -           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">*</tspan></text>
> +           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start" /></text>
>        <text
>           x="42.830166"
>           y="1033.2393"
> @@ -1345,7 +1314,7 @@
>             style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:11px;line-height:125%;font-family:monospace;-inkscape-font-specification:Monospace;text-align:start;writing-mode:lr-tb;text-anchor:start">New header files must get a new page in the API docs.</tspan></text>
>      </g>
>      <g
> -       transform="translate(1.0962334,-2.7492248)"
> +       transform="translate(1.0962334,-14.749225)"
>         id="g3619">
>        <text
>           x="42.212418"
> @@ -1396,7 +1365,7 @@
>             x="14.016749"
>             y="1049.8527"
>             id="tspan4092-8-6-3-1-8-4-4-55-7-3-9-6-5"
> -           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start">*</tspan></text>
> +           style="font-style:normal;font-variant:normal;font-weight:300;font-stretch:normal;font-size:13px;line-height:125%;font-family:monospace;-inkscape-font-specification:'Monospace Bold';text-align:start;writing-mode:lr-tb;text-anchor:start" /></text>
>      </g>
>      <rect
>         width="196.44218"
> diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
> index d21ee288b2..8ad6b6e715 100644
> --- a/doc/guides/contributing/patches.rst
> +++ b/doc/guides/contributing/patches.rst
> @@ -160,9 +160,9 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
>  
>    * For other PMDs and more info, refer to the ``MAINTAINERS`` file.
>  
> -* New external functions should be added to the local ``version.map`` file. See
> -  the :doc:`ABI policy <abi_policy>` and :ref:`ABI versioning <abi_versioning>`
> -  guides. New external functions should also be added in alphabetical order.
> +* New external functions should be exported.
> +  See the :doc:`ABI policy <abi_policy>` and :ref:`ABI versioning <abi_versioning>`
> +  guides.
>  
>  * Any new API function should be used in ``/app`` test directory.
>  
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 5368d38363..15a4991abf 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -5,8 +5,6 @@ if is_ms_compiler
>      subdir_done()
>  endif
>  
> -fs = import('fs')
> -
>  # Defines the order of dependencies evaluation
>  subdirs = [
>          'common',
> @@ -290,57 +288,25 @@ foreach subpath:subdirs
>                  install: true)
>  
>          # now build the shared driver
> -        version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), drv_path)
> -
> -        if not fs.is_file(version_map)
> -            if is_ms_linker
> -                link_mode = 'mslinker'
> -            elif is_windows
> -                link_mode = 'mingw'
> -            else
> -                link_mode = 'gnu'
> -            endif
> -            version_map = custom_target(lib_name + '_map',
> -                    command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
> -                    input: sources + sources_avx2 + sources_avx512,
> -                    output: '_'.join([class, name, 'exports.map']))
> -            version_map_path = version_map.full_path()
> -            version_map_dep = [version_map]
> -            lk_deps = [version_map]
> -
> -            if is_ms_linker and is_ms_compiler
> -                lk_args = ['/def:' + version_map.full_path()]
> -            elif is_ms_linker
> -                lk_args = ['-Wl,/def:' + version_map.full_path()]
> -            else
> -                lk_args = ['-Wl,--version-script=' + version_map.full_path()]
> -            endif
> +        if is_ms_linker
> +            link_mode = 'mslinker'
> +        elif is_windows
> +            link_mode = 'mingw'
>          else
> -            version_map_path = version_map
> -            version_map_dep = []
> -            lk_deps = [version_map]
> -
> -            if is_windows
> -                if is_ms_linker
> -                    def_file = custom_target(lib_name + '_def',
> -                            command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
> -                            input: version_map,
> -                            output: '@0@_exports.def'.format(lib_name))
> -                    lk_deps += [def_file]
> -
> -                    lk_args = ['-Wl,/def:' + def_file.full_path()]
> -                else
> -                    mingw_map = custom_target(lib_name + '_mingw',
> -                            command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
> -                            input: version_map,
> -                            output: '@0@_mingw.map'.format(lib_name))
> -                    lk_deps += [mingw_map]
> -
> -                    lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
> -                endif
> -            else
> -                lk_args = ['-Wl,--version-script=' + version_map]
> -            endif
> +            link_mode = 'gnu'
> +        endif
> +        version_map = custom_target(lib_name + '_map',
> +                command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
> +                input: sources + sources_avx2 + sources_avx512,
> +                output: '_'.join([class, name, 'exports.map']))
> +        lk_deps = [version_map]
> +
> +        if is_ms_linker and is_ms_compiler
> +            lk_args = ['/def:' + version_map.full_path()]
> +        elif is_ms_linker
> +            lk_args = ['-Wl,/def:' + version_map.full_path()]
> +        else
> +            lk_args = ['-Wl,--version-script=' + version_map.full_path()]
>          endif
>  
>          if not is_windows and developer_mode
> @@ -348,11 +314,11 @@ foreach subpath:subdirs
>              # check-symbols.sh script, using it as a
>              # dependency of the .so build
>              lk_deps += custom_target(lib_name + '.sym_chk',
> -                    command: [check_symbols, version_map_path, '@INPUT@'],
> +                    command: [check_symbols, version_map.full_path(), '@INPUT@'],
>                      capture: true,
>                      input: static_lib,
>                      output: lib_name + '.sym_chk',
> -                    depends: version_map_dep)
> +                    depends: [version_map])
>          endif
>  
>          shared_lib = shared_library(lib_name, sources_pmd_info,
> diff --git a/lib/meson.build b/lib/meson.build
> index a9cbea5fea..6157d0e13e 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2017-2019 Intel Corporation
>  
> -fs = import('fs')
>  
>  # process all libraries equally, as far as possible
>  # "core" libs first, then others alphabetically as far as possible
> @@ -289,59 +288,25 @@ foreach l:libraries
>              include_directories: includes,
>              dependencies: static_deps)
>  
> -    if not fs.is_file('@0@/@1@/version.map'.format(meson.current_source_dir(), l))
> -        if is_ms_linker
> -            link_mode = 'mslinker'
> -        elif is_windows
> -            link_mode = 'mingw'
> -        else
> -            link_mode = 'gnu'
> -        endif
> -        version_map = custom_target(libname + '_map',
> -                command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
> -                input: sources,
> -                output: '_'.join([name, 'exports.map']))
> -        version_map_path = version_map.full_path()
> -        version_map_dep = [version_map]
> -        lk_deps = [version_map]
> -
> -        if is_ms_linker and is_ms_compiler
> -            lk_args = ['/def:' + version_map.full_path()]
> -        elif is_ms_linker
> -            lk_args = ['-Wl,/def:' + version_map.full_path()]
> -        else
> -            lk_args = ['-Wl,--version-script=' + version_map.full_path()]
> -        endif
> +    if is_ms_linker
> +        link_mode = 'mslinker'
> +    elif is_windows
> +        link_mode = 'mingw'
>      else
> -        version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), l)
> -        version_map_path = version_map
> -        version_map_dep = []
> -        lk_deps = [version_map]
> -        if is_ms_linker
> -            def_file = custom_target(libname + '_def',
> -                    command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
> -                    input: version_map,
> -                    output: '@0@_exports.def'.format(libname))
> -            lk_deps += [def_file]
> -
> -            if is_ms_compiler
> -                lk_args = ['/def:' + def_file.full_path()]
> -            else
> -                lk_args = ['-Wl,/def:' + def_file.full_path()]
> -            endif
> -        else
> -            if is_windows
> -                mingw_map = custom_target(libname + '_mingw',
> -                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
> -                        input: version_map,
> -                        output: '@0@_mingw.map'.format(libname))
> -                lk_deps += [mingw_map]
> +        link_mode = 'gnu'
> +    endif
> +    version_map = custom_target(libname + '_map',
> +            command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
> +            input: sources,
> +            output: '_'.join([name, 'exports.map']))
> +    lk_deps = [version_map]
>  
> -                lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
> -            else
> -                lk_args = ['-Wl,--version-script=' + version_map]
> -            endif
> -        endif
> +    if is_ms_linker and is_ms_compiler
> +        lk_args = ['/def:' + version_map.full_path()]
> +    elif is_ms_linker
> +        lk_args = ['-Wl,/def:' + version_map.full_path()]
> +    else
> +        lk_args = ['-Wl,--version-script=' + version_map.full_path()]
>      endif
>  
>      if developer_mode and not is_windows
> @@ -349,11 +314,11 @@ foreach l:libraries
>          # check-symbols.sh script, using it as a
>          # dependency of the .so build
>          lk_deps += custom_target(name + '.sym_chk',
> -                command: [check_symbols, version_map_path, '@INPUT@'],
> +                command: [check_symbols, version_map.full_path(), '@INPUT@'],
>                  capture: true,
>                  input: static_lib,
>                  output: name + '.sym_chk',
> -                depends: version_map_dep)
> +                depends: [version_map])
>      endif
>  
>      if not use_function_versioning or is_windows

