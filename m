Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8840CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 13:00:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC6B402AB;
	Thu,  7 May 2026 15:00:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2A93340265;
 Thu,  7 May 2026 15:00:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778158808; x=1809694808;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4WAXeNUfakQ15T1f4GQDtQBIfvLibJNQ25KnJatBPio=;
 b=UlH/2Ut1Qwg1eoy98reo1Sl6GI1GMA2d+Joi1Th+I8I3h4RCh+KEt9Yp
 GuzKhMD4O1xCglUjd2UHS3VhiT6qxvnMQBY0oLlwbFCrBpebrUJSgi+Fr
 BTj8yW/PcOfXYm4IfMDj0wIylXcXy7PpwUjtPr3N2xA5LgjONFlSHxBrF
 saW+FuWU3yNSX6ADrJt/qIoys0gFGlBGf+YIUhU4VIHQxH+oTOWblTF/k
 hcb8jLKmw8bcsGxyRrrpTVn5XhNPgClSir8d4ODLIIgmxGLO7ZqlIo3yR
 dou1Yc+ent2faMBJkQQXGuHQnE4DHieY1xQ2AfPlfMjR7YRG2IQhrtGuN Q==;
X-CSE-ConnectionGUID: yvbAblqEQfuzCXT4xA0WHA==
X-CSE-MsgGUID: qEDHDC2UTgaxu6tgD+H3Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78133376"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="78133376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:00:06 -0700
X-CSE-ConnectionGUID: rBuBcb5LQsaN7NokTEefCQ==
X-CSE-MsgGUID: Lp2MzUYeSHW8tZjUCcAp/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="240783656"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 07 May 2026 06:00:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Mukul Katiyar <mukul@versa-networks.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/2] net/ice: properly handle TM hierarchy deletion
Date: Thu,  7 May 2026 12:59:29 +0000
Message-ID: <20260507125930.1668860-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

From: Mukul Katiyar <mukul@versa-networks.com>

When a TM hierarchy is fully deleted and then committed, the hardware
scheduler nodes may be left with any bandwidth limits that were
programmed by the previous hierarchy commit. These stale limits may
remain in effect the next time the device starts, permanently throttling
traffic even though the TM hierarchy was removed.

Fix this by resetting all descendant hardware scheduler nodes to their
default state when committing an empty hierarchy. Also restore the port
queue count to its hardware default and clear the committed flag so the
port starts cleanly without any TM configuration applied.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Mukul Katiyar <mukul@versa-networks.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Ensure restore is only performed if a hierarchy has already been
committed
---
 .mailmap                       |  1 +
 drivers/net/intel/ice/ice_tm.c | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 22476860ed..2f96e80f16 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1132,6 +1132,7 @@ Moti Haimovsky <motih@mellanox.com>
 Muhammad Ahmad <muhammad.ahmad@emumba.com>
 Muhammad Bilal <m.bilal@emumba.com>
 Mukesh Dua <mukesh.dua81@gmail.com>
+Mukul Katiyar <mukul@versa-networks.com>
 Murphy Yang <murphyx.yang@intel.com>
 Murthy NSSR <nidadavolu.murthy@caviumnetworks.com>
 Muthurajan Jayakumar <muthurajan.jayakumar@intel.com>
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index ff53f2acfd..2bb684bb02 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -805,6 +805,19 @@ create_sched_node_recursive(struct ice_pf *pf, struct ice_port_info *pi,
 	return 0;
 }
 
+static void
+reset_hw_node_recursive(struct ice_hw *hw, struct ice_sched_node *node)
+{
+	uint16_t i;
+
+	for (i = 0; i < node->num_children; i++) {
+		reset_hw_node_recursive(hw, node->children[i]);
+		if (ice_cfg_hw_node(hw, NULL, node->children[i]))
+			PMD_DRV_LOG(WARNING, "Failed to reset node %u to default configuration",
+					node->children[i]->info.node_teid);
+	}
+}
+
 static int
 commit_new_hierarchy(struct rte_eth_dev *dev)
 {
@@ -820,8 +833,15 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
 
 	if (sw_root == NULL) {
-		PMD_DRV_LOG(ERR, "No root node defined in TM hierarchy");
-		return -1;
+		if (!pf->tm_conf.committed) {
+			PMD_DRV_LOG(ERR, "No root node defined in TM hierarchy");
+			return -EINVAL;
+		}
+		/* TM hierarchy deleted. Restore default scheduler state. */
+		reset_hw_node_recursive(hw, hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0]);
+		pf->main_vsi->nb_qps = pf->lan_nb_qps;
+		pf->tm_conf.committed = false;
+		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
 	}
 
 	/* handle case where VSI node needs to move DOWN the hierarchy */
-- 
2.43.0

