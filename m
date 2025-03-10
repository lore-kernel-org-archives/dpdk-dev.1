Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D93C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 13:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B954021F;
	Mon, 10 Mar 2025 14:11:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id CD08440151;
 Mon, 10 Mar 2025 14:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741612284; x=1773148284;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+xNzJqUrk143Smq4PU+OTxr7cIU9F2oyTsll+4iZtdQ=;
 b=VGdiiXvc8OVCpv3Yg2PqWgl4kWh7rClbdIXA1IiZCS1Sfd//QTcx44N+
 ShuGJJwJfOV2aNq7OJbLvsJu1M1/2EXJYyeeF7rIdvgwX08CX0h5OOLql
 HBf65EXtr77a4yMJnj8hhPKcQPHxkR4l0OSrjobxjV92GpEjqQ2cGI/ek
 br/Io8gbAvBPQ/SV4zXEE1HdZwmjpKeE/ZbQdOtGkio2fNZrHVxJ3r1KK
 O6WR7LkACGcUwfMpimXB/rMUg91hWkPlaplUOOfLysKxN8sonW4qFRctp
 aqme9mJgx0fBdcvIcxGuilk7ARtv96rGO7cb/5FLqD/jqdlww+2rBe3r+ w==;
X-CSE-ConnectionGUID: Y12Tl++lSzy7p706ipqeZA==
X-CSE-MsgGUID: osAqo2j1RjaHng86AFCPEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53595992"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="53595992"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 06:11:22 -0700
X-CSE-ConnectionGUID: xnwGNGEORza0LTPnpJjZ4Q==
X-CSE-MsgGUID: vZZA5yvpT1WfMsE52VIw0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="119821717"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa006.fm.intel.com with ESMTP; 10 Mar 2025 06:11:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 1/2] net/iavf: fix missing check for interrupt errors
Date: Mon, 10 Mar 2025 13:11:15 +0000
Message-ID: <20250310131116.557117-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

When registering interrupts, there was no check if the registration of
the interrupt succeeded. Add in such a check, and go to fallback path
if the check fails. This prevents errors on FreeBSD due to missed
admin queue messages.

Fixes: cd3b124955d4 ("net/iavf: enable interrupt polling")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 9cd2b0c867..1ab84b0bfc 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2825,18 +2825,16 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 			&eth_dev->data->mac_addrs[0]);
 
 
-	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
-		/* register callback func to eal lib */
-		rte_intr_callback_register(pci_dev->intr_handle,
-					   iavf_dev_interrupt_handler,
-					   (void *)eth_dev);
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR &&
+			/* register callback func to eal lib */
+			rte_intr_callback_register(pci_dev->intr_handle,
+				   iavf_dev_interrupt_handler, (void *)eth_dev) == 0)
 
 		/* enable uio intr after callback register */
 		rte_intr_enable(pci_dev->intr_handle);
-	} else {
+	else
 		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 				  iavf_dev_alarm_handler, eth_dev);
-	}
 
 	/* configure and enable device interrupt */
 	iavf_enable_irq0(hw);
-- 
2.43.0

