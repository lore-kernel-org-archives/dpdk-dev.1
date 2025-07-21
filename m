Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CCC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E0E40A67;
	Mon, 21 Jul 2025 17:16:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EA2484067B
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753111015; x=1784647015;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3jqnjrBFuhuWA99pVBtQ8baOvnu1ti4Xkkteq6XhXxQ=;
 b=eKfgENuXOI0hgYCucvpT9xWzMGP/+J/gYd4+Jubs4MNWMTLE96HteX9D
 jq4Rg8edkuzoez9DgFxXZQsV6jwfJPZM34BzPWmJdSWufSrDjzKGGPViY
 bbKjMQ1eaFwOZr6UhVphnI7NROVXUD1wqQGCdzyB1K2wM2JtSffcwp3rr
 nc2h7Ju84O9pReJJ+iXkwYDG4HdlpKKaw28Z3F5dxCfMV105RCrGXzzJo
 O96YoHIJnZaYPriDVMeLoHWi7FhaWRnF9x0r0nW/lcIZu0V2zPets45FS
 3oz7A0I2sBIkPXi3Say14lkzUUmJ/NTBwt214m1lOiBfBBWyUACzouxBS w==;
X-CSE-ConnectionGUID: uvtS4jtnTZy8aVXnmJGbkA==
X-CSE-MsgGUID: UgnR6KD3RiKR5jPK7GkJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="42949388"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="42949388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:16:55 -0700
X-CSE-ConnectionGUID: dBbCwz9WTtilf8wakutQcw==
X-CSE-MsgGUID: ULrDkaqzTe+NZfV5BRZQVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="182575421"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2025 08:16:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v5 4/9] eal: add long options for each short option
Date: Mon, 21 Jul 2025 16:16:37 +0100
Message-ID: <20250721151643.2739725-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250721151643.2739725-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250721151643.2739725-1-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c       |  9 +++++++++
 lib/eal/common/eal_options.h              | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 12 deletions(-)

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

