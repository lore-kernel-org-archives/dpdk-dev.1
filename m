Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2260CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C838D40674;
	Fri,  3 Oct 2025 10:15:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id BAAB540651
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479320; x=1791015320;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KFeN5qVIW+IdPSsx6MSn7k+Hji1hIpJQ0HyMztXC9gQ=;
 b=mly8uB70OtCOSTGn7hZ0qNDyTDXyWH/iRdEZbu/Ls4smzun9izVcimeF
 T0QgviW6F0nfbJ/0YBKS9bBrmS6kdrA9Bj2/9MbloaHpPhRwQMGq8RFjT
 q8z/YdPVteYyYeEc8ST/FRdvvMfH7m8xZaARxVG+iBksoG9V5pOlInb24
 RMq9LXRpLORrqaocwRD+yKc3aB2JgAahYZkLsq5De5ljn55vBE9KbZNP3
 g4Lb4VLkUuVXIk+izqO7gFaVkYG0WBdxH+46jr/NJVb23XSdBEunSJAqu
 2Cwvv1v29A9Hbmu7lIXVof+kE3SVeSJ2YrUzGxXmgteK0AFBIBFjzb+aw g==;
X-CSE-ConnectionGUID: dfQQDS7KT0KxmIPOJhxeGw==
X-CSE-MsgGUID: NH9vnCdgRrGkf4ixfQl/CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473562"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473562"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:20 -0700
X-CSE-ConnectionGUID: XBiVrb6sRkuBp45zZ5Nipw==
X-CSE-MsgGUID: 7HYPoJViSOu2sO/YbWaByw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525833"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 06/18] eal: add long options for each short option
Date: Fri,  3 Oct 2025 09:14:58 +0100
Message-ID: <20251003081510.1197166-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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

When updating the docs with the new long options, standardize the format
of options which have both short and long variants, and drop the
deprecated service-coremask option from the docs, rather than adding its
new long option.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 20 ++++++++------------
 lib/eal/common/eal_common_options.c       |  8 ++++++++
 lib/eal/common/eal_options.h              | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 9ced54af40..0b17879d42 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -4,7 +4,7 @@
 Lcore-related options
 ~~~~~~~~~~~~~~~~~~~~~
 
-*   ``-l/--lcores <core list>``
+*   ``-l, --lcores <core list>``
 
     List of cores to run on
 
@@ -71,11 +71,7 @@ Lcore-related options
 
     Core ID that is used as main.
 
-*   ``-s <service core mask>``
-
-    Hexadecimal bitmask of cores to be used as service cores.
-
-*   ``-S <service core list>``
+*   ``-S, --service-corelist <service core list>``
 
     List of cores to be used as service cores.
 
@@ -108,7 +104,7 @@ Device-related options
 
        --vdev 'net_pcap0,rx_pcap=input.pcap,tx_pcap=output.pcap'
 
-*   ``-d <path to shared object or directory>``
+*   ``-d, --driver-path <path to shared object or directory>``
 
     Load external drivers. An argument can be a single shared object file, or a
     directory containing multiple driver shared objects. Multiple -d options are
@@ -134,15 +130,15 @@ Multiprocessing-related options
 Memory-related options
 ~~~~~~~~~~~~~~~~~~~~~~
 
-*   ``-n <number of channels>``
+*   ``-n, --memory-channels <number of channels>``
 
     Set the number of memory channels to use.
 
-*   ``-r <number of ranks>``
+*   ``-r, --memory-ranks <number of ranks>``
 
     Set the number of memory ranks (auto-detected by default).
 
-*   ``-m <megabytes>``
+*   ``-m, --memory-size <megabytes>``
 
     Amount of memory to preallocate at startup.
 
@@ -236,11 +232,11 @@ Debugging options
 Other options
 ~~~~~~~~~~~~~
 
-*   ``-h``, ``--help``
+*   ``-h, --help``
 
     Display help message listing all EAL parameters.
 
-*   ``-v``
+*   ``-v, --version``
 
     Display the version information on startup.
 
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 2f91b96190..675745d610 100644
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
@@ -109,6 +116,7 @@ eal_long_options[] = {
 	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
 	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
 	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
+	{OPT_VERSION,           0, NULL, OPT_VERSION_NUM         },
 
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

