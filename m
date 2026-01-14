Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DABD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D77CE40C35;
	Wed, 14 Jan 2026 16:45:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6D9E0400D6;
 Wed, 14 Jan 2026 16:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405515; x=1799941515;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ekcd77hZ9ZkbUrzp6YmGN0q/qY5Z+20UkGzqSIo7E50=;
 b=U4cMI4a8Ql5LYbXLWGoVnJVV8kSf97PiKi91ZKU5VkbqkauL9eCWkvGF
 wNy/jcM60Hu1hSgMKLchL2cctmgMcsLDh7ivUbbKvuZOD2mHp8t3Q/16L
 3Z71go24IZO7Cy+8XpaFkiQA9B/YoTEz6fmYiQGiUAWW1Zdf6lGD4de27
 YNifxZNGmCWF15WYx2pJNLzvDzikGJXBSNz/GjdVZqozaEUxS0/p83eUn
 TQtGTSmhoe0LuK+KHxR1Qy2pm42IoWymBLDH1nGsp1aT01VSLMP/ntY85
 FXtPd0lsAgP5IYGxT4Vu9kJzgGvIHjamr5ouEqEWvJB3QJZwcXxXJypyQ g==;
X-CSE-ConnectionGUID: OOuQpAHHQtW571Hv9VpTbg==
X-CSE-MsgGUID: paEvJTRkQUuH386fUPIHLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870825"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870825"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:15 -0800
X-CSE-ConnectionGUID: 2i7MK1ldReOn4yhe9c1+9w==
X-CSE-MsgGUID: k6KglNi7TIur76LsOsw2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924985"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Ray Kinsella <mdr@ashroe.eu>, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v4 08/31] power: rename variable to eliminate shadowing
Date: Wed, 14 Jan 2026 15:44:22 +0000
Message-ID: <20260114154450.2969716-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

