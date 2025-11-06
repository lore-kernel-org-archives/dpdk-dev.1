Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198EBCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1627A40B8F;
	Wed,  5 Nov 2025 19:06:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DABEA406FF;
 Wed,  5 Nov 2025 19:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762365967; x=1793901967;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iFBpMwLWgKfaiAAsKRELcsNNX6tc2m1PUExK+TyMvc8=;
 b=JCSzGAQc3Is3crKmxpxSSPbEjFj7qv7c87xn2Wf5pcKxmAcQlwXwqqRX
 VWv6DZ6kN9xFbubzB1gZvKoFCedGXYEXjnIgZ/R/ZevKDntgN3bnrvRSs
 ZBbUBRSSq6hOmrAHajbRnlZyLt3ADtiEHsbP4edd9Hg0JyZwICoGXIX6w
 SfrJb2tSQg7ymh2d0IA7tXSy3v3zvQkk/Q76na0Jxs8ifP2PB6LbXMtZV
 9z8+qBcpsYwf3OcQ6DmS4L+VADBv53t0/xLC4fxZDMsHRmG4ISxX0HNcj
 n1zuhHWvZSOAt/7ES9MLJGpVehaFg+CxJje1wWm9gQEuvjRW86fDtpm8m A==;
X-CSE-ConnectionGUID: rW3T51MBTe2XxhfbLx7FJg==
X-CSE-MsgGUID: w1zyITJ3QY+1rEzxxDBucA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75842004"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="75842004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:06:07 -0800
X-CSE-ConnectionGUID: kGc2qSn9Q/ixjrixtI08qA==
X-CSE-MsgGUID: 2QlQME2fTU6hKoLp9TMA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="187368623"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 10:06:04 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v3 1/4] net/ice: restrict ice PMD to scalar path for TxPP
Date: Thu,  6 Nov 2025 01:46:34 -0500
Message-ID: <20251106064638.23020-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106064638.23020-1-soumyadeep.hore@intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
 <20251106064638.23020-1-soumyadeep.hore@intel.com>
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

ICE PMD supports TxPP feature only in scalar path. Hence restricted
testpmd to scalar path when the feature is enabled.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index a7cc4736cf..a24694c0b1 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -59,7 +59,8 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |    \
 		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |    \
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
 
 #define ICE_TX_VECTOR_OFFLOAD (				\
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
-- 
2.47.1

