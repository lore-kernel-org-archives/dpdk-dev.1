Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D362EF0702
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15A9040DCD;
	Tue, 10 Feb 2026 17:14:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EBA0340DDE
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740063; x=1802276063;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LU4dkJZKRL0M1pD2s8qFqO3k57oEQ70o/ioFC9to+pE=;
 b=BS5RvBKbetTL1/hRrTE255KCXSMienPtA3VZHjunEeKqssaEb0CjhU/g
 qTFVBPo0WCAEkKFJpRCb9lpiM0K7LvVyG2ND6UfQeMEN9JaIr+MNlruOv
 tTd4t2pXCR/ArQkD913xSRm8uVozOv4jpi2aHHy3+X+64t+0wwPcEOHCi
 +sF9V8S/PGDP/Zi6KS+bp4zSvYN0PDNuOXERg08aRxIDQZW+R5aQgFzzo
 BMSPlPm734CptFCDWu1XFeE4fe/5lYLpaMAcJXodmGl5WCAlz29iB2M4V
 FRlI2A1/h9lZioidnW2RwRSns74UYSqqfQg3CbYc5dYLwfMpDxQ/bynYH Q==;
X-CSE-ConnectionGUID: v3vCP3ZaQ1iS+kEPId4i1g==
X-CSE-MsgGUID: u/IVW/X4QmGyJnq9iybQHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286225"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286225"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:21 -0800
X-CSE-ConnectionGUID: c6PQbwBIQm6GH+UTovkfXw==
X-CSE-MsgGUID: 5hI63GToT9Kqa7A9cp0thg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127782"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 15/26] net/i40e: avoid rte malloc in DDP ptype handling
Date: Tue, 10 Feb 2026 16:13:44 +0000
Message-ID: <6ebb58eda7061cdbb08fe671c920411c361957b2.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
References: 
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

Currently, when updating customized protocol and packet type information
via DDP packages, we are using rte_zmalloc followed by immediate rte_free.
This is not needed as these buffers are only used temporarily within
the function scope, so replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 2e0c2e2482..f27fbf89ee 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11787,7 +11787,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = pctype_num * sizeof(struct rte_pmd_i40e_proto_info);
-	pctype = rte_zmalloc("new_pctype", buff_size, 0);
+	pctype = calloc(pctype_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!pctype) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return -1;
@@ -11798,7 +11798,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PCTYPE_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get pctype list");
-		rte_free(pctype);
+		free(pctype);
 		return -1;
 	}
 
@@ -11879,7 +11879,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 		}
 	}
 
-	rte_free(pctype);
+	free(pctype);
 	return 0;
 }
 
@@ -11925,7 +11925,7 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = ptype_num * sizeof(struct rte_pmd_i40e_ptype_info);
-	ptype = rte_zmalloc("new_ptype", buff_size, 0);
+	ptype = calloc(ptype_num, sizeof(struct rte_pmd_i40e_ptype_info));
 	if (!ptype) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return -1;
@@ -11937,15 +11937,14 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PTYPE_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get ptype list");
-		rte_free(ptype);
+		free(ptype);
 		return ret;
 	}
 
-	buff_size = ptype_num * sizeof(struct rte_pmd_i40e_ptype_mapping);
-	ptype_mapping = rte_zmalloc("ptype_mapping", buff_size, 0);
+	ptype_mapping = calloc(ptype_num, sizeof(struct rte_pmd_i40e_ptype_mapping));
 	if (!ptype_mapping) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
-		rte_free(ptype);
+		free(ptype);
 		return -1;
 	}
 
@@ -12083,8 +12082,8 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to update ptype mapping table.");
 
-	rte_free(ptype_mapping);
-	rte_free(ptype);
+	free(ptype_mapping);
+	free(ptype);
 	return ret;
 }
 
@@ -12119,7 +12118,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = proto_num * sizeof(struct rte_pmd_i40e_proto_info);
-	proto = rte_zmalloc("new_proto", buff_size, 0);
+	proto = calloc(proto_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!proto) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return;
@@ -12131,7 +12130,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PROTOCOL_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get protocol list");
-		rte_free(proto);
+		free(proto);
 		return;
 	}
 
@@ -12169,7 +12168,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(INFO, "No ptype is updated.");
 
-	rte_free(proto);
+	free(proto);
 }
 
 /* Create a QinQ cloud filter
-- 
2.47.3

