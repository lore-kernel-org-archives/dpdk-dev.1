Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E10DFCB60B
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 15:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 489AE40A80;
	Fri,  6 Mar 2026 16:10:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id CDD6540262;
 Fri,  6 Mar 2026 16:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772809846; x=1804345846;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=q9eJQwFwp2HOcYmfOI+DVxaf+trHM7WL8FEWuqiqPZc=;
 b=HVCCjo0Yiiqa/1gne6lvkTXF+Vqr/nXkYEzIngzKcTI0avDLjiAg6x0d
 895FB5of6aBSokL4jYDSuai+k3L/is7iPMN8stpp6XxAS436M/Xs+yxQy
 Zde6KgzwK7vJh7V4ITb7RkuhYqE9AgCw6N4zdGdjjRMIAU3ifZOdDSVws
 HWBRrkSFiBzDqHucu4N8xxxiJOK2BjCTrSYRSmURgC9dXRqs/AnYSKHUn
 VGGB7sHCmuxd3C7q4dfQ3rvXZ1VwjW0Dhznw5zn7xG/F4PQa83MAKp4mP
 krhFUuqUMIl371wEiE1ni5uGYwytuCh8pRnTWqCuPzMdEZ9qLosN2qWS6 A==;
X-CSE-ConnectionGUID: piONg+SnRVSPKUWKjLdVgg==
X-CSE-MsgGUID: sfcxyqCATum4f5N/gaTyjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73887325"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; d="scan'208";a="73887325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 07:10:44 -0800
X-CSE-ConnectionGUID: coKDNHUrT0+5rYmwh/39KQ==
X-CSE-MsgGUID: LC7dz6CMSza31pkBt0keUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; d="scan'208";a="224011079"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 06 Mar 2026 07:10:43 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix order of tags for AVX512 Tx QinQ offload
Date: Fri,  6 Mar 2026 15:10:32 +0000
Message-ID: <20260306151032.2640579-1-ciara.loftus@intel.com>
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

The tags were not inserted the correct order in the bulk context
descriptor function on the AVX512 path. Fix it so that it is consistent
with the single packet function and the scalar path implementation.

Fixes: 23ef9b485dec ("net/iavf: fix conditions for AVX-512 VLAN offload")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 9a93a0b062..4e8bf94fa0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2125,8 +2125,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		if (offload) {
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-					(uint64_t)pkt[1]->vlan_tci :
-					(uint64_t)pkt[1]->vlan_tci_outer;
+					(uint64_t)pkt[1]->vlan_tci_outer :
+					(uint64_t)pkt[1]->vlan_tci;
 				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
@@ -2145,8 +2145,8 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		if (offload) {
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-					(uint64_t)pkt[0]->vlan_tci :
-					(uint64_t)pkt[0]->vlan_tci_outer;
+					(uint64_t)pkt[0]->vlan_tci_outer :
+					(uint64_t)pkt[0]->vlan_tci;
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-- 
2.43.0

