Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B3D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D88ED40670;
	Mon,  1 Dec 2025 12:45:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E96964065A;
 Mon,  1 Dec 2025 12:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589512; x=1796125512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ekcd77hZ9ZkbUrzp6YmGN0q/qY5Z+20UkGzqSIo7E50=;
 b=U0oMCufNAqQMxHjkUN1/EPsYYCEwJQRX1CoeT++ODGxMPdUj2RKuiecu
 QGXiSJUmC3YumvbpksblZn850VGiz9KVnpVO5JTXuuSc8L6QFoulHaFyd
 zpQCtl8voHUAwy8EEiSy+n8K0SVX/JUXcXLLy0p8NjLSZQiV+wqMCoZMa
 PJhxiijLkkuPIumydvCb1buHlFsUkPV6P7oKlrEANAVSpBiodPrSAHH93
 U4WUJT4wgXZ1WgtQY3o92GeCfrm9+v8tT/gpGBxl7xIbkgwsEDG7eESvq
 IDjLBEHyWj/4Kwst8Dn5MqHLnqcgmPTQptvypah5txi6XoPG22Qr5TXLZ w==;
X-CSE-ConnectionGUID: 6vz8o3yaTtehN9QM5Lbwrg==
X-CSE-MsgGUID: ylw1nQWoRhWO1HE9nyFYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991715"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:12 -0800
X-CSE-ConnectionGUID: WG8qr3mqTPqS747Jd4MnHA==
X-CSE-MsgGUID: 4DQducArTHyRpYX4nl91Pw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:11 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 08/31] power: rename variable to eliminate shadowing
Date: Mon,  1 Dec 2025 11:44:25 +0000
Message-ID: <20251201114448.1441377-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

