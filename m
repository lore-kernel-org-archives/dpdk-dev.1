Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6767AC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1905240A7D;
	Thu,  9 Jul 2026 13:26:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8F93C402BB;
 Thu,  9 Jul 2026 13:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783596386; x=1815132386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bJQgh3WtydiCgryDB6c8R/yPvw8BKXPUm5FMcrMW4HM=;
 b=Suj47XclwetfhmydQIt+m6WVtRUZb+fRFuUFoFWnl9cDy8xhs3YZaJXB
 h+3g5ar+Z4S7zDEMYTEy6xjDY3kKbBPJY2ubkhXXiJlt1Rpn4wulnJIXA
 LYzor7TATEEdx4sGWWtJqf9qUGVvOS/3UXUiIlCqZlTs743cgqH9x5BWg
 pa6AzFMK/2sSALQUkfAKJn4zNeQGtNaFrBPSDqd7LIMGYeYVOvIVYIHNT
 hvlE5itADW7dPjUNrjR187z8G8G1D6sUxb5SpU0xwxvV5ZaM53TsVxw1D
 UP+eQGOvOSWg1UAcKTkcrXRsIbT5LVgVoNB7YeQq7XKIKtEevL6voY1sz A==;
X-CSE-ConnectionGUID: Ga1M0UfWQ5iOU3lstlNCqA==
X-CSE-MsgGUID: pDjMNEZeSkGcUXziVZ1TdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94879771"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94879771"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:26:24 -0700
X-CSE-ConnectionGUID: SuRoV+oUTmisu4+ws751BQ==
X-CSE-MsgGUID: 2i68Nn1yR5OxHLk51DmnzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259461757"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2026 04:26:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Ciara Loftus <ciara.loftus@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2 2/3] net/i40e: activate alarm if interrupt delivery
 unavailable
Date: Thu,  9 Jul 2026 11:25:55 +0000
Message-ID: <20260709112556.1765262-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709112556.1765262-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260709112556.1765262-1-ciara.loftus@intel.com>
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
commit 111965395b37 ("net/i40e: fix blocking link wait on device start"),
the link status was often wrong after dev_start, and there was no mechanism
to self-correct.

Rather than restoring the blocking wait removed by that commit which would
re-impose a startup delay on every platform, activate the existing periodic
alarm on platforms where interrupt delivery is unavailable.

Fixes: 111965395b37 ("net/i40e: fix blocking link wait on device start")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
* Added warning on rte_eal_alarm_set failure
* Only set use_aq_polling if rte_eal_alarm_set succeeds
---
 drivers/net/intel/i40e/i40e_ethdev.c | 11 ++++++++++-
 drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b2694cd33a..b6b2d291ee 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2579,7 +2579,13 @@ i40e_dev_start(struct rte_eth_dev *dev)
 		i40e_dev_link_update(dev, !rte_intr_allow_others(intr_handle));
 		pf->mac_config_on_link_up = !dev->data->dev_link.link_status;
 		/* enable uio intr after callback register */
-		rte_intr_enable(intr_handle);
+		if (rte_intr_enable(intr_handle) != 0) {
+			if (rte_eal_alarm_set(I40E_ALARM_INTERVAL,
+					  i40e_dev_alarm_handler, dev) != 0)
+				PMD_DRV_LOG(WARNING, "Failed to set alarm");
+			else
+				pf->use_aq_polling = true;
+		}
 	}
 
 	i40e_filter_restore(pf);
@@ -2625,6 +2631,9 @@ i40e_dev_stop(struct rte_eth_dev *dev)
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

