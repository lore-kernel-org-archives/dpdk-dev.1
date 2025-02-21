Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49575C021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 08:56:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EB0C40647;
	Fri, 21 Feb 2025 09:56:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D87D84029A
 for <dev@dpdk.org>; Fri, 21 Feb 2025 09:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740128169; x=1771664169;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cgdAf+XjG31CSU4BzYKutJkugATYyfMu4izz0JgYC4o=;
 b=JD1w0enwrm8Pg9krXqEvcoiC4uug/3ndUBDI7BEBH3glVTiYjRpwvdvo
 V8uI83Kd+bEC7w3gZVlB0+XmBlVtKipRICca1d4qWpyQT45UcEU26j1zB
 e3y9I2Nc1gCxJNGid2FD6bKSGd7L3iyOI/3b7WIR9/ears3TpiF0/eb4j
 yCKLidM2jJ72B/Y6PFO/KSz8eHt9dMljxtu9+74aaXawF2mVD0Ra9lauw
 O+7WyAjX+fGjoyRf1Yz2bnul4AtP595gv7Vmemc1R2jp02XZWUx60td3j
 ZDnnTz7gpi1hqYfwZLKHU1iR6eUBFeLj0UrT/5E9sxPgarnJpY9UyiqUP g==;
X-CSE-ConnectionGUID: 9s8YQ9YPTtmEuZroSI25gA==
X-CSE-MsgGUID: OPbfzA17QlmW6vzMM3ZaMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41060458"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="41060458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 00:56:08 -0800
X-CSE-ConnectionGUID: x50ki9sDRN+NAeqvsH1YOg==
X-CSE-MsgGUID: zF0xfxc5TmSwmvoFeKY8zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115258184"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 00:56:06 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: fix ACL filter uninit
Date: Fri, 21 Feb 2025 08:25:09 +0000
Message-Id: <20250221082510.332677-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
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

The pf has enabled the ACL filter, so uninit is no longer limited
to the DCF.

Fixes: a9d612291c2d ("net/ice: support IPv4 fragments in ACL filters")

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 48 +++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 04c17a98ed..83cb3e36f9 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -278,26 +278,28 @@ ice_acl_prof_init(struct ice_pf *pf)
 	if (ret)
 		goto err_add_prof_ipv4_sctp;
 
-	for (i = 0; i < pf->main_vsi->idx; i++) {
-		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4, i);
-		if (ret)
-			goto err_assoc_prof;
-
-		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_frag, i);
-		if (ret)
-			goto err_assoc_prof;
-
-		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_udp, i);
-		if (ret)
-			goto err_assoc_prof;
-
-		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_tcp, i);
-		if (ret)
-			goto err_assoc_prof;
-
-		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_sctp, i);
-		if (ret)
-			goto err_assoc_prof;
+	if (hw->dcf_enabled) {
+		for (i = 0; i < pf->main_vsi->idx; i++) {
+			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4, i);
+			if (ret)
+				goto err_assoc_prof;
+
+			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_frag, i);
+			if (ret)
+				goto err_assoc_prof;
+
+			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_udp, i);
+			if (ret)
+				goto err_assoc_prof;
+
+			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_tcp, i);
+			if (ret)
+				goto err_assoc_prof;
+
+			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_sctp, i);
+			if (ret)
+				goto err_assoc_prof;
+		}
 	}
 	return 0;
 
@@ -1082,10 +1084,8 @@ ice_acl_uninit(struct ice_adapter *ad)
 	struct ice_pf *pf = &ad->pf;
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 
-	if (ad->hw.dcf_enabled) {
-		ice_deinit_acl(pf);
-		ice_acl_prof_free(hw);
-	}
+	ice_deinit_acl(pf);
+	ice_acl_prof_free(hw);
 }
 
 static struct
-- 
2.25.1

