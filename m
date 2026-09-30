Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B95CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 02:46:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3715410D4;
	Wed, 30 Sep 2026 04:46:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2FAE6402A2;
 Wed, 30 Sep 2026 04:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790736405; x=1822272405;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XvWsX6YXhACjsE2mQEluc61TDsjooa0w0Ir38cbur18=;
 b=So8pf/YWRcfuYL5GWdVFPssWrlKrfzOOloDAkcs0pMHU06EmmF8E3c2A
 ud2U8J3DOUfra5SKuUNEpmfveGnAwDVYr2tHvc/ChGqZnQy64hXXHouMe
 SHWOwXdyLEuoQAGXF7OYrkDDb9/SI4tbvPk1xwjqRBZ8pmctL/L81Gb3a
 d3KSXqlQ+FcG8qqvxvmQf984XRAzsH1dTorcaNHO/yvsdhyIOGBvKU+VV
 tZjJHlbeTKdTuzsrk2UjNBPrak7MKmGw+GP62lnJDhDsipQTTPzqyX7kG
 AJ/CCTGK+WLuMbHyCXuzI4PSrYA3+nrLYzKjYsKQikoJul2TyZ5hN5UDb Q==;
X-CSE-ConnectionGUID: DrlpoRCxRHuxVOtFXuEEZQ==
X-CSE-MsgGUID: OpswDQNRTYeDewoYwcdH0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="107852877"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="107852877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 19:46:44 -0700
X-CSE-ConnectionGUID: 6pOIHA7STZyo50+ZSKDyYA==
X-CSE-MsgGUID: QecLidwmSI6gIp1WZSdV5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="279354020"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa005.jf.intel.com with ESMTP; 29 Sep 2026 19:46:43 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/ice: fix disabling outer VLAN insertion
Date: Wed, 30 Sep 2026 02:48:39 +0000
Message-Id: <20260930024839.337910-1-anurag.mandal@intel.com>
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

ice_vsi_dis_outer_insertion() treats a 0 return from ice_update_vsi()
as a failure, but a return value 0 means success, so the error and
success paths are swapped.
Removing a port VLAN in double VLAN mode logs an incorrect error,
returns invalid argument, and leaves a stale
ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT bit in the cached
VSI context that later VSI updates replay into hardware.

Inverted the check to avoid this bug.

Fixes: de5da9d16430 ("net/ice: support double VLAN")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 163304ba1e..2c5ffe07f3 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6447,7 +6447,7 @@ static int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi, struct ice_vsi_vlan_
 		 ICE_AQ_VSI_OUTER_VLAN_TX_MODE_M);
 
 	status = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
-	if (!status) {
+	if (status) {
 		PMD_DRV_LOG(ERR,
 			    "update VSI for disabling outer VLAN insertion failed, err %d",
 			    status);
-- 
2.34.1

