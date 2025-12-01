Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A2D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819BC402DF;
	Mon,  1 Dec 2025 12:45:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E9BEA4013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589504; x=1796125504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2Y4fnFHKCxvqHYk9mwGCExmprQc4zhJHEk0u2bNp3hg=;
 b=B/n8T0AoAEYbajivIC0e6MEARd5RCJwLt/meRKGMlbUBBPjc272j3l7e
 DODdRdh24MsswMbduiDhU5SzBjjqavMp4prP4DmiXX8kFGI0PIi+ziywb
 IkR+Wcoh9QQPlbw3gxz46GvWWv2Y91FOKaLMBToeJETBwSzGzNw5lDOZm
 zBubDQA+THpRf6sFdwNUonAc4kMMkTlGuzThSCi1ImHEmQuOFeENG8hcP
 IXy8f26VDeLZH6jFim9pabdTiC7xCMPUvct1ElYWKAc2NePTMe0gVTYYo
 /fdMj+oon1b2PQj0d3d+NegeHsQuL7hUjL3tGo/2yPh1roB4AjVnWRh68 A==;
X-CSE-ConnectionGUID: X0huYPKsTqqQ9Bvd5OrB+g==
X-CSE-MsgGUID: dHhCAtDvTkyfl6xEJJTEUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991675"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991675"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:03 -0800
X-CSE-ConnectionGUID: BlDmMR10Sw2B/sGBTEb7wA==
X-CSE-MsgGUID: SXOcbXkqS+6byJWaWUSr7Q==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:02 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 01/31] eal: add more min/max helpers
Date: Mon,  1 Dec 2025 11:44:18 +0000
Message-ID: <20251201114448.1441377-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
add RTE_MAX3(). Change name of local temporary variables in RTE_MAX()
to allow for combinations of RTE_MIN(RTE_MAX(...)) without causing
shadow declaration warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
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
2.51.0

