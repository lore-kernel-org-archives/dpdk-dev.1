Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B4CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 02:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08914027A;
	Thu, 18 Sep 2025 04:43:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7705040144
 for <dev@dpdk.org>; Thu, 18 Sep 2025 04:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758163410; x=1789699410;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VgKMWYvClLbSkSiYnrLKz9njUs9jH0j+76sZzlk6ByM=;
 b=H2JD8wFVYJr3wnBQ10kM3ssjlBlz+9xBPpEiO86nTaDXm7/piSxv1A9r
 qknerG40IIlOxOFklAXL4z5r8GKFF+UQzMppi5fH7riFb/hLRAdx+4a60
 usB+kWEK0+EGG0erEYTdm/Z0JMC9IItDA8lvhFi6blVMnYyRr2EMNSch1
 y1cW/EEeUOBiWrw2bUvNSx6uqHwB/YVEUuzLxzmFADOgLtE2Ao48G9byl
 nWCrsNRnQCy84zU/Pdi/d5kGYLf+EonTzfR7bsvErmANW2/ygusxjRoOd
 WxIKtZ7ROKDwTXqUT8Sb8BTRz2WfiLr2IFzwgVNtu10WUSgEeHYkKsZx+ A==;
X-CSE-ConnectionGUID: U/Orp78kSzadkCY+SGjK/Q==
X-CSE-MsgGUID: P5uTFuwSQHiekhLi2GtD2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71164443"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; d="scan'208";a="71164443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 19:43:28 -0700
X-CSE-ConnectionGUID: X2QHgxQTQ+qgXy9mrOv/5A==
X-CSE-MsgGUID: Gs7CM5XaRr2z/L23RO4Apg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; d="scan'208";a="174528256"
Received: from npg-sp-srv11.iind.intel.com (HELO npg-npf-wlpr-srv27..)
 ([10.190.212.78])
 by orviesa006.jf.intel.com with ESMTP; 17 Sep 2025 19:43:27 -0700
From: Megha Ajmera <megha.ajmera@intel.com>
To: jasvinder.singh@intel.com,
	stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jasvinder Singh <Jasvinder.singh@intel.com>
Subject: [PATCH] sched: fix wrr parameter data type
Date: Thu, 18 Sep 2025 08:16:09 +0530
Message-Id: <20250918024609.2027038-1-megha.ajmera@intel.com>
X-Mailer: git-send-email 2.34.1
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

wrr tokens getting truncated to uint8_t in wrr_store function() due to
type mismatch. This patch changes the data type to uint16_t.

Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")

Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
Acked-by: Jasvinder Singh <Jasvinder.singh@intel.com>
---
 lib/sched/rte_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index 453f935ac8..daa31e8b99 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -67,7 +67,7 @@ struct __rte_cache_aligned rte_sched_pipe {
 	uint64_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
 
 	/* Weighted Round Robin (WRR) */
-	uint8_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
+	uint16_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
 
 	/* TC oversubscription */
 	uint64_t tc_ov_credits;
-- 
2.34.1

