Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABBCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 04:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D6440430;
	Thu, 30 Oct 2025 05:53:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id F07874027A;
 Thu, 30 Oct 2025 05:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761799984; x=1793335984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iFBpMwLWgKfaiAAsKRELcsNNX6tc2m1PUExK+TyMvc8=;
 b=j/DF2xW253HJ3o7aRGljo5RjnM1flWQ810ZttPV6zQtJFVNz6NifjAz2
 20yrfwf52J/k+4myz1RXWTdPxGvt73Yea2pdK0e0qg/Vx+X4qhRlskihq
 itBZYgNf159qNAnHDAVfDmuEPe4JbuPKRdFI66Jh7jiaBFCh0fRDiigh4
 Y84JBmRs6dLcf1W0Rra5z3XlelQrmztJt/6uu0kQoQnLlyI9C3MF4Kk99
 a+enwEd6mw3gXlTi8W78NZq/gEmveDB5bDX8ib31OXQRduOwOtEMwJ9jr
 ZCJBQimwd6DgOCdPsUbMm37+xSHb0FnhqBIKOe+Ic5CtpZbH97EeZQuxW A==;
X-CSE-ConnectionGUID: vUSXb98BTOu0Ni+LJm3how==
X-CSE-MsgGUID: 8kolRMOTQ9yj5VKrF2qZyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74225247"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="74225247"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 21:53:04 -0700
X-CSE-ConnectionGUID: JjZoE5tzQ5WDr6vRpbPUEg==
X-CSE-MsgGUID: QFvVcZXvTTaQQv43T0gaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; d="scan'208";a="185733133"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 21:53:01 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, ciara.loftus@intel.com, stable@dpdk.org
Subject: [PATCH v2 1/3] net/ice: restrict ice PMD to scalar path for TxPP
Date: Thu, 30 Oct 2025 13:33:02 -0400
Message-ID: <20251030173304.260209-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251030173304.260209-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251030173304.260209-1-soumyadeep.hore@intel.com>
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

