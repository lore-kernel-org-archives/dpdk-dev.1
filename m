Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4F3C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D47F4067D;
	Mon, 30 Jun 2025 17:38:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id EB64640291;
 Mon, 30 Jun 2025 17:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751297889; x=1782833889;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bDC9UDlD0L+yzwLC128LflKOCnf1shnRfwbLz8K03Kg=;
 b=PE1OWCCzYS5YjzQ38YVp1HCp4Sz8ex90UKfGXJrueT1DltTFtoyFcXu9
 3m+cZRxc6W3Epan0kW+rXWflesZQxHdTPhEuadWLqpKT+Hl5y2vFBtT7w
 CJpdz7wRLcXFO1k5XxkJyieFaYVfFxPFKPoPq7kVOiPYmLlyLILqw+fF7
 C/Q8JgfXOB8m067rT0+z9cMoykCXfj13q49776DdB+7LSLTShGhdDukJF
 QhtA94KJ6uewevU0pN9hQICY0uChw5p0qdNeZXFif23F5O0o67jj7kPUX
 3J9A5Oz1jxzTLey33+8cPenguEeycobaia7x4MrV0DXhdcTn8s2b+VMqU Q==;
X-CSE-ConnectionGUID: CII8RrxeTuC+ks3Vcd6bjw==
X-CSE-MsgGUID: khUDkuNITTCMn5Ek7wSRXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64975382"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="64975382"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 08:38:08 -0700
X-CSE-ConnectionGUID: WHSazcODRjS3gTU5Q62wFg==
X-CSE-MsgGUID: OZVARz80QD2gD6EAaRllyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; d="scan'208";a="154204396"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2025 08:38:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, thomas@monjalon.net, techboard@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2] eal: deprecate old coremask-based EAL parameters
Date: Mon, 30 Jun 2025 16:37:34 +0100
Message-ID: <20250630153752.2361112-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624134139.552315-1-bruce.richardson@intel.com>
References: <20250624134139.552315-1-bruce.richardson@intel.com>
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

Depends-on: series-35540 ("use core lists not masks in documentation")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Vipin Varghese <vipin.varghese@amd.com>
Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
V2:
* updated freebsd GSG doc
* additional changes to linux GSG sample apps section
* removed a couple of outdated references to coremask/list being mandatory
* made EAL prefix lower-case in deprecation doc
---
 doc/guides/freebsd_gsg/build_sample_apps.rst |  8 +++-----
 doc/guides/linux_gsg/build_sample_apps.rst   | 18 +++++++-----------
 doc/guides/linux_gsg/eal_args.include.rst    |  4 ----
 doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
 lib/eal/common/eal_common_options.c          |  6 ++++++
 lib/eal/include/rte_lcore.h                  |  1 -
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index 7bdd88e56d..a9124624f7 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -61,10 +61,9 @@ A large number of options can be given to the EAL when running an
 application. A full list of options can be got by passing `--help` to a
 DPDK application. Some of the EAL options for FreeBSD are as follows:
 
-*   ``-c COREMASK`` or ``-l CORELIST``:
-    A hexadecimal bit mask of the cores to run on.  Note that core numbering
-    can change between platforms and should be determined beforehand. The corelist
-    is a list of cores to use instead of a core mask.
+*   ``-l CORELIST``:
+    A list of the cores to run on, for example: ``-l 1-3``, or ``-l 1,3,5-10``.
+    Note that core numbering can change between platforms and should be determined beforehand.
 
 *   ``-b <domain:bus:devid.func>``:
     Blocklisting of ports; prevent EAL from using specified PCI device
@@ -94,7 +93,6 @@ Other options, specific to Linux and are not supported under FreeBSD are as foll
 *   ``--file-prefix``:
     The prefix text used for hugepage filenames.
 
-The ``-c`` or ``-l`` option is mandatory; the others are optional.
 
 .. _running_non_root:
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 5746a623f8..668705177e 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -33,16 +33,15 @@ The following is the list of options that can be given to the EAL:
 
 .. code-block:: console
 
-    ./rte-app [-c COREMASK | -l CORELIST] [-n NUM] [-b <domain:bus:devid.func>] \
+    ./rte-app [-l CORELIST] [-n NUM] [-b <domain:bus:devid.func>] \
               [--numa-mem=MB,...] [-d LIB.so|DIR] [-m MB] [-r NUM] [-v] [--file-prefix] \
 	      [--proc-type <primary|secondary|auto>]
 
 The EAL options are as follows:
 
-* ``-c COREMASK`` or ``-l CORELIST``:
-  An hexadecimal bit mask of the cores to run on. Note that core numbering can
-  change between platforms and should be determined beforehand. The corelist is
-  a set of core numbers instead of a bitmap core mask.
+* ``-l CORELIST``:
+  An list of the cores to run on, for example: ``-l 1-3`` or ``-l 1,3,5-10``.
+  Note that core numbering can change between platforms and should be determined beforehand.
 
 * ``-n NUM``:
   Number of memory channels per processor socket.
@@ -108,8 +107,6 @@ The EAL options are as follows:
   Store memory segments in fewer files (dynamic memory mode only - does not
   affect legacy memory mode).
 
-The ``-c`` or ``-l`` and option is mandatory; the others are optional.
-
 Copy the DPDK application binary to your target, then run the application as follows
 (assuming the platform has four memory channels per processor socket,
 and that cores 0-3 are present and are to be used for running the application)::
@@ -126,10 +123,9 @@ and that cores 0-3 are present and are to be used for running the application)::
 Logical Core Use by Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The coremask (-c 0x0f) or corelist (-l 0-3) parameter is always mandatory for DPDK applications.
-Each bit of the mask corresponds to the equivalent logical core number as reported by Linux. The preferred corelist option is a cleaner method to define cores to be used.
+The corelist (``-l``/``--lcores``) parameter is generally used for DPDK applications to specify the cores on which the application should run.
 Since these logical core numbers, and their mapping to specific cores on specific NUMA sockets, can vary from platform to platform,
-it is recommended that the core layout for each platform be considered when choosing the coremask/corelist to use in each case.
+it is recommended that the core layout for each platform be considered when choosing the corelist to use in each case.
 
 On initialization of the EAL layer by a DPDK application, the logical cores to be used and their socket location are displayed.
 This information can also be determined for all cores on the system by examining the ``/proc/cpuinfo`` file, for example, by running cat ``/proc/cpuinfo``.
@@ -151,7 +147,7 @@ This can be useful when using other processors to understand the mapping of the
 
 .. warning::
 
-    The logical core layout can change between different board layouts and should be checked before selecting an application coremask/corelist.
+    The logical core layout can change between different board layouts and should be checked before selecting an application corelist.
 
 Hugepage Memory Use by Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 359721eb6a..9c90ee5110 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -4,10 +4,6 @@
 Lcore-related options
 ~~~~~~~~~~~~~~~~~~~~~
 
-*   ``-c <core mask>``
-
-    Set the hexadecimal bitmask of the cores to run on.
-
 *   ``-l/--lcores <core list>``
 
     List of cores to run on
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..2d95540562 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -17,6 +17,16 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* eal: The ``-c <coremask>`` commandline parameter is deprecated
+  and will be removed in a future release.
+  Use the ``-l <corelist>`` or ``--lcores=<corelist>`` parameters instead
+  to specify the cores to be used when running a DPDK application.
+
+* eal: The ``-s <service-coremask>`` commandline parameter is deprecated
+  and will be removed in a future release.
+  Use the ``-S <service-corelist>`` parameter instead
+  to specify the cores to be used for background services in DPDK.
+
 * build: The ``enable_kmods`` option is deprecated and will be removed in a future release.
   Setting/clearing the option has no impact on the build.
   Instead, kernel modules will be always built for OS's where out-of-tree kernel modules
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 83b6fc7e89..f0a9ddeeb7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -616,6 +616,9 @@ eal_parse_service_coremask(const char *coremask)
 	int val;
 	uint32_t taken_lcore_count = 0;
 
+	EAL_LOG(WARNING, "'-s <service-coremask>' is deprecated, and will be removed in a future release.");
+	EAL_LOG(WARNING, "\tUse '-S <service-corelist>' option instead.");
+
 	if (coremask == NULL)
 		return -1;
 	/* Remove all blank characters ahead and after .
@@ -779,6 +782,9 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 		cores[idx] = -1;
 	idx = 0;
 
+	EAL_LOG(WARNING, "'-c <coremask>' option is deprecated, and will be removed in a future release");
+	EAL_LOG(WARNING, "\tUse '-l <corelist>' or '--lcores=<corelist>' option instead");
+
 	/* Remove all blank characters ahead and after .
 	 * Remove 0x/0X if exists.
 	 */
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 44959779a1..10f965b4f0 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -102,7 +102,6 @@ unsigned int rte_lcore_count(void);
  * When option -c or -l is given, the index corresponds
  * to the order in the list.
  * For example:
- * -c 0x30, lcore 4 has index 0, and 5 has index 1.
  * -l 22,18 lcore 22 has index 0, and 18 has index 1.
  *
  * @param lcore_id
-- 
2.48.1

