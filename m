Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617CC77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BD2740A67;
	Tue, 24 Jun 2025 15:41:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 54EA24026B;
 Tue, 24 Jun 2025 15:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772514; x=1782308514;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ls3zs3h1ErGG47S9+gs6tIPKGwMAvuGHMS6bhysz1xo=;
 b=XezC7/bxL685Vp1Ai3DhVPTmdPYtq8W56x+imLgc3nSQeI4vtybL6Q6Y
 SeZuPc16rVpQBIfypSXTpYM9qRxTyUJrzlRkmRQx+e+sHE7IGJvZHPDdY
 kuEHjhhmCvIcJLyqvMaaarWIUZgyV0/DWZQlOOTPhhlLcLicPkJNptb4T
 O/1HV83ekPRabAqS9dmRfsrPmxmd7MydZ5qOfd0IyOsSrwGUAnJnhgxrI
 LAFebwzktAEUbNdm3gwZmjZMMzUSqxA0I3QEshV7shFul5hhj0ICRIorl
 /DlNtpbSCVLMvbGakriycaE5hPbakl28BlbH0U6LQw8kyOs3GTtwenOs5 Q==;
X-CSE-ConnectionGUID: Mfr/v0U9QaGs1tubuQguXg==
X-CSE-MsgGUID: ZSW8TiYgSAy/Hr3pcqtpZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52881994"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="52881994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:41:53 -0700
X-CSE-ConnectionGUID: U9JcqGIiRHSXeTQjZr5NLQ==
X-CSE-MsgGUID: JL35e9WETxiNQbXjKn8+pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="156314321"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa003.jf.intel.com with ESMTP; 24 Jun 2025 06:41:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, thomas@monjalon.net, techboard@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] eal: deprecate old coremask-based EAL parameters
Date: Tue, 24 Jun 2025 14:41:39 +0100
Message-ID: <20250624134139.552315-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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
---
 doc/guides/linux_gsg/build_sample_apps.rst |  7 +++----
 doc/guides/linux_gsg/eal_args.include.rst  |  9 ---------
 doc/guides/rel_notes/deprecation.rst       | 10 ++++++++++
 lib/eal/common/eal_common_options.c        |  6 ++++++
 lib/eal/include/rte_lcore.h                |  1 -
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 8b8026705b..9ce564e881 100644
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
index 6ee79877c1..b0cd757569 100644
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
@@ -75,15 +71,10 @@ Lcore-related options
 
     Core ID that is used as main.
 
-*   ``-s <service core mask>``
-
-    Hexadecimal bitmask of cores to be used as service cores.
-
 *   ``-S <service core list>``
 
     List of cores to be used as service cores.
 
-
 Device-related options
 ~~~~~~~~~~~~~~~~~~~~~~
 
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

