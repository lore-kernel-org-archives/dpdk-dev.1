Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB8CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 02:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D3AA40144;
	Fri,  2 Oct 2026 04:17:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CE87A4003C;
 Fri,  2 Oct 2026 04:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790907469; x=1822443469;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9lwumDliKMGIIYYyuPnO3ZDYiDD8NwUmQ4ucXgUiaNk=;
 b=h2luqk2G6LwdCZ5Rv7j/jt0l+1jsaRnj6V5eB8XGVeYNwMRKdHbEMVBG
 mGlLRQBkqlsLZBmlYAnOH3hTK+X6GkLwPz7uYY2VgmuyO96kai3q1uNKv
 kmnncv8Asa0G2RdBdF6s77LPCA+lBBSCJ/0AiUlwxcPRxa8Hka6lNgb+I
 VRCYv1WsYh9G3WXZad2jbLBhH2mdHFT9X9z7jERA6Bm2sQIf0VImO+Ia1
 leAthEoCqjwuYRW1WuPie3yvMCvK4R/0mhDgHqa0Ueb60RKqiIYh0cnWH
 sJ97kEkvUXZCdHhP2+8I6/fD5T2BGhXBaJ3XHrsvC8nFqrpNWbatYEHJ1 g==;
X-CSE-ConnectionGUID: mlhR1jqOTkaU8uNMydKTpw==
X-CSE-MsgGUID: A3+U4PSfRuKgG5ixLrVSEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102201431"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="102201431"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 19:17:47 -0700
X-CSE-ConnectionGUID: YIsM2h4GQ16Pde2LOByBJQ==
X-CSE-MsgGUID: ESjqjZaQSEGVXip/oRMwYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="174160"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa012.fm.intel.com with ESMTP; 01 Oct 2026 19:17:44 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/ice: fix unchecked Tx time context allocation
Date: Fri,  2 Oct 2026 02:19:37 +0000
Message-Id: <20261002021937.391321-1-anurag.mandal@intel.com>
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

ice_tx_queue_start() dereferences the Tx time queue
context buffer returned by ice_malloc() without
NULL check.
On allocation failure, the E830 send-on-timestamp path
therefore crashes instead of reporting "No Memory" error,
and also the already allocated txq_elem buffer gets leaked.

Added the necessary allocation failure check and freed
txq_elem buffer in case of failure to avoid the memory leak.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..873aca0100 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -898,6 +898,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
 
 		ts_elem = ice_malloc(hw, ts_buf_len);
+		if (!ts_elem) {
+			rte_free(txq_elem);
+			return -ENOMEM;
+		}
 		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
 		ice_set_ctx(hw, (u8 *)&txtime_ctx,
 				ts_elem->txtimeqs[0].txtime_ctx,
-- 
2.34.1

