Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0854CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 06:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCDD40A75;
	Tue, 30 Sep 2025 08:58:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4268A40A71
 for <dev@dpdk.org>; Tue, 30 Sep 2025 08:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759215518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byCpi+j1z8MQ+oGcLJjfa4jw2ivtcazPy5DOtneuv38=;
 b=BqiPfNe+psA0zwcbX2ZD/7xebzKFrdAqryTB+zV7vUVnZHcihrnhAUzXihkUCTBrROxsyi
 bSicbyX//pKm5xFFtEYUe/DfWXi6qeBsSMrHu2ItmKDC0iS2hpRU5uB7ZMG7o+l/yRzpjp
 XpEcipLi3HcVaDw8Ot8Cz+Xsw/wiLww=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-dWMqZ8wfNpm99XBHZYC5lA-1; Tue,
 30 Sep 2025 02:58:35 -0400
X-MC-Unique: dWMqZ8wfNpm99XBHZYC5lA-1
X-Mimecast-MFC-AGG-ID: dWMqZ8wfNpm99XBHZYC5lA_1759215514
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF9619774E5; Tue, 30 Sep 2025 06:58:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14E211800447; Tue, 30 Sep 2025 06:58:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 8/9] buildtools/chkincs: use a staging directory for headers
Date: Tue, 30 Sep 2025 08:57:38 +0200
Message-ID: <20250930065740.1838899-9-david.marchand@redhat.com>
In-Reply-To: <20250930065740.1838899-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250930065740.1838899-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gd_hHb3TJTaqNs_fYvJFF6Bc6Ow2X01hiVkm2XtYfUM_1759215514
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

A problem with the current headers check is that it relies on
meson dependencies objects that come with their include_directories
directives, and all of those point at the library / driver sources.

This means that we won't detect a public header including a private
(as in, not exported) header, or a driver only header.

To address this issue, a staging directory is added and every header
is copied to it.

Drivers and library headers are staged to two different directories
and the check is updated accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v5:
- flushed staging directory before copying again in case of a change
  in the list of headers,

Changes since v4:
- split global_inc (isolating config include path from EAL headers),
- moved all changes under buildtools/chkincs,

Changes since v3:
- removed update of global_inc (which was unneeded, and probably was
  what triggered a Windows clang build issue reported by CI),
- moved all staging operations under a check on check_includes= option,
- moved staging directories under buildtools/chkincs/,
- renamed all variables to reflect those concern the headers check,
- made chkincs binaries depend on staging deps instead of having the
  libraries/drivers depend on them,
- added C++ check for driver headers (missed in v3),

---
 buildtools/chkincs/meson.build                | 65 +++++++++++++++----
 .../chkincs/staging/drivers/meson.build       | 13 ++++
 buildtools/chkincs/staging/meson.build        | 43 ++++++++++++
 buildtools/chkincs/staging/stage-headers.py   | 40 ++++++++++++
 meson.build                                   |  6 +-
 5 files changed, 151 insertions(+), 16 deletions(-)
 create mode 100644 buildtools/chkincs/staging/drivers/meson.build
 create mode 100644 buildtools/chkincs/staging/meson.build
 create mode 100644 buildtools/chkincs/staging/stage-headers.py

diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index ac7df41304..9a84c1cc25 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -6,6 +6,13 @@ if not get_option('check_includes')
     subdir_done()
 endif
 
+includes = [config_inc]
+deps = []
+includes_drivers = []
+deps_drivers = []
+
+subdir('staging')
+
 gen_c_file_for_header = find_program('gen_c_file_for_header.py')
 gen_c_files = generator(gen_c_file_for_header,
         output: '@BASENAME@.c',
@@ -18,18 +25,7 @@ endif
 cflags += no_wvla_cflag
 
 sources = files('main.c')
-sources += gen_c_files.process(dpdk_arch_headers + dpdk_headers + dpdk_drivers_headers)
-
-# some driver SDK headers depend on these two buses, which are mandatory in build
-# so we always include them in deps list
-deps = [get_variable('shared_rte_bus_vdev'), get_variable('shared_rte_bus_pci')]
-if dpdk_conf.has('RTE_BUS_VMBUS')
-    deps += get_variable('shared_rte_bus_vmbus')
-endif
-# add the rest of the libs to the dependencies
-foreach l:dpdk_libs_enabled
-    deps += get_variable('shared_rte_' + l)
-endforeach
+sources += gen_c_files.process(dpdk_arch_headers + dpdk_headers)
 
 executable('chkincs', sources,
         c_args: cflags,
@@ -49,6 +45,27 @@ executable('chkincs-all', sources,
         dependencies: deps,
         install: false)
 
+sources_drivers = files('main.c')
+sources_drivers += gen_c_files.process(dpdk_drivers_headers)
+
+executable('chkincs-drv', sources_drivers,
+        c_args: cflags,
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
+
+executable('chkincs-drv-exp', sources_drivers,
+        c_args: [cflags, '-DALLOW_EXPERIMENTAL_API'],
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
+
+executable('chkincs-drv-all', sources_drivers,
+        c_args: [cflags, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
+
 # run tests for c++ builds also
 if not add_languages('cpp', required: false)
     subdir_done()
@@ -59,7 +76,7 @@ gen_cpp_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cpp_sources = files('main.cpp')
-cpp_sources += gen_cpp_files.process(dpdk_arch_headers + dpdk_headers + dpdk_drivers_headers)
+cpp_sources += gen_cpp_files.process(dpdk_arch_headers + dpdk_headers)
 
 executable('chkincs-cpp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags],
@@ -79,3 +96,25 @@ executable('chkincs-cpp-all', cpp_sources,
         include_directories: includes,
         dependencies: deps,
         install: false)
+
+cpp_sources_drivers = files('main.cpp')
+cpp_sources_drivers += gen_cpp_files.process(dpdk_drivers_headers)
+
+executable('chkincs-drv-cpp', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags],
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
+
+executable('chkincs-drv-cpp-exp', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API'],
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
+
+executable('chkincs-drv-cpp-all', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API',
+                   '-DALLOW_INTERNAL_API'],
+        include_directories: includes + includes_drivers,
+        dependencies: deps + deps_drivers,
+        install: false)
diff --git a/buildtools/chkincs/staging/drivers/meson.build b/buildtools/chkincs/staging/drivers/meson.build
new file mode 100644
index 0000000000..23a1b084cb
--- /dev/null
+++ b/buildtools/chkincs/staging/drivers/meson.build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+includes += include_directories('.')
+deps += declare_dependency(sources:
+    custom_target('drivers_headers_staging',
+            output: 'drivers_headers_staging.stamp',
+            depends: cleanup_target,
+            command: [stage_headers_cmd, meson.current_build_dir(), '@OUTPUT@',
+                dpdk_drivers_headers],
+            install: false,
+    )
+)
diff --git a/buildtools/chkincs/staging/meson.build b/buildtools/chkincs/staging/meson.build
new file mode 100644
index 0000000000..8710df290b
--- /dev/null
+++ b/buildtools/chkincs/staging/meson.build
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+stage_headers_cmd = py3 + files('stage-headers.py')
+
+cleanup_target = custom_target('cleanup_staging',
+        output: 'cleanup_staging.stamp',
+        depend_files: dpdk_arch_headers + dpdk_arch_indirect_headers + dpdk_generic_headers +
+            dpdk_headers + dpdk_indirect_headers + dpdk_drivers_headers,
+        command: [stage_headers_cmd, '--cleanup', meson.current_build_dir(), '@OUTPUT@'],
+        install: false,
+)
+
+subdir('drivers')
+
+includes += include_directories('.')
+deps += declare_dependency(sources:
+    custom_target('arch_headers_staging',
+            output: 'arch_headers_staging.stamp',
+            depends: cleanup_target,
+            command: [stage_headers_cmd, meson.current_build_dir(), '@OUTPUT@',
+                dpdk_arch_headers + dpdk_arch_indirect_headers],
+            install: false,
+    )
+)
+deps += declare_dependency(sources:
+    custom_target('headers_staging',
+            output: 'headers_staging.stamp',
+            depends: cleanup_target,
+            command: [stage_headers_cmd, meson.current_build_dir(), '@OUTPUT@',
+                dpdk_headers + dpdk_indirect_headers],
+            install: false,
+    )
+)
+deps += declare_dependency(sources:
+    custom_target('generic_headers_staging',
+            output: 'generic_headers_staging.stamp',
+            depends: cleanup_target,
+            command: [stage_headers_cmd, join_paths(meson.current_build_dir(), 'generic'),
+                '@OUTPUT@', dpdk_generic_headers],
+            install: false,
+    )
+)
diff --git a/buildtools/chkincs/staging/stage-headers.py b/buildtools/chkincs/staging/stage-headers.py
new file mode 100644
index 0000000000..25201d40ec
--- /dev/null
+++ b/buildtools/chkincs/staging/stage-headers.py
@@ -0,0 +1,40 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+"""
+Headers staging script for DPDK build system.
+"""
+
+import sys
+import os
+import shutil
+from pathlib import Path
+
+def main():
+    if len(sys.argv) < 4:
+        print("Usage: stage-headers.py [--cleanup] <staging_dir> <meson_stamp> [headers...]")
+        sys.exit(1)
+
+    if len(sys.argv) == 4 and sys.argv[1] == '--cleanup':
+        staging_dir = Path(sys.argv[2])
+        meson_stamp = Path(sys.argv[3])
+
+        shutil.rmtree(staging_dir)
+        staging_dir.mkdir(parents=True, exist_ok=True)
+
+    else:
+        staging_dir = Path(sys.argv[1])
+        meson_stamp = Path(sys.argv[2])
+        headers = sys.argv[3:]
+
+        staging_dir.mkdir(parents=True, exist_ok=True)
+
+        for header in headers:
+            file = Path(header)
+            shutil.copy2(file, staging_dir / file.name)
+
+    meson_stamp.touch()
+
+if __name__ == "__main__":
+    main()
diff --git a/meson.build b/meson.build
index 9f0b06179b..7f90d3bdc3 100644
--- a/meson.build
+++ b/meson.build
@@ -69,9 +69,9 @@ elif host_machine.cpu_family().startswith('riscv')
 endif
 
 # configure the build, and make sure configs here and in config folder are
-# able to be included in any file. We also store a global array of include dirs
-# for passing to pmdinfogen scripts
-global_inc = [include_directories('.', 'config',
+# able to be included in any file
+config_inc = [include_directories('.', 'config')]
+global_inc = [config_inc, include_directories(
     'lib/eal/include',
     'lib/eal/@0@/include'.format(host_machine.system()),
     'lib/eal/@0@/include'.format(arch_subdir),
-- 
2.51.0

