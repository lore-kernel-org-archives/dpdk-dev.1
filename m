Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C27C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4219A402E5;
	Tue, 18 Feb 2025 12:15:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0C878402DA
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877345; x=1771413345;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3nPbQGJXYt7ERY+1IwU9gfIkMBEueheLJbGqI1b0ZS4=;
 b=QzmwoEB9IlCKd1/vhe3vvEXgNPW4lixJDLA0IPTaCsVQbHorTo1HYTIe
 rvvEtmPBV92YI2A3aU0EbzTFC9jif7cp+u+gHvwwVBgPxmn2t9cMh46kr
 UTJGFd7smdrXVJ+QkFyjtkONuCcgTCzBYPJcVPhOTZMnj/J8xNJONMJFo
 MLFrxwDCey1fCaU44pLEnwK3kDMJsa0mb2a9aUN+Xw2cx95YdBYmaYLq0
 UcMOdfOd+JnAEuST5OlBqv1vqxtBeAS4n5JbHMulrf08DJr0lyzrOGoIn
 GyM9wpFqQXX5pOgXHVeiDd4kjANe4Pag6MXvMaswvYzRe83koktv8ndtp Q==;
X-CSE-ConnectionGUID: WXdjemfWSJ+k8ctRYqNtCA==
X-CSE-MsgGUID: jlziQR+KTBuuP+ccC5dtcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780803"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780803"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:44 -0800
X-CSE-ConnectionGUID: hGNpo1jzTvCXQlgVV06TCw==
X-CSE-MsgGUID: sBj8omXaTvSArkR8Y/MKeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466252"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:41 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Brian Dooley <brian.dooley@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v6 1/8] build: introduce optional internal dependencies
Date: Tue, 18 Feb 2025 11:15:27 +0000
Message-ID: <6a2c1083c2196b6dbf39f3fe043e3336e5216358.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

Allow specifying internal dependencies as either mandatory or optional.
Specifying a dependency as optional will mean that the component being
built will be skipped if said dependency is not being built. At build
time, the build system will resolve any optional dependencies and add
them to the list of dependencies to be built. Any source files requiring
said optional depepdencies will still have to be added explicitly to the
build by the respective component (e.g. adding BPF-related files when BPF
support is being built).

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v4 -> v5:
    - Automatically handle optional dependencies based on Bruce's
      earlier patch [1]
    
    [1] https://patches.dpdk.org/project/dpdk/patch/20231220142152.492556-4-bruce.richardson@intel.com/

 app/meson.build                       | 14 ++++++-
 app/proc-info/meson.build             |  4 +-
 app/test-bbdev/meson.build            | 18 +++------
 app/test-crypto-perf/meson.build      |  4 +-
 app/test-pmd/meson.build              | 56 +++++++++------------------
 app/test/meson.build                  | 12 +++---
 drivers/meson.build                   | 13 ++++++-
 examples/ethtool/meson.build          |  4 +-
 examples/l2fwd-crypto/meson.build     |  4 +-
 examples/l3fwd/meson.build            |  4 +-
 examples/meson.build                  | 13 ++++++-
 examples/vm_power_manager/meson.build | 16 +++-----
 lib/meson.build                       | 13 ++++++-
 13 files changed, 89 insertions(+), 86 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index e2db888ae1..61202495bd 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -66,6 +66,7 @@ foreach app:apps
     # external package/library requirements
     ext_deps = []
     deps = []
+    optional_deps = []
 
     if not enable_apps.contains(app)
         build = false
@@ -83,10 +84,19 @@ foreach app:apps
         endif
     endif
 
+    # resolve any optional internal dependencies
+    def_lib = get_option('default_library')
+    foreach d: optional_deps
+        # if optional dependency is defined, add it to the deps list
+        if is_variable(def_lib + '_rte_' + d)
+            deps += [d]
+        endif
+    endforeach
+
     if build
         dep_objs = []
         foreach d:deps
-            var_name = get_option('default_library') + '_rte_' + d
+            var_name = def_lib + '_rte_' + d
             if not is_variable(var_name)
                 build = false
                 reason = 'missing internal dependency, "@0@"'.format(d)
@@ -111,7 +121,7 @@ foreach app:apps
 
     dpdk_apps_enabled += app
     link_libs = []
-    if get_option('default_library') == 'static'
+    if def_lib == 'static'
         link_libs = dpdk_static_libraries + dpdk_drivers
     endif
 
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 316253cd5d..51315f72a1 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -9,8 +9,6 @@ endif
 
 sources = files('main.c')
 deps += ['ethdev', 'security', 'eventdev']
-if dpdk_conf.has('RTE_LIB_METRICS')
-    deps += 'metrics'
-endif
+optional_deps += 'metrics'
 
 cflags += no_wvla_cflag
diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
index 85b060edec..d41bd60396 100644
--- a/app/test-bbdev/meson.build
+++ b/app/test-bbdev/meson.build
@@ -14,17 +14,11 @@ sources = files(
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
+optional_deps += [
+        'baseband_fpga_lte_fec',
+        'baseband_fpga_5gnr_fec',
+        'baseband_acc',
+        'baseband_la12xx',
+]
 
 cflags += no_wvla_cflag
diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
index 87dd3bc5f1..fb48d9ec29 100644
--- a/app/test-crypto-perf/meson.build
+++ b/app/test-crypto-perf/meson.build
@@ -20,8 +20,6 @@ sources = files(
         'main.c',
 )
 deps += ['cryptodev', 'net', 'security']
-if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
-    deps += 'crypto_scheduler'
-endif
+optional_deps += 'crypto_scheduler'
 
 cflags += no_wvla_cflag
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index f1c36529b4..bbc8d429f8 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -34,47 +34,29 @@ sources = files(
 if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
 endif
-
-deps += ['ethdev', 'cmdline']
-if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
-    deps += 'crypto_scheduler'
-endif
-if dpdk_conf.has('RTE_LIB_BITRATESTATS')
-    deps += 'bitratestats'
-endif
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
 
+deps += ['ethdev', 'cmdline']
+optional_deps += [
+        'crypto_scheduler',
+        'bitratestats',
+        'bpf',
+        'gro',
+        'gso',
+        'latencystats',
+        'metrics',
+        'pdump',
+        'net_bnxt',
+        'net_i40e',
+        'net_ixgbe',
+        'bus_dpaa',
+        'mempool_dpaa',
+        'net_dpaa',
+]
+
 # Driver-specific commands are located in driver directories.
 includes = include_directories('.')
 sources += testpmd_drivers_sources
-deps += testpmd_drivers_deps
+optional_deps += testpmd_drivers_deps
diff --git a/app/test/meson.build b/app/test/meson.build
index b6285a6b45..eb0447e8c6 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -7,7 +7,7 @@ sources += files('commands.c', 'test.c')
 
 # optional dependencies: some files may use these - and so we should link them in -
 # but do not explicitly require them so they are not listed in the per-file lists below
-optional_deps = ['crypto_scheduler', 'lpm']
+opt_deps = ['crypto_scheduler', 'lpm']
 
 # some other utility C files, providing functions used by various tests
 # so we need to include these deps in the dependency list for the files using those fns.
@@ -222,8 +222,8 @@ foreach f, f_deps : source_file_deps
             break
         else
             # technically we might not need this dep, but adding it is harmless
-            if d not in deps
-                deps += d
+            if d not in optional_deps and d not in deps
+                optional_deps += d
             endif
         endif
     endforeach
@@ -244,9 +244,9 @@ foreach f, f_deps : source_file_deps
     endif
 endforeach
 # add the optional dependencies
-foreach d:optional_deps
-    if is_variable(def_lib + '_rte_' + d) and d not in deps
-        deps += d
+foreach d:opt_deps
+    if d not in optional_deps and d not in deps
+        optional_deps += d
     endif
 endforeach
 
diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..fb48e11eaf 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -133,6 +133,7 @@ foreach subpath:subdirs
         includes = [include_directories(drv_path)]
         # set up internal deps. Drivers can append/override as necessary
         deps = std_deps
+        optional_deps = []
         # ext_deps: Stores external library dependency got
         # using dependency() (preferred) or find_library().
         # For the find_library() case (but not with dependency()) we also
@@ -178,11 +179,21 @@ foreach subpath:subdirs
             # get dependency objs from strings
             shared_deps = ext_deps
             static_deps = ext_deps
+
+            # resolve any optional internal dependencies
+            def_lib = get_option('default_library')
+            foreach d: optional_deps
+                # if optional dependency is defined, add it to the deps list
+                if is_variable(def_lib + '_rte_' + d)
+                    deps += [d]
+                endif
+            endforeach
+
             foreach d:deps
                 if not build
                     break
                 endif
-                if not is_variable('shared_rte_' + d)
+                if not is_variable(def_lib + '_rte_' + d)
                     build = false
                     reason = 'missing internal dependency, "@0@"'.format(d)
                     if dpdk_libs_deprecated.contains(d)
diff --git a/examples/ethtool/meson.build b/examples/ethtool/meson.build
index d7f63d48af..bb2a7fbb89 100644
--- a/examples/ethtool/meson.build
+++ b/examples/ethtool/meson.build
@@ -19,8 +19,6 @@ sources = files(
 includes = include_directories('lib', 'ethtool-app')
 
 deps += 'bus_pci'
-if dpdk_conf.has('RTE_NET_IXGBE')
-    deps += 'net_ixgbe'
-endif
+optional_deps += 'net_ixgbe'
 
 allow_experimental_apis = true
diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index c21722b85c..2a1070707e 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -7,9 +7,7 @@
 # DPDK instance, use 'make'
 
 deps += 'cryptodev'
-if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
-    deps += 'crypto_scheduler'
-endif
+optional_deps += 'crypto_scheduler'
 allow_experimental_apis = true
 sources = files(
         'main.c',
diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
index 74144c7979..9a9f2c6d40 100644
--- a/examples/l3fwd/meson.build
+++ b/examples/l3fwd/meson.build
@@ -18,7 +18,5 @@ sources = files(
         'l3fwd_lpm.c',
         'main.c',
 )
-if dpdk_conf.has('RTE_LIB_EVENTDEV')
-    deps += 'eventdev'
-endif
+optional_deps += 'eventdev'
 cflags += no_wvla_cflag
diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..14b8aadf68 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -98,12 +98,23 @@ foreach example: examples
     ext_deps = []
     includes = [include_directories(example, 'common')]
     deps = ['eal', 'mempool', 'net', 'mbuf', 'ethdev', 'cmdline']
+    optional_deps = []
     subdir(example)
 
     if build
         dep_objs = ext_deps
+
+        # resolve any optional internal dependencies
+        def_lib = get_option('default_library')
+        foreach d: optional_deps
+            # if optional dependency is defined, add it to the deps list
+            if is_variable(def_lib + '_rte_' + d)
+                deps += [d]
+            endif
+        endforeach
+
         foreach d:deps
-            var_name = get_option('default_library') + '_rte_' + d
+            var_name = def_lib + '_rte_' + d
             if not is_variable(var_name)
                 build = false
                 message('Missing dependency "@0@" for example "@1@"'.format(d, name))
diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
index dcf23198eb..6fc081b06b 100644
--- a/examples/vm_power_manager/meson.build
+++ b/examples/vm_power_manager/meson.build
@@ -8,17 +8,11 @@
 
 deps += ['power', 'power_kvm_vm']
 
-if dpdk_conf.has('RTE_NET_BNXT')
-    deps += ['net_bnxt']
-endif
-
-if dpdk_conf.has('RTE_NET_I40E')
-    deps += ['net_i40e']
-endif
-
-if dpdk_conf.has('RTE_NET_IXGBE')
-    deps += ['net_ixgbe']
-endif
+optional_deps += [
+        'net_bnxt',
+        'net_i40e',
+        'net_ixgbe',
+]
 
 allow_experimental_apis = true
 sources = files(
diff --git a/lib/meson.build b/lib/meson.build
index ce92cb5537..76bf849852 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -134,6 +134,7 @@ foreach l:libraries
     # external package/library requirements
     ext_deps = []
     deps = []
+    optional_deps = []
     # eal is standard dependency once built
     if dpdk_conf.has('RTE_LIB_EAL')
         deps += ['eal']
@@ -171,11 +172,21 @@ foreach l:libraries
 
     shared_deps = ext_deps
     static_deps = ext_deps
+
+    # resolve any optional internal dependencies
+    def_lib = get_option('default_library')
+    foreach d: optional_deps
+        # if optional dependency is defined, add it to the deps list
+        if is_variable(def_lib + '_rte_' + d)
+            deps += [d]
+        endif
+    endforeach
+
     foreach d:deps
         if not build
             break
         endif
-        if not is_variable('shared_rte_' + d)
+        if not is_variable(def_lib + '_rte_' + d)
             build = false
             reason = 'missing internal dependency, "@0@"'.format(d)
             if dpdk_libs_deprecated.contains(d)
-- 
2.43.5

