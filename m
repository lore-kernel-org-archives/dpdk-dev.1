Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9EC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2892B40A6E;
	Fri,  3 Jul 2026 15:19:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 60AE14067A;
 Fri,  3 Jul 2026 15:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084791; x=1814620791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ljrLJKtdvtHWCjijudFWthD+xu+Nh97jYPFeIjJtcPQ=;
 b=Nr3i6AF7dVYpon0XciKfj8CR2fqrPTziW2SuwovRTWKUODk6RpSGcU9L
 alrQ0eFxfjrAlghUhkBGzZ7akbwe6eQ8a08EfegDtR4oAZ6bB6zuHoXYD
 wSdHTjt3sGhjoy+449U/hxUOIChUXpJihD1Se2n4AqdP4NS4py/2KWIox
 bLQAbPfxVQYsLJTuMU/S8oMYQzQ7Lg1vnHd/AflLq9qwh7r09pSn/bgnr
 4QjYTPor2B2H/Cu3cZmsREc/nQLUYS3GhuPL35VAEsea2oriU5t6HfodD
 dswImRW2GL9U0XOCDInVqrILIKNrx2j8mHkyUKZoBoscNQzLHzFBSgHLa g==;
X-CSE-ConnectionGUID: CB6W7skeQduXBDIJBzOuMQ==
X-CSE-MsgGUID: d2gSyNyjQcWiLjdeNy6Q6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486672"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:50 -0700
X-CSE-ConnectionGUID: 6MevDxk7Qc2PCJgMrK/7Yw==
X-CSE-MsgGUID: nqYsGqUdRJu34xgISJ+wTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439850"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:48 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ting Xu <ting.xu@intel.com>
Subject: [PATCH v2 2/6] net/iavf: fix leak of queue to traffic class mapping
 data
Date: Fri,  3 Jul 2026 14:19:16 +0100
Message-ID: <20260703131921.4102325-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703131921.4102325-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
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
index 5f888d654f..faa2d4b8a0 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -97,6 +97,9 @@ iavf_tm_conf_uninit(struct rte_eth_dev *dev)
 			     shaper_profile, node);
 		rte_free(shaper_profile);
 	}
+
+	free(vf->qtc_map);
+	vf->qtc_map = NULL;
 }
 
 static inline struct iavf_tm_node *
@@ -801,7 +804,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	struct virtchnl_queues_bw_cfg *q_bw = NULL;
 	struct iavf_tm_node_list *queue_list = &vf->tm_conf.queue_list;
 	struct iavf_tm_node *tm_node;
-	struct iavf_qtc_map *qtc_map;
+	struct iavf_qtc_map *qtc_map = NULL;
+	struct iavf_qtc_map *old_qtc_map = vf->qtc_map; /* to free memory if new map assigned */
 	uint16_t size, size_q;
 	int index = 0, node_committed = 0;
 	int i, ret_val = IAVF_SUCCESS;
@@ -889,8 +893,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* store the queue TC mapping info */
-	qtc_map = rte_zmalloc("qtc_map",
-		sizeof(struct iavf_qtc_map) * q_tc_mapping->num_tc, 0);
+	qtc_map = calloc(q_tc_mapping->num_tc, sizeof(struct iavf_qtc_map));
 	if (!qtc_map) {
 		ret_val = IAVF_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -910,6 +913,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	vf->qtc_map = qtc_map;
+	free(old_qtc_map);
 	if (adapter->stopped == 1)
 		vf->tm_conf.committed = true;
 	free(q_bw);
@@ -925,5 +929,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 err:
 	free(q_bw);
 	free(q_tc_mapping);
+	free(qtc_map);
 	return ret_val;
 }
-- 
2.53.0

