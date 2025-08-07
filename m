Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD8C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 11:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E140D402E8;
	Thu,  7 Aug 2025 13:08:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 86FC0402DB;
 Thu,  7 Aug 2025 13:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754564929; x=1786100929;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yn9UdFUgjzKG4ogn1wazVRymNaPWZmSH6v6X46Zweas=;
 b=PO0MCYtx5HuhJQgCQnLe8EC+oDEf9OjF7fFI09pWlN0wqAXeZsQ+SIwm
 3hzmH+n+JgdjMgsc38ylhvfq1HhDD7DX29kCJAH4FD6Jzxvd24VYSgk3e
 rLjroPKg1Uijf01+8Xsx4IITPEFl4GGRz3URVLYvgRhTvxXzJQ+UrTpTe
 DXJUtkedHclw+S1nTyhw50kjyoZ0RevE84QCWFjEeexgjqSCmsX9Mzn1W
 fIoEgX7NsFtyeQnkFrX4+hLZMQXuobjTlcnSIRwkMHMU8Nkhciiza74Pt
 +kDR7CmZLGiqYTjQRijNmQLGuewFRDApCZ53Cm+EZ30mQYNGdenRaybG+ A==;
X-CSE-ConnectionGUID: gdFLKGixS7SMrWImkr4YNA==
X-CSE-MsgGUID: rkHm4PcqSEKPGQIUgyk0SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56605684"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56605684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 04:08:46 -0700
X-CSE-ConnectionGUID: /J3lHWawTIyvT8dDy8NftQ==
X-CSE-MsgGUID: CrqWA2HIQ/u5OLiWAB2r/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="170404260"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa005.jf.intel.com with ESMTP; 07 Aug 2025 04:08:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix Rx vector offload flags
Date: Thu,  7 Aug 2025 12:08:43 +0100
Message-ID: <20250807110843.54385-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The vector PMD datapaths for ice do not support QinQ, so we need to
update the vector offload flags to not use the general RX_OFFLOAD_VLAN
flag (which sets all vlan-related options) and replace it with the
individually supported VLAN options.

Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 9430a99ba5..e41fd8fc7c 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -72,7 +72,8 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 #define ICE_RX_VECTOR_OFFLOAD (				\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_RX_OFFLOAD_VLAN |			\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
 #define ICE_VECTOR_PATH		0
-- 
2.48.1

