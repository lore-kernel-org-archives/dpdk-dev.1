Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B76E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:25:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CFA14064E;
	Thu, 19 Feb 2026 17:23:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E1E8640655
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518214; x=1803054214;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8AOR/iCUCRFrU0llcFKaFjNODoxy4J/EpPkezCXmAZk=;
 b=A9cg3Tuyuu81aFN1WSdZBwmzUNRz0/Ejx37uk+xvbz97eDgY0zoh42G4
 lKo59LSeUPYU5LLMMj4jXTIvVXqaFVhqwr8OwilCRaczmxMbM5Yz2wD1S
 8cE6Ipnai60YPrZwOQf+EwQLGCoR3HfwcpcscZK68RM0AJk/lmOY1ClfZ
 3PfCLcnCHRDWLrpXh4+SfmFStAUCrUvXyyXnU2nddWLlqZPdxOEj0nnM/
 JEWZYJEVDWWPzCQQG9gskhZa7H/80eozGPfQDxrYw8mfSAuAjopcu6GxZ
 XYM2VK8NTUdqd6SFKNz7AL820FC8kOMzfkvMDKapouXkbyhLz+Rm1ScCS w==;
X-CSE-ConnectionGUID: lKVpw8fSSF6OCAjYOwX7HA==
X-CSE-MsgGUID: 02051rb6TG6yROQdslrejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231445"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231445"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:33 -0800
X-CSE-ConnectionGUID: 3kYwE+zlRYiuEvJhnDWbVA==
X-CSE-MsgGUID: QvGHtC/1RJaH1MCM7WyrJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699889"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 14/27] net/i40e: avoid rte malloc in DDP package handling
Date: Thu, 19 Feb 2026 16:22:57 +0000
Message-ID: <6b4139a98808af59f2c54de3c6e4dfbcc4adf8d3.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

Currently, when processing Dynamic Driver Profile (DDP) packages and
checking profile information, we are using rte_zmalloc followed by
immediate rte_free. This memory does not need to be stored in hugepage
memory, so replace it with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/rte_pmd_i40e.c | 43 +++++----------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 4839a1d9bf..7892fa8a4e 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -1557,7 +1557,7 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[port];
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint8_t *buff;
+	uint8_t buff[(I40E_MAX_PROFILE_NUM + 4) * I40E_PROFILE_INFO_SIZE] = {0};
 	struct rte_pmd_i40e_profile_list *p_list;
 	struct rte_pmd_i40e_profile_info *pinfo, *p;
 	uint32_t i;
@@ -1570,13 +1570,6 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		PMD_DRV_LOG(INFO, "Read-only profile.");
 		return 0;
 	}
-	buff = rte_zmalloc("pinfo_list",
-			   (I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4),
-			   0);
-	if (!buff) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		return -1;
-	}
 
 	ret = i40e_aq_get_ddp_list(
 		hw, (void *)buff,
@@ -1584,7 +1577,6 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		0, NULL);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get profile info list.");
-		rte_free(buff);
 		return -1;
 	}
 	p_list = (struct rte_pmd_i40e_profile_list *)buff;
@@ -1592,20 +1584,17 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		p = &p_list->p_info[i];
 		if (pinfo->track_id == p->track_id) {
 			PMD_DRV_LOG(INFO, "Profile exists.");
-			rte_free(buff);
 			return 1;
 		}
 	}
 	/* profile with group id 0xff is compatible with any other profile */
 	if ((pinfo->track_id & group_mask) == group_mask) {
-		rte_free(buff);
 		return 0;
 	}
 	for (i = 0; i < p_list->p_count; i++) {
 		p = &p_list->p_info[i];
 		if ((p->track_id & group_mask) == 0) {
 			PMD_DRV_LOG(INFO, "Profile of the group 0 exists.");
-			rte_free(buff);
 			return 2;
 		}
 	}
@@ -1616,12 +1605,9 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		if ((pinfo->track_id & group_mask) !=
 		    (p->track_id & group_mask)) {
 			PMD_DRV_LOG(INFO, "Profile of different group exists.");
-			rte_free(buff);
 			return 3;
 		}
 	}
-
-	rte_free(buff);
 	return 0;
 }
 
@@ -1637,7 +1623,10 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 	struct i40e_generic_seg_header *profile_seg_hdr;
 	struct i40e_generic_seg_header *metadata_seg_hdr;
 	uint32_t track_id;
-	uint8_t *profile_info_sec;
+	struct {
+		struct i40e_profile_section_header sec;
+		struct i40e_profile_info info;
+	} profile_info_sec = {0};
 	int is_exist;
 	enum i40e_status_code status = I40E_SUCCESS;
 	static const uint32_t type_mask = 0xff000000;
@@ -1702,26 +1691,15 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 		return -EINVAL;
 	}
 
-	profile_info_sec = rte_zmalloc(
-		"i40e_profile_info",
-		sizeof(struct i40e_profile_section_header) +
-		sizeof(struct i40e_profile_info),
-		0);
-	if (!profile_info_sec) {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory");
-		return -EINVAL;
-	}
-
 	/* Check if the profile already loaded */
 	i40e_generate_profile_info_sec(
 		((struct i40e_profile_segment *)profile_seg_hdr)->name,
 		&((struct i40e_profile_segment *)profile_seg_hdr)->version,
-		track_id, profile_info_sec,
+		track_id, (uint8_t* )&profile_info_sec,
 		op == RTE_PMD_I40E_PKG_OP_WR_ADD);
-	is_exist = i40e_check_profile_info(port, profile_info_sec);
+	is_exist = i40e_check_profile_info(port, (uint8_t* )&profile_info_sec);
 	if (is_exist < 0) {
 		PMD_DRV_LOG(ERR, "Failed to check profile.");
-		rte_free(profile_info_sec);
 		return -EINVAL;
 	}
 
@@ -1734,13 +1712,11 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 			else if (is_exist == 3)
 				PMD_DRV_LOG(ERR, "Profile of different group already exists");
 			i40e_update_customized_info(dev, buff, size, op);
-			rte_free(profile_info_sec);
 			return -EEXIST;
 		}
 	} else if (op == RTE_PMD_I40E_PKG_OP_WR_DEL) {
 		if (is_exist != 1) {
 			PMD_DRV_LOG(ERR, "Profile does not exist.");
-			rte_free(profile_info_sec);
 			return -EACCES;
 		}
 	}
@@ -1752,7 +1728,6 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 			track_id);
 		if (status) {
 			PMD_DRV_LOG(ERR, "Failed to write profile for delete.");
-			rte_free(profile_info_sec);
 			return status;
 		}
 	} else {
@@ -1765,14 +1740,13 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 				PMD_DRV_LOG(ERR, "Failed to write profile for add.");
 			else
 				PMD_DRV_LOG(ERR, "Failed to write profile.");
-			rte_free(profile_info_sec);
 			return status;
 		}
 	}
 
 	if (track_id && (op != RTE_PMD_I40E_PKG_OP_WR_ONLY)) {
 		/* Modify loaded profiles info list */
-		status = i40e_add_rm_profile_info(hw, profile_info_sec);
+		status = i40e_add_rm_profile_info(hw, (uint8_t* )&profile_info_sec);
 		if (status) {
 			if (op == RTE_PMD_I40E_PKG_OP_WR_ADD)
 				PMD_DRV_LOG(ERR, "Failed to add profile to info list.");
@@ -1785,7 +1759,6 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 	    op == RTE_PMD_I40E_PKG_OP_WR_DEL)
 		i40e_update_customized_info(dev, buff, size, op);
 
-	rte_free(profile_info_sec);
 	return status;
 }
 
-- 
2.47.3

