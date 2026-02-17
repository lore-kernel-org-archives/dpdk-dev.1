Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E0E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6840540B91;
	Tue, 17 Feb 2026 13:15:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 133F440696
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330496; x=1802866496;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AhQEkL7RXhsqsiUcB0HGzW7G058OY3YZK9rxYOWNBAY=;
 b=YKC9iMlFMJUvM96E1YarTlhPIOqYcQt0HxJ18oUzwJIGfyUlBYOpG6aO
 gWIFtXJCtOo1s+Dd3qPOyBqi5/GDHha4qTzFBxjFkMEJv1uYRvJDytHey
 pKr4/TKL6LDZNXO+i4gNirs/kwXfjijKgPORaqAgwp0Wo+eZm7JjK9r5r
 RzcoD3CS6Jnfk0wIH7zZ07W7Yw/NtRaWD/RzSwnqEN9XAQV2MxzgfhSw6
 qJ+CU2z7IcFErptQIvAPjiAod3srIyLpqNnXldKIBqx7ZlMBStoi2FX67
 4YIG+3Gt3GB5fAl8n0d5yvHEGMIE6Fvz14tdz8IwyyXGDwUNOpwepxPRE g==;
X-CSE-ConnectionGUID: sYLi5BV9SAqqQX7sxB9v4Q==
X-CSE-MsgGUID: sC8iR4LoSi6BMuppACW7bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996041"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:56 -0800
X-CSE-ConnectionGUID: BkNa8uDbTk2Pf9ZgJjUVzQ==
X-CSE-MsgGUID: EPNY71sMTb2FEU06hoV/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396815"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Date: Tue, 17 Feb 2026 12:14:04 +0000
Message-ID: <e8baf2b85fe92c4fb3f0fa8dfd7a652ca85c3974.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
index ac465c90a4..8a56f05eeb 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11788,7 +11788,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = pctype_num * sizeof(struct rte_pmd_i40e_proto_info);
-	pctype = rte_zmalloc("new_pctype", buff_size, 0);
+	pctype = calloc(pctype_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!pctype) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return -1;
@@ -11799,7 +11799,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PCTYPE_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get pctype list");
-		rte_free(pctype);
+		free(pctype);
 		return -1;
 	}
 
@@ -11880,7 +11880,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 		}
 	}
 
-	rte_free(pctype);
+	free(pctype);
 	return 0;
 }
 
@@ -11926,7 +11926,7 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = ptype_num * sizeof(struct rte_pmd_i40e_ptype_info);
-	ptype = rte_zmalloc("new_ptype", buff_size, 0);
+	ptype = calloc(ptype_num, sizeof(struct rte_pmd_i40e_ptype_info));
 	if (!ptype) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return -1;
@@ -11938,15 +11938,14 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
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
 
@@ -12084,8 +12083,8 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to update ptype mapping table.");
 
-	rte_free(ptype_mapping);
-	rte_free(ptype);
+	free(ptype_mapping);
+	free(ptype);
 	return ret;
 }
 
@@ -12120,7 +12119,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = proto_num * sizeof(struct rte_pmd_i40e_proto_info);
-	proto = rte_zmalloc("new_proto", buff_size, 0);
+	proto = calloc(proto_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!proto) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return;
@@ -12132,7 +12131,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PROTOCOL_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get protocol list");
-		rte_free(proto);
+		free(proto);
 		return;
 	}
 
@@ -12170,7 +12169,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(INFO, "No ptype is updated.");
 
-	rte_free(proto);
+	free(proto);
 }
 
 /* Create a QinQ cloud filter
-- 
2.47.3

