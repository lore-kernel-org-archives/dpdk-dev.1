Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838060820F4
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O0EynMVa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34E84064F;
	Mon, 19 Oct 2026 17:06:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 918384028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422395; x=1823958395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NkIhjWtPN8x9I0qo0a4m7IYjSCPqqQluVWir4jHFSQg=;
 b=O0EynMVaiCBXfkFRDId2joDde6InF/w9ipyZB/ARMKtdQlfD4gSFgBmx
 b6+hY2L7MZ0CfPh7IUt6k6i0YFy6zzyhFXEy66HVs0hLluqZHV6JdX6II
 aRItaKYieddZgaF4sB+mCo4tZhXph1TETS4pQh+4cn5hAanuxevUhg+wX
 3Htk/lrkASf7k9952jHtnCxHhtLxnC778lT86X7+PNWxifBrsapKMQY9U
 TaytJWGi8Xcl/tm/quh7T7KqszdzSwmzvfWuWJIMmDmBn/tGLs35X/4Lc
 dUcfHWWLgBGqpFmEnwwfPLvDkQxlisYpQDvvkvv/+kto1hHG6K6mBZ3K6 Q==;
X-CSE-ConnectionGUID: fxK9CmBHT7OkiHCiWbG9hQ==
X-CSE-MsgGUID: l7h5xpLbTF6fa4gaSe4rxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132164"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132164"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:35 -0700
X-CSE-ConnectionGUID: yRsm1nylT16c3hIGM6+MyQ==
X-CSE-MsgGUID: yrZR7VIwRP2lLS9MWqRKsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319715"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 1/9] net/iavf: keep device stopped if start fails
Date: Mon, 19 Oct 2026 16:06:20 +0100
Message-ID: <c1ce4343efb1d7147c47fcc11d18b9eed8294129.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792422213.git.anatoly.burakov@intel.com>
 <cover.1792422213.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, `iavf_dev_start()` clears `adapter->stopped` before several
operations that can fail. A subsequent `iavf_dev_stop()` then disables
interrupts and stops and resets queues even though startup did not
complete.

Mark the adapter running only after startup succeeds, and return early
from stop when it is already stopped.

Fixes: 69dd4c3d0898 ("net/avf: enable queue and device")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 7f1ad3d88c..68aced0e31 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1039,8 +1039,6 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	if (adapter->closed)
 		return -1;
 
-	adapter->stopped = 0;
-
 	vf->max_pkt_len = dev->data->mtu + IAVF_ETH_OVERHEAD;
 	vf->num_queue_pairs = RTE_MAX(dev->data->nb_rx_queues,
 				      dev->data->nb_tx_queues);
@@ -1112,6 +1110,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	}
 
 	iavf_phc_sync_alarm_start(dev);
+	adapter->stopped = 0;
 
 	/* An explicit start supersedes any pending deferred start */
 	vf->start_pending = false;
@@ -1135,13 +1134,13 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	if (adapter->closed)
 		return -1;
 
+	if (adapter->stopped == 1)
+		return 0;
+
 	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) &&
 	    dev->data->dev_conf.intr_conf.rxq != 0)
 		rte_intr_disable(intr_handle);
 
-	if (adapter->stopped == 1)
-		return 0;
-
 	iavf_phc_sync_alarm_stop(dev);
 
 	/* Disable the interrupt for Rx */
-- 
2.52.0

