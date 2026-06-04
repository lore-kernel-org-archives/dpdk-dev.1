Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60446CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B424065E;
	Thu,  4 Jun 2026 18:19:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1A184402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589981; x=1812125981;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WkpwzGCTqh4KdySpk+lxQVLLrBnWYL+xrwWIY6Iah2I=;
 b=Vtxf3uqrE4ykCza7E6eX7Wjs85qunYMOtRHuUEVoW/QlGAz+OZ8sVjga
 xZ1qdPJ77LNjuh1ZJfjRoLYnXUYpKU4muQKbCxUCeey2h+Ae1MXldsIep
 i2KxrZyO2NKa0ktqiLNXOd3jau+4bZA9x56/85PrmjF14ha/GUe9erI+Y
 824QpQQraDg6ZE1LSScc0ZNUXsN18za3gweY4XQrrH4LWujgWXNw8Ex8K
 YwzmMXSMwBcLEpMU9Q2wpnpC1GH8uKA5ixrn+CC7IOS4oD0oT3yhsgswK
 YEs6L7hqgLOx6+/AI8igb3Kr1eBFpsUm1QV5Kj6JE5AMPhRmY8HBnYHd6 Q==;
X-CSE-ConnectionGUID: C+a3oLl4SBi9X9jy1EdIJw==
X-CSE-MsgGUID: wp8q/RHbT9yc3EygiHOsZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045107"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045107"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:40 -0700
X-CSE-ConnectionGUID: 26KtSphQSeqDFmaMqIOEgA==
X-CSE-MsgGUID: u867t5BcTZOJkVc/fVnBdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240403951"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 02/27] eal/common: add token concatenation macro
Date: Thu,  4 Jun 2026 17:19:06 +0100
Message-ID: <bf3328c3f6ea50888822ea7a0b7504f2d11f8b75.1780589913.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780589913.git.anatoly.burakov@intel.com>
 <cover.1780589913.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/include/rte_common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 71415346cf..2eb21d74d1 100644
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

