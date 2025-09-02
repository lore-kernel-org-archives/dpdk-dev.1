Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B0CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B27E40651;
	Tue,  2 Sep 2025 12:49:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7ABC8402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756810165; x=1788346165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Utx37wjtHxAx06vxB7wWZLWGQ1m/TZmfd9xn5l9TfNM=;
 b=dDislscQJPSjBxowSR3L7o3lLAWJVj54e6GxohnOCszGxszn5G8RBwSM
 tq/OZmMATrCQ0TyXhVvUN5AuQBw7qYpWhlSdtaBLh1x23wKp300Z8x9x3
 kk/gTVVzg+RM5T/gZJJfWw8/w2axe3XSqh3lKsZge41DfZEz9/Q4/nC/m
 cOClxGP5YS+/rlOZWxAB0o6D+Bpqq9fEqsSTmOXPAJestddnrVqCtyto9
 T9I/xDeEkqVJ2SyqPHoS4fDi8TZwSgJCpZzCE7RiS/bUtmrBS29qmKpls
 jU//mf0xf9zn1OyX5GxDb/QkvsCX1VX26tijbD1z93n29jK1IqCSJXvJS g==;
X-CSE-ConnectionGUID: 4QcaWi6YRZWl/ufRawdDSA==
X-CSE-MsgGUID: X4uDJedwSS6HDkooSO+C8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59014548"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59014548"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:49:24 -0700
X-CSE-ConnectionGUID: vH8NCPfwSXynFG6/EDQl0w==
X-CSE-MsgGUID: 1G2nJvWMTm2iUd8MNvaS+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="175609386"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 03:49:24 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/4] net/i40e: fix supported offloads for Rx vector path
Date: Tue,  2 Sep 2025 10:48:56 +0000
Message-Id: <20250902104859.2100141-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902104859.2100141-1-ciara.loftus@intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
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

The set of supported Rx offloads in the vector path had been defined as
those supported by the scalar path. This was incorrect so define a new
list of supported offloads for the vector path. The list is the same
as the scalar path except it excludes vlan extend and qinq strip.

Also, remove a redundant check for the VLAN Extend offload in the
driver code. This check is now performed in the common rx path
selection code.

Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.h            | 11 ++++++++++-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |  6 ------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 5d5d4e08b0..1f210dfdff 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -80,7 +80,16 @@ enum i40e_header_split_mode {
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-#define I40E_RX_VECTOR_OFFLOADS I40E_RX_SCALAR_OFFLOADS
+#define I40E_RX_VECTOR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+		RTE_ETH_RX_OFFLOAD_SCATTER |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
 /** Offload features */
 union i40e_tx_offload {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index e118df9ce0..39c9d2ee10 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -54,12 +54,6 @@ static inline int
 i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 {
 #ifndef RTE_LIBRTE_IEEE1588
-	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
-
-	/* no QinQ support */
-	if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND)
-		return -1;
-
 	/**
 	 * Vector mode is allowed only when number of Rx queue
 	 * descriptor is power of 2.
-- 
2.34.1

