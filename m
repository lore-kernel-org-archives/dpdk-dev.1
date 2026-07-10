Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678FFC44501
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9844540611;
	Fri, 10 Jul 2026 12:34:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B3B01400D5;
 Fri, 10 Jul 2026 12:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679650; x=1815215650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hnBCaNXYWlF/1CDSmbhtIR23Z/OsfaMDPxKxBRSdMN4=;
 b=Nel4pib5dMppxk9sivQLpskDR9zUuyIcughMCoZVXPtsYJ5gDpvitBxh
 HwQc11b2vySMzZfxNDYEKkDXs4GabmL1i+GcbBIwdW/UdYwziqfIELpyz
 ZGILn2RM/Vg55NNk+ELqkkMPxP+02W28trlExjM3W7bqG6zktv1c4RfQU
 L+EOZ1fqzT1rh+350pFhyOmuTvzmESyAUq4d/LURNQzrm/MyQHzfkrBk3
 oNah+X9i9t5fhXf5EKhIM/Q8J0Fn+VrGufdvyQjHM0S8fufWEYwDKvrsz
 g/djet7EjwrgAbEKMEYA31SrHV0E0SnUl7riC6hO3HcM92/XD5Vi2RuDb Q==;
X-CSE-ConnectionGUID: +qc6hm+8QciWpWianjwWiQ==
X-CSE-MsgGUID: dhgbJrIvRUyD4Ioj4YR4sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428980"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428980"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:09 -0700
X-CSE-ConnectionGUID: 1Gz3RYcYTeigCmwbAj5CGA==
X-CSE-MsgGUID: 9hHZuL5tTPa3p5O9N5Cr6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163166"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 1/6] net/iavf: fix local memory leaks in TM hierarchy commit
Date: Fri, 10 Jul 2026 11:33:58 +0100
Message-ID: <20260710103403.1548864-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710103403.1548864-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260710103403.1548864-1-bruce.richardson@intel.com>
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
 drivers/net/intel/iavf/iavf_tm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index e3492ec491..5f888d654f 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2017 Intel Corporation
  */
+#include <stdlib.h>
+
 #include <rte_tm_driver.h>
 
 #include "iavf.h"
@@ -795,8 +797,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
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
@@ -832,7 +834,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 
 	size = sizeof(*q_tc_mapping) + sizeof(q_tc_mapping->tc[0]) *
 		(vf->qos_cap->num_elem - 1);
-	q_tc_mapping = rte_zmalloc("q_tc", size, 0);
+	q_tc_mapping = calloc(1, size);
 	if (!q_tc_mapping) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -840,7 +842,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 
 	size_q = sizeof(*q_bw) + sizeof(q_bw->cfg[0]) *
 		(vf->num_queue_pairs - 1);
-	q_bw = rte_zmalloc("q_bw", size_q, 0);
+	q_bw = calloc(1, size_q);
 	if (!q_bw) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -889,8 +891,10 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
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
@@ -908,6 +912,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	vf->qtc_map = qtc_map;
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
+	free(q_bw);
+	free(q_tc_mapping);
 	return ret_val;
 
 fail_clear:
@@ -917,5 +923,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		iavf_tm_conf_init(dev);
 	}
 err:
+	free(q_bw);
+	free(q_tc_mapping);
 	return ret_val;
 }
-- 
2.53.0

