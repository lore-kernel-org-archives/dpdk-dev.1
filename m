Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EDC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8DD14029E;
	Wed, 12 Mar 2025 16:51:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 596CC40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741794660; x=1773330660;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UIjtYy1FRt8xUgSMKE/8rXvQsvbQ50ZnhV92COE/z4o=;
 b=cCysvQJ0i2MBnrglI3D5w4Pc82Gle88D03vGqfsELnO4VRJnNQEvgwRo
 6zoMFM9hPbcG5jotYVqY6L83x7LMzudOUu6UjKYSVvDRLzK23YDc1qOXC
 zH3gp4jqt5OG2Js8GtYEvrx3ujTTucDYiD/fp/R7MZ1hMai41fXPw8Y2t
 Cq6IEtNYEzpBPoJrTk0oQciOQV5+Q3bb9znlt64WHsMTEcAaHxVYBKPEF
 l/x0CuY3lfjRBJ6KNMzDPo/nXXcQbcT9Ff3XnpQhkjkmobjUMgzNgv0fy
 /dgDeyFAw9qbNUsh0tXS78VXnOGErWqcnhE/SbQhOAeHI2hF8SzdyKG0e g==;
X-CSE-ConnectionGUID: 9jabf3TLQe+cNzQrWnzojQ==
X-CSE-MsgGUID: SwwaqAY6Ss+OUPUUcwNfqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42758175"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="42758175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:50:59 -0700
X-CSE-ConnectionGUID: 6fbRRoAWQ8mosQ9Q/qFmyA==
X-CSE-MsgGUID: /GSEgpS0Qc2TiDq/9f10nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="120905611"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2025 08:50:56 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/cpfl: enable AVX2 for singleq Rx/Tx
Date: Wed, 12 Mar 2025 21:22:42 +0530
Message-Id: <20250312155242.409854-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

The single queue model processes all packets in order while
the split queue model separates packet data and metadata into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/cpfl.rst           |  3 ++-
 drivers/net/intel/cpfl/cpfl_rxtx.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 154201e745..5d267ef667 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -177,7 +177,8 @@ The paths are chosen based on 2 conditions:
 
   On the x86 platform, the driver checks if the CPU supports AVX512.
   If the CPU supports AVX512 and EAL argument ``--force-max-simd-bitwidth``
-  is set to 512, AVX512 paths will be chosen.
+  is set to 512, AVX512 paths will be chosen. Otherwise, if --force-max-simd-bitwidth is set to 256,AVX2 paths will be chosen.
+  (Note that 256 is the default bitwidth if no specific value is provided.)
 
 - ``Offload features``
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 47351ca102..4f1fce20ae 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1426,6 +1426,10 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->rx_vec_allowed = true;
 
+		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
+		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			vport->rx_use_avx2 = true;
+
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
 #ifdef CC_AVX512_SUPPORT
 			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
@@ -1479,6 +1483,13 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (vport->rx_use_avx2) {
+				PMD_DRV_LOG(NOTICE,
+						"Using Single AVX2 Vector Rx (port %d).",
+						dev->data->port_id);
+				dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts_avx2;
+				return;
+			}
 		}
 		if (dev->data->scattered_rx) {
 			PMD_DRV_LOG(NOTICE,
@@ -1528,6 +1539,11 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	if (cpfl_tx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->tx_vec_allowed = true;
+
+		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
+		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			vport->tx_use_avx2 = true;
+
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
 #ifdef CC_AVX512_SUPPORT
 		{
@@ -1587,6 +1603,14 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (vport->tx_use_avx2) {
+				PMD_DRV_LOG(NOTICE,
+						"Using Single AVX2 Vector Tx (port %d).",
+						dev->data->port_id);
+				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
+				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+				return;
+			}
 		}
 		PMD_DRV_LOG(NOTICE,
 			    "Using Single Scalar Tx (port %d).",
-- 
2.34.1

