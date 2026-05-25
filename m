Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFECD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 194D040B9B;
	Mon, 25 May 2026 16:07:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id AD6DA4067A
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718036; x=1811254036;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jdRo9ymSuhJMNcb3xKa70WGmaiVYcTo9eTJxUg/Frdo=;
 b=CdlOTL9HMd6xxr5BN0uUoduLX7zuV5B2UvOZOVjEv8wkGbXVt4ebrKfK
 09yIvAsd3hReX6tH4ZwxzRv12zwxFKC8Ig51lY9NGqcJI9i7uhZI1WZQI
 tIim/8iltW31B/MmukHkl/eLU5/Fyfp3Cm5Y+mUHDMOGkTIFKIF2ZB82R
 7Maz4aIr9v81JdnfSF7Hl97LkxNYGCFIR9zR9eB1/LflOSR8X5DzQoYZp
 HRQeS33O0b3+JSdpJdp83cOSv1zmcTUSu4w3OqE7kWWbbSLtbR9l2VSGv
 oY2fGmcXPk2hxnJS4st/Vok2VEIQAYyZrj6K/Qx1tlhAD+a1+BmWU+vMk g==;
X-CSE-ConnectionGUID: N7DDPKz8Sb6lo5L4o/Uwvw==
X-CSE-MsgGUID: yPorERgdRGqgPrV9fyElpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392522"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392522"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:15 -0700
X-CSE-ConnectionGUID: h3lqjvfURKWr++OAa/pIXA==
X-CSE-MsgGUID: dc5mDtHXTNyz52JmbmUT/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692389"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 18/27] net/iavf: use common action checks for IPsec
Date: Mon, 25 May 2026 15:06:37 +0100
Message-ID: <da785551f02d86904fa6589420060f9a29f50263.1779717944.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for IPsec filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 35 ++++++++++------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index be9e297486..b2e08da0aa 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1745,26 +1745,12 @@ parse_udp_item(const struct rte_flow_item_udp *item, struct rte_udp_hdr *udp)
 	udp->src_port = item->hdr.src_port;
 }
 
-static int
-has_security_action(const struct rte_flow_action actions[],
-	const void **session)
-{
-	/* only {SECURITY; END} supported */
-	if (actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY &&
-		actions[1].type == RTE_FLOW_ACTION_TYPE_END) {
-		*session = actions[0].conf;
-		return true;
-	}
-	return false;
-}
-
 static struct iavf_ipsec_flow_item *
 iavf_ipsec_flow_item_parse(struct rte_eth_dev *ethdev,
 		const struct rte_flow_item pattern[],
-		const struct rte_flow_action actions[],
+		const struct rte_security_session *session,
 		uint32_t type)
 {
-	const void *session;
 	struct iavf_ipsec_flow_item
 		*ipsec_flow = rte_malloc("security-flow-rule",
 		sizeof(struct iavf_ipsec_flow_item), 0);
@@ -1831,9 +1817,6 @@ iavf_ipsec_flow_item_parse(struct rte_eth_dev *ethdev,
 		goto flow_cleanup;
 	}
 
-	if (!has_security_action(actions, &session))
-		goto flow_cleanup;
-
 	if (!iavf_ipsec_crypto_action_valid(ethdev, session,
 			ipsec_flow->spi))
 		goto flow_cleanup;
@@ -1958,6 +1941,14 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		      void **meta,
 		      struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_SECURITY,
+			RTE_FLOW_ACTION_TYPE_END,
+		},
+		.max_actions = 1,
+	};
 	struct iavf_pattern_match_item *item = NULL;
 	int ret = -1;
 
@@ -1965,12 +1956,16 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret < 0)
+		return ret;
+
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
 	if (item && item->meta) {
+		const struct rte_security_session *session = parsed_actions.actions[0]->conf;
 		uint32_t type = (uint64_t)(item->meta);
 		struct iavf_ipsec_flow_item *fi =
-				iavf_ipsec_flow_item_parse(ad->vf.eth_dev,
-						pattern, actions, type);
+				iavf_ipsec_flow_item_parse(ad->vf.eth_dev, pattern, session, type);
 		if (fi && meta) {
 			*meta = fi;
 			ret = 0;
-- 
2.47.3

