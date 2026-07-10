Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7385C44501
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFE2D406B7;
	Fri, 10 Jul 2026 12:34:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1193B4042E;
 Fri, 10 Jul 2026 12:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783679651; x=1815215651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ljrLJKtdvtHWCjijudFWthD+xu+Nh97jYPFeIjJtcPQ=;
 b=V3nqKJVPB+Hez0716UzQHwuxtQVcIAffFeaDwi99HHgXulfGAbSPVIA/
 EuBpbxnrxFZAqH0w08WDuPXY3v/Blp6iHUjI9+bqeGALCuwAE4eC6dI/3
 IaaFSLyoXizucBIzFhEP5sF8WzEXMofwsCm8DJBoxd0KhoL7Gx1w5OUXL
 pXbTIHCTlZhidgpNzny2uvSXttDF2O5iD09Dtd3nahqlx6067Q8dfbbi2
 3CNjb9bg4sRYvK4eEMbWs4phYI3t96zI30r/APMdIkAfwaQWMjB3Vxvie
 w/zvU9q2aC08BwCtXF4BrenRLzcBtpDkoBgSM9LLEqvbC5O6eifBkXOmU g==;
X-CSE-ConnectionGUID: UH2UcXzDQ8WfSXnj3ee7LQ==
X-CSE-MsgGUID: nPm96Tp6SuO399C8pejyrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84428981"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84428981"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 03:34:10 -0700
X-CSE-ConnectionGUID: 74Bif0/ISGGGxVvIZ12wtg==
X-CSE-MsgGUID: d+7KJA/TQRCswP1jEReZAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259163172"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 10 Jul 2026 03:34:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v3 2/6] net/iavf: fix leak of queue to traffic class mapping
 data
Date: Fri, 10 Jul 2026 11:33:59 +0100
Message-ID: <20260710103403.1548864-3-bruce.richardson@intel.com>
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

