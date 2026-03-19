Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB201090257
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A76402ED;
	Thu, 19 Mar 2026 18:13:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 33ACC4013F;
 Thu, 19 Mar 2026 18:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940421; x=1805476421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1QS61jECvPKm2eaSjgdoGg3HRKSeYaTKRZHcmUef4v8=;
 b=IrEJlBEmTfnABRsCm5hfCpN1gJQ0mysXgSA8pN1908lqvmL5p857MfzM
 jJjU+UGdExK8s+clQeppWEvkqIiXFSs1AfEbDiZ6wh/wXVaujnJAZ6mL/
 C/tRFFZ7g/ZCIzKvwLhNCvQI5txCEJHJ6EhSahBFsi6jiAOSDn1wYWtuJ
 aRMxXLXhlrh63oFf0L2dDNQm3kh8NN9oAa1R4iiFQA2MMv/CM4T3RCClE
 lbxNylM+hlO8FEGLscHy1Jqpa2PE0upFl4Fto1qujUgUQXSR4A8+Jwvxm
 Cxb/3DKKA1nNgnTYdpigBF+1qzJ+Kqzaf6NwXJxCIweRo5censSBxvw51 g==;
X-CSE-ConnectionGUID: BmopYvhzRF2S02Ldu9YRLg==
X-CSE-MsgGUID: tO+v440VSne9bJILxPEuUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648027"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:40 -0700
X-CSE-ConnectionGUID: 7jUxsmVRQRyB6rx3sjIyZg==
X-CSE-MsgGUID: XSCOxQ74TXOQC2syXl/8KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979621"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 1/7] test/timer_secondary: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:35 +0000
Message-ID: <20260319171334.1151425-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
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

FreeBSD does not have multiprocess support, so skip the secondary timer
autotest.

Bugzilla ID: 761 (partial fix)
Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_timer_secondary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 57ab39130d..529774f4d0 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -18,11 +18,11 @@
 
 #include "test.h"
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 int
 test_timer_secondary(void)
 {
-	printf("timer_secondary not supported on Windows, skipping test\n");
+	printf("timer_secondary only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 #else
-- 
2.51.0

