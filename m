Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38547CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 461CD4066D;
	Fri,  7 Nov 2025 16:51:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 58A8F40A71;
 Fri,  7 Nov 2025 16:51:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530668; x=1794066668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5gYmSU6JC5TAq0NHyZ54zh/UCqI9xaRmxgbjcAr8Ixw=;
 b=FazO4M/6RqIVTR4hzy53PL4iwjBWjEQVKY7Hv+dt4CLL/2xHe7b/1j6B
 PTDuNYIIKZa9bQEv9b/kan3Zl9aVJy/Nh+G8AP4S0aYotImqXxhx7von2
 531lkX1b54o47UAGsx9WxcySnZnho+qB6AXdidQSwwmqKhUaAn7wmLb8k
 o4ms6ur33ihoY394Gb9gloKw5iq6GrEJxZZYdvKysOjiDMmVgitcDoIwQ
 BhLPssjmivQg3dwc9jYubsq0qcCiQzYGQDqZ2wVUyZrWWY9LlR81hyRj+
 lDwiuOOvihBZ5uHVLq5E0OiB2RrJwRttjllV9/c15OLO+1oaodDo2nPIW g==;
X-CSE-ConnectionGUID: /k7kO9q/QsuOLkQvxr0Yqg==
X-CSE-MsgGUID: eSK0bgnASAm1Mg7DlP4YVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151840"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:08 -0800
X-CSE-ConnectionGUID: sfqmeKVRQuGgIxTiaKQYNw==
X-CSE-MsgGUID: kzrcs1oVSWOBg7dSplacHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321662"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [RFC PATCH v2 08/33] power: rename variable to eliminate shadowing
Date: Fri,  7 Nov 2025 15:50:04 +0000
Message-ID: <20251107155034.436809-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

