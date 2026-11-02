Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF22606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RE/6W5Lw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C81640EE1;
	Mon,  2 Nov 2026 09:15:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id AA69140E49;
 Mon,  2 Nov 2026 09:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607353; x=1825143353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2/G1bqNJhPbmplXuS8xmj0sOd17sQjLfLp2RKHj5Rc=;
 b=RE/6W5Lwd5B1F2jvDN8GyVjA/+FY8XeBiilhx2Txw3fImXAs54LscEc8
 8cjemQ+OUJxz/OZIDpeS8SkfrW/DaWcQ6TAHMVmkrohcPNXIAPUBkb2TY
 fo2+7+kEhp+SQKJCMI7vIRGKw8h+IVAKoiTDRCoF0toTL7zrM3PruScr/
 q4F4g5a8YvJ/2ebBB1WNcxx8C79djnXUzBZVzWYsSVS2aNIUZwqLmDf98
 FGnKRFxql5EY/Q5E720ApOoM577QrAwCok3gM0N1MFSBLHo/7r0MfVsbG
 o3PmWZ7dtTBDsw8c8S8wQ5+DcBMxW005hZrflQkFIb0pf+wxzYXU6vVMo Q==;
X-CSE-ConnectionGUID: NvhaxsIsQieRegHHfqYJyw==
X-CSE-MsgGUID: 10KuBLTEQ/ystvUQm9GHOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283642"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283642"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:52 -0800
X-CSE-ConnectionGUID: AktIwrrsQhaJQGiKhUxQAQ==
X-CSE-MsgGUID: Pog9DRVmTfmw++ElUOaeFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818720"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:51 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 7/7] net/ice: fix ACL profile segment leak
Date: Mon,  2 Nov 2026 08:10:37 +0000
Message-Id: <cd2ce57505b7d39def1658b940a1087ae627aceb.1793605752.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_acl_prof_init() allocates a flow segment to add the ACL profiles,
but only frees it on the error path, so it leaks on every ACL engine
init.

ice_flow_add_prof() copies the segments, so the buffer is only needed
while adding the profiles.

Allocate it on the stack instead, which removes the need to free it.

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 46 +++++++++++---------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 21b48e1009..6cf8c83738 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -226,62 +226,57 @@ ice_acl_prof_init(struct ice_pf *pf)
 	struct ice_flow_prof *prof_ipv4_udp = NULL;
 	struct ice_flow_prof *prof_ipv4_tcp = NULL;
 	struct ice_flow_prof *prof_ipv4_sctp = NULL;
-	struct ice_flow_seg_info *seg;
+	struct ice_flow_seg_info seg = {0};
 	int i;
 	int ret;
 
-	seg = (struct ice_flow_seg_info *)
-		 ice_malloc(hw, sizeof(*seg));
-	if (!seg)
-		return -ENOMEM;
-
-	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4);
-	acl_add_prof_prepare(hw, seg, false, 0, 0);
+	ICE_FLOW_SET_HDRS(&seg, ICE_FLOW_SEG_HDR_IPV4);
+	acl_add_prof_prepare(hw, &seg, false, 0, 0);
 	ret = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
 				ICE_FLTR_PTYPE_NONF_IPV4_OTHER,
-				seg, 1, NULL, 0, &prof_ipv4);
+				&seg, 1, NULL, 0, &prof_ipv4);
 	if (ret)
 		goto err_add_prof;
 
-	ice_memset(seg, 0, sizeof(*seg), ICE_NONDMA_MEM);
-	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV_FRAG);
-	acl_add_prof_prepare(hw, seg, false, 0, 0);
+	ice_memset(&seg, 0, sizeof(seg), ICE_NONDMA_MEM);
+	ICE_FLOW_SET_HDRS(&seg, ICE_FLOW_SEG_HDR_IPV_FRAG);
+	acl_add_prof_prepare(hw, &seg, false, 0, 0);
 	ret = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
 				ICE_FLTR_PTYPE_FRAG_IPV4,
-				seg, 1, NULL, 0, &prof_ipv4_frag);
+				&seg, 1, NULL, 0, &prof_ipv4_frag);
 	if (ret)
 		goto err_add_prof_ipv4_udp_frag;
 
-	ice_memset(seg, 0, sizeof(*seg), ICE_NONDMA_MEM);
-	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_UDP | ICE_FLOW_SEG_HDR_IPV4);
-	acl_add_prof_prepare(hw, seg, true,
+	ice_memset(&seg, 0, sizeof(seg), ICE_NONDMA_MEM);
+	ICE_FLOW_SET_HDRS(&seg, ICE_FLOW_SEG_HDR_UDP | ICE_FLOW_SEG_HDR_IPV4);
+	acl_add_prof_prepare(hw, &seg, true,
 			     ICE_FLOW_FIELD_IDX_UDP_SRC_PORT,
 			     ICE_FLOW_FIELD_IDX_UDP_DST_PORT);
 	ret = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
 				ICE_FLTR_PTYPE_NONF_IPV4_UDP,
-				seg, 1, NULL, 0, &prof_ipv4_udp);
+				&seg, 1, NULL, 0, &prof_ipv4_udp);
 	if (ret)
 		goto err_add_prof_ipv4_udp;
 
-	ice_memset(seg, 0, sizeof(*seg), ICE_NONDMA_MEM);
-	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV4);
-	acl_add_prof_prepare(hw, seg, true,
+	ice_memset(&seg, 0, sizeof(seg), ICE_NONDMA_MEM);
+	ICE_FLOW_SET_HDRS(&seg, ICE_FLOW_SEG_HDR_TCP | ICE_FLOW_SEG_HDR_IPV4);
+	acl_add_prof_prepare(hw, &seg, true,
 			     ICE_FLOW_FIELD_IDX_TCP_SRC_PORT,
 			     ICE_FLOW_FIELD_IDX_TCP_DST_PORT);
 	ret = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
 				ICE_FLTR_PTYPE_NONF_IPV4_TCP,
-				seg, 1, NULL, 0, &prof_ipv4_tcp);
+				&seg, 1, NULL, 0, &prof_ipv4_tcp);
 	if (ret)
 		goto err_add_prof_ipv4_tcp;
 
-	ice_memset(seg, 0, sizeof(*seg), ICE_NONDMA_MEM);
-	ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4);
-	acl_add_prof_prepare(hw, seg, true,
+	ice_memset(&seg, 0, sizeof(seg), ICE_NONDMA_MEM);
+	ICE_FLOW_SET_HDRS(&seg, ICE_FLOW_SEG_HDR_SCTP | ICE_FLOW_SEG_HDR_IPV4);
+	acl_add_prof_prepare(hw, &seg, true,
 			     ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT,
 			     ICE_FLOW_FIELD_IDX_SCTP_DST_PORT);
 	ret = ice_flow_add_prof(hw, ICE_BLK_ACL, ICE_FLOW_RX,
 				ICE_FLTR_PTYPE_NONF_IPV4_SCTP,
-				seg, 1, NULL, 0, &prof_ipv4_sctp);
+				&seg, 1, NULL, 0, &prof_ipv4_sctp);
 	if (ret)
 		goto err_add_prof_ipv4_sctp;
 
@@ -321,7 +316,6 @@ ice_acl_prof_init(struct ice_pf *pf)
 err_add_prof_ipv4_udp_frag:
 	ice_flow_rem_prof(hw, ICE_BLK_ACL, ICE_FLTR_PTYPE_NONF_IPV4_OTHER);
 err_add_prof:
-	ice_free(hw, seg);
 	return ret;
 }
 
-- 
2.25.1

