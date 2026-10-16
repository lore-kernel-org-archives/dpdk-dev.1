Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8B3CCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1151340B95;
	Fri, 16 Oct 2026 13:00:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E86A040663
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148413; x=1823684413;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1Jxp1T6ggCaa5kC7P0Mzcq7DEHKlYe7bSdQItkA4HrM=;
 b=JAJ5bZGuk6pfpjM0c67bSfYhb226iXD6TZWQgTzlVzq0QQpnhtBti1OB
 qpb9JcM3hmf6XhjYjVPraiRIgAh1AdejF0jQFAbmFf9sc88M+IthL1ws2
 Gn0MPJKyYIL2HXR7PUi0OYz/Dc1PCJhgZuT1takAsmUyFfRpv05B2hCXz
 BAkiRIjQZ7/luWNaFJUBOUMIoszhmQgagay+qZ5g4GkYYFJyvE4x/KOon
 uAaW3pSv2jxU1ecJXiSQvTiR26bW9KZnpkaXjEHqKuv1GdsXtrX4WNFg8
 lLw60d/OXj9ZR3yZX9mNr56XnxxK4UuYFxQoehXPd2wXR5E8TiD3qE8+G w==;
X-CSE-ConnectionGUID: u0Fviv6RRaCUT+pmhumMvA==
X-CSE-MsgGUID: 6tVEMEr6QcCGvCo0vBqIxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944149"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944149"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:12 -0700
X-CSE-ConnectionGUID: Cf/oEFbaRxWC/LD4ZXmExw==
X-CSE-MsgGUID: hJFEbBeHSjqxUz0LsbWu/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759411"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 11/12] build: make EAL an explicit dependency
Date: Fri, 16 Oct 2026 11:59:49 +0100
Message-ID: <20261016105950.273068-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

To improve dependency tracking using the querying script, remove EAL as
an automatic dependency of libraries, and instead include it explicitly
in the dependency list of libraries that need it (and don't have it via
other existing dependencies).

In the process, we can simplify dependency lists a bit more by removing
the conditional link between EAL and telemetry on windows. Since
telemetry is always built, it can always be present as a dependency of
EAL, and so need not be specified as a dependency when EAL is.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/acl/meson.build          | 1 +
 lib/cfgfile/meson.build      | 1 +
 lib/cryptodev/meson.build    | 2 +-
 lib/dmadev/meson.build       | 2 +-
 lib/eal/meson.build          | 5 +----
 lib/ethdev/meson.build       | 2 +-
 lib/eventdev/meson.build     | 1 -
 lib/ipsec/meson.build        | 2 +-
 lib/jobstats/meson.build     | 1 +
 lib/mempool/meson.build      | 2 +-
 lib/meson.build              | 4 ----
 lib/meter/meson.build        | 1 +
 lib/metrics/meson.build      | 2 +-
 lib/pci/meson.build          | 1 +
 lib/ptr_compress/meson.build | 1 +
 lib/rawdev/meson.build       | 2 +-
 lib/ring/meson.build         | 2 +-
 lib/stack/meson.build        | 1 +
 lib/timer/meson.build        | 1 +
 19 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index a26c111395..e41e1d1d4d 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -9,6 +9,7 @@ endif
 
 cflags += no_wvla_cflag
 
+deps += ['eal']
 sources = files('acl_bld.c', 'acl_gen.c', 'acl_run_scalar.c',
         'rte_acl.c', 'tb_mem.c')
 headers = files('rte_acl.h', 'rte_acl_osdep.h')
diff --git a/lib/cfgfile/meson.build b/lib/cfgfile/meson.build
index 88eb819856..d6d690ccaa 100644
--- a/lib/cfgfile/meson.build
+++ b/lib/cfgfile/meson.build
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+deps += ['eal']
 sources = files('rte_cfgfile.c')
 headers = files('rte_cfgfile.h')
diff --git a/lib/cryptodev/meson.build b/lib/cryptodev/meson.build
index 4734acf321..2dcadb3513 100644
--- a/lib/cryptodev/meson.build
+++ b/lib/cryptodev/meson.build
@@ -20,4 +20,4 @@ driver_sdk_headers += files(
         'cryptodev_pmd.h',
 )
 
-deps += ['kvargs', 'mbuf', 'rcu', 'telemetry']
+deps += ['kvargs', 'mbuf', 'rcu']
diff --git a/lib/dmadev/meson.build b/lib/dmadev/meson.build
index 62b0650b9b..4352178783 100644
--- a/lib/dmadev/meson.build
+++ b/lib/dmadev/meson.build
@@ -6,4 +6,4 @@ headers = files('rte_dmadev.h')
 indirect_headers += files('rte_dmadev_core.h', 'rte_dmadev_trace_fp.h')
 driver_sdk_headers += files('rte_dmadev_pmd.h')
 
-deps += ['telemetry']
+deps += ['eal']
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e72276a7ca..ee84f4852a 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -13,10 +13,7 @@ subdir(exec_env)
 
 subdir(arch_subdir)
 
-deps += ['argparse', 'kvargs']
-if not is_windows
-    deps += ['telemetry']
-endif
+deps += ['argparse', 'kvargs', 'telemetry']
 
 if dpdk_conf.has('RTE_HAS_LIBARCHIVE')
     ext_deps += libarchive
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a2..c9c141db02 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -53,7 +53,7 @@ if is_linux
     )
 endif
 
-deps += ['net', 'kvargs', 'meter', 'telemetry']
+deps += ['net', 'kvargs', 'meter']
 
 if is_freebsd
     annotate_locks = false
diff --git a/lib/eventdev/meson.build b/lib/eventdev/meson.build
index 0797c145e7..6df290bd23 100644
--- a/lib/eventdev/meson.build
+++ b/lib/eventdev/meson.build
@@ -44,4 +44,3 @@ driver_sdk_headers += files(
 )
 
 deps += ['ring', 'ethdev', 'hash', 'mempool', 'mbuf', 'timer', 'cryptodev', 'dmadev']
-deps += ['telemetry']
diff --git a/lib/ipsec/meson.build b/lib/ipsec/meson.build
index 02d18f5829..7c5cb44128 100644
--- a/lib/ipsec/meson.build
+++ b/lib/ipsec/meson.build
@@ -16,6 +16,6 @@ sources = files('esp_inb.c', 'esp_outb.c',
 headers = files('rte_ipsec.h', 'rte_ipsec_sa.h', 'rte_ipsec_sad.h')
 indirect_headers += files('rte_ipsec_group.h')
 
-deps += ['mbuf', 'net', 'cryptodev', 'security', 'hash', 'telemetry']
+deps += ['mbuf', 'net', 'cryptodev', 'security', 'hash']
 
 annotate_locks = false
diff --git a/lib/jobstats/meson.build b/lib/jobstats/meson.build
index 6da2a95b75..b7544aa035 100644
--- a/lib/jobstats/meson.build
+++ b/lib/jobstats/meson.build
@@ -7,5 +7,6 @@ if is_windows
     subdir_done()
 endif
 
+deps += ['eal']
 sources = files('rte_jobstats.c')
 headers = files('rte_jobstats.h')
diff --git a/lib/mempool/meson.build b/lib/mempool/meson.build
index 8099a56466..db67349668 100644
--- a/lib/mempool/meson.build
+++ b/lib/mempool/meson.build
@@ -19,4 +19,4 @@ headers = files(
         'rte_mempool.h',
         'rte_mempool_trace_fp.h',
 )
-deps += ['ring', 'telemetry']
+deps += ['ring']
diff --git a/lib/meson.build b/lib/meson.build
index 16c7a65786..34fbd93977 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -143,10 +143,6 @@ foreach l:libraries
     ext_deps = []
     deps = []
     optional_deps = []
-    if dpdk_conf.has('RTE_LIB_EAL')
-        # eal is standard dependency once built
-        deps += ['eal']
-    endif
 
     if dpdk_libs_deprecated.contains(l)
         if not enable_deprecated_libs.contains(l)
diff --git a/lib/meter/meson.build b/lib/meter/meson.build
index 646fd4d43f..e9e4aba506 100644
--- a/lib/meter/meson.build
+++ b/lib/meter/meson.build
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+deps += ['eal']
 sources = files('rte_meter.c')
 headers = files('rte_meter.h')
diff --git a/lib/metrics/meson.build b/lib/metrics/meson.build
index 6722f666d2..7dfc48b3ec 100644
--- a/lib/metrics/meson.build
+++ b/lib/metrics/meson.build
@@ -8,6 +8,6 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
 endif
 
-deps += ['ethdev', 'telemetry']
+deps += ['ethdev']
 
 cflags += no_wvla_cflag
diff --git a/lib/pci/meson.build b/lib/pci/meson.build
index dd41cd5068..3b42932ac7 100644
--- a/lib/pci/meson.build
+++ b/lib/pci/meson.build
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+deps += ['eal']
 sources = files('rte_pci.c')
 headers = files('rte_pci.h')
diff --git a/lib/ptr_compress/meson.build b/lib/ptr_compress/meson.build
index e92706a45f..07705034ac 100644
--- a/lib/ptr_compress/meson.build
+++ b/lib/ptr_compress/meson.build
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 Arm Limited
 
+deps += ['eal']
 headers = files('rte_ptr_compress.h')
diff --git a/lib/rawdev/meson.build b/lib/rawdev/meson.build
index ccfd922fda..9a2478492c 100644
--- a/lib/rawdev/meson.build
+++ b/lib/rawdev/meson.build
@@ -11,4 +11,4 @@ sources = files('rte_rawdev.c')
 headers = files('rte_rawdev.h')
 driver_sdk_headers = files('rte_rawdev_pmd.h')
 
-deps += ['telemetry']
+deps += ['eal']
diff --git a/lib/ring/meson.build b/lib/ring/meson.build
index 2ba160b178..a1b709836d 100644
--- a/lib/ring/meson.build
+++ b/lib/ring/meson.build
@@ -18,4 +18,4 @@ indirect_headers += files (
         'rte_ring_rts.h',
         'rte_ring_rts_elem_pvt.h',
 )
-deps += ['telemetry']
+deps += ['eal']
diff --git a/lib/stack/meson.build b/lib/stack/meson.build
index 18177a742f..cd569665b9 100644
--- a/lib/stack/meson.build
+++ b/lib/stack/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
+deps += ['eal']
 sources = files('rte_stack.c', 'rte_stack_std.c', 'rte_stack_lf.c')
 headers = files('rte_stack.h')
 # subheaders, not for direct inclusion by apps
diff --git a/lib/timer/meson.build b/lib/timer/meson.build
index 66ef89ac00..a8d89a8d93 100644
--- a/lib/timer/meson.build
+++ b/lib/timer/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
+deps += ['eal']
 sources = files('rte_timer.c')
 headers = files('rte_timer.h')
 
-- 
2.53.0

