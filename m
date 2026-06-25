Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D85CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A646D40A6C;
	Thu, 25 Jun 2026 17:48:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E725F40616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782402497; x=1813938497;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mLhcFgcX6M77BvKBjK49vyY/+7PkghaRN3nDpA1RYps=;
 b=lvTK+nrTHyvqurSNlRKZNSaH5X69vwwgrkXOTCoc82Crm8aTsS5+OnZa
 dXu5PYSdSank2RYyERt3KkRanWBF/rJuMr6nPq18SuloA1DgEW7EIb2PW
 r16KzDv2xOw7+E42Uy1KQDtfPm5GH66GS85eUwyrTsCP/uKwYYt6Aw8Fi
 53h/swQls0iWuA5n3vcIHO8N/3hE8cKWY6g3RutKuBj2mYgfyej5KZ/hv
 ajZcazeUAwi0c1+1Rp5FnfnVQC1zVQCEYuq4M4xkOvWCXG1KXNT7p+zTk
 XkMzfk1r5nvRSkIexWj1tYhz9U7FD7aXriCBwEgrselYJCS602NcyErr6 w==;
X-CSE-ConnectionGUID: tEPMg8qBQ/O7pmbGw3izMQ==
X-CSE-MsgGUID: I5aZbqJtSneRI+r9+l4nCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83279876"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83279876"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:48:16 -0700
X-CSE-ConnectionGUID: GQpgaPKpSsedLbwhE58Dig==
X-CSE-MsgGUID: RT3QT/8/QPOgxWckAEnw+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="247570997"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2026 08:48:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/4] net/ice: fix potential NULL dereference
Date: Thu, 25 Jun 2026 16:48:10 +0100
Message-ID: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
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

Static analysis reports that a rule might have a valid engine but invalid
rule pointer while having a valid rule size. This should not happen in
normal operation, but it's a good defensive check, so fix the potential
issue by checking for the problematic condition before dumping flow memory.

Coverity issue: 503774

Fixes: 215a768c180a ("net/ice: support flow dump")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_generic_flow.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index cbc3d78079..04097cca76 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2660,15 +2660,18 @@ ice_flow_dev_dump(struct rte_eth_dev *dev,
 		if (flow != NULL && p_flow != flow)
 			continue;
 
+		/* this should not happen */
+		if (p_flow->engine == NULL || p_flow->rule == NULL) {
+			PMD_DRV_LOG(DEBUG, "Invalid flow");
+			continue;
+		}
+
 		found = true;
-		if (p_flow->engine != NULL) {
-			rule_size = p_flow->engine->rule_size;
-			if (p_flow->rule != NULL)
-				rule_data = p_flow->rule;
-		}
 
-		if (p_flow->engine != NULL)
-			ice_flow_dump_blob(file,
+		rule_size = p_flow->engine->rule_size;
+		rule_data = p_flow->rule;
+
+		ice_flow_dump_blob(file,
 				p_flow->engine->name != NULL ?
 				p_flow->engine->name : "unknown",
 				rule_data, rule_size);
-- 
2.47.3

