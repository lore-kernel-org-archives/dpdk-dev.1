Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A370C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA9BF402D4;
	Fri,  3 Jul 2026 10:33:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EF1B9402D1;
 Fri,  3 Jul 2026 10:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783067628; x=1814603628;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XwqbX4RqgmSU+SgSxf57qBLGN/LCpTJVot46qlCFTXo=;
 b=aVtttunEw7k7IT30aCLNQ0VMfgf9gljl3R4ADeWq1/DEYVk6HxIBiVme
 bgr2UvqLWfWer8L9qVRzjKkCEbMHAtcLm5eGxiwry9N8CAJv0AoPyh5e2
 N/LaVFco+vsOC73Ye9ng/W1BeKYz6xjCjiuGFFzxCnYbjvbbIkkzw5FFR
 fkWQW1WcXSa9Xs0EqtDKCYJhZgyl1r3G1w6vzwI2GR1I46Jb85AnJABqK
 rzzPwVQmDbt1TE4rVKph/hlX+Q+hv4w/1LjiiFoAjb+iN5JVwi1vzHCzo
 HQPQRZMXcQr46caReMU45UFZXqk1m0TjsLlwN5NyolHurxSTSy1y9EVPG g==;
X-CSE-ConnectionGUID: vS/JwNU1QUyOpzAEQDP3/g==
X-CSE-MsgGUID: a/qYNNaAStykXshIvWLXCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83595313"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="83595313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:33:46 -0700
X-CSE-ConnectionGUID: G2ED8tPWT4Gu0Dmk9+X12g==
X-CSE-MsgGUID: 8zya6WXrTd6AjdyLiQon0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="256950261"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 03 Jul 2026 01:33:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ting Xu <ting.xu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>
Subject: [PATCH 1/2] net/iavf: fix local memory leaks in TM hierarchy commit
Date: Fri,  3 Jul 2026 09:33:34 +0100
Message-ID: <20260703083335.4058936-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The iavf_hierachy_commit function uses a number of temporary variables,
which, though small, are still leaked at function end. Clean this up by
freeing them before the function returns. Since these are not variables
that need to be in hugepage memory, also switch from using rte_zmalloc
to calloc.

Fixes: 44d0a720a538 ("net/iavf: query QoS capabilities and set queue TC mapping")
Fixes: 5779a8894d15 ("net/iavf: support queue rate limit configuration")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_tm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index e3492ec491..cc5c86b4ce 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 #include <rte_tm_driver.h>
+#include <stdlib.h>
 
 #include "iavf.h"
 
@@ -795,8 +796,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct virtchnl_queue_tc_mapping *q_tc_mapping;
-	struct virtchnl_queues_bw_cfg *q_bw;
+	struct virtchnl_queue_tc_mapping *q_tc_mapping = NULL;
+	struct virtchnl_queues_bw_cfg *q_bw = NULL;
 	struct iavf_tm_node_list *queue_list = &vf->tm_conf.queue_list;
 	struct iavf_tm_node *tm_node;
 	struct iavf_qtc_map *qtc_map;
@@ -832,7 +833,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 
 	size = sizeof(*q_tc_mapping) + sizeof(q_tc_mapping->tc[0]) *
 		(vf->qos_cap->num_elem - 1);
-	q_tc_mapping = rte_zmalloc("q_tc", size, 0);
+	q_tc_mapping = calloc(1, size);
 	if (!q_tc_mapping) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -840,7 +841,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 
 	size_q = sizeof(*q_bw) + sizeof(q_bw->cfg[0]) *
 		(vf->num_queue_pairs - 1);
-	q_bw = rte_zmalloc("q_bw", size_q, 0);
+	q_bw = calloc(1, size_q);
 	if (!q_bw) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -889,8 +890,10 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	/* store the queue TC mapping info */
 	qtc_map = rte_zmalloc("qtc_map",
 		sizeof(struct iavf_qtc_map) * q_tc_mapping->num_tc, 0);
-	if (!qtc_map)
-		return IAVF_ERR_NO_MEMORY;
+	if (!qtc_map) {
+		ret_val = IAVF_ERR_NO_MEMORY;
+		goto fail_clear;
+	}
 
 	for (i = 0; i < q_tc_mapping->num_tc; i++) {
 		q_tc_mapping->tc[i].req.start_queue_id = index;
@@ -908,6 +911,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	vf->qtc_map = qtc_map;
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
+	free(q_bw);
+	free(q_tc_mapping);
 	return ret_val;
 
 fail_clear:
@@ -917,5 +922,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		iavf_tm_conf_init(dev);
 	}
 err:
+	free(q_bw);
+	free(q_tc_mapping);
 	return ret_val;
 }
-- 
2.53.0

