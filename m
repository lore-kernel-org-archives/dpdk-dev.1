Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341CC98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B7C742FE7;
	Thu, 24 Sep 2026 15:14:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 81AEB42FC7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255681; x=1821791681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6FUP/INhAw8f97KGntyGLTOvaDJmpw+0KoobLZ9v4pg=;
 b=Ks81KZazybH7vK+hs0OHoNAOLMNFFe7FnaxMhjIoJDxskvXRu6gJr0aY
 CBWQHAJFUtQZL7QA2GQBXs6CgQv2BpHy086oX3kD7XTSYP8mAPhuhqj08
 7K86IyvIDffqL7VSDM662E/t6SVQQpyHBwlSbR292aVoqFd/W5jfhqHVJ
 1Pt2t1DVFkgktp8XRsmu+14UdKrL7x7sBV3uSEar1MOs9s8LsMme4EvSY
 Z0wQhxvuZTF//4eS6zlGWWTduL0P/Zrzmb9gxRIgnuwUAgk3bCCVr2s7V
 P+fsL37tSpb5NnEjFaQHA8oE3bZZq5LSzGZv1uEcO8wvJ0E/ppE//BVg2 A==;
X-CSE-ConnectionGUID: LUrhCR2aSxeg5EW+lZHhYw==
X-CSE-MsgGUID: OHwS9vNCR0upbH06E2HVvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915429"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:41 -0700
X-CSE-ConnectionGUID: GGNo0H65QaysHgX13a27xg==
X-CSE-MsgGUID: NBkaDt0CSL2OInWVzBOeXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518540"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:39 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 6/6] net/i40e: derive Rx/Tx offload capabilities from path
 masks
Date: Thu, 24 Sep 2026 13:13:46 +0000
Message-ID: <20260924131346.100156-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131346.100156-1-ciara.loftus@intel.com>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
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

The Rx and Tx offload capability masks duplicated the offload lists already
maintained for tracking the offloads enabled on the various scalar and
vector Rx and Tx paths. Instead of defining explicit lists for the offload
capabilities masks, instead derive the capabilities from the path masks.

A benefit of this is that if an offload is ever added to a path, it is
automatically reflected in the advertised capabilities too, instead of
relying on the capabilities masks in dev_info being kept manually in sync.
Some overlap will be present when masking the masks but it is kept because
relying on one path's offload mask always being a superset of another's is
fragile.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 29 +++-------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index defdff0378f..5d6102cae7b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3865,35 +3865,12 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_mtu = dev_info->max_rx_pktlen - I40E_ETH_OVERHEAD;
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 	dev_info->rx_queue_offload_capa = 0;
-	dev_info->rx_offload_capa =
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
-		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
-		RTE_ETH_RX_OFFLOAD_SCATTER |
-		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
-		RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	dev_info->rx_offload_capa = I40E_RX_SCALAR_OFFLOADS | I40E_RX_VECTOR_OFFLOADS;
 
 	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 	dev_info->tx_offload_capa =
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |
-		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
-		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
-		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
-		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
-		dev_info->tx_queue_offload_capa;
+		(I40E_TX_SCALAR_OFFLOADS | I40E_TX_VECTOR_OFFLOADS) &
+		~RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM;
 	if (hw->mac.type == I40E_MAC_X722) {
 		dev_info->tx_offload_capa |=
 			RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM;
-- 
2.43.0

