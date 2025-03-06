Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CEBC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 12:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E02BC40663;
	Thu,  6 Mar 2025 13:50:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C39DC40665
 for <dev@dpdk.org>; Thu,  6 Mar 2025 13:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741265437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZ/D4LuLcC5c5BQqsCfDNRynVE099ilLN2nqHanHNFg=;
 b=is60SBsDf/w6i+n9FeKF0z8yIt8nkwD3lxO+hSEWVk23SdeDomA+PjqKe0eFxGS7+0AlXb
 nIDOJTsczGcRLVs3s4xcpQNCGF5PsBSLIlVKlwBCf/0pYo2mx9h7xzz5rFsjMPb8ycMHgg
 1nHSoTx5ISE93Gt2SnZv8fo5g0hisog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-3fBj_-AZMJmmD3hy46hCRA-1; Thu,
 06 Mar 2025 07:50:33 -0500
X-MC-Unique: 3fBj_-AZMJmmD3hy46hCRA-1
X-Mimecast-MFC-AGG-ID: 3fBj_-AZMJmmD3hy46hCRA_1741265432
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1175D18001F3; Thu,  6 Mar 2025 12:50:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBCEA1800373; Thu,  6 Mar 2025 12:50:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [RFC v2 2/2] build: generate symbol maps
Date: Thu,  6 Mar 2025 13:50:21 +0100
Message-ID: <20250306125021.2231121-2-david.marchand@redhat.com>
In-Reply-To: <20250306125021.2231121-1-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250306125021.2231121-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k5Q3MSH2wNWF6uux9VDB3e97iRGdZH_chQwAmufKIKc_1741265432
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
exported can be marked with a token.
The build framework then generates map files in a format that can satisfy
GNU linker.

Apply those macros to lib/net as an example.

Documentation is missing.
Converting from .map to Windows export file is not done.
Checks on map files are left in place, though they could be removed once
the whole tree is converted.
Experimental and internal symbol types are not handled.
Probably something else is missing, but this patch is still at RFC level.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 buildtools/gen-version-map.py | 65 +++++++++++++++++++++++++++++++++++
 buildtools/meson.build        |  1 +
 drivers/meson.build           |  2 --
 lib/meson.build               | 19 ++++++++--
 lib/net/rte_arp.c             |  1 +
 lib/net/rte_ether.c           |  3 ++
 lib/net/rte_net.c             |  2 ++
 lib/net/rte_net_crc.c         |  1 +
 lib/net/version.map           | 23 -------------
 meson.build                   |  3 +-
 10 files changed, 91 insertions(+), 29 deletions(-)
 create mode 100755 buildtools/gen-version-map.py
 delete mode 100644 lib/net/version.map

diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map.py
new file mode 100755
index 0000000000..2b03f328ea
--- /dev/null
+++ b/buildtools/gen-version-map.py
@@ -0,0 +1,65 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2024 Red Hat, Inc.
+
+"""Generate a version map file used by GNU linker."""
+
+import re
+import sys
+
+# From meson.build
+sym_export_regexp = re.compile(r"^RTE_EXPORT_SYMBOL\(([^,]+)\)$")
+# From rte_function_versioning.h
+sym_ver_regexp = re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+sym_default_regexp = re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]+, ([^,]+),")
+
+with open("../ABI_VERSION") as f:
+    abi = re.match("([0-9]+).[0-9]", f.readline()).group(1)
+
+symbols = {}
+
+for file in sys.argv[2:]:
+    with open(file, encoding="utf-8") as f:
+        for ln in f.readlines():
+            node = None
+            symbol = None
+            if sym_export_regexp.match(ln):
+                symbol = sym_export_regexp.match(ln).group(1)
+            elif sym_ver_regexp.match(ln):
+                node = sym_ver_regexp.match(ln).group(1)
+                symbol = sym_ver_regexp.match(ln).group(2)
+            elif sym_default_regexp.match(ln):
+                node = sym_default_regexp.match(ln).group(1)
+                symbol = sym_default_regexp.match(ln).group(2)
+
+            if not symbol:
+                continue
+
+            if not node:
+                node = abi
+            if node not in symbols:
+                symbols[node] = []
+            symbols[node].append(symbol)
+
+with open(sys.argv[1], "w") as outfile:
+    local_token = False
+    if abi in symbols:
+        outfile.writelines(f"DPDK_{abi} {{\n\tglobal:\n\n")
+        for symbol in sorted(symbols[abi]):
+            outfile.writelines(f"\t{symbol};\n")
+        outfile.writelines("\n")
+        if not local_token:
+            outfile.writelines("\tlocal: *;\n")
+            local_token = True
+        outfile.writelines("};\n")
+        del symbols[abi]
+    for key in sorted(symbols.keys()):
+        outfile.writelines(f"DPDK_{key} {{\n\tglobal:\n\n")
+        for symbol in sorted(symbols[key]):
+            outfile.writelines(f"\t{symbol};\n")
+        outfile.writelines("\n")
+        if not local_token:
+            outfile.writelines("\tlocal: *;\n")
+            local_token = True
+        outfile.writelines(f"}} DPDK_{abi};\n")
+        del symbols[key]
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
diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..d5fe3749c4 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -5,8 +5,6 @@ if is_ms_compiler
     subdir_done()
 endif
 
-fs = import('fs')
-
 # Defines the order of dependencies evaluation
 subdirs = [
         'common',
diff --git a/lib/meson.build b/lib/meson.build
index ce92cb5537..4db1864241 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -110,6 +110,7 @@ endif
 default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
+default_cflags += ['-DRTE_EXPORT_SYMBOL(a)=']
 
 if cc.has_argument('-Wno-format-truncation')
     default_cflags += '-Wno-format-truncation'
@@ -254,6 +255,9 @@ foreach l:libraries
             include_directories: includes,
             dependencies: static_deps)
 
+    version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), l)
+    lk_deps = []
+
     if not use_function_versioning or is_windows
         # use pre-build objects to build shared lib
         sources = []
@@ -262,10 +266,19 @@ foreach l:libraries
         # for compat we need to rebuild with
         # RTE_BUILD_SHARED_LIB defined
         cflags += '-DRTE_BUILD_SHARED_LIB'
-    endif
 
-    version_map = '@0@/@1@/version.map'.format(meson.current_source_dir(), l)
-    lk_deps = [version_map]
+        # POC: generate version.map if absent.
+        if not fs.is_file(version_map)
+            map_file = custom_target(libname + '_map',
+                    command: [gen_version_map, '@OUTPUT@', '@INPUT@'],
+                    input: sources,
+                    output: '@0@_version.map'.format(libname))
+            version_map = map_file.full_path()
+            lk_deps += [map_file]
+        else
+            lk_deps += [version_map]
+        endif
+    endif
 
     if is_ms_linker
         def_file = custom_target(libname + '_def',
diff --git a/lib/net/rte_arp.c b/lib/net/rte_arp.c
index 22af519586..cd0f49a7a9 100644
--- a/lib/net/rte_arp.c
+++ b/lib/net/rte_arp.c
@@ -47,3 +47,4 @@ rte_net_make_rarp_packet(struct rte_mempool *mpool,
 
 	return mbuf;
 }
+RTE_EXPORT_SYMBOL(rte_net_make_rarp_packet)
diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index f59c20289d..9d02db1676 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -17,6 +17,7 @@ rte_eth_random_addr(uint8_t *addr)
 	addr[0] &= (uint8_t)~RTE_ETHER_GROUP_ADDR;	/* clear multicast bit */
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
+RTE_EXPORT_SYMBOL(rte_eth_random_addr)
 
 void
 rte_ether_format_addr(char *buf, uint16_t size,
@@ -25,6 +26,7 @@ rte_ether_format_addr(char *buf, uint16_t size,
 	snprintf(buf, size, RTE_ETHER_ADDR_PRT_FMT,
 		RTE_ETHER_ADDR_BYTES(eth_addr));
 }
+RTE_EXPORT_SYMBOL(rte_ether_format_addr)
 
 static int8_t get_xdigit(char ch)
 {
@@ -153,3 +155,4 @@ rte_ether_unformat_addr(const char *s, struct rte_ether_addr *ea)
 	rte_errno = EINVAL;
 	return -1;
 }
+RTE_EXPORT_SYMBOL(rte_ether_unformat_addr)
diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 0c32e78a13..9a1bc3fb7d 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -306,6 +306,7 @@ rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
 	}
 	return -1;
 }
+RTE_EXPORT_SYMBOL(rte_net_skip_ip6_ext)
 
 /* parse mbuf data to get packet type */
 uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
@@ -601,3 +602,4 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 	return pkt_type;
 }
+RTE_EXPORT_SYMBOL(rte_net_get_ptype)
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index dd93d43c2e..03be816509 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -417,6 +417,7 @@ void rte_net_crc_free(struct rte_net_crc *crc)
 {
 	rte_free(crc);
 }
+RTE_EXPORT_SYMBOL(rte_net_crc_free)
 
 RTE_VERSION_SYMBOL(25, uint32_t, rte_net_crc_calc, (const void *data, uint32_t data_len,
 	enum rte_net_crc_type type)
diff --git a/lib/net/version.map b/lib/net/version.map
deleted file mode 100644
index f4dd673fa3..0000000000
--- a/lib/net/version.map
+++ /dev/null
@@ -1,23 +0,0 @@
-DPDK_25 {
-	global:
-
-	rte_eth_random_addr;
-	rte_ether_format_addr;
-	rte_ether_unformat_addr;
-	rte_net_crc_calc;
-	rte_net_crc_free;
-	rte_net_crc_set_alg;
-	rte_net_get_ptype;
-	rte_net_make_rarp_packet;
-	rte_net_skip_ip6_ext;
-
-	local: *;
-};
-
-DPDK_26 {
-	global:
-
-	rte_net_crc_calc;
-	rte_net_crc_set_alg;
-
-} DPDK_25;
diff --git a/meson.build b/meson.build
index 8436d1dff8..dfb4cb3aee 100644
--- a/meson.build
+++ b/meson.build
@@ -13,10 +13,11 @@ project('DPDK', 'c',
         meson_version: '>= 0.57'
 )
 
+fs = import('fs')
+
 # check for developer mode
 developer_mode = false
 if get_option('developer_mode').auto()
-    fs = import('fs')
     developer_mode = fs.exists('.git')
 else
     developer_mode = get_option('developer_mode').enabled()
-- 
2.48.1

