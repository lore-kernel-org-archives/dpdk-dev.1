Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC861CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 06:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC44C40A7A;
	Tue, 30 Sep 2025 08:58:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE76406B4
 for <dev@dpdk.org>; Tue, 30 Sep 2025 08:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759215516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktP9nYyFdlnE73rJ5UoUZzIjjNzdOpXbqum5LkXOiUo=;
 b=GkhqbXJ3jjd5RBJy/KDhtQ3mDPM7epklvFaDk4pa2J4UuDjKIUtkziCDOT9S33Q/gjXrfm
 vjT11bZyAjbrSAp8E0gGG879WrnqpIXowesBtgiGge+tnkjAV1efJ0gQ+RsP/Q6jauEP5J
 58HeNj3z+YKa25JviGURIh/AL0wGPkU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-Jl55Edu5MdSs8S2f0THh2g-1; Tue,
 30 Sep 2025 02:58:33 -0400
X-MC-Unique: Jl55Edu5MdSs8S2f0THh2g-1
X-Mimecast-MFC-AGG-ID: Jl55Edu5MdSs8S2f0THh2g_1759215511
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DC7919560B5; Tue, 30 Sep 2025 06:58:30 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A173F195608E; Tue, 30 Sep 2025 06:58:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Min Zhou <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 7/9] build: factorize headers installation
Date: Tue, 30 Sep 2025 08:57:37 +0200
Message-ID: <20250930065740.1838899-8-david.marchand@redhat.com>
In-Reply-To: <20250930065740.1838899-1-david.marchand@redhat.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250930065740.1838899-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xXnSmtczcPzKS6FoBbf_G6yZVRVeAcNvcAe8W7vRT-0_1759215511
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

Gather all headers in global variables, put headers installation
in a single location and make the headers check use them instead of
dpdk_chkinc_headers.

This rework reveals a number of issues:
- net/txgbe driver was directly installing its header, bypassing
  drivers/meson.build and skipping the headers check,
- arch headers were not checked except for x86,
- some driver headers were not checked,

For the last point, a build warning must be disabled (like it is
globally in DPDK) for headers from raw drivers.

Finally, checkpatches is updated to avoid reintroductions of
install_headers().

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 buildtools/chkincs/meson.build        |  7 +++++--
 config/meson.build                    |  3 +--
 devtools/checkpatches.sh              |  9 +++++++++
 drivers/meson.build                   |  7 ++-----
 drivers/net/txgbe/meson.build         |  2 +-
 lib/eal/arm/include/meson.build       |  3 +--
 lib/eal/include/meson.build           |  3 +--
 lib/eal/loongarch/include/meson.build |  3 +--
 lib/eal/ppc/include/meson.build       |  3 +--
 lib/eal/riscv/include/meson.build     |  3 +--
 lib/eal/x86/include/meson.build       |  6 ++----
 lib/meson.build                       | 10 +++-------
 meson.build                           | 15 ++++++++++++++-
 13 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index 49dbc55254..ac7df41304 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -12,10 +12,13 @@ gen_c_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cflags = machine_args
+if cc.has_argument('-Wno-missing-field-initializers')
+    cflags += '-Wno-missing-field-initializers'
+endif
 cflags += no_wvla_cflag
 
 sources = files('main.c')
-sources += gen_c_files.process(dpdk_chkinc_headers)
+sources += gen_c_files.process(dpdk_arch_headers + dpdk_headers + dpdk_drivers_headers)
 
 # some driver SDK headers depend on these two buses, which are mandatory in build
 # so we always include them in deps list
@@ -56,7 +59,7 @@ gen_cpp_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cpp_sources = files('main.cpp')
-cpp_sources += gen_cpp_files.process(dpdk_chkinc_headers)
+cpp_sources += gen_cpp_files.process(dpdk_arch_headers + dpdk_headers + dpdk_drivers_headers)
 
 executable('chkincs-cpp', cpp_sources,
         cpp_args: ['-include', 'rte_config.h', cflags],
diff --git a/config/meson.build b/config/meson.build
index 55497f0bf5..f737b67c36 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -456,8 +456,7 @@ endif
 # set the install path for the drivers
 dpdk_conf.set_quoted('RTE_EAL_PMD_PATH', eal_pmd_path)
 
-install_headers(['rte_config.h'],
-        subdir: get_option('include_subdir_arch'))
+dpdk_arch_headers += files('rte_config.h')
 
 # enable VFIO only if it is linux OS
 dpdk_conf.set('RTE_EAL_VFIO', is_linux)
diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 35037aa8f1..d4b86922c9 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -87,6 +87,15 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
+	# don't call directly install_headers()
+	awk -v FOLDERS="lib drivers" \
+		-v SKIP_FILES='meson.build' \
+		-v EXPRESSIONS="\\\<install_headers\\\>" \
+		-v RET_ON_FAIL=1 \
+		-v MESSAGE='Using install_headers()' \
+		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
+		"$1" || res=1
+
 	# refrain from using compiler attribute without defining a common macro
 	awk -v FOLDERS="lib drivers app examples" \
 		-v SKIP_FILES='lib/eal/include/rte_common.h' \
diff --git a/drivers/meson.build b/drivers/meson.build
index f25f425565..424acb03a7 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -241,11 +241,8 @@ foreach subpath:subdirs
 
         dpdk_extra_ldflags += pkgconfig_extra_libs
 
-        install_headers(headers)
-        if get_option('enable_driver_sdk')
-            install_headers(driver_sdk_headers)
-        endif
-        dpdk_chkinc_headers += driver_sdk_headers
+        dpdk_headers += headers
+        dpdk_drivers_headers += driver_sdk_headers
 
         if headers.length() > 0
             dpdk_includes += include_directories(drv_path)
diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index 4dbbf597bb..5cdec017ed 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -31,4 +31,4 @@ elif arch_subdir == 'arm'
     sources += files('txgbe_rxtx_vec_neon.c')
 endif
 
-install_headers('rte_pmd_txgbe.h')
+headers = files('rte_pmd_txgbe.h')
diff --git a/lib/eal/arm/include/meson.build b/lib/eal/arm/include/meson.build
index 657bf58569..822ddac520 100644
--- a/lib/eal/arm/include/meson.build
+++ b/lib/eal/arm/include/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation.
 
-arch_headers = files(
+dpdk_arch_headers += files(
         'rte_atomic_32.h',
         'rte_atomic_64.h',
         'rte_atomic.h',
@@ -28,4 +28,3 @@ arch_headers = files(
         'rte_spinlock.h',
         'rte_vect.h',
 )
-install_headers(arch_headers, subdir: get_option('include_subdir_arch'))
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index d903577caa..aef5824e5f 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -64,7 +64,7 @@ driver_sdk_headers = files(
 )
 
 # special case install the generic headers, since they go in a subdir
-generic_headers = files(
+dpdk_generic_headers += files(
         'generic/rte_atomic.h',
         'generic/rte_byteorder.h',
         'generic/rte_cpuflags.h',
@@ -78,4 +78,3 @@ generic_headers = files(
         'generic/rte_spinlock.h',
         'generic/rte_vect.h',
 )
-install_headers(generic_headers, subdir: 'generic')
diff --git a/lib/eal/loongarch/include/meson.build b/lib/eal/loongarch/include/meson.build
index 6e8d12601a..574aa6dac2 100644
--- a/lib/eal/loongarch/include/meson.build
+++ b/lib/eal/loongarch/include/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2022 Loongson Technology Corporation Limited
 
-arch_headers = files(
+dpdk_arch_headers += files(
         'rte_atomic.h',
         'rte_byteorder.h',
         'rte_cpuflags.h',
@@ -15,4 +15,3 @@ arch_headers = files(
         'rte_spinlock.h',
         'rte_vect.h',
 )
-install_headers(arch_headers, subdir: get_option('include_subdir_arch'))
diff --git a/lib/eal/ppc/include/meson.build b/lib/eal/ppc/include/meson.build
index fa64330f01..87887187b8 100644
--- a/lib/eal/ppc/include/meson.build
+++ b/lib/eal/ppc/include/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
 
-arch_headers = files(
+dpdk_arch_headers += files(
         'rte_altivec.h',
         'rte_atomic.h',
         'rte_byteorder.h',
@@ -16,4 +16,3 @@ arch_headers = files(
         'rte_spinlock.h',
         'rte_vect.h',
 )
-install_headers(arch_headers, subdir: get_option('include_subdir_arch'))
diff --git a/lib/eal/riscv/include/meson.build b/lib/eal/riscv/include/meson.build
index 481c7d50a4..a7a387fb8a 100644
--- a/lib/eal/riscv/include/meson.build
+++ b/lib/eal/riscv/include/meson.build
@@ -3,7 +3,7 @@
 # Copyright(c) 2022 SiFive
 # Copyright(c) 2022 Semihalf
 
-arch_headers = files(
+dpdk_arch_headers += files(
         'rte_atomic.h',
         'rte_byteorder.h',
         'rte_cpuflags.h',
@@ -17,4 +17,3 @@ arch_headers = files(
         'rte_spinlock.h',
         'rte_vect.h',
 )
-install_headers(arch_headers, subdir: get_option('include_subdir_arch'))
diff --git a/lib/eal/x86/include/meson.build b/lib/eal/x86/include/meson.build
index 52d2f8e969..71f149e821 100644
--- a/lib/eal/x86/include/meson.build
+++ b/lib/eal/x86/include/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-arch_headers = files(
+dpdk_arch_headers += files(
         'rte_atomic.h',
         'rte_byteorder.h',
         'rte_cpuflags.h',
@@ -16,11 +16,9 @@ arch_headers = files(
         'rte_spinlock.h',
         'rte_vect.h',
 )
-arch_indirect_headers = files(
+dpdk_arch_indirect_headers += files(
         'rte_atomic_32.h',
         'rte_atomic_64.h',
         'rte_byteorder_32.h',
         'rte_byteorder_64.h',
 )
-install_headers(arch_headers + arch_indirect_headers, subdir: get_option('include_subdir_arch'))
-dpdk_chkinc_headers += arch_headers
diff --git a/lib/meson.build b/lib/meson.build
index a67efaf718..d79740a4c3 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -208,13 +208,9 @@ foreach l:libraries
 
     dpdk_libs_enabled += name
     dpdk_conf.set('RTE_LIB_' + name.to_upper(), 1)
-    install_headers(headers)
-    install_headers(indirect_headers)
-    if get_option('enable_driver_sdk')
-        install_headers(driver_sdk_headers)
-    endif
-    dpdk_chkinc_headers += headers
-    dpdk_chkinc_headers += driver_sdk_headers
+    dpdk_headers += headers
+    dpdk_indirect_headers += indirect_headers
+    dpdk_drivers_headers += driver_sdk_headers
 
     libname = 'rte_' + name
     includes += include_directories(l)
diff --git a/meson.build b/meson.build
index 2423884df7..9f0b06179b 100644
--- a/meson.build
+++ b/meson.build
@@ -37,7 +37,12 @@ dpdk_libraries = []
 dpdk_static_libraries = []
 dpdk_shared_lib_deps = []
 dpdk_static_lib_deps = []
-dpdk_chkinc_headers = []
+dpdk_arch_headers = []
+dpdk_arch_indirect_headers = []
+dpdk_generic_headers = []
+dpdk_headers = []
+dpdk_indirect_headers = []
+dpdk_drivers_headers = []
 dpdk_driver_classes = []
 dpdk_drivers = []
 dpdk_extra_ldflags = []
@@ -106,6 +111,14 @@ if get_option('check_includes')
     subdir('buildtools/chkincs')
 endif
 
+install_headers(dpdk_arch_headers + dpdk_arch_indirect_headers,
+        subdir: get_option('include_subdir_arch'))
+install_headers(dpdk_headers + dpdk_indirect_headers)
+install_headers(dpdk_generic_headers, subdir: 'generic')
+if get_option('enable_driver_sdk')
+    install_headers(dpdk_drivers_headers)
+endif
+
 # write the build config
 build_cfg = 'rte_build_config.h'
 configure_file(output: build_cfg,
-- 
2.51.0

