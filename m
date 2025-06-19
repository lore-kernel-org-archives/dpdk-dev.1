Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50722C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 765D442DCD;
	Thu, 19 Jun 2025 06:03:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 91C284021F;
 Thu, 19 Jun 2025 06:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305804; x=1781841804;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=urScQjoA3+jiuNuGlF+h4K/hdr3tt706hhfMQlvqqOU=;
 b=aDaWR+TnVDazwi/eoZNYJX4da8qKs1Skrk0oUyzzjwTSjui/VdoAFoyH
 Le1OmJByR/9UG93XgWlLZ+peg+s41Pr5AuzjTzbzhCizywDoKuOrzRm97
 dM9FSGL5gbbYkJ/1J+UW3Fw4cp417lsGm6QB5Le/Ggp2vKR/lzvZU4Wyr
 TwXoJWT4Mu2gn9TqOc5tqKnQ1mMDdyszQN3n+zfURHzRR+nvsSKk8hnPC
 zvCXlKb1qP/EbsUHea69UkLxLS+NNwBGbY1FwBX+urjjJn802T3fh/z1q
 BYG4IVIvgg+7Lre3VeHdXYIY1nRhsDOgV/BBfwWRVnClDXYZyDvDJ8r0M g==;
X-CSE-ConnectionGUID: ZpTbDnNbS8iwH/2bJCB1Vg==
X-CSE-MsgGUID: qQ77sm8uQyiF/BBqeC+ExQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592735"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592735"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:23 -0700
X-CSE-ConnectionGUID: 8RyRuRGpSe2Ng2E/67lEAA==
X-CSE-MsgGUID: 0pfQ3kblTfSIB5VD295uoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665482"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:22 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v4 1/7] event/dlb2: fix addresses deq failure when CQ depth <=
 16
Date: Wed, 18 Jun 2025 23:03:10 -0500
Message-Id: <20250619040316.317733-2-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619040316.317733-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250619040316.317733-1-pravin.pathak@intel.com>
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
index 08291b10b8..bec1e88074 100644
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
index ac432b81ad..cd2788c035 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -427,7 +427,7 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 	/* Calculate the port memory required, and round up to the nearest
 	 * cache line.
 	 */
-	alloc_sz = cfg->cq_depth * qe_sz;
+	alloc_sz = RTE_MAX(cfg->cq_depth, DLB2_MIN_HARDWARE_CQ_DEPTH) * qe_sz;
 	alloc_sz = RTE_CACHE_LINE_ROUNDUP(alloc_sz);
 
 	port_base = dlb2_alloc_coherent_aligned(&mz, &cq_base, alloc_sz,
-- 
2.39.1

