Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58A9EB4917
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68C24065E;
	Thu, 12 Feb 2026 13:53:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 39A3740613
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900826; x=1802436826;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=g+tsIRk+fUskuDbWQcjvpk4WSUkhddK+/jXHjrRj6WY=;
 b=eixSyqXaQJhw03WCbGyPtXQ+vsi4cQecSDWFz3VnOwoZcvjIXqhYdx4W
 DHXNRMYCAtLR6uKDIgoa+ViR7OesQqXjU35yDavQZtqagv5RIGv5zWJel
 oiae2ClJui19dA8Goq4Ti7DTr+2keNCSBoYLI359hEMVxEi3CiwPAfzMZ
 B9i3gUhtYPXXJ5tc50WumUMh6uzGXLZ2XOIAzFZOUe6Tdbzp3ZegVTDQP
 eoC+iQOvFB11lepZtSpmfI0WOQ2dkRVIM6PccEJShhxeCZid0Zb8YLxIN
 7eLdSyyFp3dMYQNJLzdeGQyecMMbPn0nelHJ/rZ2AQg98HOkB5IZdrPxD A==;
X-CSE-ConnectionGUID: VxNzmMQ6S2erCLWsyPXY1w==
X-CSE-MsgGUID: ngYb2P0YTfGL9O1bLwb4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785483"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785483"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:45 -0800
X-CSE-ConnectionGUID: SAWnxpIPTMmWQmB1pxCIzQ==
X-CSE-MsgGUID: hZxOPhAdQSGH/PMBGl6DXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179115"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:43 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
Date: Thu, 12 Feb 2026 12:53:25 +0000
Message-ID: <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
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

