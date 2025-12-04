Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA6D29FAB
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 18:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99FD44066E;
	Thu,  4 Dec 2025 19:21:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 31C9B40613
 for <dev@dpdk.org>; Thu,  4 Dec 2025 19:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764872464; x=1796408464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=otR1b4t8n2YFtJTC5hNSWPeSygLIrEo/2q5m/fjFHiU=;
 b=ApEKqJnEUZHOcH1wFKzdKYaXLC9LSTJuaDPQEi2BAxjG10S+vlTwbbTF
 nMTaRvafrD0Srcp2OZMpniTk0bOyBXDpEkjnEkc3OsRHlemCrRpUlmdbN
 VK4CMocLVSem9uWEOT5EHwq707WJ8Y6s7Y+AUB+LzTnQLZ+odVGO7ggyR
 OxQ5PwbGMUe5G5fXVm6gxbpngHtqfVAVNm46YjTvtSk2BPKz58Z2yf6xA
 B01+Jn2vQTN2BiyFBatwS/AkqLS0qc1PQynTGm0JZ7UOltez5L7IBfwew
 dtVB2bh9n/9X0KEn4IJDSF0XeFrAwG64ySw+9Mr0a9q88OgKh3HgUcu7c g==;
X-CSE-ConnectionGUID: LAS0049VSWyuGBeyxztERw==
X-CSE-MsgGUID: FmygXjj/RjC2HKKNl8oYAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78013017"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="78013017"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 10:21:03 -0800
X-CSE-ConnectionGUID: +vIrhRW2SimD8W+ucpe/bA==
X-CSE-MsgGUID: 7NTgqtFSRDKWY5aE4zZz0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; d="scan'208";a="218423161"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2025 10:21:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 03/10] app/test: reduce duration of secondary timer test
Date: Thu,  4 Dec 2025 18:20:40 +0000
Message-ID: <20251204182047.3154429-4-bruce.richardson@intel.com>
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

