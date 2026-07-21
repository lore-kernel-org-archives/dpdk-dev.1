Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE31C44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 14:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A92540693;
	Tue, 21 Jul 2026 16:59:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F1D0140294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 16:59:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gRXMAS3HqEP0uWEO3QZqy3/cGmOjB5iTaKZGHCRYj6Y=;
 b=CKAEGmGz7tUBNxn8fHkYLBiZHO0oMbFkpDsYhhHqZaKcIXplrCSrJGpOh8hnNdfOAhGXUYHGe
 6N29c5Qss+mjCvcPMx0uAWMM/HNjr11gihLEWkAjww4SS6hi7H4QheODIzac+1MNFfhOie76UMj
 9ZM8GiywYd9rmvhgFcKrmbs=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h4LB25dDszJ46bB;
 Tue, 21 Jul 2026 22:58:50 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A94D40570;
 Tue, 21 Jul 2026 22:59:11 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jul 2026 16:59:10 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: [PATCH v4 1/7] doc: detect ignored public headers
Date: Tue, 21 Jul 2026 15:58:34 +0100
Message-ID: <20260721145841.7424-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721145841.7424-1-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Some public headers were omitted from doc/api/doxy-api-index.md and/or
doc/api/doxy-api.conf.in. Add checks to meson configuration, with
exceptions, detecting and warning about these.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/meson.build | 21 +++++++++++++++++++++
 lib/meson.build     | 27 +++++++++++++++++++++++++++
 meson.build         | 28 ++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 102a8262e588..a3e6ebc26bc2 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -287,6 +287,27 @@ foreach subpath:subdirs
         dpdk_headers += headers
         dpdk_drivers_headers += driver_sdk_headers
 
+        if check_docs and headers.length() > 0
+            foreach h:headers
+                hname = fs.name(h)
+                if not hname.startswith('rte_')
+                    warning('public header @0@ name does not start with "rte_"'.format(h))
+                endif
+                is_ignored = false
+                foreach ig:doc_ignored_header_suffixes
+                    is_ignored = is_ignored or ('/' + hname).endswith(ig)
+                endforeach
+                if not is_ignored and hname not in doc_indexed_headers
+                    warning('public header @0@ is not listed in @1@'.format(h, doc_index_path))
+                endif
+            endforeach
+            doc_dir = 'drivers/' + drv_path
+            if doc_dir not in doc_built_dirs
+                warning('public header directory @0@ is not listed in @1@'.format(doc_dir,
+                    doc_build_path))
+            endif
+        endif
+
         if headers.length() > 0
             dpdk_includes += include_directories(drv_path)
         endif
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb800..8c974477c651 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -209,6 +209,33 @@ foreach l:libraries
     dpdk_indirect_headers += indirect_headers
     dpdk_drivers_headers += driver_sdk_headers
 
+    if check_docs and headers.length() > 0
+        foreach h:headers
+            hname = fs.name(h)
+            if not (hname.startswith('rte_') or hname.startswith('cmdline'))
+                warning('public header @0@ name does not start with "rte_" or "cmdline"'.format(h))
+            endif
+            is_ignored = false
+            foreach ig:doc_ignored_header_suffixes
+                is_ignored = is_ignored or ('/' + hname).endswith(ig)
+            endforeach
+            if not is_ignored and hname not in doc_indexed_headers
+                warning('public header @0@ is not listed in @1@'.format(h, doc_index_path))
+            endif
+        endforeach
+        if l == 'eal'
+            doc_dirs = ['lib/eal/include', 'lib/eal/include/generic']
+        else
+            doc_dirs = ['lib/' + l]
+        endif
+        foreach d:doc_dirs
+            if d not in doc_built_dirs
+                warning('public header directory @0@ is not listed in @1@'.format(d,
+                    doc_build_path))
+            endif
+        endforeach
+    endif
+
     libname = 'rte_' + name
     includes += include_directories(l)
     dpdk_includes += include_directories(l)
diff --git a/meson.build b/meson.build
index b01010ffa076..d22f0d4b57bf 100644
--- a/meson.build
+++ b/meson.build
@@ -88,6 +88,34 @@ if is_linux
     global_inc += include_directories('kernel/linux')
 endif
 
+# on linux, try to check that documentation sources are correctly built and indexed
+check_docs = is_linux and meson.version().version_compare('>= 0.60.0')
+
+if check_docs
+    doc_build_path = 'doc/api/doxy-api.conf.in'
+    doc_build_file = dpdk_source_root / doc_build_path
+    doc_built_dirs = run_command('sed', '--regexp-extended', '--quiet',
+        # Extract and print the file path immediately following @TOPDIR@/ .
+        's#^(INPUT *=)? *@TOPDIR@/([^ ]*)( .*|\\\\|)$#\\2#p',
+        doc_build_file, check: true).stdout().strip('\n').split('\n')
+
+    doc_index_path = 'doc/api/doxy-api-index.md'
+    doc_index_file = dpdk_source_root / doc_index_path
+    doc_indexed_headers = run_command('sed', '--regexp-extended', '--quiet',
+        # Extract and print the (@ref ...) contents.
+        's#^.*\\(@ref ([^)]*)\\).*$#\\1#p',
+        doc_index_file, check: true).stdout().strip('\n').split('\n')
+
+    # Suffixes of the headers that don't have to be indexed;
+    # full name is matched if the entry starts with a slash.
+    doc_ignored_header_suffixes = [
+            '/rte_os.h',
+            '/rte_trace_point_register.h',
+            '_trace.h',
+            '_trace_fp.h',
+    ]
+endif
+
 # build libs and drivers
 subdir('lib')
 subdir('drivers')
-- 
2.43.0

