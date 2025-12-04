Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE8D29FAB
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2DE5406BA;
	Thu,  4 Dec 2025 19:21:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B8D254066E;
 Thu,  4 Dec 2025 19:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872466; x=1796408466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4emQhvthmL90PjXJHNHLO/a7A64pglFT6afx3qpY5Tk=;
 b=T4rPB9UIZqEfGHLRjdaDiPMY4yrYqh4sn3PNJLj8lU2YBmGNNltmrDbZ
 EnWiCtwsLnyM4gniCor4QUJvKCITWmBoF2qWGB+hC1NvEPssGMYKrXRdA
 1cp4MN94EpBTnLr96RvTCL73taMY97yYSpUQxJXjiF9aVK17QiRoBfZ5Q
 mHolr8gowWxDjgpwav1Q6R5qOD6QnakC5OSNQPE6WbNpVmhDda1WP4amZ
 9KGr6ONNATK7EPoF2SoVUmjUCPH/Ho2p/O/RJL5NPbm1gJNA3bYGWq7XR
 v4YTs0iLZ5StXeTeVQZEITMDieY0C9E51gA+gqnECxGHM1TtQyZpZv7eo w==;
X-CSE-ConnectionGUID: 4aeXbbTFTIKhO6NRovPy9A==
X-CSE-MsgGUID: ykhXHDZbQiCKxhYcY5wpng==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013019"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013019"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:04 -0800
X-CSE-ConnectionGUID: qBbLLX7iSIO3GuyVf3Jb1g==
X-CSE-MsgGUID: QTTi9JorRmOdQm0t7xoJgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423167"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 04/10] app/test: fix timer loop hang on secondary process
 failure
Date: Thu,  4 Dec 2025 18:20:41 +0000
Message-ID: <20251204182047.3154429-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204182047.3154429-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
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

When the secondary process run from timer_secontary_autotest fails, the
timer loop is never stopped so the whole process hangs until timeout.
Fix this by setting the stop flag before checking for success or failure
of the secondary process.

Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_timer_secondary.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index ee2675a821..8580880a56 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -160,11 +160,12 @@ test_timer_secondary(void)
 		TEST_ASSERT_SUCCESS(ret, "Failed to launch timer manage loop");
 
 		ret = timer_secondary_spawn_wait(*sec_lcorep);
-		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
+		/* must set exit flag even on error case, so check ret later */
 
 		rte_delay_ms(500);
-
 		test_info->exit_flag = 1;
+
+		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
 		rte_eal_wait_lcore(*mgr_lcorep);
 
 #ifdef RTE_LIBRTE_TIMER_DEBUG
-- 
2.51.0

