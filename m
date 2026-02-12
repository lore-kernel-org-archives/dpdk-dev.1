Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D894EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5597F40689;
	Thu, 12 Feb 2026 13:53:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C371B40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900831; x=1802436831;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=P+Lwh9kGN14Ct9KB1Nk6T5ileoyCefNf5oYCMxCoSDA=;
 b=mdZVrV2qw+I7y2vPL1bbpmERzzdSz467e32LD0KFx73aIxn7ywmCeE7l
 5dV4YsIG6dCvAYG+b0LajIruLwSii6ePhfPDY2mM4s2gZnrs4VoIccbtn
 aEhmZNoeD05lNi5NdcbgFcDgBmhhlAgT/zV1zrTr2XfG4zzuEKbtwLU8F
 r2XKhx2I9jkfGGU9KeLwOLRQD+HKrwnIl/oFYnUwF72d7iXTIq9wuXux4
 ARhSb9NPROMKNu3a8Fp1xNfgsECwLPZf/xw11yukZwEfTJD2Rr05zBMym
 A/P778TXshFNG5/6qidMAIO08cV8o//TNYbkAbsXAEZmgP6kUX7FLHy7c g==;
X-CSE-ConnectionGUID: mYWPmwRuRMKd+QmNTF0emA==
X-CSE-MsgGUID: aK8tZOkqR7avEBidwEI/GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785489"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:51 -0800
X-CSE-ConnectionGUID: OTMt2hWXTkK5wg/1maLfsg==
X-CSE-MsgGUID: 8B8aN3LIRFaxOw8Y+szWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179154"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v5 06/12] net/i40e: move FDIR config to flow create
Date: Thu, 12 Feb 2026 12:53:29 +0000
Message-ID: <64574a5889cb36c831f959e7cbe167e31547ef3f.1770900758.git.anatoly.burakov@intel.com>
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

Currently, FDIR filter parsing function will modify FDIR state after a
successful match. However, this function is called from both flow create
and flow validate, which results in the driver modifying FDIR state after
a flow validate call. Move the FDIR config to flow create.

Fixes: 2e67a7fbf3ff ("net/i40e: config flow director automatically")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 51 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index f130f53ae0..193b1b6725 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2551,9 +2551,7 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 			    struct rte_flow_error *error,
 			    union i40e_filter_t *filter)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_fdir_filter_conf *fdir_filter =
-		&filter->fdir_filter;
+	struct i40e_fdir_filter_conf *fdir_filter = &filter->fdir_filter;
 	int ret;
 
 	ret = i40e_flow_parse_fdir_pattern(dev, pattern, error, fdir_filter);
@@ -2570,32 +2568,7 @@ i40e_flow_parse_fdir_filter(struct rte_eth_dev *dev,
 
 	cons_filter_type = RTE_ETH_FILTER_FDIR;
 
-	if (pf->fdir.fdir_vsi == NULL) {
-		/* Enable fdir when fdir flow is added at first time. */
-		ret = i40e_fdir_setup(pf);
-		if (ret != I40E_SUCCESS) {
-			rte_flow_error_set(error, ENOTSUP,
-					   RTE_FLOW_ERROR_TYPE_HANDLE,
-					   NULL, "Failed to setup fdir.");
-			return -rte_errno;
-		}
-		ret = i40e_fdir_configure(dev);
-		if (ret < 0) {
-			rte_flow_error_set(error, ENOTSUP,
-					   RTE_FLOW_ERROR_TYPE_HANDLE,
-					   NULL, "Failed to configure fdir.");
-			goto err;
-		}
-	}
-
-	/* If create the first fdir rule, enable fdir check for rx queues */
-	if (TAILQ_EMPTY(&pf->fdir.fdir_list))
-		i40e_fdir_rx_proc_enable(dev, 1);
-
 	return 0;
-err:
-	i40e_fdir_teardown(pf);
-	return -rte_errno;
 }
 
 /* Parse to get the action info of a tunnel filter
@@ -3921,6 +3894,28 @@ i40e_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 
 	if (cons_filter_type == RTE_ETH_FILTER_FDIR) {
+		/* if this is the first time we're creating an fdir flow */
+		if (pf->fdir.fdir_vsi == NULL) {
+			ret = i40e_fdir_setup(pf);
+			if (ret != I40E_SUCCESS) {
+				rte_flow_error_set(error, ENOTSUP,
+						RTE_FLOW_ERROR_TYPE_HANDLE,
+						NULL, "Failed to setup fdir.");
+				return NULL;
+			}
+			ret = i40e_fdir_configure(dev);
+			if (ret < 0) {
+				rte_flow_error_set(error, ENOTSUP,
+						RTE_FLOW_ERROR_TYPE_HANDLE,
+						NULL, "Failed to configure fdir.");
+				i40e_fdir_teardown(pf);
+				return NULL;
+			}
+		}
+		/* If create the first fdir rule, enable fdir check for rx queues */
+		if (TAILQ_EMPTY(&pf->fdir.fdir_list))
+			i40e_fdir_rx_proc_enable(dev, 1);
+
 		flow = i40e_fdir_entry_pool_get(fdir_info);
 		if (flow == NULL) {
 			rte_flow_error_set(error, ENOBUFS,
-- 
2.47.3

