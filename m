Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B4E9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9798C40B9E;
	Wed, 11 Feb 2026 15:21:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AC52440B9E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819682; x=1802355682;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mHC7jY2iAtAFrsPGzElY6RHAH3LChGkz7yvzp01tWyE=;
 b=TtQpWFC8zax34MZxrrPrKhxUDcbjxcTro9WxZZviBp3wf1xmDGwZnJy7
 zXPOYPJH4Eb8GclXL3fpQ7mm9eLMWllbaRchitd82TF9G6y8W0LB/gx4g
 4gPM2H9VtTcMz2mIaHg7tBTIvtlHArcsMPSVU+x7rs4n2svl89YUZwhVY
 mmrBnxtevt8/uarJeRG1pOHSaOXraLg6/7zJWYZNtiLfuIi9b/HPTD6qI
 d5nSSyASgNnuEV9g6fW27bjOp2880QuLJMtAdZuazALUtIsNJ3sNMaUhQ
 6pIgLy6SF7f3qujKuE+DnLNxKjbk1s9xwCYY/luPwLQhMu3xnUqLi4KQK A==;
X-CSE-ConnectionGUID: T3qDbUBNQhS0zUEDQPTs0g==
X-CSE-MsgGUID: SFBGngmlS+esZ+n6euSoPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866773"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866773"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:20 -0800
X-CSE-ConnectionGUID: DwvS7Cy0SSqt6TzSAuN1Dg==
X-CSE-MsgGUID: kprS1h+JRzuKtMWtyiZwyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569198"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 16/25] net/iavf: use common action checks for IPsec
Date: Wed, 11 Feb 2026 14:20:33 +0000
Message-ID: <d965c32bce90f8b8fad122cc43a4aff953e7ff2d.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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
index 5c47b3ac4b..8a14216716 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1677,26 +1677,12 @@ parse_udp_item(const struct rte_flow_item_udp *item, struct rte_udp_hdr *udp)
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
@@ -1763,9 +1749,6 @@ iavf_ipsec_flow_item_parse(struct rte_eth_dev *ethdev,
 		goto flow_cleanup;
 	}
 
-	if (!has_security_action(actions, &session))
-		goto flow_cleanup;
-
 	if (!iavf_ipsec_crypto_action_valid(ethdev, session,
 			ipsec_flow->spi))
 		goto flow_cleanup;
@@ -1888,6 +1871,14 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
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
 
@@ -1895,12 +1886,15 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
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

