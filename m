Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263CC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2499C4042E;
	Mon, 24 Feb 2025 12:40:32 +0100 (CET)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mails.dpdk.org (Postfix) with ESMTP id 4851840E42
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1740397228; x=1771933228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=D3zfZGqv3gj6zVUqIz/98nxfMKK8quENXAJM2MHicPk=;
 b=iYczLrjv+jyYUwZR6ln4+eG+jPeWYefBgfzFqzVpxQe1olmITQWsMWgx
 c0h8rHgJZ1GIkzAETvDgI7L9MSYiQsj1naimidQV3Kagc2kUyI+tLtpfp
 lcRBZrioABvh2Iz2F2vDcMSlQ0mV/uXF6m+PxMdsa7S4PxP74ep7Diqgh g=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; d="scan'208";a="496610358"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-9102.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:40:23 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:17212]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.133:2525]
 with esmtp (Farcaster)
 id e3009af0-f8f1-4a0f-bbd4-2f10fcdb1eb5; Mon, 24 Feb 2025 11:40:21 +0000 (UTC)
X-Farcaster-Flow-ID: e3009af0-f8f1-4a0f-bbd4-2f10fcdb1eb5
Received: from EX19D023EUB004.ant.amazon.com (10.252.51.89) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D023EUB004.ant.amazon.com (10.252.51.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:20 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 11:40:20 +0000
Received: from HFA15-CG15235BS.amazon.com (unknown [10.1.213.12])
 by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix)
 with ESMTP id 60AE6800CD; Mon, 24 Feb 2025 11:40:19 +0000 (UTC)
From: <shaibran@amazon.com>
To: <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Wajeeh Atrash
 <atrwajee@amazon.com>
Subject: [PATCH 3/4] net/ena: remove deprecated notifications
Date: Mon, 24 Feb 2025 13:40:10 +0200
Message-ID: <20250224114011.1789-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224114011.1789-1-shaibran@amazon.com>
References: <20250224114011.1789-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
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

From: Shai Brandes <shaibran@amazon.com>

Remove deprecated asynchronous event notifications that may arrive
from the device. The removal ensures that only supported event
handling mechanisms are in use.

Signed-off-by: Wajeeh Atrash <atrwajee@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 51 ------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 71a60b0eff..705b0b3a85 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1924,10 +1924,7 @@ static int ena_device_init(struct ena_adapter *adapter,
 	}
 
 	aenq_groups = BIT(ENA_ADMIN_LINK_CHANGE) |
-		      BIT(ENA_ADMIN_NOTIFICATION) |
 		      BIT(ENA_ADMIN_KEEP_ALIVE) |
-		      BIT(ENA_ADMIN_FATAL_ERROR) |
-		      BIT(ENA_ADMIN_WARNING) |
 		      BIT(ENA_ADMIN_CONF_NOTIFICATIONS);
 
 	aenq_groups &= get_feat_ctx->aenq.supported_groups;
@@ -3050,29 +3047,6 @@ eth_ena_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return i;
 }
 
-static void ena_update_hints(struct ena_adapter *adapter,
-			     struct ena_admin_ena_hw_hints *hints)
-{
-	if (hints->admin_completion_tx_timeout)
-		adapter->ena_dev.admin_queue.completion_timeout =
-			hints->admin_completion_tx_timeout * 1000;
-
-	if (hints->mmio_read_timeout)
-		/* convert to usec */
-		adapter->ena_dev.mmio_read.reg_read_to =
-			hints->mmio_read_timeout * 1000;
-
-	if (hints->driver_watchdog_timeout) {
-		if (hints->driver_watchdog_timeout == ENA_HW_HINTS_NO_TIMEOUT)
-			adapter->keep_alive_timeout = ENA_HW_HINTS_NO_TIMEOUT;
-		else
-			// Convert msecs to ticks
-			adapter->keep_alive_timeout =
-				(hints->driver_watchdog_timeout *
-				rte_get_timer_hz()) / 1000;
-	}
-}
-
 static void ena_tx_map_mbuf(struct ena_ring *tx_ring,
 	struct ena_tx_buffer *tx_info,
 	struct rte_mbuf *mbuf,
@@ -4078,30 +4052,6 @@ static void ena_update_on_link_change(void *adapter_data,
 	rte_eth_dev_callback_process(eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL);
 }
 
-static void ena_notification(void *adapter_data,
-			     struct ena_admin_aenq_entry *aenq_e)
-{
-	struct rte_eth_dev *eth_dev = adapter_data;
-	struct ena_adapter *adapter = eth_dev->data->dev_private;
-	struct ena_admin_ena_hw_hints *hints;
-
-	if (aenq_e->aenq_common_desc.group != ENA_ADMIN_NOTIFICATION)
-		PMD_DRV_LOG_LINE(WARNING, "Invalid AENQ group: %x. Expected: %x",
-			aenq_e->aenq_common_desc.group,
-			ENA_ADMIN_NOTIFICATION);
-
-	switch (aenq_e->aenq_common_desc.syndrome) {
-	case ENA_ADMIN_UPDATE_HINTS:
-		hints = (struct ena_admin_ena_hw_hints *)
-			(&aenq_e->inline_data_w4);
-		ena_update_hints(adapter, hints);
-		break;
-	default:
-		PMD_DRV_LOG_LINE(ERR, "Invalid AENQ notification link state: %d",
-			aenq_e->aenq_common_desc.syndrome);
-	}
-}
-
 static void ena_keep_alive(void *adapter_data,
 			   __rte_unused struct ena_admin_aenq_entry *aenq_e)
 {
@@ -4156,7 +4106,6 @@ static void unimplemented_aenq_handler(__rte_unused void *data,
 static struct ena_aenq_handlers aenq_handlers = {
 	.handlers = {
 		[ENA_ADMIN_LINK_CHANGE] = ena_update_on_link_change,
-		[ENA_ADMIN_NOTIFICATION] = ena_notification,
 		[ENA_ADMIN_KEEP_ALIVE] = ena_keep_alive,
 		[ENA_ADMIN_CONF_NOTIFICATIONS] = ena_suboptimal_configuration
 	},
-- 
2.17.1

