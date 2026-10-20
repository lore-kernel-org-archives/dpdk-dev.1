Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4C606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MwOK9siO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 959F940659;
	Tue, 20 Oct 2026 14:11:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DC08B40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498275; x=1824034275;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MsfGvU6KOeO5ikcFn/dkXCXD0pzDoQi9qex0QP7dZ+M=;
 b=MwOK9siOUu5aqAqHmoPhhuhXcJtmXFN5esBkTpGueGHXwCceWLobUWSe
 0qBb4qj8UdAon26Ak3/weRbplkP4nKxeez6RJmHntfJ8gBRxrPDomTeS/
 24J1hOJjln2ybbqSZX2KKwtW8vQP1zxdL9GylE4dRaqYMNc5V68vFcC8j
 ysmQLt9c13/zRGuxbxb6vRWB3Y5VHBd6c5t3p9oTB7+CK6NwS8W0KKEl0
 /kaSpL4AGO4/Td74mIuqOm4QFnU3Y7QDWacL7dm9A9tq28ZxlhYJ5gnsn
 PUAeE5R/45Z8lEWkSMRVcDj1026dPtFtNitwexvpwbqQzcBSmOVEVs5ku w==;
X-CSE-ConnectionGUID: WD0Z28BWSqGek8/SV/voXQ==
X-CSE-MsgGUID: O8TQ29FMS0ecOCNeSGxNSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101784"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:14 -0700
X-CSE-ConnectionGUID: WFyPEtDtRCCW6OEtlmfBnQ==
X-CSE-MsgGUID: SrDDFkJqQAOe6DTVKD9cQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253895"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Xuan Ding <xuan.ding@intel.com>,
 Simei Su <simei.su@intel.com>
Subject: [PATCH v1 1/6] net/ice: release ACL slot on entry creation failure
Date: Tue, 20 Oct 2026 13:11:04 +0100
Message-ID: <c84ac911518d38194909537a1da3c6bc931fc86a.1792498154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792498154.git.anatoly.burakov@intel.com>
References: 
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ACL entry creation reserves a bitmap slot before programming hardware.
If programming fails, the reserved slot is not restored, so repeated
failures consume the available slots. The slot is also left reserved
when it exceeds the supported entry limit.

Restore the bitmap slot on both failure paths. Keep it reserved only
when entry creation succeeds.

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index a91bd558f3..eb5d88ccc5 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -462,6 +462,7 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
 					 acts, act_cnt, &hw_entry);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Fail to add entry.");
+			rte_bitmap_set(pf->acl.slots, slot_id);
 			return ret;
 		}
 		rule->entry_id[entry_idx] = entry_id;
@@ -469,6 +470,7 @@ ice_acl_hw_set_conf(struct ice_pf *pf, struct ice_fdir_fltr *input,
 	} else {
 		PMD_DRV_LOG(ERR, "Exceed the maximum entry number(%d)"
 			    " HW supported!", MAX_ACL_NORMAL_ENTRIES);
+		rte_bitmap_set(pf->acl.slots, slot_id);
 		return -1;
 	}
 
-- 
2.52.0

