Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1986C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 13:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE12D42E02;
	Thu, 19 Jun 2025 15:37:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C7D094025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 15:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750340229; x=1781876229;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ru1FThZG2CfUM5+WGjD22yovG6wKj9pBsjCtEyV7ysA=;
 b=n0lfevXCEJKZEfDTM/6fF+tcMotqrlL/aV8ZYLWyETRSiO9cLsa7UQ4B
 8yFbO+bH4x90/ieWds6laLFdhMWxT4hWb3JMc36HmIcSWee5IgmMmT7Iy
 fbRQnUHb3Xn5gZlj4t33BQZjTJCy1Cq0kdIl2zmAO3tdKV15uCznrc+Ng
 vKE78Mx1IjmNbH7ifOhFGwD/4JCQesbktXyE6pF+JYSj33LBiIDNI+QAT
 7nHYqzl59qyu3C2vjV50kSRCPy0ndgHWEkWhzaEnH++yY7bh6HZEtZ90D
 4Jt2hmO4W8LHdpHGzeMa9vjYbDIjAdUxzCeSvMZCv/xEzAw4CSAs/rQLM A==;
X-CSE-ConnectionGUID: UWBj/TrbT5qIQYjyDDRPRg==
X-CSE-MsgGUID: 0i8StFa/RrWn2fCC9HEuxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52684291"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="52684291"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 06:37:07 -0700
X-CSE-ConnectionGUID: 3i2nYU1EQ+yh+jmrzLWohw==
X-CSE-MsgGUID: PZaKQKIIRlieYHuKVUGa9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="187866986"
Received: from silpixa00401177.ir.intel.com (HELO vm177..) ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 19 Jun 2025 06:37:05 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/3] net/iavf: support qinq insertion offload for scalar path
Date: Thu, 19 Jun 2025 13:36:56 +0000
Message-Id: <20250619133658.13494-1-ciara.loftus@intel.com>
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

Enable Tx QINQ offload if the VF reports support for inserting both an
outer and inner VLAN tag. The VF capabilities report the locations for
placing each of the tags - either L2TAG1 in the tx descriptor or L2TAG2
in the context descriptor. Use this information to configure the
descriptors correctly.
This offload was previously incorrectly reported as always supported in
the device configuration, so this is corrected.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini    |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c |  8 +++-
 drivers/net/intel/iavf/iavf_rxtx.c   | 55 +++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index ce9860e963..61c4742197 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -29,6 +29,7 @@ Traffic manager      = Y
 Inline crypto        = Y
 CRC offload          = Y
 VLAN offload         = P
+QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Timestamp offload    = Y
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b3dacbef84..d058b87d54 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -622,7 +622,7 @@ iavf_dev_vlan_insert_set(struct rte_eth_dev *dev)
 		return 0;
 
 	enable = !!(dev->data->dev_conf.txmode.offloads &
-		    RTE_ETH_TX_OFFLOAD_VLAN_INSERT);
+		    (RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_QINQ_INSERT));
 	iavf_config_vlan_insert_v2(adapter, enable);
 
 	return 0;
@@ -1158,7 +1158,6 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
@@ -1182,6 +1181,11 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
+			vf->vlan_v2_caps.offloads.insertion_support.inner &&
+			vf->vlan_v2_caps.offloads.insertion_support.outer)
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
+
 	if (iavf_ipsec_crypto_supported(adapter)) {
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 5411eb6897..1ce9de0699 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -797,17 +797,32 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			&adapter->vf.vlan_v2_caps.offloads.insertion_support;
 		uint32_t insertion_cap;
 
-		if (insertion_support->outer)
-			insertion_cap = insertion_support->outer;
-		else
-			insertion_cap = insertion_support->inner;
-
-		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
-			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
-			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
-		} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
-			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
-			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
+		if (insertion_support->outer == VIRTCHNL_VLAN_UNSUPPORTED ||
+				insertion_support->inner == VIRTCHNL_VLAN_UNSUPPORTED) {
+			/* Only one insertion is supported. */
+			if (insertion_support->outer)
+				insertion_cap = insertion_support->outer;
+			else
+				insertion_cap = insertion_support->inner;
+
+			if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
+				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
+				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
+			} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
+				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
+				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
+			}
+		} else {
+			 /* Both outer and inner insertion supported. */
+			if (insertion_support->inner & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
+				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
+				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG1");
+				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG2");
+			} else {
+				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
+				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG2");
+				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG1");
+			}
 		}
 	} else {
 		txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
@@ -2391,7 +2406,7 @@ iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
 	uint64_t flags = mb->ol_flags;
 	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
 	    RTE_MBUF_F_TX_TUNNEL_MASK | RTE_MBUF_F_TX_OUTER_IP_CKSUM |
-	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+	    RTE_MBUF_F_TX_OUTER_UDP_CKSUM | RTE_MBUF_F_TX_QINQ))
 		return 1;
 	if (flags & RTE_MBUF_F_TX_VLAN &&
 	    vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
@@ -2413,8 +2428,9 @@ iavf_fill_ctx_desc_cmd_field(volatile uint64_t *field, struct rte_mbuf *m,
 	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
 		cmd = IAVF_TX_CTX_DESC_TSO << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
-	if (m->ol_flags & RTE_MBUF_F_TX_VLAN &&
-			vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+	if ((m->ol_flags & RTE_MBUF_F_TX_VLAN &&
+			vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) ||
+			m->ol_flags & RTE_MBUF_F_TX_QINQ) {
 		cmd |= IAVF_TX_CTX_DESC_IL2TAG2
 			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	}
@@ -2589,6 +2605,10 @@ iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
 
 	if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
 		desc->l2tag2 = m->vlan_tci;
+
+	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
+		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci :
+										m->vlan_tci_outer;
 }
 
 
@@ -2643,6 +2663,13 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 		l2tag1 |= m->vlan_tci;
 	}
 
+	/* Descriptor based QinQ insertion */
+	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
+		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
+		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci :
+									m->vlan_tci_outer;
+	}
+
 	if ((m->ol_flags &
 	    (IAVF_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
 		goto skip_cksum;
-- 
2.34.1

