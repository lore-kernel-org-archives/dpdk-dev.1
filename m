Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA22D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D6594066B;
	Mon,  8 Dec 2025 12:52:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1CD684064A
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194773; x=1796730773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=otR1b4t8n2YFtJTC5hNSWPeSygLIrEo/2q5m/fjFHiU=;
 b=GpwV/+3D64EOjVTfeLpwVMiOnxexMmsRRea/u63iqNn64eLTWA/K5+Bu
 k/Qm7cJoR1nTQCJ4RRgV0ROBSCxEooupGiEQtoZRcJtojrFQgUq39GWyQ
 DqgqGB7mEXUXVx42P+IAHpLMFKFS7FOfo1x74bG/w/l0ZrpPDrefsVuy4
 qVGihhpc70R0BQJoKJArtC/ZInFHCmmglp+YmMbxqlMJytRpvs6lr0+zp
 jEiAyApRUdgyVZ3/CC9Eny0Hpl7f+kBvWeP8Aac3cpWqB6Tju9GY/KtHW
 fytN/irjrNMvx/v74SFCruvzPzGZTA2FipbCn9n4WuCwUmdkAIgZmZ9j6 w==;
X-CSE-ConnectionGUID: UiDQLyJnSdi1kNzrPpNs/A==
X-CSE-MsgGUID: pDniZo5tRYaBc/50rianxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096053"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096053"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:52 -0800
X-CSE-ConnectionGUID: ZRvj9dMvT3OgJsfREkHVtA==
X-CSE-MsgGUID: TKa8lVMnQL+zu7QYAotqdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970648"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/11] app/test: reduce duration of secondary timer test
Date: Mon,  8 Dec 2025 11:52:37 +0000
Message-ID: <20251208115245.3809624-4-bruce.richardson@intel.com>
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

Reduce the timer duration and the primary wait duration in the secondary
process timer autotest. This should help ensure it doesn't time out what
run in a CI environment.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_timer_secondary.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 60ce8c7507..ee2675a821 100644
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

