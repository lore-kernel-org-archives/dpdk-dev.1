Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6DCD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D1E40289;
	Wed, 17 Jun 2026 12:40:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B60084027A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781692830; x=1813228830;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KICULBLzr0VJVdbIAFrvVMrtnaYJf63FdHSIb6q1oaI=;
 b=h0H4MoWc43U+8KUubIIhcCmKLfgFju04K5y5sMx+yrzt1pZfUO8HJNmu
 rHNaiCysFtoIyrPe8V2fuzCyh1/xH41svvgfQPdxO9akN0P+b4yoFKhq/
 B2p3FSd/8n8p5HGDLmuScosJ1N7XUon0osyTBWH/l8/Y2hA4ZPkGwa/zZ
 m5R0PQmq4Lkl1WUg/sq9VCjLfQGL+9lx1Ld0H9jNXJ93hyJXnhCFKPTNz
 pbZI6t293pIUanu/cv40VAP4uQZ66zZQ/Ysldo6+OPtnP28CA0Ugtn8GE
 pUAMFKHFb3ik5OFWz7DRHQlCMGrSa4uaYCSuBabIge7kEOPL+Y4F0TMfP Q==;
X-CSE-ConnectionGUID: BSKRSqlkRe+YsYe9ARuNyA==
X-CSE-MsgGUID: 6fvupElURPegTpdmV4JUnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93146599"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93146599"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:40:29 -0700
X-CSE-ConnectionGUID: bJWMkmOjQbyjeRDo8e+6Zw==
X-CSE-MsgGUID: NyjsSrn/REu1nmzB/oYkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="286146772"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 17 Jun 2026 03:40:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/1] net/i40e: do not reject RSS types parameter
Date: Wed, 17 Jun 2026 11:40:26 +0100
Message-ID: <7f6f11fb07bc550784335123af6a270cd514f7d7.1781692817.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

After the recent refactor, global RSS configuration started rejecting the
RSS types parameter because it was not used for anything.

However, because testpmd will specify RSS types by default if omitted from
the flow command (i.e. `actions rss queues 0 1 end` vs `actions rss queues
0 1 end types end`), RSS action based flows that are created without
mentioning RSS types will still have RSS types as non-zero, causing flow
creation failures not directly related to the pattern.

Fix it by printing a warning but allowing spurious RSS types as opposed to
rejecting it outright.

Fixes: 0185303c2e24 ("net/i40e: refactor RSS flow parameter checks")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_hash.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 8b80d0a91c..5a6543a9ec 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -1089,12 +1089,18 @@ i40e_hash_validate_rss_common(const struct rte_flow_action_rss *rss_act,
 				"Symmetric hash function not supported without specific patterns");
 	}
 
-	/* hash types are not supported for global RSS configuration */
-	if (rss_act->types != 0) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
-				"RSS types not supported without a pattern");
-	}
+	/*
+	 * When RSS types is not specified in testpmd, it will set up a default
+	 * RSS types value for the flow. Even though no hash engine part calling
+	 * this particular function will use RSS types parameter for anything,
+	 * we cannot reject having it because it is extra effort for testpmd
+	 * user to avoid specifying it.
+	 *
+	 * So, instead, accept types value even though we are not using it for
+	 * anything, but produce a warning for the user.
+	 */
+	if (rss_act->types != 0)
+		PMD_DRV_LOG(WARNING, "RSS types specified but will not be used");
 
 	/* check RSS key length if it is specified */
 	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
-- 
2.47.3

