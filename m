Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCDCD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 159BF4064F;
	Mon, 25 May 2026 16:06:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id CA81F40276
 for <dev@dpdk.org>; Mon, 25 May 2026 16:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718016; x=1811254016;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Cu9WjkQGi51TXboBTirjDtavD9tjLsVD2WEiwjvEJB8=;
 b=OtkOxryg3C23ZCo4yxzvhWqKWw2EVfySqzEArGlULOs00SziVTwLlyWA
 qtOXGc7/pkJhc5hemt8S7wYRP9U3EY+stV9n3SWn6v567hAdyzfUImRYN
 1wfc24sVu8cDn3m/pJjwb4rmYpGPWye08RHylsiiV/GRHdyoc0uWxWta+
 a9QatAF85Kis+V+cSZullxB2DiU82a506wW6uk8KXj2o8zV8OgB1wD31k
 RpSKqLEehtX7K4Sz8JDsYpKv5StXHAh72J3Da+B4YJQF+6383VBAbQJax
 BX15JjNkx5ckzPTKKzizOCYawXu7F7jLwgAIDZWEifx8zzVOhLRrWa9SB g==;
X-CSE-ConnectionGUID: TjKH6AjnThS+k/HVFH3hFQ==
X-CSE-MsgGUID: fkUbuxvyS2ObVact185c9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392474"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392474"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:06:54 -0700
X-CSE-ConnectionGUID: 50OgKCL1QY61BHKBEHbTxQ==
X-CSE-MsgGUID: Nbux0KOUSRaYxGRVM+gVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692292"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:06:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 02/27] eal/common: add token concatenation macro
Date: Mon, 25 May 2026 15:06:21 +0100
Message-ID: <57ed806b6c47aa9316bd5af3154535439d39cdf6.1779717943.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
References: 
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

Add `RTE_CONCAT()` macro to enable token concatenation with proper macro
expansion.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/include/rte_common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 0a356abae2..05e72e500e 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -918,6 +918,10 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
 /** Take a macro value and get a string version of it */
 #define RTE_STR(x) _RTE_STR(x)
 
+/** Concatenate two tokens after expanding macros in both. */
+#define _RTE_CONCAT2(a, b) a ## b
+#define RTE_CONCAT(a, b) _RTE_CONCAT2(a, b)
+
 /**
  * ISO C helpers to modify format strings using variadic macros.
  * This is a replacement for the ", ## __VA_ARGS__" GNU extension.
-- 
2.47.3

