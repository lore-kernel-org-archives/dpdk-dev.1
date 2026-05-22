Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF05CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9924D40667;
	Fri, 22 May 2026 17:14:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1F4994003C
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462885; x=1810998885;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Cu9WjkQGi51TXboBTirjDtavD9tjLsVD2WEiwjvEJB8=;
 b=kKV0kTedzusjAgPhS0qAnIqsvjokDIP5goTFaJme09e2b2GBs51piK6C
 OoyZJSzGB3niXDsOBBS0qSJ63I6gIZ0V37EM41SEYLFqr66FXb2lXyENt
 3vSncrqMuZ1lYiz2MLr9HCDHzxfl11nZzaOtAkE8Xos5tfVG7imKW4V0k
 8KVGPunLsEGbjitsmil7lmpkPnYBHHLMXtSvxfS39by7g9xiQLOiX5Ao+
 7cj1WmkesZ+K+7v/BNhUwjPXV/Vdrd/QzZ2uQDSgFbbxmVCG4kb9nG22Z
 F+0RVfNOO14xPu1mlj+wpCC+cnPvsbujRVxXC5f5Ku9VT8g5pgKCQ/MEo A==;
X-CSE-ConnectionGUID: /uKWxyG+RA+UauQTtDtdPw==
X-CSE-MsgGUID: YYEH3BXgQjSLY55esFYCTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969149"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969149"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:44 -0700
X-CSE-ConnectionGUID: WLHR2W+aR669rTgXZ/xnwA==
X-CSE-MsgGUID: apN1f7kASOqTQhhy9Awfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213917"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 01/26] eal/common: add token concatenation macro
Date: Fri, 22 May 2026 16:14:10 +0100
Message-ID: <57ed806b6c47aa9316bd5af3154535439d39cdf6.1779462699.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779462698.git.anatoly.burakov@intel.com>
 <cover.1779462698.git.anatoly.burakov@intel.com>
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

