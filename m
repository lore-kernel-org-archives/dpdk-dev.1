Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72337CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3FC7402F0;
	Fri,  7 Nov 2025 16:50:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BC0B84021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:50:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530654; x=1794066654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fPLK9OWp0dKKWa6yE4iqcFxOgT5MmGsJ1vCpMJ/lbAI=;
 b=c3PppH0rxzJ5fVENUTuyvgSXSe5DECSS8I3JZuvj7yo87S7aQP8CA+Ii
 zULn9wF5F3pMcVCB8cAN0XSi+ofaZv5Hu+OeFUj/L4oBEQaZpWhHtReKR
 G+ytpM57SsebA8goXunSUYHfPlhEpecN8n8slFLxeSwCqwbRUSgO5AIxx
 MVHFHrzwv/Qp04rBDol85K8IHKhEZvAeC0XB/oLqe5V1MbdSNWt2ONnPn
 A18Sc5ymuptwnjfn90DUrhWDBVwwrGKLu6dPe+/lf2isob4TgWVPUstJj
 4YnPADLSxEESJZpUQ6uOW9R6n+USfqUJM/1xtffIcOsHtJbHuloYpO3lU g==;
X-CSE-ConnectionGUID: pPjpqgnZRWCNn2YplZwFQw==
X-CSE-MsgGUID: Lq8zw5jxRgqeXzEsyFF4Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151818"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151818"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:50:53 -0800
X-CSE-ConnectionGUID: wzYXYQesR8+LfJy6euXq3A==
X-CSE-MsgGUID: JAet0Oq9RFmK9FE7UicqGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321620"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:50:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC PATCH v2 01/33] eal: add more min/max helpers
Date: Fri,  7 Nov 2025 15:49:57 +0000
Message-ID: <20251107155034.436809-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

From: Stephen Hemminger <stephen@networkplumber.org>

Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)), and similarly
add RTE_MAX3(). Change name of local temporary variables in RTE_MAX()
to allow for combinations of RTE_MIN(RTE_MAX(...)) without causing
shadow declaration warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/include/rte_common.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..36400e8e43 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -799,6 +799,19 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 		_a < _b ? _a : _b; \
 	})
 
+/**
+ * Macro to return the minimum of three numbers
+ */
+#define RTE_MIN3(a, b, c)                      \
+	__extension__ ({                        \
+		typeof (a) _a = (a);            \
+		typeof (b) _b = (b);            \
+		typeof (c) _c = (c);            \
+		_a < _b ? (_a < _c ? _a : _c)   \
+		        : (_b < _c ? _b : _c);  \
+	})
+
+
 /**
  * Macro to return the minimum of two numbers
  *
@@ -814,9 +827,21 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_MAX(a, b) \
 	__extension__ ({ \
-		typeof (a) _a = (a); \
-		typeof (b) _b = (b); \
-		_a > _b ? _a : _b; \
+		typeof (a) _ax = (a); \
+		typeof (b) _bx = (b); \
+		_ax > _bx ? _ax : _bx; \
+	})
+
+/**
+ * Macro to return the maximum of three numbers
+ */
+#define RTE_MAX3(a, b, c)                      \
+	__extension__ ({                        \
+		typeof (a) _a = (a);            \
+		typeof (b) _b = (b);            \
+		typeof (c) _c = (c);            \
+		_a > _b ? (_a > _c ? _a : _c)   \
+		        : (_b > _c ? _b : _c);  \
 	})
 
 /**
-- 
2.48.1

