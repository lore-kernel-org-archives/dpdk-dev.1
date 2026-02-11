Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C2E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3312E40B97;
	Wed, 11 Feb 2026 14:53:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id A567E40B97
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818029; x=1802354029;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3cIWH7FxIVj2mRjRK7KcZNFK0IWHv3+Pu1Ni5Il63Dc=;
 b=KTgvAM5MG/L+21xHryWaup1qJ9RODwoFqa2bRqkhL5lL3afvt9uR4e9s
 Ey88nyEpbXSaPtfTKqbsIXdbkXh+3LJ+yTzhD56BshPWXw5xMXO7cHwHB
 jKzWqvYMr/65FIq0wv6vCjZGHDBoz3/QX47bcQABRipyPPn0GFBdLjSvV
 UxXU3INodFC2EADIZf3jmf4DoLRSXB2BzYksifgJsnUZploFUDv99Zlp7
 vwML+QJ9M10PqEDnVij+AIc+v4OJ7oMnH6/WLiHg+KYbBrSZ5iVOXZt/4
 nmgIAkFUlWi8J3LK7YGXnNw1ZpIPQ7j7DFj6yv6BEPpWRBkk6JAClRcLQ g==;
X-CSE-ConnectionGUID: Jwg7h8j3Tg+rQfmLIBL6HQ==
X-CSE-MsgGUID: xy+GS1S/S2+UNOBfeQ28TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808258"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808258"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:49 -0800
X-CSE-ConnectionGUID: wz1uV3hvQUmOoZk6zr0kCg==
X-CSE-MsgGUID: wjAdfbi3QLqjscaUQtQxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359607"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 14/27] net/i40e: avoid rte malloc in DDP package handling
Date: Wed, 11 Feb 2026 13:52:56 +0000
Message-ID: <75d6a7f7525aaaa4b503697c4be7e5dc16e8cae7.1770817884.git.anatoly.burakov@intel.com>
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

Currently, when processing Dynamic Driver Profile (DDP) packages and
checking profile information, we are using rte_zmalloc followed by
immediate rte_free. This is not needed as these buffers are only used
temporarily, so replace it with stack-allocated structures or regular
malloc/free where appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/rte_pmd_i40e.c | 43 +++++++++------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index fb73fa924f..a2e24b5ea2 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -1569,9 +1569,7 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		PMD_DRV_LOG(INFO, "Read-only profile.");
 		return 0;
 	}
-	buff = rte_zmalloc("pinfo_list",
-			   (I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4),
-			   0);
+	buff = calloc(I40E_MAX_PROFILE_NUM + 4, I40E_PROFILE_INFO_SIZE);
 	if (!buff) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return -1;
@@ -1583,7 +1581,7 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		0, NULL);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get profile info list.");
-		rte_free(buff);
+		free(buff);
 		return -1;
 	}
 	p_list = (struct rte_pmd_i40e_profile_list *)buff;
@@ -1591,20 +1589,20 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		p = &p_list->p_info[i];
 		if (pinfo->track_id == p->track_id) {
 			PMD_DRV_LOG(INFO, "Profile exists.");
-			rte_free(buff);
+			free(buff);
 			return 1;
 		}
 	}
 	/* profile with group id 0xff is compatible with any other profile */
 	if ((pinfo->track_id & group_mask) == group_mask) {
-		rte_free(buff);
+		free(buff);
 		return 0;
 	}
 	for (i = 0; i < p_list->p_count; i++) {
 		p = &p_list->p_info[i];
 		if ((p->track_id & group_mask) == 0) {
 			PMD_DRV_LOG(INFO, "Profile of the group 0 exists.");
-			rte_free(buff);
+			free(buff);
 			return 2;
 		}
 	}
@@ -1615,12 +1613,12 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 		if ((pinfo->track_id & group_mask) !=
 		    (p->track_id & group_mask)) {
 			PMD_DRV_LOG(INFO, "Profile of different group exists.");
-			rte_free(buff);
+			free(buff);
 			return 3;
 		}
 	}
 
-	rte_free(buff);
+	free(buff);
 	return 0;
 }
 
@@ -1636,7 +1634,10 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
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
@@ -1701,26 +1702,15 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
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
 
@@ -1733,13 +1723,11 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
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
@@ -1751,7 +1739,6 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 			track_id);
 		if (status) {
 			PMD_DRV_LOG(ERR, "Failed to write profile for delete.");
-			rte_free(profile_info_sec);
 			return status;
 		}
 	} else {
@@ -1764,14 +1751,13 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
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
@@ -1784,7 +1770,6 @@ rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 	    op == RTE_PMD_I40E_PKG_OP_WR_DEL)
 		i40e_update_customized_info(dev, buff, size, op);
 
-	rte_free(profile_info_sec);
 	return status;
 }
 
-- 
2.47.3

