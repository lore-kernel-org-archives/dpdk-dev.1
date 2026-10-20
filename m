Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3A606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfnDmKus
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B4E40693;
	Tue, 20 Oct 2026 14:11:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 44BCC4060F
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498276; x=1824034276;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Mm25C52gCOU9UgwcKfVr9kkdCJVPnGHryHTaWKjefBI=;
 b=lfnDmKusu90BQZF9PsoBf4ClA5Q2nB/KjTACau5rWiQ1/pIc1yVteWmm
 TEjGhkobjpCkBxYY1zooKYbucCos68ubg97lLlBJCSdFQtcK2lPHpKwFm
 O+G63OSvGbqCJ2UdUz3Z/uPVe8Ez4K+xrHkv74L9o/1ccMPsd2OyqK0AZ
 n0Zq0JTeOsLphsgzRqrCXP4qlbpjYBbx7JkyIAQCqUbxb+qXVHlvsenaW
 2kQzBnD3YW7eS/mim1oilj5oxnZk+JrxH+ItNljx3925pUVa+4Z0Bq7np
 u+A8db4TOCpvI3M2su2VqfIIlMjZXjUnyXKqMQcD//ujDL1inSUxRsUnH g==;
X-CSE-ConnectionGUID: zEKT2wbURdWAqcjph2IHUw==
X-CSE-MsgGUID: K5tH5wQDR/+iRiGI/ZlQdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101786"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101786"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:16 -0700
X-CSE-ConnectionGUID: dNxZ1s1AQ4qledINJeCTqQ==
X-CSE-MsgGUID: enu1IR7xRS2dI2N4k4yEXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253901"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Xiaolong Ye <xiaolong.ye@intel.com>, Yahui Cao <yahui.cao@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v1 2/6] net/ice: fix inconsistent state on FDIR failure
Date: Tue, 20 Oct 2026 13:11:05 +0100
Message-ID: <c1c40841ee6fba9e2d0322a2ae1fd7ae06cff891.1792498154.git.anatoly.burakov@intel.com>
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

FDIR creation programs the hardware rule before inserting its software
hash entry. If insertion fails, creation returns without removing the
hardware rule or releasing its counter, and MARK parsing may remain
enabled despite no flow handle being returned.

Reserve the hash entry before programming the rule, and release the
counter if reservation fails. Remove the reserved entry if hardware
programming fails. Enable MARK parsing only after both steps succeed.

Fixes: 1a2fc1799f09 ("net/ice: reject duplicated flow for flow director")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 517c32cecf..63a0d9fb1f 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1654,8 +1654,18 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		filter->input.cnt_index = filter->counter->hw_index;
 	}
 
+	/* Reserve the software entry before installing the hardware rule. */
+	ret = ice_fdir_entry_insert(pf, entry, &key);
+	if (ret) {
+		rte_flow_error_set(error, -ret,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Insert entry to table failed.");
+		goto free_counter;
+	}
+
 	ret = ice_fdir_add_del_filter(pf, filter, true);
 	if (ret) {
+		ice_fdir_entry_del(pf, &key);
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Add filter rule failed.");
@@ -1666,14 +1676,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		ice_fdir_rx_parsing_enable(ad, 1);
 
 	memcpy(entry, filter, sizeof(*entry));
-	ret = ice_fdir_entry_insert(pf, entry, &key);
-	if (ret) {
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Insert entry to table failed.");
-		goto free_entry;
-	}
-
 	flow->rule = entry;
 	ice_fdir_cnt_update(pf, filter->input.flow_type, is_tun, true);
 
-- 
2.52.0

