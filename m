Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC1606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=enuks5pL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 845C9406B6;
	Mon,  9 Nov 2026 16:35:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A4314028F;
 Mon,  9 Nov 2026 16:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794238514; x=1825774514;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DsDb5BKJO5F5guCEs/JLC3JD5UxkqUgHo332mS2g3Qo=;
 b=enuks5pLJb/Ck/21TMyHQCKpB+np0q9f2wjHuOnQ3yntKKV0SnxCd0XM
 f4rrF3c9sMfBJXMEzCIjRL4mNjlGmPlDDQO/1U5UjvelpRmL8UMcKz6Al
 31kUDoEQIYtwFUDJIz24pKdxThlyVcQLedju8FuoTieT1ogOf7BKouCQP
 1WpHpZnmfV5GGlvseSzlWJhybDf26sJUvr3EVHWdSQrbN0GZMXAic4Jls
 20Lo/jaqnKNH/e1uAs/H7IyqpXNZvkSPj1UST9/3UsYXwM0uZHjd24m3d
 oL0k2SCexRdRXV6v/ZTfYtppcb4+WBjilZi+/zXuyfdE7Gq7rnQGp0tPh A==;
X-CSE-ConnectionGUID: u5Pz7F72RnW34TTcxb1yyA==
X-CSE-MsgGUID: u203D8FsTQunXqT0aN1grA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2862115"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2862115"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 07:35:11 -0800
X-CSE-ConnectionGUID: Z4Ntl3sPQA2p2UaLpC7NZg==
X-CSE-MsgGUID: T1WQrz6DTzy1rvMRAeviiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7921125"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 09 Nov 2026 07:35:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix ACL entry limit on devices with 8 ports
Date: Mon,  9 Nov 2026 15:32:45 +0000
Message-ID: <20261109153245.53360-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Currently, the ACL table depth is halved on devices with more than 4
PFs, but the driver still assumes 256 entries are available. The base
code reserves only 50% of the scenario for the NORMAL priority band,
so on an 8-port device adding the 129th rule fails and the flow silently
falls back to the switch engine.

Fix it by deriving the entry limit from the configured depth so the
driver rejects rules beyond the NORMAL band with an explicit error.

Fixes: 17a8fc206178 ("net/ice: fix initialization with 8 ports")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 9 ++++++---
 drivers/net/intel/ice/ice_ethdev.h     | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 94c9ea89fdc..0f913126ded 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -134,6 +134,9 @@ ice_acl_setup(struct ice_pf *pf)
 	if (err)
 		return err;
 
+	/* Only the NORMAL priority band (50% of the scenario) is used. */
+	pf->acl.max_entries = params.depth / 2;
+
 	return 0;
 }
 
@@ -449,7 +452,7 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
 	/* For IPV4_OTHER type, should add entry for all types.
 	 * For IPV4_UDP/TCP/SCTP type, only add entry for each.
 	 */
-	if (slot_id < MAX_ACL_NORMAL_ENTRIES) {
+	if (slot_id < pf->acl.max_entries) {
 		entry_id = ((uint64_t)flow_type << 32) | slot_id;
 		ret = ice_flow_add_entry(hw, blk, flow_type,
 					 entry_id, pf->main_vsi->idx,
@@ -463,8 +466,8 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
 		rule->entry_id[entry_idx] = entry_id;
 		pf->acl.hw_entry_id[slot_id] = hw_entry;
 	} else {
-		PMD_DRV_LOG(ERR, "Exceed the maximum entry number(%d)"
-			    " HW supported!", MAX_ACL_NORMAL_ENTRIES);
+		PMD_DRV_LOG(ERR, "Exceed the maximum entry number(%u)"
+			    " HW supported!", pf->acl.max_entries);
 		rte_bitmap_set(pf->acl.slots, slot_id);
 		return -1;
 	}
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 945e765c2c2..7a3d164143b 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -498,6 +498,7 @@ struct ice_acl_conf {
  */
 struct ice_acl_info {
 	struct rte_bitmap *slots;
+	uint16_t max_entries;
 	uint64_t hw_entry_id[MAX_ACL_NORMAL_ENTRIES];
 };
 
-- 
2.43.0

