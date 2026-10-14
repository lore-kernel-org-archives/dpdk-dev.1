Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8957CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8499040A89;
	Wed, 14 Oct 2026 17:19:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8F1AE406FF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991169; x=1823527169;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=t+a7Hgyet4S9vx/oSE3OjPwMbr5JICHMQeKVjHccEx4=;
 b=QF+BYTjFkrdToWMH8Br5cLKNnVTM9ruamgMMo4T6pqd+CrTjlGCKM7ai
 1WWeeFPl/wUmxOOKKduN+QW+Fm8+PpuZaTs8PKXegLfs8pTxPYaBm4q31
 9ZMzDkE+YQ+oba5t5gquC4MMvHeV3VLX/KQEkMguTlN0N4buZwq9swGfd
 pipsgQe3SsZ5NPTHMBHpYVr/I6ssgMxbo2L7lsKpSzLecUBFDv8HqkBLo
 A3AHT/F/Q3v3OYGVFuaREZIFA3MixOkTnt9EeXeCbb9rmwt/5Xt/jbVEu
 asg5RQQ4z3deI+3oS4grWTFrwqJi2AWrlvoD8nZiEFGPgb3UfQfhkpKQM Q==;
X-CSE-ConnectionGUID: AaT2B1OCTSiHwdp3QPAiUA==
X-CSE-MsgGUID: 5D4dReu2SDWOQb7W9WDDNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646305"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646305"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:06 -0700
X-CSE-ConnectionGUID: mUhMpMgWT7qzZi4cmYIBMg==
X-CSE-MsgGUID: 5KO54ZeqQbOenVEuLUW/0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294647"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:05 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 4/7] net/iavf: fix flow subscription metadata leaks
Date: Wed, 14 Oct 2026 16:18:47 +0100
Message-ID: <3a37fde0f842c44def508105eedb3aebedef2c8e.1791991100.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791991100.git.anatoly.burakov@intel.com>
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

Flow subscription parsing allocates metadata for create and validate.
The create callback leaks it when rule allocation or subscription fails,
and the validate callback never frees it.

Release the metadata on both create failure paths and after validation.

Fixes: 7b902af49947 ("net/iavf: support flow subscription rule")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 4b2e40af3c0..8afbb698141 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -81,7 +81,7 @@ iavf_fsub_create(struct iavf_adapter *ad, struct rte_flow *flow,
 		rte_flow_error_set(error, ENOMEM,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				"Failed to allocate memory for fsub rule");
-		return -rte_errno;
+		goto free_entry;
 	}
 
 	ret = iavf_flow_sub(ad, filter);
@@ -99,6 +99,7 @@ iavf_fsub_create(struct iavf_adapter *ad, struct rte_flow *flow,
 	return ret;
 
 free_entry:
+	rte_free(meta);
 	rte_free(rule);
 	return -rte_errno;
 }
@@ -133,6 +134,7 @@ iavf_fsub_validation(struct iavf_adapter *ad,
 	int ret;
 
 	ret = iavf_flow_sub_check(ad, filter);
+	rte_free(filter);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-- 
2.52.0

