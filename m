Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB8EEDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C73734064F;
	Fri, 13 Feb 2026 10:10:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5C37B4042F
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973825; x=1802509825;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EWRJvXN3qd/Gl/oPMKifk8SPzaIV923uAGiipYuVSHU=;
 b=O68OfznvUeC16xa+LmLE6bC2gQmb2Z3wJGHmtzruU8NZ1NSC+wvBkwGK
 W5x1VazkN1x4dsSuEkTLKQWvhd2beilJgdguf/0nXxaYUdHwqkT/4uVXe
 gLPj9m0Moml5aIgV3n61KQaXqGPrXTvmenYCC9VXTutWETahOXLzlA2Kl
 LNf5Z8u5Odv3JTum3CgzY2+dsrop1XIHcQXzUUTKl/9otGNvzG/Gd87Nl
 MfuX5yzfU6SB3lyfGD1LuwSrH4sgTGzPjB3dtyM6xSWXOF8ahXaifIPOK
 7vnwNIsB+o9OuoyhIbNwdlgnX7ZATVeREvP7kogAByqZijM9dGJ6Ctp6B Q==;
X-CSE-ConnectionGUID: wMKzo6X/Qq+KwUEOgSgI5A==
X-CSE-MsgGUID: scGFkSitSBSC6toizEMhMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567853"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567853"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:24 -0800
X-CSE-ConnectionGUID: YCeqvHe+RSiO34ose8cEyA==
X-CSE-MsgGUID: tx3KSD9HTDGt4Y8ahMscgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966048"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v6 02/12] net/ixgbe: fix memory leak in security flows
Date: Fri, 13 Feb 2026 09:10:04 +0000
Message-ID: <17f72f1ca2363a9e87b0c8ec976e21909320a328.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

Additionally, security flows return pointer to allocated `rte_flow` struct
unconditionally, even though the underlying call to ipsec code might have
failed. Fix that by checking the return value from the filter function
before returning.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 ++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
index 27d2ba1132..90072e757e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3062,8 +3062,12 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 
 #ifdef RTE_LIB_SECURITY
 	/* ESP flow not really a flow*/
-	if (ntuple_filter.proto == IPPROTO_ESP)
+	if (ntuple_filter.proto == IPPROTO_ESP) {
+		if (ret != 0)
+			goto out;
+		flow->is_security = true;
 		return flow;
+	}
 #endif
 
 	if (!ret) {
@@ -3350,6 +3354,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
@@ -3442,6 +3452,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		return ret;
 	}
 
+free:
 	TAILQ_FOREACH(ixgbe_flow_mem_ptr, &ixgbe_flow_list, entries) {
 		if (ixgbe_flow_mem_ptr->flow == pmd_flow) {
 			TAILQ_REMOVE(&ixgbe_flow_list,
-- 
2.47.3

