Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244CFCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC36540B9C;
	Thu, 25 Jun 2026 17:48:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A61A54068A
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782402499; x=1813938499;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=N3f5LxnEQ5oa2FyJbzEoLhJAOBqf2lyqSEaSryqNZlo=;
 b=cjgz5KGv1PU9Jbd44jsg5kCw6TrGhMW6BuDky3gbg2KNYXyos2UTddTg
 2gcfrjrl6xpWGSmKUIeejlg87kpDa6NDx7bK8fVpn1Fz3Ulf32qooDBRd
 +tiXlry+/yz0pnngR3lp/YUQzhmCwe/NmJPeGpx9S4PPen0LvwsUR/Kos
 eVXw7Dft0m+XJyzWpWW5z+7FPSO0lcTwZwPdo68KJ4HruY9lW2DikE8+s
 Y9fm3kFRGm1lFCvXaoqvgzd8iGj8hz06IGcTrALU37IlCZpLxsoqe298j
 eAxl8ImnmWXPFuoYZqkBRrLEIQAk1qIz1Vg4RYJ/gyVbnglox7EeqJAmD w==;
X-CSE-ConnectionGUID: gE0+cyhpSiqD04lopVLLmg==
X-CSE-MsgGUID: 0InT5fYxTQqgO/iDiAhQAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83279879"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83279879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:48:18 -0700
X-CSE-ConnectionGUID: 9MPWdjm0Qru0zJCaSWxwEA==
X-CSE-MsgGUID: +F9SQv+OS5uCv9IbNeIXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="247571025"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2026 08:48:17 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 3/4] net/i40e: fix potential NULL dereference
Date: Thu, 25 Jun 2026 16:48:12 +0100
Message-ID: <6dc186c05567cdbfd0c993c6001400151e168feb.1782402484.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
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

Static analysis reports that a rule dump may trigger NULL dereference when
rule pointer is NULL. This should not happen under normal circumstances as
0 sized rule would not dereference the rule data pointer due to chunking,
but it's a good defensive check, so add it.

Coverity issue: 503771

Fixes: ffaddd0fa935 ("net/i40e: support flow dump")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 1051c99fba..142cfb5150 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1276,11 +1276,19 @@ i40e_flow_dev_dump(struct rte_eth_dev *dev,
 		if (flow != NULL && p_flow != flow)
 			continue;
 
+		/* should not happen */
+		if (p_flow->rule == NULL) {
+			PMD_DRV_LOG(DEBUG, "Invalid flow rule");
+			continue;
+		}
+
+		rule_size = i40e_flow_rule_size(p_flow->filter_type);
+		/* should not happen either */
+		if (rule_size == 0)
+			continue;
+
 		found = true;
-		if (p_flow->rule != NULL) {
-			rule_size = i40e_flow_rule_size(p_flow->filter_type);
-			rule_data = p_flow->rule;
-		}
+		rule_data = p_flow->rule;
 		i40e_flow_dump_blob(file,
 			i40e_flow_rule_name(p_flow->filter_type),
 			rule_data, rule_size);
-- 
2.47.3

