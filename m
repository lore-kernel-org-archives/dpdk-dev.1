Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C378CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9413A40E1D;
	Fri,  7 Nov 2025 16:51:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 67BCB40E13;
 Fri,  7 Nov 2025 16:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530681; x=1794066681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B6lWAOUfRz9REMBLK5oLuIcRr9kdw3dp//8nljb9MzA=;
 b=lw+0AfEBs0m0vCmB/YohHL4yczO6lGPyM626gzYtrVpY0F+kKR41Wc0g
 DML8dcg23t2o0jorn28Cgv2wvRs+ydLgSilA6YFkH7s6CCns+Vtkkqy8j
 zgYr7Rje+vVwhA7gDyd19fJ2KeMlmyMvRqMbfqH4JIVogMmmd/wLrx7U/
 SFP8z7GbAS9NdDeKDm9HPOUBTRfGctcjA2sWWJkrdBxgPdMyVwuYci7Hk
 PHNLiViKB5vsGORBNZ0WCNgE2oBVa7/UayOGeon9CX2C5WKk6kgV0CLvu
 FXr+2ktk1cEMVx2cJ/+IjH50Qc2YbuOlWvgVcVyDr+au3PvrpEBoMoVJa Q==;
X-CSE-ConnectionGUID: y2dZilK9SXKiqQu2lhEWmg==
X-CSE-MsgGUID: ZFoL3vW+T5CyGu7L+/12Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151853"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151853"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:20 -0800
X-CSE-ConnectionGUID: dcwhUYwASt+H+xky3VkqAA==
X-CSE-MsgGUID: +Cj1YzojRIm71E+bw3auUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321707"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>
Subject: [RFC PATCH v2 16/33] net/ice: fix build with shadow warnings enabled
Date: Fri,  7 Nov 2025 15:50:12 +0000
Message-ID: <20251107155034.436809-17-bruce.richardson@intel.com>
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

