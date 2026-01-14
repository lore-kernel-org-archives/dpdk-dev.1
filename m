Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A75D37E44
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48062409FA;
	Wed, 14 Jan 2026 16:45:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CD323400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405501; x=1799941501;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HrFznUpLdrmsA4CooLIUNewG7612AalhLPfN30x7yL4=;
 b=MFAJxeyJC2LUGqhRadald1uDSVP9IEycGOsdqupinZXW4K1y6PL7/Npo
 H94dkIbb4Rh8dD36PrHxwDN6VGUcQXdNqtcuSvpe+TErL8MdLWS+I/Ecw
 0jJFEZNmfSLACaeVxZQMd7rCYMgBMRdyo7czHScNod+IngmXd9bMu6pZC
 VBx6CnkJkRM99Vtijtm8lnpsjW0FseF1t1wJGfYL1fa1aztf4twBDoU+8
 lgadGsg4WFOAlAN9o+BlT8r/Esef0qevVwBh+3cRTdKOluXGTXpDRtrn+
 R6yePVi+ounQ/Zj2jAfNT2JDzmVYWvyXfzbvFLfkjKtVcpZkUUvVjBplj g==;
X-CSE-ConnectionGUID: v/EmkkhjS8K+McxdBZh4lg==
X-CSE-MsgGUID: UP5P9Ba5QcOGTE9I/JzEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870768"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870768"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:00 -0800
X-CSE-ConnectionGUID: Xe8b3lukTIqTg7XqpMHCGw==
X-CSE-MsgGUID: Ddby/uxxRDqi+3wo51mcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924878"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:44:58 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v4 01/31] eal: add more min/max helpers
Date: Wed, 14 Jan 2026 15:44:15 +0000
Message-ID: <20260114154450.2969716-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Stephen Hemminger <stephen@networkplumber.org>

Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)), and similarly
add RTE_MAX3(). Change name of local temporary variables in existing
macros to allow for combinations of RTE_MIN(RTE_MAX(...)) without
causing shadow declaration warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/include/rte_common.h | 38 ++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..3d013f5592 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -794,9 +794,22 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_MIN(a, b) \
 	__extension__ ({ \
-		typeof (a) _a = (a); \
-		typeof (b) _b = (b); \
-		_a < _b ? _a : _b; \
+		typeof (a) _a_min = (a); \
+		typeof (b) _b_min = (b); \
+		_a_min < _b_min ? _a_min : _b_min; \
+	})
+
+/**
+ * Macro to return the minimum of three numbers
+ */
+#define RTE_MIN3(a, b, c) \
+	__extension__ ({ \
+		typeof (a) _a_min3 = (a); \
+		typeof (b) _b_min3 = (b); \
+		typeof (c) _c_min3 = (c); \
+		_a_min3 < _b_min3 ? \
+			(_a_min3 < _c_min3 ? _a_min3 : _c_min3) : \
+		        (_b_min3 < _c_min3 ? _b_min3 : _c_min3);  \
 	})
 
 /**
@@ -814,9 +827,22 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_MAX(a, b) \
 	__extension__ ({ \
-		typeof (a) _a = (a); \
-		typeof (b) _b = (b); \
-		_a > _b ? _a : _b; \
+		typeof (a) _a_max = (a); \
+		typeof (b) _b_max = (b); \
+		_a_max > _b_max ? _a_max : _b_max; \
+	})
+
+/**
+ * Macro to return the maximum of three numbers
+ */
+#define RTE_MAX3(a, b, c) \
+	__extension__ ({ \
+		typeof (a) _a_max3 = (a); \
+		typeof (b) _b_max3 = (b); \
+		typeof (c) _c_max3 = (c); \
+		_a_max3 > _b_max3 ? \
+			(_a_max3 > _c_max3 ? _a_max3 : _c_max3) : \
+			(_b_max3 > _c_max3 ? _b_max3 : _c_max3);  \
 	})
 
 /**
-- 
2.51.0

