Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F572C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C5942FCD;
	Thu, 24 Sep 2026 15:14:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 83E1242FA9;
 Thu, 24 Sep 2026 15:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255679; x=1821791679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=52dHgXk+yf2zVtkMFg/M7kRjn76aQsdnj3QfrInI0NE=;
 b=LjYGTokByhJJdTLDu+PGkGxNQfU7asTVWI5/bM+uiWrwKVHGqQSSx52p
 3Flt25ieVsdg3wqWZzlSElUba4Zc/QlL9fJBRlmYZA1MAqiFa7NxFf4rS
 wVXQWvKSKsVBLhQUNa0D6i9ZRTj0jpTu7U0DUdd0ji59aEINMxQXqbOo+
 BaEOjPdeyFo8J06J1i75SWQIYS0NP+j8du6+sfemOJmP0pxPMMsuumrMf
 8rCQ1xC8IuCwhxdtQX2xUlgxOzgwCJ/JSPbgCT7B6R3GPD+r8QS+hvdKZ
 qiW1WCYUCdAqByckJ9nzF1OTqv6K3z918T8I4YAyuM/plf8CgLUylZALp g==;
X-CSE-ConnectionGUID: PCitkR6zTYOxaL5zQpzOaA==
X-CSE-MsgGUID: MnzcLN2eT7yj0rOSIAo31w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915427"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915427"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:38 -0700
X-CSE-ConnectionGUID: pQAg8muNT6i+1mzTsw7UFg==
X-CSE-MsgGUID: qnX+Jpc7SdetjKVCox1GeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518533"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:37 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 4/6] net/ice: derive Rx/Tx offload capabilities from path masks
Date: Thu, 24 Sep 2026 13:13:44 +0000
Message-ID: <20260924131346.100156-5-ciara.loftus@intel.com>
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

tx_offload_capa was missing RTE_ETH_TX_OFFLOAD_UDP_TSO even though the
scalar Tx path supports it. Rather than adding the missing flag to the Tx
offload capabilities directly, derive tx_offload_capa from a mask of all of
the Tx path offload masks.

While we are here, do the same for the Rx offload capabilities mask, which
now derives itself from a mask of all of the Rx path offload masks.

A benefit of this is that if an offload is ever added to a path, it is
automatically reflected in the advertised capabilities too, instead of
relying on the capabilities masks in dev_info being kept manually in sync.
Some overlap will be present when masking the masks but it is kept because
relying on one path's offload mask always being a superset of another's is
fragile.

Fixes: 623ca7a15db4 ("net/ice: enable UDP fragmentation offload")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 33 +++++++-----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 2722f359cb3..b8e703c6956 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4745,32 +4745,13 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->flow_type_rss_offloads = 0;
 
 	if (!is_safe_mode) {
-		dev_info->rx_offload_capa |=
-			RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-			RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
-			RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-			RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
-			RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |
-			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-			RTE_ETH_RX_OFFLOAD_RSS_HASH |
-			RTE_ETH_RX_OFFLOAD_TIMESTAMP |
-			RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT;
-		dev_info->tx_offload_capa |=
-			RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
-			RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
-			RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
-			RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-			RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
-			RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
-			RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
-			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
-		if (hw->phy_model == ICE_PHY_E830)
-			dev_info->tx_offload_capa |=
-				RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
+		dev_info->rx_offload_capa = ICE_RX_SCALAR_OFFLOADS |
+			ICE_RX_VECTOR_OFFLOADS | ICE_RX_VECTOR_OFFLOAD_OFFLOADS;
+		dev_info->tx_offload_capa = ICE_TX_SCALAR_OFFLOADS |
+			CI_TX_VECTOR_OFFLOADS | CI_TX_VEC_OFFLOAD_PATH_OFFLOADS |
+			CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS;
+		if (hw->phy_model != ICE_PHY_E830)
+			dev_info->tx_offload_capa &= ~RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
 		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
 	}
 
-- 
2.43.0

