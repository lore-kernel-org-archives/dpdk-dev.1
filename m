Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0AEF4644A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77E5440A7F;
	Mon, 16 Mar 2026 11:53:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9A01540651
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658395; x=1805194395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RiJ2eOeKWlGsYyUtMflUtD3XPKtC83XLIPf2i96wDxQ=;
 b=Zi8RcSQZUnurKH2iJcAqtFTuMrY6VSLjwHfPkaTE5cZvq05imqDGU9mG
 DCf2BHkiXEDUs7kew+oSyPXUCgq/qCUCT1cw4CloBqPhMlgdy/eNqRazK
 VVdcM1AJDLxxBnHtvzbnXE6eLrhmN7sPevsUVT9TOUV9HA4ax6b5vdfST
 XwEzzCoA4p1YFXf2xkrO47kXVZACB5jf/Gbh8ma+6DPg66UkkWWIDPUiY
 mC4colMUlMib0flOtJhQd/7WC5Y/B7Wub+DbfyaRQd+szaptXhyHZmbhq
 5aa/NB1de0oF17hGaD2Q4OhFJlIgb7VaeAGipvc0WP8v17htnm/Smqzd+ w==;
X-CSE-ConnectionGUID: ljFEdViNQ/uUJeMa4oL0aA==
X-CSE-MsgGUID: iT0XGuv6SBCoF5c+GduP8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237433"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:14 -0700
X-CSE-ConnectionGUID: xDG+g0FQQsG+eDL3/YElfQ==
X-CSE-MsgGUID: JWs8IIIzS4eVeuuvC/CRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826773"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 16/25] net/iavf: use common action checks for IPsec
Date: Mon, 16 Mar 2026 10:52:41 +0000
Message-ID: <99926b622a9e4021c88cf0034b8359c2cd0025e2.1773658290.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773658289.git.anatoly.burakov@intel.com>
 <cover.1773658289.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 34 +++++++++-------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index fd35997cbd..6466d84cfb 100644
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
@@ -1956,6 +1939,14 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
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
 
@@ -1963,12 +1954,15 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
+	if (ci_flow_check_actions(actions, &param, &parsed_actions, error) < 0)
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

