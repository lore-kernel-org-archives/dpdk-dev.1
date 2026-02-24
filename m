Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A1F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40189406FF;
	Tue, 24 Feb 2026 16:15:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id AD66B40612
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946094; x=1803482094;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8AOR/iCUCRFrU0llcFKaFjNODoxy4J/EpPkezCXmAZk=;
 b=YQjLz4XW3+tlGLkCVyo0n1ugTCvc6XVVfQ7PlnPu+mwyFznMUbSDpiiB
 VoVqiWgRDnFPxzPY99auFDws3h5fcOlE0FBaQaQ+geMVZWOQy12XriyiC
 K+j0cyTxix7UNF1v8xK22HhAgzSDz4v3u0ARBF/50YjEckizAByMkglO+
 Qa7bRy/FEWuFLlXZV6Mu3iRUGwhnokwK7S1Xh7OEf3qDprKDPrc9jC+Lk
 rk26B2GnCuuefkI9z0QssaOJUWnsDBPQ7rY72ptJ+Qmz5tM52qReHXaKD
 Rbp1OQaiYMBHH4djhF+zO5404FQkPQ0tZrsfGXZofH9Xol5zRJz+8G5gX Q==;
X-CSE-ConnectionGUID: Yt8XnvrCTGytog8TvXDYww==
X-CSE-MsgGUID: gt3A0tqyQgG17ywKxJDdUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056260"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056260"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:53 -0800
X-CSE-ConnectionGUID: cUQiCmLNQpiLAK3Ii+uBEQ==
X-CSE-MsgGUID: PT/IncXtSVGIHlXFmbSJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526169"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 14/26] net/i40e: avoid rte malloc in DDP package handling
Date: Tue, 24 Feb 2026 15:14:19 +0000
Message-ID: <03a8205b508dca129f1f3a5c916688f9c1022d7a.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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

