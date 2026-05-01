Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA82ACCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 10:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43844042C;
	Fri,  1 May 2026 12:59:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6C5E540299;
 Fri,  1 May 2026 12:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777633146; x=1809169146;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gb71SrOGeajZUoEKfXILUK2gP5PizYeZTyrOTBF0jx8=;
 b=SxZGQexnbA2h75SM6ubBcM3YQ996vbWUuIE9/q+TnMhuQTRk1kVE6cav
 0GrVUGmNKqY/MM0RAOojjFxPbBGYCBydMlfBR3/3B61ggLzzFHrikEWrq
 di7/zGxPJWl8syqwyyMbgrZYh3GmSwQ4ky5YxkrM9GFF1cG4rA8Aw3pRP
 vfmiDw1GGye/n94O370p7qkXb7L22gWADIhXKa5pQJ5SFVGjdzSsfH6y4
 OwYPV6aeQrnWMOwBxcLqaBbCXMktjtT89aLC+x1ZfkTcRYVzvTKXXpta7
 i3SeBTHhDdGLNFIu83la7dELFjvOXRn8Xl+5Ad2HBsA1JBmjAgWN6OIs/ g==;
X-CSE-ConnectionGUID: Wa4RN38VSryAz+M/hPrqtw==
X-CSE-MsgGUID: UGCUclwlQEmp4iDpOfUgsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89971700"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="89971700"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 03:59:04 -0700
X-CSE-ConnectionGUID: Gr2dwG08RzGCHO/mzXEbaQ==
X-CSE-MsgGUID: 4yF5W7R6Tji0imIak33HrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="239162077"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 01 May 2026 03:59:02 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Mukul Katiyar <mukul@versa-networks.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/2] net/ice: properly handle TM hierarchy deletion
Date: Fri,  1 May 2026 10:57:54 +0000
Message-ID: <20260501105755.1136087-1-ciara.loftus@intel.com>
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
 .mailmap                       |  1 +
 drivers/net/intel/ice/ice_tm.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7e23e2f528..e65a0c6b20 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1129,6 +1129,7 @@ Moti Haimovsky <motih@mellanox.com>
 Muhammad Ahmad <muhammad.ahmad@emumba.com>
 Muhammad Bilal <m.bilal@emumba.com>
 Mukesh Dua <mukesh.dua81@gmail.com>
+Mukul Katiyar <mukul@versa-networks.com>
 Murphy Yang <murphyx.yang@intel.com>
 Murthy NSSR <nidadavolu.murthy@caviumnetworks.com>
 Muthurajan Jayakumar <muthurajan.jayakumar@intel.com>
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index ff53f2acfd..4dcfb15c27 100644
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
@@ -820,8 +833,11 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
 
 	if (sw_root == NULL) {
-		PMD_DRV_LOG(ERR, "No root node defined in TM hierarchy");
-		return -1;
+		/* TM hierarchy deleted. Restore default scheduler state. */
+		reset_hw_node_recursive(hw, hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0]);
+		pf->main_vsi->nb_qps = pf->lan_nb_qps;
+		pf->tm_conf.committed = false;
+		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
 	}
 
 	/* handle case where VSI node needs to move DOWN the hierarchy */
-- 
2.43.0

