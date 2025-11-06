Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC356CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3333E40A6F;
	Thu,  6 Nov 2025 15:10:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6E23B40659;
 Thu,  6 Nov 2025 15:10:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438212; x=1793974212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5gYmSU6JC5TAq0NHyZ54zh/UCqI9xaRmxgbjcAr8Ixw=;
 b=glnLZubovxnS9weeP15TIGwbfIk8nw6mJN9WyQD6JnX/OHiXd+SPpUvY
 udHs7zCSo5kCHIZXESQOkn9Zqyyz7qLd7OwX6Ur7Gy9tlLA8YJoMiHTv0
 fHS3Ej6f+zFRgOT3Zv/nbtlBWzLjuyry3BxlqwtU5Ba8jOMAm1pfWRCrv
 h8O1LcznOW3vEod5KRbQI/yuyb/9iWKg7wxTyei6bXuZFnu0IeoWhLdde
 MHRmXMV0MfUuVIEvgxkygRlBkkgvEm4M9xrIVwu0l/e6RIVFumeYTCB5E
 U4vD0FjucGxhok9EpTA0A9SgWzTU1aAZw3zVcZLyXI2JefmrZjOEHBe1h Q==;
X-CSE-ConnectionGUID: W7+OlC7sRm64sLu4jreKaQ==
X-CSE-MsgGUID: I5hohKXgS42cbnAoPaReIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185306"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:11 -0800
X-CSE-ConnectionGUID: KZH1OvKzTg6DJ433I+TmuA==
X-CSE-MsgGUID: mhQXJuhgREa9ZdGA4lDVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054737"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 08/19] power: rename variable to eliminate shadowing
Date: Thu,  6 Nov 2025 14:09:37 +0000
Message-ID: <20251106140948.2894678-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

The "pause_duration" variable is a global and then shadowed as a local
var in clb_pause. Rename the local variable to allow building with
"-Wshadow".

Fixes: 4a8fbc28e431 ("power: add get/set pause duration API")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/power/rte_power_pmd_mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/power/rte_power_pmd_mgmt.c b/lib/power/rte_power_pmd_mgmt.c
index 6cacc562c2..a4d53aac2a 100644
--- a/lib/power/rte_power_pmd_mgmt.c
+++ b/lib/power/rte_power_pmd_mgmt.c
@@ -337,7 +337,7 @@ clb_pause(uint16_t port_id __rte_unused, uint16_t qidx __rte_unused,
 	struct queue_list_entry *queue_conf = arg;
 	struct pmd_core_cfg *lcore_conf;
 	const bool empty = nb_rx == 0;
-	uint32_t pause_duration = rte_power_pmd_mgmt_get_pause_duration();
+	const uint32_t duration = rte_power_pmd_mgmt_get_pause_duration();
 
 	lcore_conf = RTE_LCORE_VAR(lcore_cfgs);
 
@@ -357,11 +357,11 @@ clb_pause(uint16_t port_id __rte_unused, uint16_t qidx __rte_unused,
 		if (global_data.intrinsics_support.power_pause) {
 			const uint64_t cur = rte_rdtsc();
 			const uint64_t wait_tsc =
-					cur + global_data.tsc_per_us * pause_duration;
+				cur + global_data.tsc_per_us * duration;
 			rte_power_pause(wait_tsc);
 		} else {
 			uint64_t i;
-			for (i = 0; i < global_data.pause_per_us * pause_duration; i++)
+			for (i = 0; i < global_data.pause_per_us * duration; i++)
 				rte_pause();
 		}
 	}
-- 
2.48.1

