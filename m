Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1098ECA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55953406B7;
	Mon, 18 Aug 2025 12:59:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E8C7940649
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514785; x=1787050785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z2BWcocRxeqgYWjf4ttECMdSaz1aKuybIZ223jR9StY=;
 b=O/2HsJjTiRoJDpcrdCXRTnIYsRDHIBjHg0r0zGwNHd20M7wvIWkArmLC
 YH0rFIcg44x6nfOCTv4rGrYza1eB7VGi4hK06HN3qHzpJfulZFVtkSiK6
 ixh95a0yr7KjQp51mq9od3+R7qOFkig9wBDWKJD3WYoZlniWzm6TI/UXh
 RRpz9gIZYiwmpPhvwuhXlCUCxldEx+hWpXvGMS+493B9/Y3szeNOrNrvH
 SAtlHBJ1jXxHh/FGa907qGk5PRRreLGPui5oxDnElZd6Jkp6V6SCQCtYs
 pUUrsu1tQ4NsdM85EeRyLynJYiShJNIY7Fup4mVOvAQtLGYTcQWxzTGxE Q==;
X-CSE-ConnectionGUID: 0TiRLNzORjykZwX2HbBjNw==
X-CSE-MsgGUID: 87TPOKhgR6q1q04mQlLEzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165438"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165438"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:43 -0700
X-CSE-ConnectionGUID: GGOI3QK5R0WYwwgBYfAmwQ==
X-CSE-MsgGUID: xsbS4wOERAOneopBz+rfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722996"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:42 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/15] net/iavf: reorder enum of Rx function types
Date: Mon, 18 Aug 2025 10:59:10 +0000
Message-Id: <20250818105914.169732-12-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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

Order the elements in the enum of Rx function types starting from
smallest SIMD width to largest, similar to the order in the i40e and
ice drivers.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 69f9abbef3..435902fbc2 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -323,29 +323,29 @@ struct iavf_security_ctx;
 enum iavf_rx_func_type {
 	IAVF_RX_DISABLED,
 	IAVF_RX_DEFAULT,
-	IAVF_RX_FLEX_RXD,
-	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_SCATTERED,
+	IAVF_RX_FLEX_RXD,
 	IAVF_RX_SCATTERED_FLEX_RXD,
+	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_SSE,
-	IAVF_RX_AVX2,
-	IAVF_RX_AVX2_OFFLOAD,
-	IAVF_RX_SSE_FLEX_RXD,
-	IAVF_RX_AVX2_FLEX_RXD,
-	IAVF_RX_AVX2_FLEX_RXD_OFFLOAD,
 	IAVF_RX_SSE_SCATTERED,
+	IAVF_RX_SSE_FLEX_RXD,
+	IAVF_RX_SSE_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2,
 	IAVF_RX_AVX2_SCATTERED,
+	IAVF_RX_AVX2_OFFLOAD,
 	IAVF_RX_AVX2_SCATTERED_OFFLOAD,
-	IAVF_RX_SSE_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2_FLEX_RXD,
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX2_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512,
-	IAVF_RX_AVX512_OFFLOAD,
-	IAVF_RX_AVX512_FLEX_RXD,
-	IAVF_RX_AVX512_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED,
+	IAVF_RX_AVX512_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED_OFFLOAD,
+	IAVF_RX_AVX512_FLEX_RXD,
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD,
+	IAVF_RX_AVX512_FLEX_RXD_OFFLOAD,
 	IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD,
 };
 
-- 
2.34.1

