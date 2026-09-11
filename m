Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB9C88E53
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 16:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ABA642DD1;
	Fri, 11 Sep 2026 18:40:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6E48042D35;
 Fri, 11 Sep 2026 18:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789144835; x=1820680835;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dgGjLUaGpw35x33Z86+m/suBbfBhKEQ/g2Kc5pegRzg=;
 b=JEedpdpaYQUbLZDGvq+VNLUrGbaUVRg2ecnZHZTudUCaLnPfwPo7QSJF
 ZXAyPdPKz0Ldq6nkl81aghMHyA39NgoYaWcfRakmgvcVzPd6yrtq4Bct5
 1hL/+6fNmQ/fGEqI/d2oglcRftkZ8julZD4ETZMBZ+HGBPgw1tyARQ5a2
 /on6UAE4bl4FlJmFHyI21q2trHpvavyku9rTpN5Y59nkAMBl0LlKlLPUV
 kPHJpiqRVS2wqVnpjdonyWFgNGr7tijA8LI1GbB79ERwEfcSdDdVQ+Bm8
 nQBzX33Txza/WPe8OIYe46A9HWH2/ybCM802UwXlWVCuxQD1aGhDurUMS w==;
X-CSE-ConnectionGUID: ksKOGN+oT4+PfzJGqsQIGg==
X-CSE-MsgGUID: m7hqs3FWRtWkSptnnLGEjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89484915"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89484915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 09:40:34 -0700
X-CSE-ConnectionGUID: aTDW7JWvRz66gi+r08v+dA==
X-CSE-MsgGUID: VGljaxtiRs+bZ3oEViAT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="296949911"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa001.fm.intel.com with ESMTP; 11 Sep 2026 09:40:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] eal: fix pointer add/sub macros for large offsets values
Date: Fri, 11 Sep 2026 17:40:29 +0100
Message-ID: <20260911164030.2465043-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The macros for adding or subtracting from pointers cast the pointer type
to uintptr_t before doing the arithmetic. However, for 32-bit builds, if
the value being added or subtracted is larger than uintptr_t, then we
get errors when casting back to "void *" type. We fix this by casting
the result to uintptr_t before casting to pointer.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/include/rte_common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index f872d3eabb..c17f50e2fd 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -572,12 +572,12 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /**
  * add a byte-value offset to a pointer
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#define RTE_PTR_ADD(ptr, x) ((void *)(uintptr_t)((uintptr_t)(ptr) + (x)))
 
 /**
  * subtract a byte-value offset from a pointer
  */
-#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#define RTE_PTR_SUB(ptr, x) ((void *)(uintptr_t)((uintptr_t)(ptr) - (x)))
 
 /**
  * get the difference between two pointer values, i.e. how far apart
-- 
2.53.0

