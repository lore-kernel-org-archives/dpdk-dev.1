Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC88D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6218F40E22;
	Thu, 11 Dec 2025 18:17:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 767B840E0B
 for <dev@dpdk.org>; Thu, 11 Dec 2025 18:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473438; x=1797009438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EOS3NmgVb//CZN7hS3ozPArpDyXsNlYHPUkxOaMoYWY=;
 b=RJDv8JlW+KZA/SeP8fwkkS/alw+gALEp8x61KmIcjMAyseM4/4vqbHUw
 dTtAPhjWNz9WiBIyL8g/Yl0at73OW3nJ/GcfWaNoFNanPpjqy/KqCI7Og
 egI/MyXix72P0Ky2jSDfX2CPR0J0Pg0i6Y7PIp8r+wPNPXbEZw0Isb/Bk
 V9bynEBY/qAvqn1SZGsKmzOaoZt2h8ioO0y9PIsuL0X3YLVdTN0EN6VPF
 lL5YXNFWSc9WvoXx8VG0/RjUGwVlHG7cbiUsJTWgWarNRXkEb3C0tNsnJ
 v7dKICL9rqP4whvttBlnb87WVi+BN+pZovBAYwGucyTK/E2tcDqu3kTc2 A==;
X-CSE-ConnectionGUID: 3624FovXSLeDH8fSPTJQRA==
X-CSE-MsgGUID: xB+E3mUTRjCZga4bruyilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069983"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:17 -0800
X-CSE-ConnectionGUID: Wo+5TnLDQ0ut1juEQxdQeQ==
X-CSE-MsgGUID: kZR8a/PzScOoG3fH+Ad7Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461561"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 03/11] app/test: reduce duration of secondary timer test
Date: Thu, 11 Dec 2025 17:17:01 +0000
Message-ID: <20251211171709.714229-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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

Reduce the timer duration and the primary wait duration in the secondary
process timer autotest. This should help ensure it doesn't time out what
run in a CI environment.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_timer_secondary.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 4e220559b4..864f175d6a 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -162,7 +162,7 @@ test_timer_secondary(void)
 		ret = timer_secondary_spawn_wait(*sec_lcorep);
 		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
 
-		rte_delay_ms(2000);
+		rte_delay_ms(500);
 
 		test_info->exit_flag = 1;
 		rte_eal_wait_lcore(*mgr_lcorep);
@@ -189,8 +189,8 @@ test_timer_secondary(void)
 
 			rte_timer_init(tim);
 
-			/* generate timeouts between 10 and 160 ms */
-			timeout_ms = ((rte_rand() & 0xF) + 1) * 10;
+			/* generate timeouts between 10 and 80 ms */
+			timeout_ms = ((rte_rand() & 0x7) + 1) * 10;
 			ticks = timeout_ms * rte_get_timer_hz() / MSECPERSEC;
 
 			ret = rte_timer_alt_reset(test_info->timer_data_id,
-- 
2.51.0

