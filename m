Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA8606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DDH+Ikng
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC2F40647;
	Fri, 23 Oct 2026 11:32:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8332A40299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747961; x=1824283961;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AN6rTwbirWWLUDfzJzvMtaLpljy3Xd/35AYlNb+gt38=;
 b=DDH+IkngJ86XqPYsAAFb1w5qGP+gh2KapnqfxbawyAWd5ediEsQ5g+Hw
 8X4DEqEpNOdecf0IJm+jWbZpF6SMz+d8wcWqIY532lxRyMDJ9qyTrD4CY
 jFMkHLqJG7Jb4Z+v4K3ie4uiXeIZtcMiuvgB4Tm1AbPIFAYu+fxpE3GWd
 4IBzQv3FDSMPROd7vb7g/H6SqnH0hlopfzAF0od+f35KROXMGD9YPxv+x
 6dS/OEeYaDKQ8gDUULAHACcah+3p0Zzt2dSyDarvHfsy4Nws4JWQGEfaL
 31zJj0jeKX1XiFBYtuS0z8dc50PJv4CZ4kVBeHRXR6860Y3R9AlknSFaq g==;
X-CSE-ConnectionGUID: VDK9q1aPT86+Fws/RjIAIA==
X-CSE-MsgGUID: 0IjUWhGdQmuNiKR6A1SBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498263"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498263"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:40 -0700
X-CSE-ConnectionGUID: yMI/RQjUTcSQUIRUN2SZXQ==
X-CSE-MsgGUID: lbZVOeatRmunbiS5y9Eg1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509446"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v5 01/10] net/iavf: keep device stopped if start fails
Date: Fri, 23 Oct 2026 10:32:21 +0100
Message-ID: <5849bad0174d725710f0ac2166264a05d32f0b76.1792747916.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

