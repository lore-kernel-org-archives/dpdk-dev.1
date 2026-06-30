Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC890C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31BBF406B4;
	Tue, 30 Jun 2026 16:16:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0DFEB40648;
 Tue, 30 Jun 2026 16:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829008; x=1814365008;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WrW8M2sIDHbZMVzNkwXZUSwjCiuQIXDM5Dt+vyuJDNo=;
 b=Z8wbGOD+8tMRpCTCtoTMUAZm+BkTp6fTXZQxmmu7ZOoYbyT4V21W7OVD
 VvEJXB3SPGNuNvUkhGFH+Yh5mGklZhVscWrGx/RhqT9PQlXW152+qYsuJ
 rwjQ2xphv9rfWYD+6zniQJr6dvlz+qamkR6kwRNd28XjhriztZRbSnhAN
 ceRGvWIkGFRV3iEPgDSnT82wKz0TfAAp2HEEJYObJg5x3fQ9aRM19v7Y2
 RBOeDluv2JCBf7jNwwqPLFyxZrqcyzG+eZa62nMRBn2vAvsRF48ecjUvJ
 ITkJes/hW3OBR2t424037UHBE7GjQw6XKfWBuEoxGOJyBoZD02Q2waG69 g==;
X-CSE-ConnectionGUID: QtmJg4vJSVC7uf/MZSctNw==
X-CSE-MsgGUID: tOllHlhCSWGB7lWu4ecOIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94693507"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="94693507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:16:47 -0700
X-CSE-ConnectionGUID: 9nO5lfaLRgSmkXL+asZv2g==
X-CSE-MsgGUID: IaHNtKpVQXS6app9yAm9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248291046"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2026 07:16:46 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/2] net/i40e: activate alarm if interrupt delivery unavailable
Date: Tue, 30 Jun 2026 14:16:27 +0000
Message-ID: <20260630141627.1035420-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630141627.1035420-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
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

If interrupt registration fails eg. on FreeBSD with nic_uio, and Rx
queue interrupts are configured (intr_conf.rxq != 0), the interrupt
handler is never called and ICR0 events, including AdminQ messages
carrying link state notifications, are never processed. In polling
mode (rxq == 0) a periodic alarm already drains these events, but in
the interrupt-enabled configuration no such fallback existed.

This gap has always existed but was partially masked by the blocking link
status poll in the i40e dev_start function, which would delay some time
until the link was up before returning. In this case, the link status was
typically correct after dev_start. However after that delay was removed in
111965395b ("net/i40e: fix blocking link wait on device start"), the link
status was often wrong after dev_start, and there was no mechanism to
self-correct.

Rather than restoring the blocking wait removed by that commit which would
re-impose a startup delay on every platform, activate the existing periodic
alarm on platforms where interrupt delivery is unavailable.

Fixes: 111965395b ("net/i40e: fix blocking link wait on device start")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 9 ++++++++-
 drivers/net/intel/i40e/i40e_ethdev.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b2694cd33a..86eb7468c8 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2579,7 +2579,11 @@ i40e_dev_start(struct rte_eth_dev *dev)
 		i40e_dev_link_update(dev, !rte_intr_allow_others(intr_handle));
 		pf->mac_config_on_link_up = !dev->data->dev_link.link_status;
 		/* enable uio intr after callback register */
-		rte_intr_enable(intr_handle);
+		if (rte_intr_enable(intr_handle) != 0) {
+			pf->use_aq_polling = true;
+			rte_eal_alarm_set(I40E_ALARM_INTERVAL,
+					  i40e_dev_alarm_handler, dev);
+		}
 	}
 
 	i40e_filter_restore(pf);
@@ -2625,6 +2629,9 @@ i40e_dev_stop(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.intr_conf.rxq == 0) {
 		rte_eal_alarm_cancel(i40e_dev_alarm_handler, dev);
 		rte_intr_enable(intr_handle);
+	} else if (pf->use_aq_polling) {
+		rte_eal_alarm_cancel(i40e_dev_alarm_handler, dev);
+		pf->use_aq_polling = false;
 	}
 
 	/* Disable all queues */
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 5a009393b0..9d9bde6aeb 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1193,6 +1193,8 @@ struct i40e_pf {
 	bool fw8_3gt;
 	/* MAC config needs re-applying when link first comes up */
 	bool mac_config_on_link_up;
+	/* true when interrupt path unavailable */
+	bool use_aq_polling;
 
 	struct i40e_vf_msg_cfg vf_msg_cfg;
 	uint64_t prev_rx_bytes;
-- 
2.43.0

