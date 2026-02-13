Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A3EDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD91340A87;
	Fri, 13 Feb 2026 11:27:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BB0D140A70
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978430; x=1802514430;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LU4dkJZKRL0M1pD2s8qFqO3k57oEQ70o/ioFC9to+pE=;
 b=DrBuXjzj9hN7TAZUBp33U78eukMtOArYt9YaJxA0xIbkdVWh/JBSH9Cp
 +40dIKgiRNCfB5J7F0YMdVrFoScJxFMMiM1HGA5ZRGYQcP+gjtH48ZdpF
 Mn3hjMpTnSePYqll2wug53kSO9xT0El5KiTSQJd/Vn1XwWy64XwxuRoaX
 iIZzSg0JEHb74CT/VhhNL6cDhyR7yJgd5vpQD9dG8mBC40e8ewh56QfNA
 naVMnP2fiNgTDCiy+VjkApUW7dqFiHTkkzkoCJ59qgV9NjH+i+3n682qQ
 O4jAZzTvFr7S2krdGo/Umaq3nW7IcQpndNjNgqthPROjmTPipSVN/U/LP A==;
X-CSE-ConnectionGUID: hNadAoj3TIiYMDYnEKv9KQ==
X-CSE-MsgGUID: CUsowzunQHmFwLKv+7M3ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603104"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603104"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:09 -0800
X-CSE-ConnectionGUID: hOWfy+LUTZeI0JNiRL+nTQ==
X-CSE-MsgGUID: qy6OtfQ0RQWAkXBtg2mQ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028104"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Date: Fri, 13 Feb 2026 10:26:26 +0000
Message-ID: <ceda6030af950283c4c6eed39b8d14266b68b04b.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

