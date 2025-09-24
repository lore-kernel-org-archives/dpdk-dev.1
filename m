Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EDCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 17:26:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 937D540B94;
	Wed, 24 Sep 2025 19:26:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 950B340B94
 for <dev@dpdk.org>; Wed, 24 Sep 2025 19:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758734781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXBdfUHdqfIFFqUeo2HVeIDaua6Qa64wTpVkS3VdOqM=;
 b=CMIAbvPbJ5k2vKacednMOe0pAgZmaTuEF5ojc0WhGFesSKPOudpZOmZx4drijpIf7E3U5p
 dZ77Ql4JPu5Az+QQS2y7m4ALEDRGA9hQTPAU+4lpahtPLJ9Hz0EeqwIUGeTN4/lyOs6gq5
 ZePmvl88WVazzFzD+gYAnDqxFBRQH0U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-B35Ae87wNPOMu3psof4B0Q-1; Wed,
 24 Sep 2025 13:26:19 -0400
X-MC-Unique: B35Ae87wNPOMu3psof4B0Q-1
X-Mimecast-MFC-AGG-ID: B35Ae87wNPOMu3psof4B0Q_1758734778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C86E61956096; Wed, 24 Sep 2025 17:26:17 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E183518003FC; Wed, 24 Sep 2025 17:26:15 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for headers
Date: Wed, 24 Sep 2025 19:25:34 +0200
Message-ID: <20250924172536.2447183-7-david.marchand@redhat.com>
In-Reply-To: <20250924172536.2447183-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8iV7xIdUUTtw7d83mqDBX8o1EKCKdUyy4CouqumumRQ_1758734778
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
 MAINTAINERS                    |  3 +++
 buildtools/chkincs/meson.build | 41 ++++++++++++++++------------------
 buildtools/meson.build         |  1 +
 buildtools/stage-headers.py    | 32 ++++++++++++++++++++++++++
 drivers/meson.build            | 28 ++++++++++++++++++++---
 lib/eal/include/meson.build    |  8 +++++++
 lib/eal/meson.build            | 10 +++++++++
 lib/meson.build                | 41 ++++++++++++++++++++++++++--------
 meson.build                    |  4 ++++
 staging/drivers/meson.build    |  5 +++++
 staging/meson.build            |  7 ++++++
 11 files changed, 146 insertions(+), 34 deletions(-)
 create mode 100644 buildtools/stage-headers.py
 create mode 100644 staging/drivers/meson.build
 create mode 100644 staging/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..f309e20a22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -131,10 +131,13 @@ F: buildtools/get-numa-count.py
 F: buildtools/list-dir-globs.py
 F: buildtools/map-list-symbol.sh
 F: buildtools/pkg-config/
+F: buildtools/stage-headers.py
 F: buildtools/symlink-drivers-solibs.sh
 F: buildtools/symlink-drivers-solibs.py
 F: devtools/test-meson-builds.sh
 F: devtools/check-meson.py
+F: staging/drivers/meson.build
+F: staging/meson.build
 
 Public CI
 M: Aaron Conole <aconole@redhat.com>
diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index 49dbc55254..10298b71a1 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -12,38 +12,41 @@ gen_c_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cflags = machine_args
+cflags += '-Wno-missing-field-initializers'
 cflags += no_wvla_cflag
+cflags += '-I../config'
+cflags += '-I.'
+cflags += '-Istaging'
 
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
+cflags_drivers = '-Istaging/drivers'
+sources_drivers = files('main.c')
+sources_drivers += gen_c_files.process(dpdk_chkinc_driver_headers)
 
 executable('chkincs', sources,
         c_args: cflags,
-        include_directories: includes,
-        dependencies: deps,
         install: false)
 
 executable('chkincs-exp', sources,
         c_args: [cflags, '-DALLOW_EXPERIMENTAL_API'],
-        include_directories: includes,
-        dependencies: deps,
         install: false)
 
 executable('chkincs-all', sources,
         c_args: [cflags, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
-        include_directories: includes,
-        dependencies: deps,
+        install: false)
+
+executable('chkincs-drv', sources_drivers,
+        c_args: [cflags, cflags_drivers],
+        install: false)
+
+executable('chkincs-drv-exp', sources_drivers,
+        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API'],
+        install: false)
+
+executable('chkincs-drv-all', sources_drivers,
+        c_args: [cflags, cflags_drivers, '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API'],
         install: false)
 
 # run tests for c++ builds also
@@ -60,19 +63,13 @@ cpp_sources += gen_cpp_files.process(dpdk_chkinc_headers)
 
 executable('chkincs-cpp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags],
-        include_directories: includes,
-        dependencies: deps,
         install: false)
 
 executable('chkincs-cpp-exp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API'],
-        include_directories: includes,
-        dependencies: deps,
         install: false)
 
 executable('chkincs-cpp-all', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags, '-DALLOW_EXPERIMENTAL_API',
                    '-DALLOW_INTERNAL_API'],
-        include_directories: includes,
-        dependencies: deps,
         install: false)
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
index f25f425565..e159562e6b 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -245,7 +245,29 @@ foreach subpath:subdirs
         if get_option('enable_driver_sdk')
             install_headers(driver_sdk_headers)
         endif
-        dpdk_chkinc_headers += driver_sdk_headers
+        dpdk_chkinc_headers += headers
+        dpdk_chkinc_driver_headers += driver_sdk_headers
+
+        if headers.length() != 0
+            staged_headers_deps += declare_dependency(sources:
+                    custom_target(lib_name + '_header_staging',
+                            output: lib_name + '_header_staging.stamp',
+                            command: [stage_headers_cmd, staging_dir, '@OUTPUT@', headers],
+                            install: false,
+                    )
+            )
+        endif
+
+        if driver_sdk_headers.length() != 0
+            staged_headers_deps += declare_dependency(sources:
+                    custom_target(lib_name + '_driver_header_staging',
+                            output: lib_name + '_driver_header_staging.stamp',
+                            command: [stage_headers_cmd, drivers_staging_dir, '@OUTPUT@',
+                                driver_sdk_headers],
+                            install: false,
+                    )
+            )
+        endif
 
         if headers.length() > 0
             dpdk_includes += include_directories(drv_path)
@@ -348,10 +370,10 @@ foreach subpath:subdirs
         # testpmd or other built-in apps can find it if necessary
         shared_dep = declare_dependency(link_with: shared_lib,
                 include_directories: includes,
-                dependencies: shared_deps)
+                dependencies: shared_deps + staged_headers_deps)
         static_dep = declare_dependency(
                 include_directories: includes,
-                dependencies: static_deps)
+                dependencies: static_deps + staged_headers_deps)
 
         dpdk_drivers += static_lib
 
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index d903577caa..d79dd0f2fc 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -79,3 +79,11 @@ generic_headers = files(
         'generic/rte_vect.h',
 )
 install_headers(generic_headers, subdir: 'generic')
+staged_headers_deps += declare_dependency(sources:
+        custom_target('eal_generic_header_staging',
+                output: 'eal_generic_header_staging.stamp',
+                command: [stage_headers_cmd, join_paths(staging_dir, 'generic'), '@OUTPUT@',
+                    generic_headers],
+                install: false,
+        )
+)
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..6f1f0e80cd 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -12,7 +12,17 @@ endif
 
 subdir(exec_env)
 
+arch_headers = []
+arch_indirect_headers = []
 subdir(arch_subdir)
+staged_headers_deps += declare_dependency(sources:
+        custom_target('eal_arch_header_staging',
+                output: 'eal_arch_header_staging.stamp',
+                command: [stage_headers_cmd, staging_dir, '@OUTPUT@',
+                    arch_headers + arch_indirect_headers],
+                install: false,
+        )
+)
 
 deps += ['log', 'kvargs']
 if not is_windows
diff --git a/lib/meson.build b/lib/meson.build
index a67efaf718..8bc3cc3fdb 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -129,6 +129,7 @@ foreach l:libraries
     headers = []
     indirect_headers = [] # public headers not directly included by apps
     driver_sdk_headers = [] # public headers included by drivers
+    staged_headers_deps = []
     includes = []
     cflags = default_cflags
     objs = [] # other object files to link against, used e.g. for
@@ -214,7 +215,29 @@ foreach l:libraries
         install_headers(driver_sdk_headers)
     endif
     dpdk_chkinc_headers += headers
-    dpdk_chkinc_headers += driver_sdk_headers
+    dpdk_chkinc_driver_headers += driver_sdk_headers
+
+    lib_headers = headers + indirect_headers
+    if lib_headers.length() != 0
+        staged_headers_deps += declare_dependency(sources:
+                custom_target(l + '_header_staging',
+                        output: l + '_header_staging.stamp',
+                        command: [stage_headers_cmd, staging_dir, '@OUTPUT@', lib_headers],
+                        install: false,
+                )
+        )
+    endif
+
+    if driver_sdk_headers.length() != 0
+        staged_headers_deps += declare_dependency(sources:
+                custom_target(l + '_driver_header_staging',
+                        output: l + '_driver_header_staging.stamp',
+                        command: [stage_headers_cmd, drivers_staging_dir, '@OUTPUT@',
+                            driver_sdk_headers],
+                        install: false,
+                )
+        )
+    endif
 
     libname = 'rte_' + name
     includes += include_directories(l)
@@ -223,9 +246,9 @@ foreach l:libraries
     # special case for header only libraries
     if sources.length() == 0
         shared_dep = declare_dependency(include_directories: includes,
-                dependencies: shared_deps)
+                dependencies: shared_deps + staged_headers_deps)
         static_dep = declare_dependency(include_directories: includes,
-                dependencies: static_deps)
+                dependencies: static_deps + staged_headers_deps)
         set_variable('shared_rte_' + name, shared_dep)
         set_variable('static_rte_' + name, static_dep)
         dpdk_shared_lib_deps += shared_dep
@@ -254,7 +277,7 @@ foreach l:libraries
         if sources_avx2.length() > 0
             avx2_lib = static_library(libname + '_avx2_lib',
                     sources_avx2,
-                    dependencies: static_deps,
+                    dependencies: static_deps + staged_headers_deps,
                     include_directories: includes,
                     c_args: [cflags, cc_avx2_flags])
             objs += avx2_lib.extract_objects(sources_avx2)
@@ -263,7 +286,7 @@ foreach l:libraries
             cflags += '-DCC_AVX512_SUPPORT'
             avx512_lib = static_library(libname + '_avx512_lib',
                     sources_avx512,
-                    dependencies: static_deps,
+                    dependencies: static_deps + staged_headers_deps,
                     include_directories: includes,
                     c_args: [cflags, cflags_avx512, cc_avx512_flags])
             objs += avx512_lib.extract_objects(sources_avx512)
@@ -275,12 +298,12 @@ foreach l:libraries
             sources,
             objects: objs,
             c_args: cflags,
-            dependencies: static_deps,
+            dependencies: static_deps + staged_headers_deps,
             include_directories: includes,
             install: true)
     static_dep = declare_dependency(
             include_directories: includes,
-            dependencies: static_deps)
+            dependencies: static_deps + staged_headers_deps)
 
     if is_ms_linker
         link_mode = 'mslinker'
@@ -331,7 +354,7 @@ foreach l:libraries
             sources,
             objects: objs,
             c_args: cflags,
-            dependencies: shared_deps,
+            dependencies: shared_deps + staged_headers_deps,
             include_directories: includes,
             link_args: lk_args,
             link_depends: lk_deps,
@@ -340,7 +363,7 @@ foreach l:libraries
             install: true)
     shared_dep = declare_dependency(link_with: shared_lib,
             include_directories: includes,
-            dependencies: shared_deps)
+            dependencies: shared_deps + staged_headers_deps)
 
     dpdk_libraries = [shared_lib] + dpdk_libraries
     dpdk_static_libraries = [static_lib] + dpdk_static_libraries
diff --git a/meson.build b/meson.build
index 2423884df7..bb21ce7dd4 100644
--- a/meson.build
+++ b/meson.build
@@ -38,6 +38,7 @@ dpdk_static_libraries = []
 dpdk_shared_lib_deps = []
 dpdk_static_lib_deps = []
 dpdk_chkinc_headers = []
+dpdk_chkinc_driver_headers = []
 dpdk_driver_classes = []
 dpdk_drivers = []
 dpdk_extra_ldflags = []
@@ -47,6 +48,8 @@ dpdk_apps_enabled = []
 dpdk_libs_disabled = []
 dpdk_libs_enabled = []
 dpdk_drvs_disabled = []
+staging_dir = []
+drivers_staging_dir = []
 testpmd_drivers_sources = []
 testpmd_drivers_deps = []
 abi_version_file = files('ABI_VERSION')
@@ -73,6 +76,7 @@ global_inc = [include_directories('.', 'config',
 )]
 
 # do configuration and get tool paths
+subdir('staging')
 subdir('buildtools')
 subdir('config')
 
diff --git a/staging/drivers/meson.build b/staging/drivers/meson.build
new file mode 100644
index 0000000000..e29c7c5739
--- /dev/null
+++ b/staging/drivers/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+global_inc += [include_directories('.')]
+drivers_staging_dir = meson.current_build_dir()
diff --git a/staging/meson.build b/staging/meson.build
new file mode 100644
index 0000000000..be13049a7b
--- /dev/null
+++ b/staging/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2025 Red Hat, Inc.
+
+global_inc += [include_directories('.')]
+staging_dir = meson.current_build_dir()
+
+subdir('drivers')
-- 
2.51.0

