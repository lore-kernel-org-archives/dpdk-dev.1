Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206AEF44866
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65ED840B95;
	Fri, 10 Apr 2026 15:13:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 29AA340A76
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826834; x=1807362834;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=M9qrDOff2TLkB2fOz1CY/a5mZQ/4A9fXqjByF3hSZkg=;
 b=DSYm3t50GQNWXhpjTBfxLmqKye7Y5uB7ILaBrodA2dJIsi0IRHrESMpJ
 ozA04ws3/AmLY9VrQ64VKpESTbwM9y9tbLpEtY8bt/bBMHjrDm3y7M30x
 M4wwE2Kbxb1kINXhzk+OS0Cr7bmMpngBOPrvWPqNmCMRhoXng8DpKjehf
 3CR3iysh8HWr6EN6pgIOewarv4QPP939TEmdyjyP9933rznaxHFYHHZNt
 UFylbeOdNuvwZQ/JiDl0zaG0pjNAi19XrUJEimJkZX88gYkpIEXAvwprQ
 aNWUhkcjvDBjUL33ELghWvSNjonjCAn8b/fWLStqgaYCvuWU1q3SbCTHL g==;
X-CSE-ConnectionGUID: 2/jtd4ZBRWKDikEYfUNIxQ==
X-CSE-MsgGUID: fh8lQMteRCixg4HZla4r2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736356"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736356"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:53 -0700
X-CSE-ConnectionGUID: JxQKuq2eS9KxEaj7jagbKQ==
X-CSE-MsgGUID: K29RvjH3RjKfHSoYgcyf9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084690"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 20/29] net/iavf: use common action checks for IPsec
Date: Fri, 10 Apr 2026 14:13:14 +0100
Message-ID: <ce97c907587706b7e28a667735082dd0d0e8e93e.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
index fd35997cbd..f3a1f89468 100644
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
 
@@ -1963,12 +1954,16 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
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

