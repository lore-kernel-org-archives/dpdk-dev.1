Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A687C83F0A
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 17:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB3B540A75;
	Tue,  8 Jul 2025 19:20:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EAC7C40A75
 for <dev@dpdk.org>; Tue,  8 Jul 2025 19:20:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751995252; x=1783531252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T1t6uwEqjzKadK2SvKfxDjHC/G//2Ka9qM24QHnOL8E=;
 b=fTLF0n2Xi1LRNG+cdjCeQdL31nWQE7Y8eqLcbG9vYsUU63I2NOYnf4/o
 fV9V7fu+cyWZiUbEBsiYgG3hDcrtc2idLrB62l/y3aqAqReqq9Sm7QLvL
 2yDvx4dkxsMNWmIVaaRf4mVEgrjM75OvoJU4AbKbPWBzR8ZX2B0uFL5vF
 a38HBArp9EIRvjN7yDBNkzTSZy/rq1lt/S68FFEN6ONjxbJr9QCBNJHbY
 IJ9KlGHKNvWgKvAfi5eE+6WIXG3TF3EJq+ApfosSfO5C44yiAFLxQ2HNR
 cCEBUISpr3YFRG4VpV3h2iVmK3wWX5iTy9iBTi3H14faWYnRltce2a45Y g==;
X-CSE-ConnectionGUID: TLO3OLwaRKqHe1lgAme2ew==
X-CSE-MsgGUID: 8O80peDmQvKKFSXk18eJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57913119"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57913119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 10:20:51 -0700
X-CSE-ConnectionGUID: Hm6lm16KSMqmToIKEhrQuw==
X-CSE-MsgGUID: gmPnDOqmQdWR0xqLuYYz3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="161200619"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa005.jf.intel.com with ESMTP; 08 Jul 2025 10:20:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 1/5] eal: add long options for each short option
Date: Tue,  8 Jul 2025 17:20:35 +0000
Message-ID: <20250708172039.183989-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708172039.183989-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
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

To simplify future rework of the EAL arg handling, add a long-option
equivalent for each short option that doesn't already have one.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c |  9 +++++++++
 lib/eal/common/eal_options.h        | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index f0a9ddeeb7..cafae9d9d7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -66,7 +66,9 @@ eal_short_options[] =
 const struct option
 eal_long_options[] = {
 	{OPT_BASE_VIRTADDR,     1, NULL, OPT_BASE_VIRTADDR_NUM    },
+	{OPT_COREMASK,          1, NULL, OPT_COREMASK_NUM        },
 	{OPT_CREATE_UIO_DEV,    0, NULL, OPT_CREATE_UIO_DEV_NUM   },
+	{OPT_DRIVER_PATH,       1, NULL, OPT_DRIVER_PATH_NUM     },
 	{OPT_FILE_PREFIX,       1, NULL, OPT_FILE_PREFIX_NUM      },
 	{OPT_HELP,              0, NULL, OPT_HELP_NUM             },
 	{OPT_HUGE_DIR,          1, NULL, OPT_HUGE_DIR_NUM         },
@@ -76,6 +78,11 @@ eal_long_options[] = {
 	{OPT_LOG_COLOR,		2, NULL, OPT_LOG_COLOR_NUM	  },
 	{OPT_LOG_LEVEL,         1, NULL, OPT_LOG_LEVEL_NUM        },
 	{OPT_LOG_TIMESTAMP,     2, NULL, OPT_LOG_TIMESTAMP_NUM    },
+	{OPT_MEMORY_CHANNELS,   1, NULL, OPT_MEMORY_CHANNELS_NUM },
+	{OPT_MEMORY_RANKS,      1, NULL, OPT_MEMORY_RANKS_NUM    },
+	{OPT_MEMORY_SIZE,       1, NULL, OPT_MEMORY_SIZE_NUM     },
+	{OPT_SERVICE_CORELIST,  1, NULL, OPT_SERVICE_CORELIST_NUM },
+	{OPT_SERVICE_COREMASK,  1, NULL, OPT_SERVICE_COREMASK_NUM },
 	{OPT_TRACE,             1, NULL, OPT_TRACE_NUM            },
 	{OPT_TRACE_DIR,         1, NULL, OPT_TRACE_DIR_NUM        },
 	{OPT_TRACE_BUF_SIZE,    1, NULL, OPT_TRACE_BUF_SIZE_NUM   },
@@ -109,6 +116,8 @@ eal_long_options[] = {
 	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
 	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
 	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
+	{OPT_VERSION,           0, NULL, OPT_VERSION_NUM         },
+
 
 	{0,                     0, NULL, 0                        }
 };
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 7a56aa3810..6ef45559f0 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -17,8 +17,24 @@ enum {
 	OPT_DEV_ALLOW_NUM       = 'a',
 #define OPT_DEV_BLOCK         "block"
 	OPT_DEV_BLOCK_NUM      = 'b',
+#define OPT_COREMASK          "coremask"
+	OPT_COREMASK_NUM       = 'c',
+#define OPT_DRIVER_PATH       "driver-path"
+	OPT_DRIVER_PATH_NUM    = 'd',
 #define OPT_LCORES            "lcores"
 	OPT_LCORES_NUM         = 'l',
+#define OPT_MEMORY_SIZE       "memory-size"
+	OPT_MEMORY_SIZE_NUM    = 'm',
+#define OPT_MEMORY_CHANNELS   "memory-channels"
+	OPT_MEMORY_CHANNELS_NUM = 'n',
+#define OPT_MEMORY_RANKS     "memory-ranks"
+	OPT_MEMORY_RANKS_NUM   = 'r',
+#define OPT_SERVICE_COREMASK  "service-coremask"
+	OPT_SERVICE_COREMASK_NUM = 's',
+#define OPT_SERVICE_CORELIST  "service-corelist"
+	OPT_SERVICE_CORELIST_NUM = 'S',
+#define OPT_VERSION           "version"
+	OPT_VERSION_NUM        = 'v',
 
 	/* first long only option value must be >= 256, so that we won't
 	 * conflict with short options */
-- 
2.48.1

