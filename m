Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A1C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F36A64065F;
	Fri,  2 May 2025 17:11:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id ED8734029E
 for <dev@dpdk.org>; Fri,  2 May 2025 17:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746198719; x=1777734719;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4nzgHQwQwh5UJWYPb1i4/2F1z0TnR30m5+spddFq48k=;
 b=CQWw4nHvGXhN0q8l1CkHXbcI7SF6tNwliKsOW2acnogCnT5NfKvkvv+s
 +oUYr+G7rnPl+ewSbhoC7b/FCToIpyf4N7HgPToxlLxrtGoIeOkj1TfLZ
 MwxLHxJsx2go3+S6e91Rsqv+GkhuN+1lo7xuQmFYNyUYZEnb2UyaLgvuk
 6n6DY2yhTnlNEwnrVFV79TTiQNrhc7rTbKjFU1He/AA62ZJ6qINzNfA3s
 tkKmDe2TGKQaZwNf6D5Cfb4jTrXjiGdDBkK/OCet2G4yS6l1frEwOPSYh
 P+1vNVTO2JeWW47knzWVx3aJtIMqLPoWoW2DfP+JMw4yD9Y3EJ0mCe3NS w==;
X-CSE-ConnectionGUID: vpVKFhD3RsmN6Hoz/wk/fA==
X-CSE-MsgGUID: e+QAA8sIQxauzNlWaHbC3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47970489"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47970489"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:11:58 -0700
X-CSE-ConnectionGUID: hIf5aUWWQHuR8a4CzYYOBA==
X-CSE-MsgGUID: UNnpbuPjTUauM1VUR3PDVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135172750"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 02 May 2025 08:11:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, mb@smartsharesystems.com,
 stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
Date: Fri,  2 May 2025 16:11:31 +0100
Message-ID: <20250502151134.536799-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502151134.536799-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
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

As the number of cores/cpus on platforms has increased over the years,
the use of coremasks rather than core-lists for identifying DPDK cores
has become more and more unwieldy. At this point, let's deprecate the
coremask-based EAL parameters for future removal, and point users to the
core-list based versions instead.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/eventdevs/dlb2.rst                |  6 +++---
 doc/guides/faq/faq.rst                       |  8 +++-----
 doc/guides/linux_gsg/build_sample_apps.rst   |  7 +++----
 doc/guides/linux_gsg/eal_args.include.rst    |  8 ++------
 doc/guides/prog_guide/meson_ut.rst           |  2 +-
 doc/guides/prog_guide/multi_proc_support.rst |  2 +-
 doc/guides/prog_guide/service_cores.rst      |  8 ++++----
 doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
 doc/guides/sample_app_ug/ip_frag.rst         |  7 +------
 doc/guides/sample_app_ug/ip_reassembly.rst   |  7 +------
 doc/guides/sample_app_ug/multi_process.rst   | 14 +++++---------
 doc/guides/sample_app_ug/qos_scheduler.rst   |  2 +-
 doc/guides/sample_app_ug/test_pipeline.rst   |  2 +-
 doc/guides/tools/testbbdev.rst               |  2 +-
 lib/eal/common/eal_common_options.c          |  6 ++++++
 15 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 2532d92888..d1b736830d 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -408,9 +408,9 @@ the DLB device locally available on the same tile along with other
 resources. To allocate optimal resources, probing is done for each
 producer port (PP) for a given CPU and the best performing ports are
 allocated to producers. The cpu used for probing is either the first
-core of producer coremask (if present) or the second core of EAL
-coremask. This will be extended later to probe for all CPUs in the
-producer coremask or EAL coremask. Producer coremask can be passed
+core of producer coremask DLB2 device parameter (if present) or the second core of EAL
+core list. This will be extended later to probe for all CPUs in the
+producer coremask or EAL core list. Producer coremask can be passed
 along with the BDF of the DLB devices.
 
     .. code-block:: console
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index 297cb5119e..ddcb018b3a 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -47,11 +47,9 @@ therefore all the hugepages are allocated on the wrong socket.
 To avoid this scenario, either lower the amount of hugepage memory available to 1 GB size (or less), or run the application with taskset
 affinitizing the application to a would-be main core.
 
-For example, if your EAL coremask is 0xff0, the main core will usually be the first core in the coremask (0x10); this is what you have to supply to taskset::
+For example, if your EAL core list is '4-11', the main core will usually be the first core in the list (core 4); this is what you have to supply to taskset::
 
-   taskset 0x10 ./l2fwd -l 4-11 -n 2
-
-.. Note: Instead of '-c 0xff0' use the '-l 4-11' as a cleaner way to define lcores.
+   taskset -c 4 ./l2fwd -l 4-11 -n 2
 
 In this way, the hugepages have a greater chance of being allocated to the correct socket.
 Additionally, a ``--socket-mem`` option could be used to ensure the availability of memory for each socket, so that if hugepages were allocated on
@@ -167,7 +165,7 @@ Can I split packet RX to use DPDK and have an application's higher order functio
 ----------------------------------------------------------------------------------------------------------------
 
 The DPDK's lcore threads are Linux pthreads bound onto specific cores. Configure the DPDK to do work on the same
-cores and run the application's other work on other cores using the DPDK's "coremask" setting to specify which
+cores and run the application's other work on other cores using the DPDK's "core list" (-l/--lcores) setting to specify which
 cores it should launch itself on.
 
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 433839ecc7..c568549f26 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -126,10 +126,9 @@ and that cores 0-3 are present and are to be used for running the application)::
 Logical Core Use by Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The coremask (-c 0x0f) or corelist (-l 0-3) parameter is always mandatory for DPDK applications.
-Each bit of the mask corresponds to the equivalent logical core number as reported by Linux. The preferred corelist option is a cleaner method to define cores to be used.
+The corelist (-l/--lcores 0-3) parameter is always mandatory for DPDK applications.
 Since these logical core numbers, and their mapping to specific cores on specific NUMA sockets, can vary from platform to platform,
-it is recommended that the core layout for each platform be considered when choosing the coremask/corelist to use in each case.
+it is recommended that the core layout for each platform be considered when choosing the corelist to use in each case.
 
 On initialization of the EAL layer by a DPDK application, the logical cores to be used and their socket location are displayed.
 This information can also be determined for all cores on the system by examining the ``/proc/cpuinfo`` file, for example, by running cat ``/proc/cpuinfo``.
@@ -151,7 +150,7 @@ This can be useful when using other processors to understand the mapping of the
 
 .. warning::
 
-    The logical core layout can change between different board layouts and should be checked before selecting an application coremask/corelist.
+    The logical core layout can change between different board layouts and should be checked before selecting an application corelist.
 
 Hugepage Memory Use by Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 9cfbf7de84..7ffd2e2535 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -4,10 +4,6 @@
 Lcore-related options
 ~~~~~~~~~~~~~~~~~~~~~
 
-*   ``-c <core mask>``
-
-    Set the hexadecimal bitmask of the cores to run on.
-
 *   ``-l <core list>``
 
     List of cores to run on
@@ -37,9 +33,9 @@ Lcore-related options
 
     Core ID that is used as main.
 
-*   ``-s <service core mask>``
+*   ``-S <service core list>``
 
-    Hexadecimal bitmask of cores to be used as service cores.
+    List of cores to be used as service cores.
 
 Device-related options
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/prog_guide/meson_ut.rst b/doc/guides/prog_guide/meson_ut.rst
index 78cf3f845c..9bc52a30fc 100644
--- a/doc/guides/prog_guide/meson_ut.rst
+++ b/doc/guides/prog_guide/meson_ut.rst
@@ -60,7 +60,7 @@ Arguments of ``test()`` that can be provided in meson.build are as below:
 
 Note: the content of meson ``--test-args`` option and the content of ``args``
 are appended when invoking the DPDK test binary.
-Because of this, it is recommended not to set any default coremask or memory
+Because of this, it is recommended not to set any default corelist or memory
 configuration in per test ``args`` and rather let users select what best fits
 their environment. If a test can't run, then it should be skipped, as described
 below.
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index 0c57145470..dd57b6f8c1 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -166,7 +166,7 @@ Some of these are documented below:
     so it is recommended that it be disabled only when absolutely necessary,
     and only when the implications of this change have been understood.
 
-*   All DPDK processes running as a single application and using shared memory must have distinct coremask/corelist arguments.
+*   All DPDK processes running as a single application and using shared memory must have distinct corelist arguments.
     It is not possible to have a primary and secondary instance, or two secondary instances,
     using any of the same logical cores.
     Attempting to do so can cause corruption of memory pool caches, among other issues.
diff --git a/doc/guides/prog_guide/service_cores.rst b/doc/guides/prog_guide/service_cores.rst
index d4e6c3d6e6..5284eeb96a 100644
--- a/doc/guides/prog_guide/service_cores.rst
+++ b/doc/guides/prog_guide/service_cores.rst
@@ -26,10 +26,10 @@ Service Core Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 There are two methods to having service cores in a DPDK application, either by
-using the service coremask, or by dynamically adding cores using the API.
-The simpler of the two is to pass the `-s` coremask argument to EAL, which will
-take any cores available in the main DPDK coremask, and if the bits are also set
-in the service coremask the cores become service-cores instead of DPDK
+using the service corelist, or by dynamically adding cores using the API.
+The simpler of the two is to pass the `-S` corelist argument to EAL, which will
+take any cores available in the main DPDK corelist, and if also set
+in the service corelist the cores become service-cores instead of DPDK
 application lcores.
 
 Enabling Services on Cores
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..2ea898ff8a 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -17,6 +17,16 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* EAL: The ``-c <coremask>`` commandline parameter is deprecated
+  and will be removed in a future release.
+  Use the ``-l <corelist>`` or ``--lcores=<corelist>`` parameters instead
+  to specify the cores to be used when running a DPDK application.
+
+* EAL: The ``-s <service-coremask>`` commandline parameter is deprecated
+  and will be removed in a future release.
+  Use the ``-S <service-corelist>`` parameter instead
+  to specify the cores to be used for background services in DPDK.
+
 * build: The ``enable_kmods`` option is deprecated and will be removed in a future release.
   Setting/clearing the option has no impact on the build.
   Instead, kernel modules will be always built for OS's where out-of-tree kernel modules
diff --git a/doc/guides/sample_app_ug/ip_frag.rst b/doc/guides/sample_app_ug/ip_frag.rst
index 4b2071cbae..3f0b5ce5e7 100644
--- a/doc/guides/sample_app_ug/ip_frag.rst
+++ b/doc/guides/sample_app_ug/ip_frag.rst
@@ -67,12 +67,7 @@ To run the example in linux environment with 2 lcores (2,4) over 2 ports(0,2) wi
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-ip_fragmentation -l 2,4 -n 3 -- -p 5
-    EAL: coremask set to 14
-    EAL: Detected lcore 0 on socket 0
-    EAL: Detected lcore 1 on socket 1
-    EAL: Detected lcore 2 on socket 0
-    EAL: Detected lcore 3 on socket 1
-    EAL: Detected lcore 4 on socket 0
+    EAL: Detected CPU lcores: ...
     ...
 
     Initializing port 0 on lcore 2... Address:00:1B:21:76:FA:2C, rxq=0 txq=2,0 txq=4,1
diff --git a/doc/guides/sample_app_ug/ip_reassembly.rst b/doc/guides/sample_app_ug/ip_reassembly.rst
index b8800dd9e7..e55ee7eb79 100644
--- a/doc/guides/sample_app_ug/ip_reassembly.rst
+++ b/doc/guides/sample_app_ug/ip_reassembly.rst
@@ -63,12 +63,7 @@ with 1 Rx queue per lcore:
 .. code-block:: console
 
     ./<build_dir>/examples/dpdk-ip_reassembly -l 2,4 -n 3 -- -p 5
-    EAL: coremask set to 14
-    EAL: Detected lcore 0 on socket 0
-    EAL: Detected lcore 1 on socket 1
-    EAL: Detected lcore 2 on socket 0
-    EAL: Detected lcore 3 on socket 1
-    EAL: Detected lcore 4 on socket 0
+    EAL: Detected CPU lcores: ...
     ...
 
     Initializing port 0 on lcore 2... Address:00:1B:21:76:FA:2C, rxq=0 txq=2,0 txq=4,1
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index e2b1b16c84..29bca806e1 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -36,7 +36,7 @@ Running the Application
 ^^^^^^^^^^^^^^^^^^^^^^^
 
 To run the application, start ``simple_mp`` binary in one terminal,
-passing at least two cores in the coremask/corelist:
+passing at least two cores in the corelist:
 
 .. code-block:: console
 
@@ -50,11 +50,7 @@ The process should start successfully and display a command prompt as follows:
 .. code-block:: console
 
     $ ./<build_dir>/examples/dpdk-simple_mp -l 0-1 -n 4 --proc-type=primary
-    EAL: coremask set to 3
-    EAL: Detected lcore 0 on socket 0
-    EAL: Detected lcore 1 on socket 0
-    EAL: Detected lcore 2 on socket 0
-    EAL: Detected lcore 3 on socket 0
+    EAL: Detected CPU lcores: ...
     ...
 
     EAL: Requesting 2 pages of size 1073741824
@@ -72,7 +68,7 @@ The process should start successfully and display a command prompt as follows:
     simple_mp >
 
 To run the secondary process to communicate with the primary process,
-again run the same binary setting at least two cores in the coremask/corelist:
+again run the same binary setting at least two cores in the corelist:
 
 .. code-block:: console
 
@@ -237,8 +233,8 @@ In addition to the EAL parameters, the application-specific parameters are:
 .. note::
 
    In the server process, has a single thread using the lowest numbered lcore
-   in the coremask/corelist, performs all packet I/O.
-   If coremask/corelist parameter specifies with more than a single lcore bit set,
+   in the corelist, performs all packet I/O.
+   If corelist parameter specifies with more than a single lcore,
    an additional lcore will be used for a thread to print packet count periodically.
 
 The server application stores configuration data in shared memory,
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index 9936b99172..36ada4902c 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -194,7 +194,7 @@ Another example with 2 packet flow configurations using different ports but shar
 Note that independent cores for the packet flow configurations for each of the RX, WT and TX thread are also supported,
 providing flexibility to balance the work.
 
-The EAL coremask/corelist is constrained to contain the default main core 1 and the RX, WT and TX cores only.
+The EAL corelist is constrained to contain the default main core 1 and the RX, WT and TX cores only.
 
 Explanation
 -----------
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index d57d08fb2c..818be93cd6 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -47,7 +47,7 @@ The application execution command line is:
 
     ./dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE
 
-The -c or -l EAL CPU coremask/corelist option has to contain exactly 3 CPU cores.
+The ``-l/--lcores`` EAL CPU corelist option has to contain exactly 3 CPU cores.
 The first CPU core in the core mask is assigned for core A, the second for core B and the third for core C.
 
 The PORTMASK parameter must contain 2 or 4 ports.
diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index ddb8d787be..8677cd2c43 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -78,7 +78,7 @@ The following are the command-line options:
 
 ``-l NUM_LCORES, --num_lcores NUM_LCORES``
  Specifies number of lcores to run. If not specified num_lcores is set
- according to value from RTE configuration (EAL coremask)
+ according to value from RTE configuration (EAL corelist)
 
 ``-b BURST_SIZE [BURST_SIZE ...], --burst-size BURST_SIZE [BURST_SIZE ...]``
  Specifies operations enqueue/dequeue burst size. If not specified burst_size is
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b6fff7ec05..19c5997c7c 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -614,6 +614,9 @@ eal_parse_service_coremask(const char *coremask)
 	int val;
 	uint32_t taken_lcore_count = 0;
 
+	EAL_LOG(WARNING, "'-s <service-coremask>' is deprecated, and will be removed in a future release.");
+	EAL_LOG(WARNING, "\tUse '-S <service-corelist>' option instead.");
+
 	if (coremask == NULL)
 		return -1;
 	/* Remove all blank characters ahead and after .
@@ -777,6 +780,9 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 		cores[idx] = -1;
 	idx = 0;
 
+	EAL_LOG(WARNING, "'-c <coremask>' option is deprecated, and will be removed in a future release");
+	EAL_LOG(WARNING, "\tUse '-l <corelist>' or '--lcores=<corelist>' option instead");
+
 	/* Remove all blank characters ahead and after .
 	 * Remove 0x/0X if exists.
 	 */
-- 
2.45.2

