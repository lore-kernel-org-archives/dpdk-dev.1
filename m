Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA5D3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E7D4066F;
	Mon,  8 Dec 2025 12:52:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B446A40656;
 Mon,  8 Dec 2025 12:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194774; x=1796730774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4emQhvthmL90PjXJHNHLO/a7A64pglFT6afx3qpY5Tk=;
 b=fYcPOC+zn20Bz9gpgZ+SaJi/BQ0kQbUNg8haa8ivWJcjLU00Hx9BPvea
 BH1MoBnd+RmmiM27OfKhxu6+TRKEpt+NIA9y2r8dDZv6MPh5pI2mzOPU1
 rp4pQ65WZkss5tVC2QIgleEq9fQnsCASNQ3S4wJYHrfRuCPn7KwjQwPCb
 ecrmviqmaR/020OBbuLp9SROJSlsIIPPX6LPjwnsgSH40UImB9RONhpHi
 oHDF2qOBTV7dgMor1fMS3QvYReJTcGQgyKqUDKKysCDgLbMSoZZqjLqsw
 b5f8CvtTy0CbLnFC/PGXcFYco2ZNMd5beGcm51dHK7YUF7QxUcSC6Bkkz w==;
X-CSE-ConnectionGUID: 3PoMGHV7TFmDQNc35hDTeQ==
X-CSE-MsgGUID: zD3IeoYMRo2msphli2AYsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096054"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096054"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:53 -0800
X-CSE-ConnectionGUID: U1XpbFgjS+e4WwVyisXp0g==
X-CSE-MsgGUID: iUPA1TwgQAeXpllij5q0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970653"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3 04/11] app/test: fix timer loop hang on secondary process
 failure
Date: Mon,  8 Dec 2025 11:52:38 +0000
Message-ID: <20251208115245.3809624-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

