Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21FE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E166C40648;
	Wed, 11 Feb 2026 14:49:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 42C464026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817779; x=1802353779;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o6JqKM4AAQ5duugMct6DYXwEb0qxr341xsPCQOgNbxk=;
 b=Zye8opw3JgNvTtqjlvDmxQUdKE9TfGMgepUXZO9h1KTSC0eAq2qvojMF
 uMwZbirl6NVNbY7urOJDvXa/jO1DIoNr/m5Kb1YhCfRCp5Vl3UAzQX6/L
 X7GqnC5XSRS05VtfDrejleyx1RDlf+Fu7fcRYpXmND26ZJsFvLySRZrzf
 uH2M453KrfQM9Y1oEGkSinCkRAlJaZEgwAMuyTWqWtqgKvE26QODLJiGl
 5s1dGT3umVhTdEqjYM95yabQ8ub9TBhp4H+ZSFaQNoZk/x5JTa7fNspNy
 BR6oogElajK8956IMVaz5BSbwLTdBHEoKmbScXm11o6O8CNjw5s/sD/zb Q==;
X-CSE-ConnectionGUID: ZQw5Qd6fRraGqrs2bJlfHA==
X-CSE-MsgGUID: oXiIGldhQh2OSLv1HA9Nww==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332511"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:31 -0800
X-CSE-ConnectionGUID: TyHqWsH2TiuJA1wciFYJLQ==
X-CSE-MsgGUID: g/CIhO0DQSympQx71r8mnA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:30 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v4 2/9] net/ixgbe: fix memory leak in security flows
Date: Wed, 11 Feb 2026 13:49:09 +0000
Message-ID: <27473234ede7bb1551ad61cd69e3ed34f120fed7.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
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

Currently, security flows are implemented as a special case and do not go
through the normal flow create/destroy infrastructure. However, because of
that, it is impossible to destroy such flows once created. Fix it by adding
a flag to rte_flow indicating that it is a security flow, so that it can be
destroyed later.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 ++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5393c81363..5dbd659941 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -359,6 +359,8 @@ struct ixgbe_l2_tn_info {
 
 struct rte_flow {
 	enum rte_filter_type filter_type;
+	/* security flows are not rte_filter_type */
+	bool is_security;
 	void *rule;
 };
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 27d2ba1132..066a69eb12 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3062,8 +3062,10 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 
 #ifdef RTE_LIB_SECURITY
 	/* ESP flow not really a flow*/
-	if (ntuple_filter.proto == IPPROTO_ESP)
+	if (ntuple_filter.proto == IPPROTO_ESP) {
+		flow->is_security = true;
 		return flow;
+	}
 #endif
 
 	if (!ret) {
@@ -3350,6 +3352,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
+	/* Special case for SECURITY flows */
+	if (flow->is_security) {
+		ret = 0;
+		goto free;
+	}
+
 	switch (filter_type) {
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
@@ -3442,6 +3450,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		return ret;
 	}
 
+free:
 	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
 		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
 			TAILQ_REMOVE(&ixgbe_flow_list,
-- 
2.47.3

