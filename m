Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169A2EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B27D940661;
	Thu, 12 Feb 2026 13:53:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4536140652
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900827; x=1802436827;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rOyGDnw443EOyowVnefMau1SIfpADY8SyKU1wlUJfOk=;
 b=RZJzuF17l+myF2D50K264k92PXtulEh9+zWEJXA4HWRM4VLviHlmHzth
 /u2QW1gOyARpxVnLlPT2m2eu62lJ8MJlZF4UcaoRCitDIwMD6MGn29268
 XNhEhFla6FSOL6C8j4FF0G7zBTFrVc96Pf3IDRBCsPED/0kEKVegChs6a
 GTyTqcqK2nx8aDdKiBOV/2qxcbCw4+ommHfp4sXj7IdA2+tnv/lR2dZwA
 4zxxZyIESq0NxrLNgxHtp+ZuAgrnDAdcrTr6OG9bsXRADC6AqlGmzYCwL
 azhIj/PzndhWAbtNu5HE2ZJJMuzTU79XD4EI7O13mMc3g3UYNNRynGXZL g==;
X-CSE-ConnectionGUID: MfXa8L6oT5mz0QD8tme7CQ==
X-CSE-MsgGUID: XO/zK9UTRK+46nsdkym+9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785485"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:46 -0800
X-CSE-ConnectionGUID: jiu66rTAQay1BPQr7yTtNw==
X-CSE-MsgGUID: GCgwftz7TfKtommUn5Vjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179124"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v5 03/12] net/ixgbe: fix potential null dereference in IPsec
Date: Thu, 12 Feb 2026 12:53:26 +0000
Message-ID: <af139585d9da1c0211d9e4d7926260f83b216b3e.1770900758.git.anatoly.burakov@intel.com>
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

When parsing IPsec flows, we access the `conf` pointer unconditionally,
even though it might be NULL. Fix by adding the check.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 90072e757e..81b983ce69 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -221,6 +221,13 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	act = next_no_void_action(actions, NULL);
 	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
 		const void *conf = act->conf;
+
+		if (conf == NULL) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				act, "NULL security conf.");
+			return -rte_errno;
+		}
 		/* check if the next not void item is END */
 		act = next_no_void_action(actions, act);
 		if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-- 
2.47.3

