Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA213C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87F7042FDF;
	Thu, 24 Sep 2026 15:14:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9376242FB5;
 Thu, 24 Sep 2026 15:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255680; x=1821791680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2yng3tuzdHjWNUHJeLoxLkqJAY6X2eK6YDD/aFoJ2cg=;
 b=NBVjutSlzoOf5og4cjYwO7z3jtP/S/eEPhvAn0a6ztBzQ9MF7nYEml2s
 7TR/zPBqeJK07MTiAncvuY/rum/OMynj9L394PySuUEDnYj6/ZpsQ6UJI
 foe5uERseCvoHej06MlvqDJ5UqYpjTiJdxmXvFHJdff+lr8nwOS1dioL3
 f9IFAn4N6SpAIqpYQj9geLrudAIUwWUPtrNCtNVt4aBD8I5WtzoH5apeB
 nNqwMGMCjYLhMow/RH/D0JFqOZq9yymo79dDsrRdoqmgdVAlY7d9CKQYQ
 hBfcgs9vnO99RVsvNosdzHsKs8ctdOEnw1x96w7/pMPe45qqRKmwY/9UE Q==;
X-CSE-ConnectionGUID: zuNpv6C0TxKyRRi6vp9EOw==
X-CSE-MsgGUID: 5xdyZMJgQG6WUFHPl0aPeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915428"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915428"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:40 -0700
X-CSE-ConnectionGUID: kQzO9GMbTX6j31qre4wSaw==
X-CSE-MsgGUID: nBO+7teNRmWolMLShdlxzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518537"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 5/6] net/iavf: derive Rx/Tx offload capabilities from path
 masks
Date: Thu, 24 Sep 2026 13:13:45 +0000
Message-ID: <20260924131346.100156-6-ciara.loftus@intel.com>
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

rx_offload_capa was missing RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM even though
the scalar Rx path supports it. Rather than adding the missing flag to the
Rx offload capabilities directly, derive rx_offload_capa from a mask of all
of the Rx path offload masks.

Similarly, tx_offload_capa was missing RTE_ETH_TX_OFFLOAD_UDP_TSO despite
the Tx path already supporting and advertising this offload. Derive the
tx offload capabilities mask from a mask of all of the Tx path offload
masks.

A benefit of this is that if an offload is ever added to a path, it is
automatically reflected in the advertised capabilities too, instead of
relying on the capabilities masks in dev_info being kept manually in sync.
Some overlap will be present when masking the masks but it is kept because
relying on one path's offload mask always being a superset of another's is
fragile.

Fixes: 3b8c645afa06 ("net/iavf: fix outer checksum flags")
Fixes: 1e728b01120c ("net/iavf: rework Tx path")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 34 +++++++++-------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8daa507bbb..b8ca1a19e3e 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1202,31 +1202,19 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 			RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->rx_offload_capa =
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
-		RTE_ETH_RX_OFFLOAD_SCATTER |
-		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
-		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-		RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		(IAVF_RX_SCALAR_OFFLOADS | IAVF_RX_SCALAR_FLEX_OFFLOADS |
+		 IAVF_RX_VECTOR_OFFLOADS | IAVF_RX_VECTOR_OFFLOAD_OFFLOADS |
+		 IAVF_RX_VECTOR_FLEX_OFFLOADS | IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS) &
+		~(RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+		  RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		  RTE_ETH_RX_OFFLOAD_SECURITY);
 
 	dev_info->tx_offload_capa =
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
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
-		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+		(IAVF_TX_SCALAR_OFFLOADS | CI_TX_VECTOR_OFFLOADS |
+		 CI_TX_VEC_OFFLOAD_PATH_OFFLOADS | CI_TX_VEC_CTX_OFFLOAD_PATH_OFFLOADS) &
+		~(RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
+		  RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
+		  RTE_ETH_TX_OFFLOAD_SECURITY);
 
 	/* X710 does not support outer udp checksum */
 	if (adapter->hw.mac.type != IAVF_MAC_XL710)
-- 
2.43.0

