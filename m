Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1ED37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD3D40E27;
	Wed, 14 Jan 2026 16:45:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9B74B40B91;
 Wed, 14 Jan 2026 16:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405527; x=1799941527;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2FNKBX/BiVhdKLfo5K4zmZyYL88ncMCrIcIV89BQoPI=;
 b=EafDHi6usXTNo1WkQfoCJZw8ZMB11SrOH8CxoAMWpRw0LBtM8X5wseGL
 lyZwcII4PgkU7ptk53b01EqhNhNxOQ4h8zdRjv6In51dAO0AjuRjj9cFj
 EsOl7dba7lYWbyEC+1E82Daabiq1slnN8syt0khPKglGeOJhbYANkdPCm
 g9P9lL5W8n6ffTWxF26uqa1km+IgzJRcaML+qgGJsWKufJ+vpG9LYwbvP
 34hyG6cPhE2WaN4SSCFVKBTMNNFkGhmvMESGIEFbkoYiJEpNZ8nIfM92P
 i9OQBw2LxjWMynPJdIq500SIhUIHV62JdFd5CTLvWAwquJyVtxVVFNfX2 g==;
X-CSE-ConnectionGUID: 6lHmP7ITS+uNA2GFm+31ig==
X-CSE-MsgGUID: JWcrKAODTnCxuNL+r/zy1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870877"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:26 -0800
X-CSE-ConnectionGUID: lNDc1IZvRpusM9ELnVwfUA==
X-CSE-MsgGUID: UU8XtK4mT3mw5L4g5yFuTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925016"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Wenjun Wu <wenjun1.wu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v4 15/31] net/ice: fix build with shadow warnings enabled
Date: Wed, 14 Jan 2026 15:44:29 +0000
Message-ID: <20260114154450.2969716-16-bruce.richardson@intel.com>
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

