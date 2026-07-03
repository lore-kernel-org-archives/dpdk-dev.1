Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D4C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DEE740687;
	Fri,  3 Jul 2026 10:33:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 95D08402D1;
 Fri,  3 Jul 2026 10:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783067633; x=1814603633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IMnJLTm7qTcAymIyRBBUZRqV77tB8g0fMbIiVlKI+io=;
 b=oFvZcHjNPtDQMSGDiUU2F0UYzIDqBZytH/kpsZL4mu8t4N+TI6eezQM3
 fFT1jndolP2dykaoJJ0DMdtgnLLAe2a+ltWJ9eQZnT2Cpo3m3BJGVjdTm
 brzEioFi3xQWR100Vopxvph6Oxx2W5z8fO+CLyU2E9czzuDeHK5FPgPRm
 643OOvUV8gWPfaqKqogI/cAyOFy4R1Kj5p7932tMGFDH1bmL4L82runjl
 2XtSx2h8eqD5jwDtwr6QlJU38ThGkywaPtS8w7XLdF+3VCx1jspLbrfnC
 YRwIa3Wne9Uci1gGHfi9u5pOSk5B6eKfD1wUXl3wgrlbs6KbWHX7GZXf0 w==;
X-CSE-ConnectionGUID: ugbB5br+Qo6M7QmmbevgRQ==
X-CSE-MsgGUID: tLgSJV/oR3SCPI8NjZG+Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83595332"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="83595332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 01:33:52 -0700
X-CSE-ConnectionGUID: tUUzxLr0QjmA99UVMibt7Q==
X-CSE-MsgGUID: Cl3gd7A7TyaefOEncwzlFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="256950302"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 03 Jul 2026 01:33:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ting Xu <ting.xu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH 2/2] net/iavf: fix leak of queue to traffic class mapping data
Date: Fri,  3 Jul 2026 09:33:35 +0100
Message-ID: <20260703083335.4058936-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703083335.4058936-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
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

On iavf TM hierarchy commit, the queue to traffic class mapping is
generated and stored in a pointer from the VF structure. However, that
data is never later freed. The data is also unnecessarily allocated from
hugepage memory.

Fix these issues by replacing rte_zmalloc with calloc, and then
appropriately freeing the memory at a) uninit of the device, b) at
failure of apply of the new settings and c) replacement of old data by
new.

Fixes: 3fd32df381f8 ("net/iavf: check Tx packet with correct UP and queue")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c |  2 ++
 drivers/net/intel/iavf/iavf_tm.c     | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 80e740ef29..1cd8c88384 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2755,6 +2755,8 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 
 	rte_free(vf->qos_cap);
 	vf->qos_cap = NULL;
+	free(vf->qtc_map);
+	vf->qtc_map = NULL;
 
 	rte_free(vf->rss_lut);
 	vf->rss_lut = NULL;
diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index cc5c86b4ce..0f39da232d 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -96,6 +96,9 @@ iavf_tm_conf_uninit(struct rte_eth_dev *dev)
 			     shaper_profile, node);
 		rte_free(shaper_profile);
 	}
+
+	free(vf->qtc_map);
+	vf->qtc_map = NULL;
 }
 
 static inline struct iavf_tm_node *
@@ -800,7 +803,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	struct virtchnl_queues_bw_cfg *q_bw = NULL;
 	struct iavf_tm_node_list *queue_list = &vf->tm_conf.queue_list;
 	struct iavf_tm_node *tm_node;
-	struct iavf_qtc_map *qtc_map;
+	struct iavf_qtc_map *qtc_map = NULL;
+	struct iavf_qtc_map *old_qtc_map = vf->qtc_map; /* to free memory if new map assigned */
 	uint16_t size, size_q;
 	int index = 0, node_committed = 0;
 	int i, ret_val = IAVF_SUCCESS;
@@ -888,8 +892,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* store the queue TC mapping info */
-	qtc_map = rte_zmalloc("qtc_map",
-		sizeof(struct iavf_qtc_map) * q_tc_mapping->num_tc, 0);
+	qtc_map = calloc(q_tc_mapping->num_tc, sizeof(struct iavf_qtc_map));
 	if (!qtc_map) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -909,6 +912,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	vf->qtc_map = qtc_map;
+	free(old_qtc_map);
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
 	free(q_bw);
@@ -924,5 +928,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 err:
 	free(q_bw);
 	free(q_tc_mapping);
+	free(qtc_map);
 	return ret_val;
 }
-- 
2.53.0

