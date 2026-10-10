Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9ECA6004
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DEB64027F;
	Sat, 10 Oct 2026 14:11:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E2A054026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 14:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791634281; x=1823170281;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HM4PiOK/pvywe0VckLAj24Eu93aIDfize29yAq61X6s=;
 b=lb14KN2RMBFUMW/5yCHf647Eg6AsgNdA9dPeS1/bHy2a59gM4syg/FJE
 D4leycWKRyCLU1ixkMM3LbvqoXmVtXV9NqXjmbCyOJWgYv8Q5a822m22n
 RLT5Gqc+Vt1ZUYyDAbw5yGZ/o2rVT1TI1rXTRDjBztNiEgYCYU3I6O/uN
 TeWbo9MsNq4b4x/F76tGeJ2tk68xGxSF7Y0VVYu3P/22lnceMutyHwjQZ
 B+e9XI5NnUQHku+38jJVXfgpfWnmzu4cGg2DOgNmISq5g8MKGDoAWO9iV
 +gvpsdKfAqwkteXsfYqoP6DJ/Q0UQvSsc/Rfyyva6jOlFEWsIrFvkT7sY Q==;
X-CSE-ConnectionGUID: bBMnJhGqR6iSH6brclhBFQ==
X-CSE-MsgGUID: zO/pNi4lTOGQ61yO8L5GeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="297806"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="297806"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 05:11:19 -0700
X-CSE-ConnectionGUID: fSfa4IH+RS+dTWGTtr0DKA==
X-CSE-MsgGUID: +6N5zJtHT4WpUk68CwVQ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="507758"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 10 Oct 2026 05:11:18 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/iavf: fix memory leaks in RSS flow engine
Date: Sat, 10 Oct 2026 12:12:55 +0000
Message-Id: <20261010121255.528329-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

This patch addresses several memory leaks and
incorrect error reporting that exist in the
iavf RSS (hash) flow engine:

- iavf_hash_parse_raw_pattern() returns without
  freeing "pkt_buf" when the "msk_buf" allocation
  fails, leaking the first buffer on every failed
  raw pattern parse.

- iavf_hash_create() only frees the parsed "meta"
  on success.
  Both error paths return early and leak the struct
  iavf_rss_meta allocated by iavf_hash_parse_pattern_action(),
  which no other caller frees.
  Free in both error paths.

- iavf_hash_destroy() never releases flow->rule.
  The virtchnl_rss_cfg allocated by iavf_hash_create() is only
  released by the engine's free callback, iavf_hash_free(),
  which is invoked from iavf_flow_uninit() but not from
  iavf_flow_destroy().
  So every flow destroy or flush of an RSS rule leaks it.
  The early return taken while the VF is resetting leaks it too.
  Free the config and clear flow->rule properly in all paths.

- Out of memory conditions are reported to the application as
  EINVAL while -ENOMEM is returned.
  Report ENOMEM instead.

Fixes: bc0e85586eaf ("net/iavf: support VF RSS flow rule with raw pattern")
Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
Fixes: c02ea7410e51 ("net/iavf: fix flow flush after PF reset")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_hash.c | 33 ++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 9515094402..00b616f34b 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -918,8 +918,10 @@ iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 		return -ENOMEM;
 
 	msk_buf = rte_zmalloc(NULL, pkt_len, 0);
-	if (!msk_buf)
+	if (!msk_buf) {
+		rte_free(pkt_buf);
 		return -ENOMEM;
+	}
 
 	/* convert string to int array */
 	for (i = 0, j = 0; i < spec_len; i += 2, j++) {
@@ -1538,7 +1540,7 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
-		rte_flow_error_set(error, EINVAL,
+		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "No memory for rss_meta_ptr");
 		return -ENOMEM;
@@ -1594,9 +1596,10 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 	rss_cfg = rte_zmalloc("iavf rss rule",
 			      sizeof(struct virtchnl_rss_cfg), 0);
 	if (!rss_cfg) {
-		rte_flow_error_set(error, EINVAL,
+		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "No memory for rss rule");
+		rte_free(meta);
 		return -ENOMEM;
 	}
 
@@ -1612,6 +1615,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Failed to add rss rule.");
 		rte_free(rss_cfg);
+		rte_free(meta);
 		return -rte_errno;
 	}
 
@@ -1629,19 +1633,22 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
 	struct virtchnl_rss_cfg *rss_cfg;
 	int ret = 0;
 
-	if (vf->vf_reset)
-		return 0;
-
 	rss_cfg = (struct virtchnl_rss_cfg *)flow->rule;
 
-	ret = iavf_add_del_rss_cfg(ad, rss_cfg, false);
-	if (ret) {
-		PMD_DRV_LOG(ERR, "fail to del RSS configure");
-		rte_flow_error_set(error, -ret,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to delete rss rule.");
-		return -rte_errno;
+	if (!vf->vf_reset) {
+		ret = iavf_add_del_rss_cfg(ad, rss_cfg, false);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "fail to del RSS configure");
+			rte_flow_error_set(error, -ret,
+					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					   "Failed to delete rss rule.");
+			return -rte_errno;
+		}
 	}
+
+	flow->rule = NULL;
+	rte_free(rss_cfg);
+
 	return ret;
 }
 
-- 
2.34.1

