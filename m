Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D8CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B292A40DF5;
	Thu,  9 Oct 2025 15:01:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id AB8A640DCD
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014895; x=1791550895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PTGZNoXQu8EgHYpc6bUY/Dn6DhgHpB0dk2w1C9l9KEU=;
 b=biBorvR2c0soyoHymi4pkRXP409IuHAIae73V2qan8hOAt7s383i1i0l
 LFr1AMPFnp+FPU9ApphpvkMMj4u3/vN+bbAfDhf991qopDgU27KEEN9Af
 FJjeBj/ahdPI1sJm/zqd+W7AZ9uVWHrAiIrVtwWVTh8JC3icpWtJhP0xH
 D/0GiNMmyP7mUsdbrCPvlVED0zszw9Ho3zTf4PQRLFnpTf8xEamOrBc3J
 Ns3pdJNx8rgpq0BwuBEi/aABC96TjLX0P5skc3cyzQXUMmR6BcTeH0oG6
 tGAsHy93gIYaGDGeu1XvC7VZ5j4q+2CzNQ2VP1k+Cvy12+1d6/Zqs2Vgn w==;
X-CSE-ConnectionGUID: WWil7CWgStaZBx7Oii0+8A==
X-CSE-MsgGUID: oNMIqoHvTS+ElUAXTUI14Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663161"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663161"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:35 -0700
X-CSE-ConnectionGUID: 7++7QBlORaG7jh8TXxarJA==
X-CSE-MsgGUID: 3jWoBpQZT/mOt1hx58V4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951673"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:33 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 20/21] eal: allow lcore ID remapping with core lists
Date: Thu,  9 Oct 2025 14:00:55 +0100
Message-ID: <20251009130056.2630343-21-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

Allow the "-R" flag to be used with core lists so that we can specify
lists with core ids >= RTE_MAX_LCORE in them, e.g. -l 140-148. In order
to do so, we limit the use of the "@" symbol for per-core remapping when
specifying a core list for automatic/global remapping, rather than
dealing with the situation of some cores being manually remapped and
others automatically.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 22 +++++++++++++++++
 doc/guides/rel_notes/release_25_11.rst    | 11 +++++++++
 lib/eal/common/eal_common_options.c       | 29 ++++++++++++++++++++---
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 0b17879d42..4a3c4d9b5f 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -67,6 +67,28 @@ Lcore-related options
     At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
     be used.
 
+*  ``-R, --remap-lcore-ids [<start lcore id>]``
+
+   Enable automatic remapping of lcore-ids to a contiguous set starting from 0,
+   or from a user-provided value.
+
+   When this flag is passed, the lcores specified by core mask or core list options
+   are taken as the physical cores on which the application will run,
+   and one thread will be started per core, with sequential lcore-ids.
+
+   For example: ``dpdk-test -l 20-24 -R``
+   will start 5 threads with lcore-ids 0 to 4 on physical cores 20 to 24.
+
+   Another example: ``dpdk-test -l 140-144 -R=10``
+   will start 5 threads with lcore-ids 10 to 14 on physical cores 140 to 144.
+
+.. note::
+
+    When using with the ``--lcores`` option, only simple core lists are allowed.
+    The ``@`` symbol to bind lcores to physical cpus,
+    and the use of ``()`` for core groupings,
+    are not allowed when ``-R`` or ``--remap-lcore-ids`` is also used.
+
 *   ``--main-lcore <core ID>``
 
     Core ID that is used as main.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index f73bab1227..4443ebbe92 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,17 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added automatic lcore-id remapping option.**
+
+  Added the EAL option ``--remap-lcore-ids`` or ``-R``
+  to enable automatic remapping of lcore-ids to a contiguous set starting from 0,
+  or from a user-provided value.
+  When this flag is passed, the lcores specified by core mask or core list options
+  are taken as the physical cores on which the application will run,
+  and one thread will be started per core, with sequential lcore-ids.
+  For example: ``dpdk-test -l 140-144 -R``
+  will start 5 threads with lcore-ids 0 to 4 on physical cores 140 to 144.
+
 * **Added speed 800G.**
 
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 2bcb50bbee..9f460d1740 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1938,9 +1938,32 @@ eal_parse_args(void)
 		}
 		core_parsed = 1;
 	} else if (args.lcores != NULL) {
-		if (eal_parse_lcores(args.lcores) < 0) {
-			EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
-			return -1;
+		if (!remap_lcores) {
+			if (eal_parse_lcores(args.lcores) < 0) {
+				EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
+				return -1;
+			}
+		} else {
+			rte_cpuset_t cpuset;
+
+			if (strchr(args.lcores, '@') != NULL || strchr(args.lcores, '(') != NULL) {
+				EAL_LOG(ERR, "cannot use '@' or core groupings '()' in lcore list when remapping lcores");
+				return -1;
+			}
+			if (rte_argparse_parse_type(args.lcores,
+					RTE_ARGPARSE_VALUE_TYPE_CORELIST, &cpuset) != 0) {
+				EAL_LOG(ERR, "Error parsing lcore list: '%s'", args.lcores);
+				return -1;
+			}
+
+			if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
+				char *available = available_cores();
+
+				EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
+						args.coremask, available);
+				free(available);
+				return -1;
+			}
 		}
 		core_parsed = 1;
 	}
-- 
2.48.1

