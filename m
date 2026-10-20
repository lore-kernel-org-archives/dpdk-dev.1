Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D01606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LVALRCu6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D591240656;
	Tue, 20 Oct 2026 11:11:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 223EA40144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487500; x=1824023500;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NkIhjWtPN8x9I0qo0a4m7IYjSCPqqQluVWir4jHFSQg=;
 b=LVALRCu6hM5TtbeJDlKMjBDAuG84Szt4ghE4bY0DWmuMOpyx/5n2HBCm
 Qt++Mie2a0qEyIsI9/N7fkgbQG7uejX46J0Qsf8ZtZgwKETfb7T78Gnu4
 xIIzJYYhesq4S5w8D5GqCAkBjDm24bC3bvO2FuBC7NM9gZis7NvgaediI
 9r7A3hlIu/fwmZvV6xTu/K08sZ6PqIQQ+TiFT4w0ME/+dKQIwYjBVeaTv
 HhDX5q+0w52yVzMG/NW3kJR5ODXEo0QHZD/wmq5LdKqEj5iQS0taE2Exq
 0/iJZHNDJSPvGEjt2JpwIQnP220AWcz0h/DuA2A1FFrWYlvRVQxbSwICe w==;
X-CSE-ConnectionGUID: 5w6JFfz0SP63fkrKe24KGA==
X-CSE-MsgGUID: cVpKuHAhTxm5542NRUompQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286805"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286805"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:39 -0700
X-CSE-ConnectionGUID: PiFVx4c3TkWRMKuLc/+Bnw==
X-CSE-MsgGUID: zIMTO7ksTYm111m8IbIgGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879434"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v3 01/10] net/iavf: keep device stopped if start fails
Date: Tue, 20 Oct 2026 10:11:24 +0100
Message-ID: <9ffd8df4f0a3494089d5295a2b706b70057a3454.1792487374.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792487374.git.anatoly.burakov@intel.com>
 <cover.1792487374.git.anatoly.burakov@intel.com>
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

