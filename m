Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE539D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97FCF40A7A;
	Mon,  1 Dec 2025 12:45:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3E5A440662;
 Mon,  1 Dec 2025 12:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589520; x=1796125520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2FNKBX/BiVhdKLfo5K4zmZyYL88ncMCrIcIV89BQoPI=;
 b=HaY5I+rZztSz4hpgug09XK6OSci5ipXLtuYNJJyuJc4T9HGI8Nv+QBj9
 XEOou9Vdxv+lY5Yq6MmNQ/BtWa38zArFeJOSksDbhUm/D2ggjXBMYWtw8
 xRYhe2Ga9+T+zRWwxvslhkhPvoydt0cyL9Ck38Y86HG8mDbJz3NIAuyL5
 RJ+uFyI2dHSfXlsY1Y4W8pzQ+6ggVF9+RX2xS1cNKeZ+qKCoAazt+GpIu
 c3lEfkgepdH05VPQm+FduUpZ2++lj/7kL6/TBJR3/aF++UZTABiNQXZal
 qMRBEC8NVd8o+AYEvQyXtyOCVclbaDR67sxkKUeXWeVD59iWiOD8HoKF/ g==;
X-CSE-ConnectionGUID: 6EC4FNmKQmasOXLyN1Mlrw==
X-CSE-MsgGUID: UtZdXTH4T5CAIivakgkbFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991738"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991738"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:19 -0800
X-CSE-ConnectionGUID: tljACWhHTRClEKJgkX3egQ==
X-CSE-MsgGUID: sKNDQM7CTDaimqa9Cdhv9A==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 15/31] net/ice: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:32 +0000
Message-ID: <20251201114448.1441377-16-bruce.richardson@intel.com>
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

The RTE_MIN macro used newly-defined local variables internally, which
means that it had variable shadowing issues when one RTE_MIN call was
used inside another. Fix this for ice driver by using two separate
RTE_MIN calls to have the same effect.

Fixes: 8c03aa5e00f0 ("net/ice: optimize maximum queue number calculation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c721d135f5..3242572cd8 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -999,9 +999,9 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
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
2.51.0

