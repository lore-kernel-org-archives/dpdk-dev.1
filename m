Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9CC28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 09:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD4D40658;
	Tue, 11 Mar 2025 10:56:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4631640659
 for <dev@dpdk.org>; Tue, 11 Mar 2025 10:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741687010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueJsVzdFd/sI1+PoVniauWHLObooYbfiEfc4AjbhrkI=;
 b=axTnWwFLLFGWUD+6xi08CsQ9+a/In/3DPdBE4NoD9/GIgQIVtcP7X5TubdGBMkI1+wxmsL
 HX7KJT4itvYEMfbGVN4CsKCcg3LFM2XU9ECgXEHy/E4E7QiTer6cVRXKuuPhew0DiZjpw+
 9ouddgcwiVb/Y/J16i1BMROg245QQbc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-3WCS4i6NMqOI64Dbb04bRA-1; Tue,
 11 Mar 2025 05:56:47 -0400
X-MC-Unique: 3WCS4i6NMqOI64Dbb04bRA-1
X-Mimecast-MFC-AGG-ID: 3WCS4i6NMqOI64Dbb04bRA_1741687006
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AE3D1800A36; Tue, 11 Mar 2025 09:56:46 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43DBF30001A2; Tue, 11 Mar 2025 09:56:44 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC v3 5/8] build: generate symbol maps
Date: Tue, 11 Mar 2025 10:56:03 +0100
Message-ID: <20250311095609.194523-6-david.marchand@redhat.com>
In-Reply-To: <20250311095609.194523-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UVIIEivE-C-y5WTGIQ8pQyTI5FjK-MTlp2RNbNAesa0_1741687006
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
Changes since RFC v2:
- because of MSVC limitations wrt macro passed via cmdline,
  used an internal header for defining RTE_EXPORT_* macros,
- updated documentation and tooling,

---
 MAINTAINERS                                |   2 +
 buildtools/gen-version-map.py              | 111 ++++++++++
 buildtools/map-list-symbol.sh              |  10 +-
 buildtools/meson.build                     |   1 +
 config/meson.build                         |   2 +
 config/rte_export.h                        |  16 ++
 devtools/check-symbol-change.py            |  90 +++++++++
 devtools/check-symbol-maps.sh              |  14 --
 devtools/checkpatches.sh                   |   2 +-
 doc/guides/contributing/abi_versioning.rst | 224 ++-------------------
 drivers/meson.build                        |  94 +++++----
 drivers/version.map                        |   3 -
 lib/meson.build                            |  91 ++++++---
 13 files changed, 371 insertions(+), 289 deletions(-)
 create mode 100755 buildtools/gen-version-map.py
 create mode 100644 config/rte_export.h
 create mode 100755 devtools/check-symbol-change.py
 delete mode 100644 drivers/version.map

diff --git a/MAINTAINERS b/MAINTAINERS
index 312e6fcee5..04772951d3 100644
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
index 0000000000..b160aa828b
--- /dev/null
+++ b/buildtools/gen-version-map.py
@@ -0,0 +1,111 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2024 Red Hat, Inc.
+
+"""Generate a version map file used by GNU or MSVC linker."""
+
+import re
+import sys
+
+# From rte_export.h
+export_exp_sym_regexp = re.compile(r"^RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+), ([0-9]+.[0-9]+)\)")
+export_int_sym_regexp = re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
+export_sym_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
+# From rte_function_versioning.h
+ver_sym_regexp = re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+ver_exp_sym_regexp = re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
+default_sym_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+
+with open(sys.argv[2]) as f:
+    abi = 'DPDK_{}'.format(re.match("([0-9]+).[0-9]", f.readline()).group(1))
+
+symbols = {}
+
+for file in sys.argv[4:]:
+    with open(file, encoding="utf-8") as f:
+        for ln in f.readlines():
+            node = None
+            symbol = None
+            comment = None
+            if export_exp_sym_regexp.match(ln):
+                node = 'EXPERIMENTAL'
+                symbol = export_exp_sym_regexp.match(ln).group(1)
+                comment = ' # added in {}'.format(export_exp_sym_regexp.match(ln).group(2))
+            elif export_int_sym_regexp.match(ln):
+                node = 'INTERNAL'
+                symbol = export_int_sym_regexp.match(ln).group(1)
+            elif export_sym_regexp.match(ln):
+                node = abi
+                symbol = export_sym_regexp.match(ln).group(1)
+            elif ver_sym_regexp.match(ln):
+                node = 'DPDK_{}'.format(ver_sym_regexp.match(ln).group(1))
+                symbol = ver_sym_regexp.match(ln).group(2)
+            elif ver_exp_sym_regexp.match(ln):
+                node = 'EXPERIMENTAL'
+                symbol = ver_exp_sym_regexp.match(ln).group(1)
+            elif default_sym_regexp.match(ln):
+                node = 'DPDK_{}'.format(default_sym_regexp.match(ln).group(1))
+                symbol = default_sym_regexp.match(ln).group(2)
+
+            if not symbol:
+                continue
+
+            if node not in symbols:
+                symbols[node] = {}
+            symbols[node][symbol] = comment
+
+if sys.argv[1] == 'msvc':
+    with open(sys.argv[3], "w") as outfile:
+        outfile.writelines(f"EXPORTS\n")
+        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
+            if key not in symbols:
+                continue
+            for symbol in sorted(symbols[key].keys()):
+                outfile.writelines(f"\t{symbol}\n")
+            del symbols[key]
+else:
+    with open(sys.argv[3], "w") as outfile:
+        local_token = False
+        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
+            if key not in symbols:
+                continue
+            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
+            for symbol in sorted(symbols[key].keys()):
+                if sys.argv[1] == 'mingw' and symbol.startswith('per_lcore'):
+                    prefix = '__emutls_v.'
+                else:
+                    prefix = ''
+                outfile.writelines(f"\t{prefix}{symbol};")
+                comment = symbols[key][symbol]
+                if comment:
+                    outfile.writelines(f"{comment}")
+                outfile.writelines("\n")
+            outfile.writelines("\n")
+            if not local_token:
+                outfile.writelines("\tlocal: *;\n")
+                local_token = True
+            outfile.writelines("};\n")
+            del symbols[key]
+        for key in sorted(symbols.keys()):
+            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
+            for symbol in sorted(symbols[key].keys()):
+                if sys.argv[1] == 'mingw' and symbol.startswith('per_lcore'):
+                    prefix = '__emutls_v.'
+                else:
+                    prefix = ''
+                outfile.writelines(f"\t{prefix}{symbol};")
+                comment = symbols[key][symbol]
+                if comment:
+                    outfile.writelines(f"{comment}")
+                outfile.writelines("\n")
+            outfile.writelines(f"}} {abi};\n")
+            if not local_token:
+                outfile.writelines("\tlocal: *;\n")
+                local_token = True
+            del symbols[key]
+        # No exported symbol, add a catch all
+        if not local_token:
+            outfile.writelines(f"{abi} {{\n")
+            outfile.writelines("\tlocal: *;\n")
+            local_token = True
+            outfile.writelines("};\n")
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
diff --git a/config/meson.build b/config/meson.build
index f31fef216c..54657055fb 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -303,8 +303,10 @@ endif
 # add -include rte_config to cflags
 if is_ms_compiler
     add_project_arguments('/FI', 'rte_config.h', language: 'c')
+    add_project_arguments('/FI', 'rte_export.h', language: 'c')
 else
     add_project_arguments('-include', 'rte_config.h', language: 'c')
+    add_project_arguments('-include', 'rte_export.h', language: 'c')
 endif
 
 # enable extra warnings and disable any unwanted warnings
diff --git a/config/rte_export.h b/config/rte_export.h
new file mode 100644
index 0000000000..83d871fe11
--- /dev/null
+++ b/config/rte_export.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Red Hat, Inc.
+ */
+
+#ifndef RTE_EXPORT_H
+#define RTE_EXPORT_H
+
+/* *Internal* macros for exporting symbols, used by the build system.
+ * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
+ * version this symbol was introduced in.
+ */
+#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
+#define RTE_EXPORT_INTERNAL_SYMBOL(a)
+#define RTE_EXPORT_SYMBOL(a)
+
+#endif /* RTE_EXPORT_H */
diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-change.py
new file mode 100755
index 0000000000..09709e4f06
--- /dev/null
+++ b/devtools/check-symbol-change.py
@@ -0,0 +1,90 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+"""Check exported symbols change in a patch."""
+
+import re
+import sys
+
+file_header_regexp = re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers)/([^/]+)/([^/]+)")
+# From rte_export.h
+export_exp_sym_regexp = re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBOL\(([^,]+),")
+export_int_sym_regexp = re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\(([^)]+)\)")
+export_sym_regexp = re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
+# TODO, handle versioned symbols from rte_function_versioning.h
+# ver_sym_regexp = re.compile(r"^.RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+# ver_exp_sym_regexp = re.compile(r"^.RTE_VERSION_EXPERIMENTAL_SYMBOL\([^,]+, ([^,]+),")
+# default_sym_regexp = re.compile(r"^.RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+
+symbols = {}
+
+for file in sys.argv[1:]:
+    with open(file, encoding="utf-8") as f:
+        for ln in f.readlines():
+            if file_header_regexp.match(ln):
+                if file_header_regexp.match(ln).group(2) == "lib":
+                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))
+                elif file_header_regexp.match(ln).group(3) == "intel":
+                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3, 4))
+                else:
+                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))
+
+                if lib not in symbols:
+                    symbols[lib] = {}
+                continue
+
+            if export_exp_sym_regexp.match(ln):
+                symbol = export_exp_sym_regexp.match(ln).group(1)
+                node = 'EXPERIMENTAL'
+            elif export_int_sym_regexp.match(ln):
+                node = 'INTERNAL'
+                symbol = export_int_sym_regexp.match(ln).group(1)
+            elif export_sym_regexp.match(ln):
+                symbol = export_sym_regexp.match(ln).group(1)
+                node = 'stable'
+            else:
+                continue
+
+            if symbol not in symbols[lib]:
+                symbols[lib][symbol] = {}
+            added = ln[0] == '+'
+            if added and 'added' in symbols[lib][symbol] and node != symbols[lib][symbol]['added']:
+                print(f"{symbol} in {lib} was found in multiple ABI, please check.")
+            if not added and 'removed' in symbols[lib][symbol] and node != symbols[lib][symbol]['removed']:
+                print(f"{symbol} in {lib} was found in multiple ABI, please check.")
+            if added:
+                symbols[lib][symbol]['added'] = node
+            else:
+                symbols[lib][symbol]['removed'] = node
+
+    for lib in sorted(symbols.keys()):
+        error = False
+        for symbol in sorted(symbols[lib].keys()):
+            if 'removed' not in symbols[lib][symbol]:
+                # Symbol addition
+                node = symbols[lib][symbol]['added']
+                if node == 'stable':
+                    print(f"ERROR: {symbol} in {lib} has been added directly to stable ABI.")
+                    error = True
+                else:
+                    print(f"INFO: {symbol} in {lib} has been added to {node} ABI.")
+                continue
+
+            if 'added' not in symbols[lib][symbol]:
+                # Symbol removal
+                node = symbols[lib][symbol]['added']
+                if node == 'stable':
+                    print(f"INFO: {symbol} in {lib} has been removed from stable ABI.")
+                    print(f"Please check it has gone though the deprecation process.")
+                continue
+
+            if symbols[lib][symbol]['added'] == symbols[lib][symbol]['removed']:
+                # Symbol was moved around
+                continue
+
+            # Symbol modifications
+            added = symbols[lib][symbol]['added']
+            removed = symbols[lib][symbol]['removed']
+            print(f"INFO: {symbol} in {lib} is moving from {removed} to {added}")
+            print(f"Please check it has gone though the deprecation process.")
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
index 003bb49e04..7dcac7c8c9 100755
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
index 88dd776b4c..addbb24b9e 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -58,12 +58,12 @@ persists over multiple releases.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/librte_acl_exports.map
  DPDK_21 {
         global:
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/librte_eal_exports.map
  DPDK_21 {
         global:
  ...
@@ -77,7 +77,7 @@ that library.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/librte_acl_exports.map
  DPDK_21 {
         global:
  ...
@@ -88,7 +88,7 @@ that library.
  } DPDK_21;
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/librte_eal_exports.map
  DPDK_21 {
         global:
  ...
@@ -100,12 +100,12 @@ how this may be done.
 
 .. code-block:: none
 
- $ head ./lib/acl/version.map
+ $ head ./build/lib/librte_acl_exports.map
  DPDK_22 {
         global:
  ...
 
- $ head ./lib/eal/version.map
+ $ head ./build/lib/librte_eal_exports.map
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
 
 The macros are:
@@ -169,6 +168,7 @@ Assume we have a function as follows
   * Create an acl context object for apps to
   * manipulate
   */
+ RTE_EXPORT_SYMBOL(rte_acl_create)
  struct rte_acl_ctx *
  rte_acl_create(const struct rte_acl_param *param)
  {
@@ -187,6 +187,7 @@ private, is safe), but it also requires modifying the code as follows
   * Create an acl context object for apps to
   * manipulate
   */
+ RTE_EXPORT_SYMBOL(rte_acl_create)
  struct rte_acl_ctx *
  rte_acl_create(const struct rte_acl_param *param, int debug)
  {
@@ -203,78 +204,16 @@ The addition of a parameter to the function is ABI breaking as the function is
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
 we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current ABI version,
-the function return type, and the function name and its arguments.
+the function return type, the function name and its arguments.
 
 .. code-block:: c
 
+ -RTE_EXPORT_SYMBOL(rte_acl_create)
  -struct rte_acl_ctx *
  -rte_acl_create(const struct rte_acl_param *param)
  +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const struct rte_acl_param *param))
@@ -293,6 +232,7 @@ We have now mapped the original rte_acl_create symbol to the original function
 
 Please see the section :ref:`Enabling versioning macros
 <enabling_versioning_macros>` to enable this macro in the meson/ninja build.
+
 Next, we need to create the new version of the symbol. We create a new
 function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
 
@@ -312,9 +252,9 @@ The macro instructs the linker to create the new default symbol
 ``rte_acl_create@DPDK_22``, which points to the function named ``rte_acl_create_v22``
 (declared by the macro).
 
-And that's it, on the next shared library rebuild, there will be two versions of
-rte_acl_create, an old DPDK_21 version, used by previously built applications,
-and a new DPDK_22 version, used by future built applications.
+And that's it. On the next shared library rebuild, there will be two versions of rte_acl_create,
+an old DPDK_21 version, used by previously built applications, and a new DPDK_22 version,
+used by future built applications.
 
 .. note::
 
@@ -364,6 +304,7 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
     * Create an acl context object for apps to
     * manipulate
     */
+   RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_create)
    __rte_experimental
    struct rte_acl_ctx *
    rte_acl_create(const struct rte_acl_param *param)
@@ -371,27 +312,8 @@ Assume we have an experimental function ``rte_acl_create`` as follows:
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
 
@@ -399,31 +321,13 @@ When we promote the symbol to the stable ABI, we simply strip the
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
@@ -452,30 +356,6 @@ and ``DPDK_22`` version nodes.
       return rte_acl_create(param);
    }
 
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
 .. _abi_deprecation:
 
 Deprecating part of a public API
@@ -484,38 +364,7 @@ ________________________________
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
 
@@ -539,36 +388,7 @@ of a major ABI version. If a version node completely specifies an API, then
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
- };
-
-Then any uses of RTE_DEFAULT_SYMBOL that pointed to the old node should be
+Any uses of RTE_DEFAULT_SYMBOL that pointed to the old node should be
 updated to point to the new version node in any header files for all affected
 symbols.
 
diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..c8bc556f1a 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -245,14 +245,14 @@ foreach subpath:subdirs
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
@@ -262,48 +262,72 @@ foreach subpath:subdirs
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
+            if is_ms_linker
+                link_mode = 'msvc'
+            elif is_windows
+                link_mode = 'mingw'
+            else
+                link_mode = 'gnu'
             endif
-        endif
+            version_map = custom_target(lib_name + '_map',
+                    command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
+                    input: sources,
+                    output: 'lib@0@_exports.map'.format(lib_name))
+            version_map_path = version_map.full_path()
+            version_map_dep = [version_map]
+            lk_deps = [version_map]
 
-        if is_windows
             if is_ms_linker
-                def_file = custom_target(lib_name + '_def',
-                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
-                        input: version_map,
-                        output: '@0@_exports.def'.format(lib_name))
-                lk_deps += [def_file]
-
-                lk_args = ['-Wl,/def:' + def_file.full_path()]
+                if is_ms_compiler
+                    lk_args = ['/def:' + version_map.full_path()]
+                else
+                    lk_args = ['-Wl,/def:' + version_map.full_path()]
+                endif
             else
-                mingw_map = custom_target(lib_name + '_mingw',
-                        command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
-                        input: version_map,
-                        output: '@0@_mingw.map'.format(lib_name))
-                lk_deps += [mingw_map]
-
-                lk_args = ['-Wl,--version-script=' + mingw_map.full_path()]
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
diff --git a/lib/meson.build b/lib/meson.build
index ce92cb5537..b6bac02b48 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2019 Intel Corporation
 
+fs = import('fs')
 
 # process all libraries equally, as far as possible
 # "core" libs first, then others alphabetically as far as possible
@@ -254,42 +255,60 @@ foreach l:libraries
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
+            link_mode = 'msvc'
+        elif is_windows
+            link_mode = 'mingw'
+        else
+            link_mode = 'gnu'
+        endif
+        version_map = custom_target(libname + '_map',
+                command: [gen_version_map, link_mode, abi_version_file, '@OUTPUT@', '@INPUT@'],
+                input: sources,
+                output: 'lib@0@_exports.map'.format(libname))
+        version_map_path = version_map.full_path()
+        version_map_dep = [version_map]
+        lk_deps = [version_map]
 
-        if is_ms_compiler
-            lk_args = ['/def:' + def_file.full_path()]
+        if is_ms_linker
+            if is_ms_compiler
+                lk_args = ['/def:' + version_map.full_path()]
+            else
+                lk_args = ['-Wl,/def:' + version_map.full_path()]
+            endif
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
 
@@ -298,11 +317,21 @@ foreach l:libraries
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
2.48.1

