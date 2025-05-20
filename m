Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33CC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:40:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E75D40B9D;
	Tue, 20 May 2025 18:40:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 788974029C
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759243; x=1779295243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=znBiSN27qJ0p34eTTwAYJ3QhoW+cpP2gT+XXMcFktxg=;
 b=UyeOsrZIUVMVPpIe6Ruq37SMURDmKVMTvOkuYJwRhu8bMhrk7dpFi6j4
 guP5ow3fVJtdO5OTAHQoJsxoiyR7xCNWu5AI5JYYKe7jENnkHtkH9ndDu
 XYyYzC1NcbbIV5L4/IZMrUzJCRm3OUIIxrIGbVGhjnca5gpZTDk2DmW43
 GV5kVjoQjDOw+0lkygJ7EEMUb+fo9EEvS98s6EWQq4iNe9MFlpYrUB0xV
 sCK4DvKZhZFmXxI1PcDQOb+rWSm3LNmE+wcTOZwO9p2XsHdRCfuBPT7A/
 SOhg8AVZRhEq4jMHc+sRPXMKNsDNTVINuuodMLMHRjtAI+cdtc8Sp0E8u w==;
X-CSE-ConnectionGUID: i7USaWYUTY2gkRO5rEOEmA==
X-CSE-MsgGUID: gu5XpreBTVScxfrkcb5ZWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320461"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:43 -0700
X-CSE-ConnectionGUID: nY5OU1fIRpClLXd4qmjTTw==
X-CSE-MsgGUID: VDbdR9toTvGUToa4ud2j8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759473"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC PATCH 1/7] eal: add long options for each short option
Date: Tue, 20 May 2025 17:40:18 +0100
Message-ID: <20250520164025.2055721-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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
index ed514ec1d1..a22dc69681 100644
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
@@ -106,6 +113,8 @@ eal_long_options[] = {
 	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
 	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
 	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
+	{OPT_VERSION,           0, NULL, OPT_VERSION_NUM         },
+
 
 	{0,                     0, NULL, 0                        }
 };
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 7b84b7d778..e493821db1 100644
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

