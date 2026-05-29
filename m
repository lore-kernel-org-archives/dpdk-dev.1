Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D4ACD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:36:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADB64066D;
	Fri, 29 May 2026 17:36:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 450064027D
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068999; x=1811604999;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Cu9WjkQGi51TXboBTirjDtavD9tjLsVD2WEiwjvEJB8=;
 b=QXS3K8GUqqqfcLm/leM3Z3WCHKBs5DRQv8amBHFT5/gxDhbrVguY4unh
 Qz1PNuVGUPZOgYui3yvn+oTP1rAVM18KSv1Or5CSzV02XZtB6r3sm/4Le
 mUNGyBcD7R+zoM08VRgYxCc8DFifKFNcMdCeA/pf7JwHyboOMc8jGKhP8
 0Nrb0OlAyeZ6KoWiE68jER+gHiGzJQngZuf3aLhR08QJr4WPkD221PVr/
 qFJF891TQwSal0oaUgZvDT/l5vocGNcerVHPiKa41NgkjgNOMyL6W1G0E
 k/yILvB1RWvxI/NNdKgD2xnx1ZnLYxeCvSHeHaFIwI5MeETfV8ZrZYl6Y w==;
X-CSE-ConnectionGUID: DvwGeDeCSCygC/ovZpv1oA==
X-CSE-MsgGUID: 3+/c7e1kS+CKT4mY5CDK+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549766"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549766"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:39 -0700
X-CSE-ConnectionGUID: 6BqAfxbJQo+g3+Y3se82+g==
X-CSE-MsgGUID: 2cAHkrjfTfa04R37GahLJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001201"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 02/27] eal/common: add token concatenation macro
Date: Fri, 29 May 2026 16:36:04 +0100
Message-ID: <704cee7225126a5d50df80ddc166c9f7a05b832f.1780068633.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
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

