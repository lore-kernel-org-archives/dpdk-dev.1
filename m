Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08ECA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 10:45:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B532C410EA;
	Thu,  4 Sep 2025 12:44:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 194974027D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 12:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756982690; x=1788518690;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PkKpCHPgdxKXSCk2rBuGVLYQkDCgfZhNeo6if0zYSf4=;
 b=fQ7CO6YFhEf+7c1jvA8njMSKOeX+AwoeoFTtBy8vP6V8zWaVdClMqjWn
 uyD2kxrVnEtDrOVcCtZmVwJFIC2Uuf1LAjp4vdbLWa37jAWly5Oawy7yf
 9y/4xYn7JEErBAyh6Mxwc6mrnA8JitHbJdLk6Ug9CwwEV4uh9EqyAkPhA
 LW8ali1mjjUfp3jlFvL3AfT6iCH84GKOTLgjlpCWlqoLbgXxekD5RiUFy
 8BgT+T55zzXcOXB1TyFNFDB9LeS37J5g9zC+ACHraE3kTAqzX0uzOPuTP
 RJ9prm+UM5XDftW7Ii1gR3pqDePr0/8flUOvwxjiHVgzpE/+PMZjYQz68 w==;
X-CSE-ConnectionGUID: To7dNa2yQqGnZgslwjXaaw==
X-CSE-MsgGUID: hnp1uayvRXWdqEkq2AU1NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59463071"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59463071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 03:44:49 -0700
X-CSE-ConnectionGUID: y41anw0WSqCSUu5abrtGPA==
X-CSE-MsgGUID: FTcuFWLDSnSuNN61vdYRjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="195512090"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa002.fm.intel.com with ESMTP; 04 Sep 2025 03:44:48 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/3] net/iavf: fix Tx path selection for VLAN offload
Date: Thu,  4 Sep 2025 10:44:40 +0000
Message-Id: <20250904104440.2167205-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904104440.2167205-1-ciara.loftus@intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
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

For the vlan insert offload a different tx vector offload path is
required depending on where the tag must be placed in the descriptor
which can vary from one VF to another. Some VFs use the L2TAG2 field
which requires the use of a context descriptor. Adjust the logic for
selecting the tx path so that the correct path is used for each vlan tag
location. Before this fix, if the tag was to be put in the L2TAG1 field,
the scalar path was always used which was incorrect, because the AVX-512
vector path also supports this offload.

Fixes: abca31f780e1 ("net/iavf: support VLAN insertion for the AVX-512 path")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.h            |  1 -
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 23 +++++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 723c30d05b..a499141049 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -53,7 +53,6 @@
 #define IAVF_TX_VECTOR_OFFLOAD_CTX (			\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
 		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
 #define IAVF_RX_NO_OFFLOADS 0
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index a3688baf4b..f513777663 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -73,6 +73,8 @@ iavf_rx_vec_queue_default(struct ci_rx_queue *rxq)
 static inline int
 iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
+	bool vlan_offload = false, vlan_needs_ctx = false;
+
 	if (!txq)
 		return -1;
 
@@ -88,20 +90,21 @@ iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 		return IAVF_VECTOR_CTX_PATH;
 	}
 
+	/* Vlan tci needs to be inserted via ctx desc, if the vlan_flag is L2TAG2. */
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) {
+		vlan_offload = true;
+		if (txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
+			vlan_needs_ctx = true;
+	}
+
 	/**
-	 * Vlan tci needs to be inserted via ctx desc, if the vlan_flag is L2TAG2.
 	 * Tunneling parameters and other fields need be configured in ctx desc
 	 * if the outer checksum offload is enabled.
 	 */
-	if (txq->offloads & (IAVF_TX_VECTOR_OFFLOAD | IAVF_TX_VECTOR_OFFLOAD_CTX)) {
-		if (txq->offloads & IAVF_TX_VECTOR_OFFLOAD_CTX) {
-			if (txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ||
-					txq->offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) {
-				txq->use_ctx = 1;
-				return IAVF_VECTOR_CTX_OFFLOAD_PATH;
-			} else {
-				return -1;
-			}
+	if (txq->offloads & (IAVF_TX_VECTOR_OFFLOAD | IAVF_TX_VECTOR_OFFLOAD_CTX) || vlan_offload) {
+		if (txq->offloads & IAVF_TX_VECTOR_OFFLOAD_CTX || vlan_needs_ctx) {
+			txq->use_ctx = 1;
+			return IAVF_VECTOR_CTX_OFFLOAD_PATH;
 		} else {
 			return IAVF_VECTOR_OFFLOAD_PATH;
 		}
-- 
2.34.1

