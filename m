Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA59C3601A
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 16:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D3340E1C;
	Thu,  3 Apr 2025 18:59:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 39607402CB
 for <dev@dpdk.org>; Thu,  3 Apr 2025 18:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743699560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmW1SD3DM2GiQdX0LhpfmTNGITc+HZKOuos+NDFasGc=;
 b=L+VcQ0JSsoMIU7yf4xjoLFsHlakIVqlsiC67xf9LXSJxQIdl735K8GsHhwpiBxwZvkFtEj
 F+62jlEGc6q7ioFIvL9i+HAocWNvCSQG6Mrx6pYznesLx4xmFD+mvb06ngjteaWJk0Vwq1
 yv8as9ctVHzWs5TB+guhKCsDT0kGyIc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-kT28n-oAMN6zF6CxjwnHNQ-1; Thu,
 03 Apr 2025 12:59:17 -0400
X-MC-Unique: kT28n-oAMN6zF6CxjwnHNQ-1
X-Mimecast-MFC-AGG-ID: kT28n-oAMN6zF6CxjwnHNQ_1743699556
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECADC1800258; Thu,  3 Apr 2025 16:59:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.228])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 774D01955BC2; Thu,  3 Apr 2025 16:59:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 4/8] build: generate symbol maps
Date: Thu,  3 Apr 2025 18:58:33 +0200
Message-ID: <20250403165845.1315380-5-david.marchand@redhat.com>
In-Reply-To: <20250403165845.1315380-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gqrpBmINVinJLB13FQWWMwkc8Vy99TzKCv-WYf2IwI0_1743699556
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Rather than maintain a file in parallel of the code, symbols to be
exported can be marked with a token RTE_EXPORT_*SYMBOL.

From those marks, the build framework generates map files only for
symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
becomes unnecessary).

The build framework directly creates a map file in the format that the
linker expects (rather than converting from GNU linker to MSVC linker).

Empty maps are allowed again as a replacement for drivers/version.map.

The symbol check is updated to only support the new format.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v6:
- rewrote parameter parsing for python scripts,
- fixed most pylint complaints,
- dropped TODO comment in symbol check,
- renamed header to eal_export.h,
- updated macros definition,

Changes since RFC v4:
- fixed MSVC export map (a msvc->mslinker update was missing),
- fixed join() error (with older meson? I don't see this on Fedora),
- explicit inclusion of header is now required,
- header has been renamed and moved to lib/eal/common/,
- because lib/log does not depend on EAL, added explicit
  include_directories,
- symbol versioning update has been moved later in the series,
  so updated gen-version-map.py accordingly,
- fixed bug when checking symbol removal,

Changes since RFC v3:
- polished python,
- fixed doc updates not belonging to this patch,
- renamed map files,
- changed msvc->mslinker as link mode,
- added parsing of AVX sources,

Changes since RFC v2:
- because of MSVC limitations wrt macro passed via cmdline,
  used an internal header for defining RTE_EXPORT_* macros,
- updated documentation and tooling,

---
 MAINTAINERS                                |   2 +
 buildtools/gen-version-map.py              | 134 ++++++++++++
 buildtools/map-list-symbol.sh              |  10 +-
 buildtools/meson.build                     |   1 +
 devtools/check-symbol-change.py            | 108 ++++++++++
 devtools/check-symbol-maps.sh              |  14 --
 devtools/checkpatches.sh                   |   2 +-
 doc/guides/contributing/abi_versioning.rst | 227 ++-------------------
 drivers/meson.build                        |  98 +++++----
 drivers/version.map                        |   3 -
 lib/eal/common/eal_export.h                |  16 ++
 lib/meson.build                            |  96 ++++++---
 12 files changed, 415 insertions(+), 296 deletions(-)
 create mode 100755 buildtools/gen-version-map.py
 create mode 100755 devtools/check-symbol-change.py
 delete mode 100644 drivers/version.map
 create mode 100644 lib/eal/common/eal_export.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b01103f8e..42ea07854b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -95,6 +95,7 @@ F: devtools/check-maintainers.sh
 F: devtools/check-forbidden-tokens.awk
 F: devtools/check-git-log.sh
 F: devtools/check-spdx-tag.sh
+F: devtools/check-symbol-change.py
 F: devtools/check-symbol-change.sh
 F: devtools/check-symbol-maps.sh
 F: devtools/checkpatches.sh
@@ -127,6 +128,7 @@ F: config/
 F: buildtools/check-symbols.sh
 F: buildtools/chkincs/
 F: buildtools/call-sphinx-build.py
+F: buildtools/gen-version-map.py
 F: buildtools/get-cpu-count.py
 F: buildtools/get-numa-count.py
 F: buildtools/list-dir-globs.py
diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map.py
new file mode 100755
index 0000000000..c5ea10def0
--- /dev/null
+++ b/buildtools/gen-version-map.py
@@ -0,0 +1,134 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+"""Generate a version map file used by GNU or MSVC linker."""
+
+import argparse
+import re
+
+# From eal_export.h
+export_exp_sym_regexp = re.compile(
+    r"^RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+), ([0-9]+.[0-9]+)\)"
+)
+export_int_sym_regexp = re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
+export_sym_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
+# From rte_function_versioning.h
+ver_sym_regexp = re.compile(r"^VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
+ver_exp_sym_regexp = re.compile(r"^VERSION_SYMBOL_EXPERIMENTAL\([^,]+, ([^,]+)\)")
+default_sym_regexp = re.compile(r"^BIND_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+)\)")
+
+parser = argparse.ArgumentParser(
+    description=__doc__,
+    formatter_class=argparse.RawDescriptionHelpFormatter,
+)
+parser.add_argument(
+    "--linker", choices=["gnu", "mingw", "mslinker", ], required=True, help="Linker type"
+)
+parser.add_argument(
+    "--abi-version",
+    required=True,
+    type=argparse.FileType("r", encoding="utf-8"),
+    help="ABI version file",
+)
+parser.add_argument(
+    "--output",
+    required=True,
+    type=argparse.FileType("w", encoding="utf-8"),
+    help="Output file",
+)
+parser.add_argument(
+    "--source",
+    nargs="+",
+    required=True,
+    type=argparse.FileType("r", encoding="utf-8"),
+    help="Input source to parse",
+)
+args = parser.parse_args()
+
+ABI_MAJOR = re.match("([0-9]+).[0-9]", args.abi_version.readline()).group(1)
+ABI = f"DPDK_{ABI_MAJOR}"
+
+symbols = {}
+
+for file in args.source:
+    for ln in file.readlines():
+        node = None
+        symbol = None
+        comment = ""
+        if export_exp_sym_regexp.match(ln):
+            node = "EXPERIMENTAL"
+            symbol = export_exp_sym_regexp.match(ln).group(1)
+            version = export_exp_sym_regexp.match(ln).group(2)
+            comment = f" # added in {version}"
+        elif export_int_sym_regexp.match(ln):
+            node = "INTERNAL"
+            symbol = export_int_sym_regexp.match(ln).group(1)
+        elif export_sym_regexp.match(ln):
+            node = ABI
+            symbol = export_sym_regexp.match(ln).group(1)
+        elif ver_sym_regexp.match(ln):
+            abi = ver_sym_regexp.match(ln).group(2)
+            node = f"DPDK_{abi}"
+            symbol = ver_sym_regexp.match(ln).group(1)
+        elif ver_exp_sym_regexp.match(ln):
+            node = "EXPERIMENTAL"
+            symbol = ver_exp_sym_regexp.match(ln).group(1)
+        elif default_sym_regexp.match(ln):
+            abi = default_sym_regexp.match(ln).group(2)
+            node = f"DPDK_{abi}"
+            symbol = default_sym_regexp.match(ln).group(1)
+
+        if not symbol:
+            continue
+
+        if node not in symbols:
+            symbols[node] = {}
+        symbols[node][symbol] = comment
+
+if args.linker == "mslinker":
+    print("EXPORTS", file=args.output)
+    for key in (ABI, "EXPERIMENTAL", "INTERNAL"):
+        if key not in symbols:
+            continue
+        for symbol in sorted(symbols[key].keys()):
+            print(f"\t{symbol}", file=args.output)
+        del symbols[key]
+else:  # GNU format
+    local_token = False
+    for key in (ABI, "EXPERIMENTAL", "INTERNAL"):
+        if key not in symbols:
+            continue
+        print(f"{key} {{\n\tglobal:\n", file=args.output)
+        for symbol in sorted(symbols[key].keys()):
+            if args.linker == "mingw" and symbol.startswith("per_lcore"):
+                prefix = "__emutls_v."
+            else:
+                prefix = ""
+            comment = symbols[key][symbol]
+            print(f"\t{prefix}{symbol};{comment}", file=args.output)
+        if not local_token:
+            print("\n\tlocal: *;", file=args.output)
+            local_token = True
+        print("};", file=args.output)
+        del symbols[key]
+    for key in sorted(symbols.keys()):
+        print(f"{key} {{\n\tglobal:\n", file=args.output)
+        for symbol in sorted(symbols[key].keys()):
+            if args.linker == "mingw" and symbol.startswith("per_lcore"):
+                prefix = "__emutls_v."
+            else:
+                prefix = ""
+            comment = symbols[key][symbol]
+            print(f"\t{prefix}{symbol};{comment}", file=args.output)
+        print(f"}} {ABI};", file=args.output)
+        if not local_token:
+            print("\n\tlocal: *;", file=args.output)
+            local_token = True
+        del symbols[key]
+    # No exported symbol, add a catch all
+    if not local_token:
+        print(f"{ABI} {{", file=args.output)
+        print("\n\tlocal: *;", file=args.output)
+        local_token = True
+        print("};", file=args.output)
diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol.sh
index eb98451d8e..0829df4be5 100755
--- a/buildtools/map-list-symbol.sh
+++ b/buildtools/map-list-symbol.sh
@@ -62,10 +62,14 @@ for file in $@; do
 		if (current_section == "") {
 			next;
 		}
+		symbol_version = current_version
+		if (/^[^}].*[^:*]; # added in /) {
+			symbol_version = $5
+		}
 		if ("'$version'" != "") {
-			if ("'$version'" == "unset" && current_version != "") {
+			if ("'$version'" == "unset" && symbol_version != "") {
 				next;
-			} else if ("'$version'" != "unset" && "'$version'" != current_version) {
+			} else if ("'$version'" != "unset" && "'$version'" != symbol_version) {
 				next;
 			}
 		}
@@ -73,7 +77,7 @@ for file in $@; do
 		if ("'$symbol'" == "all" || $1 == "'$symbol'") {
 			ret = 0;
 			if ("'$quiet'" == "") {
-				print "'$file' "current_section" "$1" "current_version;
+				print "'$file' "current_section" "$1" "symbol_version;
 			}
 			if ("'$symbol'" != "all") {
 				exit 0;
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 4e2c1217a2..b745e9afa4 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -16,6 +16,7 @@ else
     py3 = ['meson', 'runpython']
 endif
 echo = py3 + ['-c', 'import sys; print(*sys.argv[1:])']
+gen_version_map = py3 + files('gen-version-map.py')
 list_dir_globs = py3 + files('list-dir-globs.py')
 map_to_win_cmd = py3 + files('map_to_win.py')
 sphinx_wrapper = py3 + files('call-sphinx-build.py')
diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
new file mode 100755
index 0000000000..1efeb82fcd
--- /dev/null
+++ b/devtools/check-symbol-change.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+"""Check exported symbols change in a patch."""
+
+import argparse
+import re
+
+file_header_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers)/([^/]+)/([^/]+)")
+# From eal_exports.h
+export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
+export_int_sym_regexp = re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
+export_sym_regexp = re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
+
+parser = argparse.ArgumentParser(
+    description=__doc__,
+    formatter_class=argparse.RawDescriptionHelpFormatter,
+)
+parser.add_argument(
+    "--patch",
+    nargs="+",
+    required=True,
+    type=argparse.FileType("r", encoding="utf-8"),
+    help="Input patch to parse",
+)
+args = parser.parse_args()
+
+symbols = {}
+
+for file in args.patch:
+    for ln in file.readlines():
+        if file_header_regexp.match(ln):
+            if file_header_regexp.match(ln).group(2) == "lib":
+                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
+            elif file_header_regexp.match(ln).group(3) == "intel":
+                lib = "/".join(file_header_regexp.match(ln).group(2, 3, 4))
+            else:
+                lib = "/".join(file_header_regexp.match(ln).group(2, 3))
+
+            if lib not in symbols:
+                symbols[lib] = {}
+            continue
+
+        if export_exp_sym_regexp.match(ln):
+            symbol = export_exp_sym_regexp.match(ln).group(1)
+            node = "EXPERIMENTAL"
+        elif export_int_sym_regexp.match(ln):
+            node = "INTERNAL"
+            symbol = export_int_sym_regexp.match(ln).group(1)
+        elif export_sym_regexp.match(ln):
+            symbol = export_sym_regexp.match(ln).group(1)
+            node = "stable"
+        else:
+            continue
+
+        if symbol not in symbols[lib]:
+            symbols[lib][symbol] = {}
+        added = ln[0] == "+"
+        if (
+            added
+            and "added" in symbols[lib][symbol]
+            and node != symbols[lib][symbol]["added"]
+        ):
+            print(f"{symbol} in {lib} was found in multiple ABI, please check.")
+        if (
+            not added
+            and "removed" in symbols[lib][symbol]
+            and node != symbols[lib][symbol]["removed"]
+        ):
+            print(f"{symbol} in {lib} was found in multiple ABI, please check.")
+        if added:
+            symbols[lib][symbol]["added"] = node
+        else:
+            symbols[lib][symbol]["removed"] = node
+
+    for lib in sorted(symbols.keys()):
+        error = False
+        for symbol in sorted(symbols[lib].keys()):
+            if "removed" not in symbols[lib][symbol]:
+                # Symbol addition
+                node = symbols[lib][symbol]["added"]
+                if node == "stable":
+                    print(
+                        f"ERROR: {symbol} in {lib} has been added directly to stable ABI."
+                    )
+                    error = True
+                else:
+                    print(f"INFO: {symbol} in {lib} has been added to {node} ABI.")
+                continue
+
+            if "added" not in symbols[lib][symbol]:
+                # Symbol removal
+                node = symbols[lib][symbol]["removed"]
+                if node == "stable":
+                    print(f"INFO: {symbol} in {lib} has been removed from stable ABI.")
+                    print("Please check it has gone though the deprecation process.")
+                continue
+
+            if symbols[lib][symbol]["added"] == symbols[lib][symbol]["removed"]:
+                # Symbol was moved around
+                continue
+
+            # Symbol modifications
+            added = symbols[lib][symbol]["added"]
+            removed = symbols[lib][symbol]["removed"]
+            print(f"INFO: {symbol} in {lib} is moving from {removed} to {added}")
+            print("Please check it has gone though the deprecation process.")
diff --git a/devtools/check-symbol-maps.sh b/devtools/check-symbol-maps.sh
index 6121f78ec6..fcd3931e5d 100755
--- a/devtools/check-symbol-maps.sh
+++ b/devtools/check-symbol-maps.sh
@@ -60,20 +60,6 @@ if [ -n "$local_miss_maps" ] ; then
     ret=1
 fi
 
-find_empty_maps ()
-{
-    for map in $@ ; do
-        [ $(buildtools/map-list-symbol.sh $map | wc -l) != '0' ] || echo $map
-    done
-}
-
-empty_maps=$(find_empty_maps $@)
-if [ -n "$empty_maps" ] ; then
-    echo "Found empty maps:"
-    echo "$empty_maps"
-    ret=1
-fi
-
 find_bad_format_maps ()
 {
     abi_version=$(cut -d'.' -f 1 ABI_VERSION)
diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index c9088bb403..9180c2b070 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
 PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
 SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
 LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
-NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG"
+NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
 options="$options $DPDK_CHECKPATCH_OPTIONS"
 
 print_usage () {
diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 7afd1c1886..b6b6bf64d7 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -58,12 +58,12 @@ persists over multiple releases.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/acl_exports.map
  DPDK_21 {
         global:
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/eal_exports.map
  DPDK_21 {
         global:
  ...
@@ -77,7 +77,7 @@ that library.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/acl_exports.map
  DPDK_21 {
         global:
  ...
@@ -88,7 +88,7 @@ that library.
  } DPDK_21;
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/eal_exports.map
  DPDK_21 {
         global:
  ...
@@ -100,12 +100,12 @@ how this may be done.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/acl_exports.map
  DPDK_22 {
         global:
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/eal_exports.map
  DPDK_22 {
         global:
  ...
@@ -134,8 +134,7 @@ linked to the DPDK.
 
 To support backward compatibility the ``rte_function_versioning.h``
 header file provides macros to use when updating exported functions. These
-macros are used in conjunction with the ``version.map`` file for
-a given library to allow multiple versions of a symbol to exist in a shared
+macros allow multiple versions of a symbol to exist in a shared
 library so that older binaries need not be immediately recompiled.
 
 The macros exported are:
@@ -176,6 +175,7 @@ Assume we have a function as follows
   * Create an acl context object for apps to
   * manipulate
   */
+ RTE_EXPORT_SYMBOL(rte_acl_create)
  struct rte_acl_ctx *
  rte_acl_create(const struct rte_acl_param *param)
  {
@@ -194,6 +194,7 @@ private, is safe), but it also requires modifying the code as follows
   * Create an acl context object for apps to
   * manipulate
   */
+ RTE_EXPORT_SYMBOL(rte_acl_create)
  struct rte_acl_ctx *
  rte_acl_create(const struct rte_acl_param *param, int debug)
  {
@@ -210,78 +211,16 @@ The addition of a parameter to the function is ABI breaking as the function is
 public, and existing application may use it in its current form. However, the
 compatibility macros in DPDK allow a developer to use symbol versioning so that
 multiple functions can be mapped to the same public symbol based on when an
-application was linked to it. To see how this is done, we start with the
-requisite libraries version map file. Initially the version map file for the acl
-library looks like this
+application was linked to it.
 
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-
-        rte_acl_add_rules;
-        rte_acl_build;
-        rte_acl_classify;
-        rte_acl_classify_alg;
-        rte_acl_classify_scalar;
-        rte_acl_create;
-        rte_acl_dump;
-        rte_acl_find_existing;
-        rte_acl_free;
-        rte_acl_ipv4vlan_add_rules;
-        rte_acl_ipv4vlan_build;
-        rte_acl_list_dump;
-        rte_acl_reset;
-        rte_acl_reset_rules;
-        rte_acl_set_ctx_classify;
-
-        local: *;
-   };
-
-This file needs to be modified as follows
-
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-
-        rte_acl_add_rules;
-        rte_acl_build;
-        rte_acl_classify;
-        rte_acl_classify_alg;
-        rte_acl_classify_scalar;
-        rte_acl_create;
-        rte_acl_dump;
-        rte_acl_find_existing;
-        rte_acl_free;
-        rte_acl_ipv4vlan_add_rules;
-        rte_acl_ipv4vlan_build;
-        rte_acl_list_dump;
-        rte_acl_reset;
-        rte_acl_reset_rules;
-        rte_acl_set_ctx_classify;
-
-        local: *;
-   };
-
-   DPDK_22 {
-        global:
-        rte_acl_create;
-
-   } DPDK_21;
-
-The addition of the new block tells the linker that a new version node
-``DPDK_22`` is available, which contains the symbol rte_acl_create, and inherits
-the symbols from the DPDK_21 node. This list is directly translated into a
-list of exported symbols when DPDK is compiled as a shared library.
-
-Next, we need to specify in the code which function maps to the rte_acl_create
+We need to specify in the code which function maps to the rte_acl_create
 symbol at which versions.  First, at the site of the initial symbol definition,
 we need to update the function so that it is uniquely named, and not in conflict
 with the public symbol name
 
 .. code-block:: c
 
+ -RTE_EXPORT_SYMBOL(rte_acl_create)
  -struct rte_acl_ctx *
  -rte_acl_create(const struct rte_acl_param *param)
  +struct rte_acl_ctx * __vsym
@@ -358,9 +297,9 @@ such that it contains both versions of the symbol and the public API.
    rte_acl_create_v22(const struct rte_acl_param *param, int debug);
 
 
-And that's it, on the next shared library rebuild, there will be two versions of
-rte_acl_create, an old DPDK_21 version, used by previously built applications,
-and a new DPDK_22 version, used by future built applications.
+And that's it. On the next shared library rebuild, there will be two versions of rte_acl_create,
+an old DPDK_21 version, used by previously built applications, and a new DPDK_22 version,
+used by newly built applications.
 
 .. note::
 
@@ -443,6 +382,7 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
     * Create an acl context object for apps to
     * manipulate
     */
+   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_create)
    __rte_experimental
    struct rte_acl_ctx *
    rte_acl_create(const struct rte_acl_param *param)
@@ -450,27 +390,8 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
    ...
    }
 
-In the map file, experimental symbols are listed as part of the ``EXPERIMENTAL``
-version node.
-
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-        ...
-
-        local: *;
-   };
-
-   EXPERIMENTAL {
-        global:
-
-        rte_acl_create;
-   };
-
 When we promote the symbol to the stable ABI, we simply strip the
-``__rte_experimental`` annotation from the function and move the symbol from the
-``EXPERIMENTAL`` node, to the node of the next major ABI version as follow.
+``__rte_experimental`` annotation from the function.
 
 .. code-block:: c
 
@@ -478,31 +399,13 @@ When we promote the symbol to the stable ABI, we simply strip the
     * Create an acl context object for apps to
     * manipulate
     */
+   RTE_EXPORT_SYMBOL(rte_acl_create)
    struct rte_acl_ctx *
    rte_acl_create(const struct rte_acl_param *param)
    {
           ...
    }
 
-We then update the map file, adding the symbol ``rte_acl_create``
-to the ``DPDK_22`` version node.
-
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-        ...
-
-        local: *;
-   };
-
-   DPDK_22 {
-        global:
-
-        rte_acl_create;
-   } DPDK_21;
-
-
 Although there are strictly no guarantees or commitments associated with
 :ref:`experimental symbols <experimental_apis>`, a maintainer may wish to offer
 an alias to experimental. The process to add an alias to experimental,
@@ -519,6 +422,7 @@ and ``DPDK_22`` version nodes.
     * Create an acl context object for apps to
     * manipulate
     */
+   RTE_EXPORT_SYMBOL(rte_acl_create)
    struct rte_acl_ctx *
    rte_acl_create(const struct rte_acl_param *param)
    {
@@ -540,37 +444,6 @@ and ``DPDK_22`` version nodes.
    }
    BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
 
-In the map file, we map the symbol to both the ``EXPERIMENTAL``
-and ``DPDK_22`` version nodes.
-
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-        ...
-
-        local: *;
-   };
-
-   DPDK_22 {
-        global:
-
-        rte_acl_create;
-   } DPDK_21;
-
-   EXPERIMENTAL {
-        global:
-
-        rte_acl_create;
-   };
-
-.. note::
-
-   Please note, similar to :ref:`symbol versioning <example_abi_macro_usage>`,
-   when aliasing to experimental you will also need to take care of
-   :ref:`mapping static symbols <mapping_static_symbols>`.
-
-
 .. _abi_deprecation:
 
 Deprecating part of a public API
@@ -579,38 +452,7 @@ ________________________________
 Lets assume that you've done the above updates, and in preparation for the next
 major ABI version you decide you would like to retire the old version of the
 function. After having gone through the ABI deprecation announcement process,
-removal is easy. Start by removing the symbol from the requisite version map
-file:
-
-.. code-block:: none
-
-   DPDK_21 {
-        global:
-
-        rte_acl_add_rules;
-        rte_acl_build;
-        rte_acl_classify;
-        rte_acl_classify_alg;
-        rte_acl_classify_scalar;
-        rte_acl_dump;
- -      rte_acl_create
-        rte_acl_find_existing;
-        rte_acl_free;
-        rte_acl_ipv4vlan_add_rules;
-        rte_acl_ipv4vlan_build;
-        rte_acl_list_dump;
-        rte_acl_reset;
-        rte_acl_reset_rules;
-        rte_acl_set_ctx_classify;
-
-        local: *;
-   };
-
-   DPDK_22 {
-        global:
-        rte_acl_create;
-   } DPDK_21;
-
+removal is easy.
 
 Next remove the corresponding versioned export.
 
@@ -634,36 +476,9 @@ of a major ABI version. If a version node completely specifies an API, then
 removing part of it, typically makes it incomplete. In those cases it is better
 to remove the entire node.
 
-To do this, start by modifying the version map file, such that all symbols from
-the node to be removed are merged into the next node in the map.
-
-In the case of our map above, it would transform to look as follows
-
-.. code-block:: none
-
-   DPDK_22 {
-        global:
-
-        rte_acl_add_rules;
-        rte_acl_build;
-        rte_acl_classify;
-        rte_acl_classify_alg;
-        rte_acl_classify_scalar;
-        rte_acl_dump;
-        rte_acl_create
-        rte_acl_find_existing;
-        rte_acl_free;
-        rte_acl_ipv4vlan_add_rules;
-        rte_acl_ipv4vlan_build;
-        rte_acl_list_dump;
-        rte_acl_reset;
-        rte_acl_reset_rules;
-        rte_acl_set_ctx_classify;
-
-        local: *;
  };
 
-Then any uses of BIND_DEFAULT_SYMBOL that pointed to the old node should be
+Any uses of BIND_DEFAULT_SYMBOL that pointed to the old node should be
 updated to point to the new version node in any header files for all affected
 symbols.
 
diff --git a/drivers/meson.build b/drivers/meson.build
index c15319dc24..ff0cb2e02d 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -275,14 +275,14 @@ foreach subpath:subdirs
                 dependencies: static_deps,
                 c_args: cflags)
         objs += tmp_lib.extract_all_objects(recursive: true)
-        sources = custom_target(out_filename,
+        sources_pmd_info = custom_target(out_filename,
                 command: [pmdinfo, tmp_lib.full_path(), '@OUTPUT@', pmdinfogen],
                 output: out_filename,
                 depends: [tmp_lib])
 
         # now build the static driver
         static_lib = static_library(lib_name,
-                sources,
+                sources_pmd_info,
                 objects: objs,
                 include_directories: includes,
                 dependencies: static_deps,
@@ -292,48 +292,72 @@ foreach subpath:subdirs
         # now build the shared driver
         version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), drv_path)
 
-        lk_deps = []
-        lk_args = []
         if not fs.is_file(version_map)
-            version_map = '@0@/version.map'.format(meson.current_source_dir())
-            lk_deps += [version_map]
-        else
-            lk_deps += [version_map]
-            if not is_windows and developer_mode
-                # on unix systems check the output of the
-                # check-symbols.sh script, using it as a
-                # dependency of the .so build
-                lk_deps += custom_target(lib_name + '.sym_chk',
-                        command: [check_symbols, version_map, '@INPUT@'],
-                        capture: true,
-                        input: static_lib,
-                        output: lib_name + '.sym_chk')
-            endif
-        endif
-
-        if is_windows
             if is_ms_linker
-                def_file = custom_target(lib_name + '_def',
-                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
-                        input: version_map,
-                        output: '@0@_exports.def'.format(lib_name))
-                lk_deps += [def_file]
-
-                lk_args = ['-Wl,/def:' + def_file.full_path()]
+                link_mode = 'mslinker'
+            elif is_windows
+                link_mode = 'mingw'
             else
-                mingw_map = custom_target(lib_name + '_mingw',
-                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
-                        input: version_map,
-                        output: '@0@_mingw.map'.format(lib_name))
-                lk_deps += [mingw_map]
-
-                lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
+                link_mode = 'gnu'
+            endif
+            version_map = custom_target(lib_name + '_map',
+                    command: [gen_version_map, '--linker', link_mode,
+                              '--abi-version', abi_version_file, '--output', '@OUTPUT@',
+                              '--source', '@INPUT@'],
+                    input: sources + sources_avx2 + sources_avx512,
+                    output: '_'.join([class, name, 'exports.map']))
+            version_map_path = version_map.full_path()
+            version_map_dep = [version_map]
+            lk_deps = [version_map]
+
+            if is_ms_linker and is_ms_compiler
+                lk_args = ['/def:' + version_map.full_path()]
+            elif is_ms_linker
+                lk_args = ['-Wl,/def:' + version_map.full_path()]
+            else
+                lk_args = ['-Wl,--version-script=' + version_map.full_path()]
             endif
         else
-            lk_args = ['-Wl,--version-script=' + version_map]
+            version_map_path = version_map
+            version_map_dep = []
+            lk_deps = [version_map]
+
+            if is_windows
+                if is_ms_linker
+                    def_file = custom_target(lib_name + '_def',
+                            command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
+                            input: version_map,
+                            output: '@0@_exports.def'.format(lib_name))
+                    lk_deps += [def_file]
+
+                    lk_args = ['-Wl,/def:' + def_file.full_path()]
+                else
+                    mingw_map = custom_target(lib_name + '_mingw',
+                            command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
+                            input: version_map,
+                            output: '@0@_mingw.map'.format(lib_name))
+                    lk_deps += [mingw_map]
+
+                    lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
+                endif
+            else
+                lk_args = ['-Wl,--version-script=' + version_map]
+            endif
+        endif
+
+        if not is_windows and developer_mode
+            # on unix systems check the output of the
+            # check-symbols.sh script, using it as a
+            # dependency of the .so build
+            lk_deps += custom_target(lib_name + '.sym_chk',
+                    command: [check_symbols, version_map_path, '@INPUT@'],
+                    capture: true,
+                    input: static_lib,
+                    output: lib_name + '.sym_chk',
+                    depends: version_map_dep)
         endif
 
-        shared_lib = shared_library(lib_name, sources,
+        shared_lib = shared_library(lib_name, sources_pmd_info,
                 objects: objs,
                 include_directories: includes,
                 dependencies: shared_deps,
diff --git a/drivers/version.map b/drivers/version.map
deleted file mode 100644
index 17cc97bda6..0000000000
--- a/drivers/version.map
+++ /dev/null
@@ -1,3 +0,0 @@
-DPDK_25 {
-	local: *;
-};
diff --git a/lib/eal/common/eal_export.h b/lib/eal/common/eal_export.h
new file mode 100644
index 0000000000..7904ed851c
--- /dev/null
+++ b/lib/eal/common/eal_export.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#ifndef EAL_EXPORT_H
+#define EAL_EXPORT_H
+
+/* Internal macros for exporting symbols, used by the build system.
+ * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
+ * version this symbol was introduced in.
+ */
+#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(symbol, ver)
+#define RTE_EXPORT_INTERNAL_SYMBOL(symbol)
+#define RTE_EXPORT_SYMBOL(symbol)
+
+#endif /* EAL_EXPORT_H */
diff --git a/lib/meson.build b/lib/meson.build
index 91efc65c4b..51d44bfd41 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2019 Intel Corporation
 
+fs = import('fs')
 
 # process all libraries equally, as far as possible
 # "core" libs first, then others alphabetically as far as possible
@@ -137,9 +138,12 @@ foreach l:libraries
     # external package/library requirements
     ext_deps = []
     deps = []
-    # eal is standard dependency once built
     if dpdk_conf.has('RTE_LIB_EAL')
+        # eal is standard dependency once built
         deps += ['eal']
+    else
+        # otherwise, make private headers available (like eal_export.h)
+        includes += include_directories('eal/common')
     endif
 
     if dpdk_libs_deprecated.contains(l)
@@ -285,42 +289,60 @@ foreach l:libraries
             include_directories: includes,
             dependencies: static_deps)
 
-    if not use_function_versioning or is_windows
-        # use pre-build objects to build shared lib
-        sources = []
-        objs += static_lib.extract_all_objects(recursive: false)
-    else
-        # for compat we need to rebuild with
-        # RTE_BUILD_SHARED_LIB defined
-        cflags += '-DRTE_BUILD_SHARED_LIB'
-    endif
-
-    version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), l)
-    lk_deps = [version_map]
-
-    if is_ms_linker
-        def_file = custom_target(libname + '_def',
-                command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
-                input: version_map,
-                output: '@0@_exports.def'.format(libname))
-        lk_deps += [def_file]
+    if not fs.is_file('@0@/@1@/version.map'.format(meson.current_source_dir(), l))
+        if is_ms_linker
+            link_mode = 'mslinker'
+        elif is_windows
+            link_mode = 'mingw'
+        else
+            link_mode = 'gnu'
+        endif
+        version_map = custom_target(libname + '_map',
+                command: [gen_version_map, '--linker', link_mode,
+                          '--abi-version', abi_version_file, '--output', '@OUTPUT@',
+                          '--source', '@INPUT@'],
+                input: sources,
+                output: '_'.join([name, 'exports.map']))
+        version_map_path = version_map.full_path()
+        version_map_dep = [version_map]
+        lk_deps = [version_map]
 
-        if is_ms_compiler
-            lk_args = ['/def:' + def_file.full_path()]
+        if is_ms_linker and is_ms_compiler
+            lk_args = ['/def:' + version_map.full_path()]
+        elif is_ms_linker
+            lk_args = ['-Wl,/def:' + version_map.full_path()]
         else
-            lk_args = ['-Wl,/def:' + def_file.full_path()]
+            lk_args = ['-Wl,--version-script=' + version_map.full_path()]
         endif
     else
-        if is_windows
-            mingw_map = custom_target(libname + '_mingw',
+        version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), l)
+        version_map_path = version_map
+        version_map_dep = []
+        lk_deps = [version_map]
+        if is_ms_linker
+            def_file = custom_target(libname + '_def',
                     command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
                     input: version_map,
-                    output: '@0@_mingw.map'.format(libname))
-            lk_deps += [mingw_map]
+                    output: '@0@_exports.def'.format(libname))
+            lk_deps += [def_file]
 
-            lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
+            if is_ms_compiler
+                lk_args = ['/def:' + def_file.full_path()]
+            else
+                lk_args = ['-Wl,/def:' + def_file.full_path()]
+            endif
         else
-            lk_args = ['-Wl,--version-script=' + version_map]
+            if is_windows
+                mingw_map = custom_target(libname + '_mingw',
+                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
+                        input: version_map,
+                        output: '@0@_mingw.map'.format(libname))
+                lk_deps += [mingw_map]
+
+                lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
+            else
+                lk_args = ['-Wl,--version-script=' + version_map]
+            endif
         endif
     endif
 
@@ -329,11 +351,21 @@ foreach l:libraries
         # check-symbols.sh script, using it as a
         # dependency of the .so build
         lk_deps += custom_target(name + '.sym_chk',
-                command: [check_symbols,
-                    version_map, '@INPUT@'],
+                command: [check_symbols, version_map_path, '@INPUT@'],
                 capture: true,
                 input: static_lib,
-                output: name + '.sym_chk')
+                output: name + '.sym_chk',
+                depends: version_map_dep)
+    endif
+
+    if not use_function_versioning or is_windows
+        # use pre-build objects to build shared lib
+        sources = []
+        objs += static_lib.extract_all_objects(recursive: false)
+    else
+        # for compat we need to rebuild with
+        # RTE_BUILD_SHARED_LIB defined
+        cflags += '-DRTE_BUILD_SHARED_LIB'
     endif
 
     shared_lib = shared_library(libname,
-- 
2.49.0

