Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC33C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 10:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DADF42EEC;
	Fri,  4 Sep 2026 12:52:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0D05F42EDC;
 Fri,  4 Sep 2026 12:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788519148; x=1820055148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zxWQZD8MFs8S5Mp4DHIGHRBi25oYRTkCo1NDy1v0E0I=;
 b=luBSlj8eaDm6kiwE2ytY1gxSiitGGRMbLr85bemSZmuBZK30ec/mWMNf
 UVZbVFpIrG/xTVVK4ycwrlOb0C2flR/qVniYSRVQo8HAxC6pobIJE+O1p
 quXDHgNCxEVV1vlnjVuAX5R0HWVXtPTwaVa6x9+aGNc8HfoT0lssQ5n9V
 Umoeo5bINpu12Khzia+XNC1Uy77DfBCXIuv6tnILwD70KYMXmjSr32sqE
 IHfZkfU7KJ3lDox6fzJbGTBW8prMi8Viyzm5uznjFwX6ORZbhHaWX8U0b
 WvYQKej3F/Ho8/Qn+XLKTGbvMQItAQRfiFG8cTZgf38UneuavEV6qkptR A==;
X-CSE-ConnectionGUID: nJTTCEPkTLSjbFSS9jsBuw==
X-CSE-MsgGUID: kbhguRnvRPiBKZACZA5wDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76573769"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="76573769"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 03:52:28 -0700
X-CSE-ConnectionGUID: zAlxjVXITKqPdf6WhTVPDA==
X-CSE-MsgGUID: 9buzmF/iRJa9cZrAlSNrfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="308223635"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Sep 2026 03:52:26 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/3] net/ice: fix Tx queue capacity sizing after TM commit
Date: Fri,  4 Sep 2026 10:51:37 +0000
Message-ID: <20260904105139.3117640-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904105139.3117640-1-ciara.loftus@intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
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

commit_new_hierarchy() computes the number of usable Tx queues (nb_qps)
by indexing the arrays nodes_created_per_level[] and hw->layer_info[] with
a value derived from ice_get_leaf_level(). nodes_created_per_level[] is
indexed by absolute hw scheduler layer, but ice_get_leaf_level() returns a
value relative to the TM hierarchy's root position, so the index used was
off by the number of hidden layers.

This under-counted the qgroup layer, causing nb_qps to be computed from a
shallower layer than the one actually holding the committed qgroup nodes.
In turn this caused rte_eth_dev_configure to reject any nb_tx_queues above
the miscalculated capacity.

Fix by converting the index to an absolute layer index.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 2e6ef9c264f..651d6aa932d 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -848,7 +848,7 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 	const uint16_t new_root_level = pf->tm_conf.hidden_layers;
 	/* count nodes per hw level, not per logical */
 	uint16_t nodes_created_per_level[ICE_TM_MAX_LAYERS] = {0};
-	uint8_t q_lvl = ice_get_leaf_level(pf);
+	uint8_t q_lvl = ice_get_leaf_level(pf) + pf->tm_conf.hidden_layers;
 	uint8_t qg_lvl = q_lvl - 1;
 	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
 
-- 
2.43.0

