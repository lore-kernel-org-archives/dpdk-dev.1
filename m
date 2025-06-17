Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE8C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:26:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D929342707;
	Tue, 17 Jun 2025 20:26:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3979E410E6;
 Tue, 17 Jun 2025 20:26:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184798; x=1781720798;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mqp8jEZPieSEYnnPlVj7sCHSD2srqWhXO4UnMTYABnE=;
 b=bCMWTLhTEPbsR04yUuI6rJJuOqF6EnhMaiiwKyjubwZKJTX1i0lJDhvs
 0pk2KFApQlLgQQys4yxtJKW849mvPsyOp1qTQ0EILjdBM+bf+ZPp1HbA1
 P4c3z4+bVMHJb22KfDUeFWXyFMCdm2U4DgV7UEVxdyVFwvh7xajYbhum4
 75k7ELaBz4QzRo9zme5yZuiJp3aGaq6aEgyXvTDd87aZkQp2h8TSmEdAA
 fbPetiqNBX5q8Hc/ziswCNdADF+4Hcr95WnCwc5qrmtzoxl3gAF6Z3gJd
 Yx2P2NqfuUcaDtVHt2SIVXpKuNb86BSVEhsaG60RQyTsoqQaSOypIA3Kc g==;
X-CSE-ConnectionGUID: x52VQ1A5Soyv/Hn2sEjzRQ==
X-CSE-MsgGUID: JCZSw3lwQ0SOCX3No1QF2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737716"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737716"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:38 -0700
X-CSE-ConnectionGUID: ZNYKzbbLR/iCBKH+1kCMjg==
X-CSE-MsgGUID: sXoV1hfhSBOstie6CUsv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622612"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:36 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v3 1/7] event/dlb2: fix addresses deq failure when CQ depth <=
 16
Date: Tue, 17 Jun 2025 13:26:24 -0500
Message-Id: <20250617182631.257612-2-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250617182631.257612-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
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

Fixes: 3a6d0c04e7fb3e ("event/dlb2: add port setup")
Cc: stable@dpdk.org

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
2.39.1

