Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F636C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:54:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E5D240B9E;
	Mon,  6 Jul 2026 12:53:42 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5DAE340A6D
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:53:37 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv1Qr1jbLzJ469c;
 Mon,  6 Jul 2026 18:52:36 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 93E4D40584;
 Mon,  6 Jul 2026 18:53:32 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 12:53:32 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: [PATCH v2 1/7] doc: detect ignored public headers
Date: Mon, 6 Jul 2026 11:52:49 +0100
Message-ID: <20260706105256.79904-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105256.79904-1-marat.khalili@huawei.com>
References: <20260702200050.88710-1-marat.khalili@huawei.com>
 <20260706105256.79904-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
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
doc/api/doxy-api.conf.in. Add checks to meson configuration detecting
and warning about these.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/meson.build | 17 +++++++++++++++++
 lib/meson.build     | 23 +++++++++++++++++++++++
 meson.build         | 19 +++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 102a8262e588..09c063660291 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -287,6 +287,23 @@ foreach subpath:subdirs
         dpdk_headers += headers
         dpdk_drivers_headers += driver_sdk_headers
 
+        if check_docs and headers.length() > 0
+            foreach h:headers
+                hname = fs.name(h)
+                if not hname.startswith('rte_')
+                    warning('public header @0@ name does not start with "rte_"'.format(h))
+                endif
+                if hname not in doc_indexed_headers
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
index af5c160cb800..ff5c474d2cc3 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -209,6 +209,29 @@ foreach l:libraries
     dpdk_indirect_headers += indirect_headers
     dpdk_drivers_headers += driver_sdk_headers
 
+    if check_docs and headers.length() > 0
+        foreach h:headers
+            hname = fs.name(h)
+            if not (hname.startswith('rte_') or hname.startswith('cmdline'))
+                warning('public header @0@ name does not start with "rte_" or "cmdline"'.format(h))
+            endif
+            if hname not in doc_indexed_headers
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
+                warning('public header directory @0@ is not listed in @1@'.format(doc_dir,
+                    doc_build_path))
+            endif
+        endforeach
+    endif
+
     libname = 'rte_' + name
     includes += include_directories(l)
     dpdk_includes += include_directories(l)
diff --git a/meson.build b/meson.build
index b01010ffa076..2488c54f1b17 100644
--- a/meson.build
+++ b/meson.build
@@ -88,6 +88,25 @@ if is_linux
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
+endif
+
 # build libs and drivers
 subdir('lib')
 subdir('drivers')
-- 
2.43.0

