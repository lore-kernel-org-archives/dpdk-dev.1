Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B56CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B20354068E;
	Fri, 16 Oct 2026 13:00:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6480B402EE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148407; x=1823684407;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kHGh8aHvRmHE43M3bARRSLHQ/G7G7rASGSQ8/RNSETw=;
 b=Bl+aLH4a0gFZKKKItc1XBTxrZ22Z84qbDhnDl/i95zBh+yZYZP0qP+xn
 r6gogpfIUjWcABcgg2Fi32wq66ilMbiSlUjUmEKmQHwLXz8oFWsAovozZ
 gVOb0wVcxexGeGeC/C2yZCUM2s37SGcBC5ITjAIPySQGj+lOW8xRrvxGd
 nul7HlUQSGAw8vrySMQheYIHlDlisRlIn0YWhLE+O+MU1+fofE9xkOh10
 BdbpSpqwfw1mWkqJfwUP9MsY2MdpdNIOTRzdrUsfozNq+nqtk3bb1f+8C
 MjdGuwK7Mw+I6uXxfVQ9fVWQNha2bPb5NvueeGbwZVfWL5W9OIcgc+MjW Q==;
X-CSE-ConnectionGUID: fL0HKJJ3RW6TI83qGkgDiA==
X-CSE-MsgGUID: RL8uw6k1SauyUGC4S30TZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944133"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944133"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:06 -0700
X-CSE-ConnectionGUID: nD6y+f6FQLyC4Cp7EybUpA==
X-CSE-MsgGUID: 1ctxMGUOSdyKpsGz6a/SqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759379"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 04/12] build: add direct support for optional dependencies
Date: Fri, 16 Oct 2026 11:59:42 +0100
Message-ID: <20261016105950.273068-5-bruce.richardson@intel.com>
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

A number of DPDK components sometimes expose extra capabilities if other
drivers are present, without actually requiring that to be always
present. Standardize that design by way of an "optional_deps" variable
to be set in meson.build files.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/meson.build                   | 10 ++++++-
 app/proc-info/meson.build         |  4 +--
 app/test-bbdev/meson.build        | 18 ++++-------
 app/test-crypto-perf/meson.build  |  4 +--
 app/test-pmd/meson.build          | 50 ++++++++++---------------------
 app/test/meson.build              |  6 ----
 drivers/meson.build               |  9 ++++++
 drivers/net/intel/ice/meson.build |  7 +++--
 lib/meson.build                   | 10 ++++++-
 9 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index 7472d925b2..79a0672edc 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -63,9 +63,11 @@ foreach app:apps
               # instruction-set optimized versions of code
 
     # use "deps" for internal DPDK dependencies, and "ext_deps" for
-    # external package/library requirements
+    # external package/library requirements. Use "optional_deps" for internal
+    # dependencies to link against only if they are already being built.
     ext_deps = []
     deps = []
+    optional_deps = []
 
     if not enable_apps.contains(app)
         build = false
@@ -99,6 +101,12 @@ foreach app:apps
             endif
             dep_objs += [get_variable(var_name)]
         endforeach
+        foreach d:optional_deps
+            var_name = get_option('default_library') + '_rte_' + d
+            if is_variable(var_name) and not deps.contains(d)
+                dep_objs += [get_variable(var_name)]
+            endif
+        endforeach
     endif
 
     if not build
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 316253cd5d..60c4eb2a90 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -9,8 +9,6 @@ endif
 
 sources = files('main.c')
 deps += ['ethdev', 'security', 'eventdev']
-if dpdk_conf.has('RTE_LIB_METRICS')
-    deps += 'metrics'
-endif
+optional_deps = ['metrics']
 
 cflags += no_wvla_cflag
diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
index f85a20c5b0..c3cdd4d7c5 100644
--- a/app/test-bbdev/meson.build
+++ b/app/test-bbdev/meson.build
@@ -8,17 +8,11 @@ sources = files(
         'test_bbdev_vector.c',
 )
 deps += ['bbdev', 'bus_vdev']
-if dpdk_conf.has('RTE_BASEBAND_FPGA_LTE_FEC')
-    deps += ['baseband_fpga_lte_fec']
-endif
-if dpdk_conf.has('RTE_BASEBAND_FPGA_5GNR_FEC')
-    deps += ['baseband_fpga_5gnr_fec']
-endif
-if dpdk_conf.has('RTE_BASEBAND_ACC')
-    deps += ['baseband_acc']
-endif
-if dpdk_conf.has('RTE_BASEBAND_LA12XX')
-    deps += ['baseband_la12xx']
-endif
+optional_deps = [
+        'baseband_acc',
+        'baseband_fpga_5gnr_fec',
+        'baseband_fpga_lte_fec',
+        'baseband_la12xx',
+]
 
 cflags += no_wvla_cflag
diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
index 87dd3bc5f1..76de68bfaf 100644
--- a/app/test-crypto-perf/meson.build
+++ b/app/test-crypto-perf/meson.build
@@ -20,8 +20,6 @@ sources = files(
         'main.c',
 )
 deps += ['cryptodev', 'net', 'security']
-if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
-    deps += 'crypto_scheduler'
-endif
+optional_deps = ['crypto_scheduler']
 
 cflags += no_wvla_cflag
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index 83163a5406..82ec6626f3 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -35,42 +35,24 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
 endif
 
 deps += ['ethdev', 'cmdline', 'pci']
-if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
-    deps += 'crypto_scheduler'
-endif
-if dpdk_conf.has('RTE_LIB_BITRATESTATS')
-    deps += 'bitratestats'
-endif
+optional_deps = [
+        'bitratestats',
+        'bpf',
+        'bus_dpaa',
+        'crypto_scheduler',
+        'gro',
+        'gso',
+        'latencystats',
+        'mempool_dpaa',
+        'metrics',
+        'net_bnxt',
+        'net_dpaa',
+        'net_i40e',
+        'net_ixgbe',
+        'pdump',
+]
 if dpdk_conf.has('RTE_LIB_BPF')
     sources += files('bpf_cmd.c')
-    deps += 'bpf'
-endif
-if dpdk_conf.has('RTE_LIB_GRO')
-    deps += 'gro'
-endif
-if dpdk_conf.has('RTE_LIB_GSO')
-    deps += 'gso'
-endif
-if dpdk_conf.has('RTE_LIB_LATENCYSTATS')
-    deps += 'latencystats'
-endif
-if dpdk_conf.has('RTE_LIB_METRICS')
-    deps += 'metrics'
-endif
-if dpdk_conf.has('RTE_LIB_PDUMP')
-    deps += 'pdump'
-endif
-if dpdk_conf.has('RTE_NET_BNXT')
-    deps += 'net_bnxt'
-endif
-if dpdk_conf.has('RTE_NET_I40E')
-    deps += 'net_i40e'
-endif
-if dpdk_conf.has('RTE_NET_IXGBE')
-    deps += 'net_ixgbe'
-endif
-if dpdk_conf.has('RTE_NET_DPAA')
-    deps += ['bus_dpaa', 'mempool_dpaa', 'net_dpaa']
 endif
 
 # Driver-specific commands are located in driver directories.
diff --git a/app/test/meson.build b/app/test/meson.build
index 881b919b63..0b2f4fd708 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -259,12 +259,6 @@ foreach f, f_deps : source_file_deps
         sources += files(f)
     endif
 endforeach
-# add the optional dependencies
-foreach d:optional_deps
-    if is_variable(def_lib + '_rte_' + d) and d not in deps
-        deps += d
-    endif
-endforeach
 
 cflags += no_wvla_cflag
 cflags += no_shadow_cflag
diff --git a/drivers/meson.build b/drivers/meson.build
index 440c3959cf..e75fa983e2 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -174,6 +174,9 @@ foreach subpath:subdirs
         includes = [include_directories(drv_path)]
         # set up internal deps. Drivers can append/override as necessary
         deps = std_deps
+        # optional_deps: internal dependencies to link against only if they are
+        # already being built, rather than being always required
+        optional_deps = []
         # ext_deps: Stores external library dependency got
         # using dependency() (preferred) or find_library().
         # For the find_library() case (but not with dependency()) we also
@@ -249,6 +252,12 @@ foreach subpath:subdirs
                     static_deps += [get_variable('static_rte_' + d)]
                 endif
             endforeach
+            foreach d:optional_deps
+                if build and is_variable('shared_rte_' + d) and not deps.contains(d)
+                    shared_deps += [get_variable('shared_rte_' + d)]
+                    static_deps += [get_variable('static_rte_' + d)]
+                endif
+            endforeach
         endif
 
         if not build
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 322d9597d2..e5ba7ac92c 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -22,9 +22,10 @@ testpmd_sources = files('ice_testpmd.c')
 
 deps += ['hash', 'net']
 
-if dpdk_conf.has('RTE_NET_IAVF')
-    deps += 'net_iavf'
-else
+# link against the iavf driver if it is being built, otherwise build the parts
+# of it needed here directly into this driver
+optional_deps = ['net_iavf']
+if not dpdk_conf.has('RTE_NET_IAVF')
     includes += include_directories(
             '../iavf',
             '../iavf/base'
diff --git a/lib/meson.build b/lib/meson.build
index 0c5da21522..87bfb914e8 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -137,9 +137,11 @@ foreach l:libraries
               # instruction-set optimized versions of code
 
     # use "deps" for internal DPDK dependencies, and "ext_deps" for
-    # external package/library requirements
+    # external package/library requirements. Use "optional_deps" for internal
+    # dependencies to link against only if they are already being built.
     ext_deps = []
     deps = []
+    optional_deps = []
     if dpdk_conf.has('RTE_LIB_EAL')
         # eal is standard dependency once built
         deps += ['eal']
@@ -201,6 +203,12 @@ foreach l:libraries
             static_deps += [get_variable('static_rte_' + d)]
         endif
     endforeach
+    foreach d:optional_deps
+        if build and is_variable('shared_rte_' + d) and not deps.contains(d)
+            shared_deps += [get_variable('shared_rte_' + d)]
+            static_deps += [get_variable('static_rte_' + d)]
+        endif
+    endforeach
 
     if not build
         dpdk_libs_disabled += name
-- 
2.53.0

