Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA6606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bkzcdLhd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C6C740615;
	Wed, 21 Oct 2026 16:26:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 186A640041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592772; x=1824128772;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZQ1N4lOCV0q2lUy37TeLZUbOq95VITJwNK04+EqPJIU=;
 b=bkzcdLhd4yxnXTFowSJL8i41dyvW/gwb59KS7H/2MqMth9yf8L20/1p5
 E2gScZo9l7EZNhxbsRbhNC4BxHuXnacswj/bs/ioktf4KxsUSpNf3LVbB
 lgmNa2W1KHzr062oEzbUfpHjHsawqbLROcj5hgB++4hPKObEs3Ny1yJ2E
 ZoUUIjry5XmdpLKk4ll+qsGgC1NH52rQgOHs0iflPLGrooiOJx41IPpin
 FaKClfqGIL51cjyG2APktwY0Ls79BCEsfbgnTQCAmJ+S8KmVs+d1aV72/
 HtKM1PZRYvv4MWvpyMW7T06q7HlHlsh0l62SEHnMTaEcbQUE/RKScxfeC A==;
X-CSE-ConnectionGUID: 94GbBjCTTzKlVldJ5XvXHg==
X-CSE-MsgGUID: wu7LmoVBT6u4wWjt4NuM2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192896"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:11 -0700
X-CSE-ConnectionGUID: W1ySis52RsOjf4Y4TagKYA==
X-CSE-MsgGUID: qYAcTc8oTfSN9Hhgno8Dlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570485"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v4 01/10] net/iavf: keep device stopped if start fails
Date: Wed, 21 Oct 2026 15:25:41 +0100
Message-ID: <6c09ec48e2026b535a2e6aff3a664267297b23ef.1792592724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
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
index 9e0e13d4992..1ec9e946fc4 100644
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

