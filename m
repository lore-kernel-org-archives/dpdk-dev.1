Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D607BE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3360340DCB;
	Wed, 11 Feb 2026 14:53:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id BCBE940BA2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818031; x=1802354031;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LU4dkJZKRL0M1pD2s8qFqO3k57oEQ70o/ioFC9to+pE=;
 b=GlML2ydkd3h578Od3S0j1LGttuBtlWe8FFESGq7x/BxanIcCGBR2iYAh
 erc/sh1DKP7Kk8I/lKJAVeJpGwMy92QAucMQ/dFcqJaYjuHyQLgHbM4Fx
 HKElbC1hcQpas8Jjf06SASbSg6WXHqNwPt15tF0o+MYpHFU4dmZyWLUXE
 xFhBg1TUgKObDMpLFl+qUTQXW+yLWWN+8Qk8MJ18GhqbAL/++dI/kPw3D
 hSaY694zWaHPJ0pQkv1oEmqfk9Y032GrTqiC+dba4znE+e12B2h5mLP82
 EP2G13/2xOStINhLOo1iHVi/9AgxCsTDInr23hgCErBCPtVDHN574niEF g==;
X-CSE-ConnectionGUID: 4VobpvVvR0C3fO+M4kKdLg==
X-CSE-MsgGUID: ei8yKYpfR3u8TpplVi9rDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808260"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808260"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:50 -0800
X-CSE-ConnectionGUID: PwywykWcQH+r3h10IlruVQ==
X-CSE-MsgGUID: rGsDCiE0RXSjlyIM166FSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359612"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Date: Wed, 11 Feb 2026 13:52:57 +0000
Message-ID: <a48eb9cd4cee66fb306fe57c0755e0256a574152.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

