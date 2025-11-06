Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3405CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20F8940E0A;
	Thu,  6 Nov 2025 15:10:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 02EF040DC9;
 Thu,  6 Nov 2025 15:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438219; x=1793974219;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B6lWAOUfRz9REMBLK5oLuIcRr9kdw3dp//8nljb9MzA=;
 b=XU0M4B76JT6/Z0+ODvLYjIZsm2AK7q+8gdwup2O1eTTIlNaKRBaxLi8M
 CvHqkHtGYIAnd8X3alUHUlqEc9h5oUEF7ihCOCYasHez85jII96FI+rKS
 JRAxvX1bLPWhtI4w177apvJgCNGVf+g0kx7QA0FtB+HOKm5+GlEg6fIo6
 KrOHeZvFd0oKjFuNk7pjz8yxKPdQcjge4KbQVq3yyR6wf8PtVw7O0j2J5
 mG7o2EBIyj8ngnLjTZ9jlhksdK2rU7SryE86K+hRVfpE+P4mFHNF3hFcx
 ATo4TieCMJO/+9WUk2rQObYIJQSBauBFjZqnfusIFVnSwB5vVN8t9p63W g==;
X-CSE-ConnectionGUID: aiAhJw5dS4WxF2PAXcdK6Q==
X-CSE-MsgGUID: ktaxm5bfRZiRCxyLviC70w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185342"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185342"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:19 -0800
X-CSE-ConnectionGUID: yMUSoNdjQsuu+JOvwmLvPA==
X-CSE-MsgGUID: hjX/GYxbQy2XXG0nf0cZUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054779"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 16/19] net/ice: fix build with shadow warnings enabled
Date: Thu,  6 Nov 2025 14:09:45 +0000
Message-ID: <20251106140948.2894678-17-bruce.richardson@intel.com>
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

The RTE_MIN macro used newly-defined local variables internally, which
means that it had variable shadowing issues when one RTE_MIN call was
used inside another. Fix this for ice driver by using two separate
RTE_MIN calls to have the same effect.

Fixes: 8c03aa5e00f0 ("net/ice: optimize maximum queue number calculation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..d2bd423a69 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -995,9 +995,9 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
 	if (vsi->adapter->hw.func_caps.common_cap.num_msix_vectors < 2) {
 		vsi->nb_qps = 0;
 	} else {
-		vsi->nb_qps = RTE_MIN
-			((uint16_t)vsi->adapter->hw.func_caps.common_cap.num_msix_vectors - 2,
-			RTE_MIN(vsi->nb_qps, ICE_MAX_Q_PER_TC));
+		vsi->nb_qps = RTE_MIN(vsi->nb_qps, ICE_MAX_Q_PER_TC);
+		vsi->nb_qps = RTE_MIN(vsi->nb_qps,
+			(uint16_t)vsi->adapter->hw.func_caps.common_cap.num_msix_vectors - 2);
 
 		/* cap max QPs to what the HW reports as num-children for each layer.
 		 * Multiply num_children for each layer from the entry_point layer to
-- 
2.48.1

