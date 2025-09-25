Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775BCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:32:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6D4240A6E;
	Thu, 25 Sep 2025 14:32:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1593840687
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758803564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0cEZyCI5yMSgbQkMQvnvDPdqR+/Y3qVwTlciqdqsaA=;
 b=Pkd162dMOvTcSbsKF4JwJcFQ+DZKFja94Q+nCCPUNuyIrgQgCN3886UvC9j9jVm0FFeTbl
 lhVOlByVOeNOacGpZcBJ88McQC9fTtb5dYxNURa3oZsNmXRLjLaJFRVJWJ3KqpbzklWu2G
 R/QoHw0HBJ/cEzM70YkyZsENJY3KoiM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-zHwU5DUiNs6DM_Y9d2UjyQ-1; Thu,
 25 Sep 2025 08:32:39 -0400
X-MC-Unique: zHwU5DUiNs6DM_Y9d2UjyQ-1
X-Mimecast-MFC-AGG-ID: zHwU5DUiNs6DM_Y9d2UjyQ_1758803558
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E571956095; Thu, 25 Sep 2025 12:32:38 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 598B11800446; Thu, 25 Sep 2025 12:32:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v4 6/7] buildtools/chkincs: use a staging directory for headers
Date: Thu, 25 Sep 2025 14:31:48 +0200
Message-ID: <20250925123150.3063298-7-david.marchand@redhat.com>
In-Reply-To: <20250925123150.3063298-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ei-PFMYUxBJIDzLTBAH6Qo9iBijKa06q7dpvc2bAt4s_1758803558
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
---
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
 MAINTAINERS                                   |  1 +
 buildtools/chkincs/meson.build                | 69 +++++++++++++------
 .../chkincs/staging/drivers/meson.build       |  4 ++
 buildtools/chkincs/staging/meson.build        |  5 ++
 buildtools/meson.build                        |  1 +
 buildtools/stage-headers.py                   | 32 +++++++++
 drivers/meson.build                           | 26 ++++++-
 lib/eal/include/meson.build                   | 10 +++
 lib/eal/meson.build                           | 12 ++++
 lib/meson.build                               | 27 +++++++-
 meson.build                                   |  8 +++
 11 files changed, 171 insertions(+), 24 deletions(-)
 create mode 100644 buildtools/chkincs/staging/drivers/meson.build
 create mode 100644 buildtools/chkincs/staging/meson.build
 create mode 100644 buildtools/stage-headers.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..76672b67c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -131,6 +131,7 @@ F: buildtools/get-numa-count.py
 F: buildtools/list-dir-globs.py
 F: buildtools/map-list-symbol.sh
 F: buildtools/pkg-config/
+F: buildtools/stage-headers.py
 F: buildtools/symlink-drivers-solibs.sh
 F: buildtools/symlink-drivers-solibs.py
 F: devtools/test-meson-builds.sh
diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index 49dbc55254..376556f5f4 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -12,38 +12,47 @@ gen_c_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cflags = machine_args
+cflags += '-Wno-missing-field-initializers'
 cflags += no_wvla_cflag
+cflags += '-I' + dpdk_source_root + '/config'
+cflags += '-I' + dpdk_build_root
+cflags += '-I' + dpdk_chkinc_staging_dir
 
 sources = files('main.c')
 sources += gen_c_files.process(dpdk_chkinc_headers)
 
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
+cflags_drivers = '-I' + dpdk_chkinc_drivers_staging_dir
+sources_drivers = files('main.c')
+sources_drivers += gen_c_files.process(dpdk_chkinc_drivers_headers)
 
 executable('chkincs', sources,
         c_args: cflags,
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
         install: false)
 
 executable('chkincs-exp', sources,
         c_args: [cflags, '-DALLOW_EXPERIMENTAL_API'],
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
         install: false)
 
 executable('chkincs-all', sources,
         c_args: [cflags, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
+        install: false)
+
+executable('chkincs-drv', sources_drivers,
+        c_args: [cflags, cflags_drivers],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
+        install: false)
+
+executable('chkincs-drv-exp', sources_drivers,
+        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API'],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
+        install: false)
+
+executable('chkincs-drv-all', sources_drivers,
+        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
         install: false)
 
 # run tests for c++ builds also
@@ -58,21 +67,37 @@ gen_cpp_files = generator(gen_c_file_for_header,
 cpp_sources = files('main.cpp')
 cpp_sources += gen_cpp_files.process(dpdk_chkinc_headers)
 
+cpp_sources_drivers = files('main.cpp')
+cpp_sources_drivers += gen_cpp_files.process(dpdk_chkinc_drivers_headers)
+
 executable('chkincs-cpp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags],
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
         install: false)
 
 executable('chkincs-cpp-exp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API'],
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
         install: false)
 
 executable('chkincs-cpp-all', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API',
                    '-DALLOW_INTERNAL_API'],
-        include_directories: includes,
-        dependencies: deps,
+        dependencies: dpdk_chkinc_staging_deps,
+        install: false)
+
+executable('chkincs-drv-cpp', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
+        install: false)
+
+executable('chkincs-drv-cpp-exp', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API'],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
+        install: false)
+
+executable('chkincs-drv-cpp-all', cpp_sources_drivers,
+        cpp_args: ['-include', 'rte_config.h', cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API',
+                   '-DALLOW_INTERNAL_API'],
+        dependencies: dpdk_chkinc_staging_deps + dpdk_chkinc_drivers_staging_deps,
         install: false)
diff --git a/buildtools/chkincs/staging/drivers/meson.build b/buildtools/chkincs/staging/drivers/meson.build
new file mode 100644
index 0000000000..b19b1c0908
--- /dev/null
+++ b/buildtools/chkincs/staging/drivers/meson.build
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+dpdk_chkinc_drivers_staging_dir = meson.current_build_dir()
diff --git a/buildtools/chkincs/staging/meson.build b/buildtools/chkincs/staging/meson.build
new file mode 100644
index 0000000000..0b05656330
--- /dev/null
+++ b/buildtools/chkincs/staging/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+dpdk_chkinc_staging_dir = meson.current_build_dir()
+subdir('drivers')
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 32cea7cff7..561236e0af 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -27,6 +27,7 @@ get_min_meson_version_cmd = py3 + files('get-min-meson-version.py')
 get_test_suites_cmd = py3 + files('get-test-suites.py')
 header_gen_cmd = py3 + files('gen-header.py')
 has_hugepages_cmd = py3 + files('has-hugepages.py')
+stage_headers_cmd = py3 + files('stage-headers.py')
 cmdline_gen_cmd = py3 + files('dpdk-cmdline-gen.py')
 check_dts_requirements = py3 + files('check-dts-requirements.py')
 
diff --git a/buildtools/stage-headers.py b/buildtools/stage-headers.py
new file mode 100644
index 0000000000..3057c6a26f
--- /dev/null
+++ b/buildtools/stage-headers.py
@@ -0,0 +1,32 @@
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
+        print("Usage: stage-headers.py <staging_dir> <meson_stamp> [headers...]")
+        sys.exit(1)
+
+    staging_dir = Path(sys.argv[1])
+    meson_stamp = Path(sys.argv[2])
+    headers = sys.argv[3:]
+
+    staging_dir.mkdir(parents=True, exist_ok=True)
+
+    for header in headers:
+        file = Path(header)
+        shutil.copy2(file, staging_dir / file.name)
+
+    meson_stamp.touch()
+
+if __name__ == "__main__":
+    main()
diff --git a/drivers/meson.build b/drivers/meson.build
index f25f425565..dae1e83ca4 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -245,7 +245,31 @@ foreach subpath:subdirs
         if get_option('enable_driver_sdk')
             install_headers(driver_sdk_headers)
         endif
-        dpdk_chkinc_headers += driver_sdk_headers
+        dpdk_chkinc_headers += headers
+        dpdk_chkinc_drivers_headers += driver_sdk_headers
+
+        if get_option('check_includes')
+            if headers.length() > 0
+                dpdk_chkinc_staging_deps += declare_dependency(sources:
+                        custom_target(lib_name + '_header_staging',
+                                output: lib_name + '_header_staging.stamp',
+                                command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
+                                    headers],
+                                install: false,
+                        )
+                )
+            endif
+            if driver_sdk_headers.length() > 0
+                dpdk_chkinc_drivers_staging_deps += declare_dependency(sources:
+                        custom_target(lib_name + '_driver_header_staging',
+                                output: lib_name + '_driver_header_staging.stamp',
+                                command: [stage_headers_cmd, dpdk_chkinc_drivers_staging_dir,
+                                    '@OUTPUT@', driver_sdk_headers],
+                                install: false,
+                        )
+                )
+            endif
+        endif
 
         if headers.length() > 0
             dpdk_includes += include_directories(drv_path)
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index d903577caa..92aa1c885d 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -79,3 +79,13 @@ generic_headers = files(
         'generic/rte_vect.h',
 )
 install_headers(generic_headers, subdir: 'generic')
+if get_option('check_includes')
+    dpdk_chkinc_staging_deps += declare_dependency(sources:
+            custom_target('eal_generic_header_staging',
+                    output: 'eal_generic_header_staging.stamp',
+                    command: [stage_headers_cmd, join_paths(dpdk_chkinc_staging_dir, 'generic'),
+                        '@OUTPUT@', generic_headers],
+                    install: false,
+            )
+    )
+endif
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..4ffd048ab1 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -12,7 +12,19 @@ endif
 
 subdir(exec_env)
 
+arch_headers = []
+arch_indirect_headers = []
 subdir(arch_subdir)
+if get_option('check_includes')
+    dpdk_chkinc_staging_deps += declare_dependency(sources:
+            custom_target('eal_arch_header_staging',
+                    output: 'eal_arch_header_staging.stamp',
+                    command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
+                        arch_headers + arch_indirect_headers],
+                    install: false,
+            )
+    )
+endif
 
 deps += ['log', 'kvargs']
 if not is_windows
diff --git a/lib/meson.build b/lib/meson.build
index a67efaf718..34f930f12e 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -214,7 +214,32 @@ foreach l:libraries
         install_headers(driver_sdk_headers)
     endif
     dpdk_chkinc_headers += headers
-    dpdk_chkinc_headers += driver_sdk_headers
+    dpdk_chkinc_drivers_headers += driver_sdk_headers
+
+    if get_option('check_includes')
+        lib_headers = headers + indirect_headers
+        if lib_headers.length() != 0
+            dpdk_chkinc_staging_deps += declare_dependency(sources:
+                    custom_target(l + '_header_staging',
+                            output: l + '_header_staging.stamp',
+                            command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
+                                lib_headers],
+                            install: false,
+                    )
+            )
+        endif
+
+        if driver_sdk_headers.length() != 0
+            dpdk_chkinc_drivers_staging_deps += declare_dependency(sources:
+                    custom_target(l + '_driver_header_staging',
+                            output: l + '_driver_header_staging.stamp',
+                            command: [stage_headers_cmd, dpdk_chkinc_drivers_staging_dir,
+                                '@OUTPUT@', driver_sdk_headers],
+                            install: false,
+                    )
+            )
+        endif
+    endif
 
     libname = 'rte_' + name
     includes += include_directories(l)
diff --git a/meson.build b/meson.build
index 2423884df7..82498bcf54 100644
--- a/meson.build
+++ b/meson.build
@@ -38,6 +38,11 @@ dpdk_static_libraries = []
 dpdk_shared_lib_deps = []
 dpdk_static_lib_deps = []
 dpdk_chkinc_headers = []
+dpdk_chkinc_staging_dir = []
+dpdk_chkinc_staging_deps = []
+dpdk_chkinc_drivers_headers = []
+dpdk_chkinc_drivers_staging_dir = []
+dpdk_chkinc_drivers_staging_deps = []
 dpdk_driver_classes = []
 dpdk_drivers = []
 dpdk_extra_ldflags = []
@@ -74,6 +79,9 @@ global_inc = [include_directories('.', 'config',
 
 # do configuration and get tool paths
 subdir('buildtools')
+if get_option('check_includes')
+    subdir('buildtools/chkincs/staging')
+endif
 subdir('config')
 
 if is_linux
-- 
2.51.0

