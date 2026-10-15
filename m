Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E8DCC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9CB402E4;
	Thu, 15 Oct 2026 10:34:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 85B7640041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792053248; x=1823589248;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DaQdnmBG45wmpZ3GOSzG2/Pm0BNuS6rNXetW7obYWB8=;
 b=nheePRGB8V6zfUaUEQxhCP8noaehZ+lpkYfebRAvFO5V5ds+CfUTZxuo
 D17x1PcfKboZRz+j6QY6xbQbFEPuH5KBUs+h8e20Hl8o5M6/PwGofZTgQ
 8iaz99VWNNrKkAVLqIbsSGe+JH9ojaWoxJIUBGA1ASsDaVVjtxOfp8j0D
 Wn1Aoz01ejm0+tVvuABb4rZRbWOaWac4oJxJ1MjxusqubUrZzh1bu2FaQ
 iX+knsrqZr/vl8xIQe1k6gWs4Q1tn+sQZdg/4aZhcUk3/R4bLer2LJbhF
 Y56l4u1/OXgR2xlzDUHVDWg1aCdOAGgiB9JBhBTdAl8J+1lnhxdpkOG52 g==;
X-CSE-ConnectionGUID: +Sykr2RtQI2Jihq9c2MrxQ==
X-CSE-MsgGUID: 8F3isPkhQrCFlx9zbu7mWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="697498"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="697498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:34:08 -0700
X-CSE-ConnectionGUID: scH6bZEMSf+DKmpjjfEUfA==
X-CSE-MsgGUID: eqjb+NhNTIuOA5uAHZ11pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1972798"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 01:34:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v1 2/2] net/iavf: keep device stopped if start fails
Date: Thu, 15 Oct 2026 09:34:04 +0100
Message-ID: <5488d85c2ded08838becaee6de8328694ee00234.1792053236.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <809e0c5b2ab57f1b14c68be8ac34e70cbbe82233.1792053236.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c0c58af746..8930ee8709 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1047,7 +1047,6 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		return -1;
 
 	wb_on_itr = (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) != 0;
-	adapter->stopped = 0;
 
 	vf->max_pkt_len = dev->data->mtu + IAVF_ETH_OVERHEAD;
 	vf->num_queue_pairs = RTE_MAX(dev->data->nb_rx_queues,
@@ -1120,6 +1119,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	}
 
 	iavf_phc_sync_alarm_start(dev);
+	adapter->stopped = 0;
 
 	/* An explicit start supersedes any pending deferred start */
 	vf->start_pending = false;
@@ -1150,13 +1150,13 @@ iavf_dev_stop(struct rte_eth_dev *dev)
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

