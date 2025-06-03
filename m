Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350BBC61CE5
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D59410FD;
	Tue,  3 Jun 2025 20:05:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4177F40DCB
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973920; x=1780509920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TxBJ0tRrzcyHyxjdrjt6lCkQLV7dtbEXUefKryVtTwY=;
 b=HGg2ZxrRkS04cv0ClStf0+Ek5FvaHsBbsjZMBeYUBZg7CACegYO4ru3Z
 RxdrxHdAqp5VQnkEEATRMd5N14WIr5zrOxcjlyFXXx9c/P0NDgYS3qClM
 OBLch97ImzB4927pF8wy1Lov3kGt0WJHHCwMwQmH5tLVgol7e6sGQJW0+
 enQfXQsJJj2H8lV14MqnfhQDhcuBi6jTTJm5ozbB637TdILGlIO7uq6pC
 eXWYT5NaQRxOE0edzTt6S0gY+LEugUlLKns9nBoD7PqE+zBNgdIAkqsMR
 1ZeD46wZmpiDbH6rq1WwEpk3wrwyd4GJO0OMo4W6/x205G8O7bssnz4L0 Q==;
X-CSE-ConnectionGUID: Se6EqiSBQSuudP5VugS74g==
X-CSE-MsgGUID: eE+XImi1QBeUolajdEApNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463572"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463572"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:19 -0700
X-CSE-ConnectionGUID: u9G06chzQiqBjGpCxH8URw==
X-CSE-MsgGUID: q8OG5sArRNa+eefsX/OaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110472"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:19 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2 1/7] event/dlb2: addresses deq failure when CQ depth <= 16
Date: Tue,  3 Jun 2025 13:05:08 -0500
Message-Id: <20250603180514.3826917-2-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603180514.3826917-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250603180514.3826917-1-pravin.pathak@intel.com>
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

When application configures a DIR port with CQ depth less than 8, DLB PMD
sets port's cq_depth as 8 and token reservation is used to make the
effective cq_depth smaller. However, while setting port's cq_depth_mask
application configured CQ depth was used resulting in reading incorrect
cachelines while dequeuing. Use PMD calculated CQ depth for cq_depth_mask
calculation.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/dlb2.c       | 4 ++--
 drivers/event/dlb2/pf/dlb2_pf.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 286241ea41..a0e673b96b 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -1951,9 +1951,9 @@ dlb2_hw_create_dir_port(struct dlb2_eventdev *dlb2,
 	qm_port->cq_idx_unmasked = 0;
 
 	if (dlb2->poll_mode == DLB2_CQ_POLL_MODE_SPARSE)
-		qm_port->cq_depth_mask = (cfg.cq_depth * 4) - 1;
+		qm_port->cq_depth_mask = (qm_port->cq_depth * 4) - 1;
 	else
-		qm_port->cq_depth_mask = cfg.cq_depth - 1;
+		qm_port->cq_depth_mask = qm_port->cq_depth - 1;
 
 	qm_port->gen_bit_shift = rte_popcount32(qm_port->cq_depth_mask);
 	/* starting value of gen bit - it toggles at wrap time */
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index ed4e6e424c..31b5487d85 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -400,7 +400,7 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 	/* Calculate the port memory required, and round up to the nearest
 	 * cache line.
 	 */
-	alloc_sz = cfg->cq_depth * qe_sz;
+	alloc_sz = RTE_MAX(cfg->cq_depth, DLB2_MIN_HARDWARE_CQ_DEPTH) * qe_sz;
 	alloc_sz = RTE_CACHE_LINE_ROUNDUP(alloc_sz);
 
 	port_base = dlb2_alloc_coherent_aligned(&mz, &cq_base, alloc_sz,
-- 
2.25.1

