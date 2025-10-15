Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF11CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B677E40670;
	Wed, 15 Oct 2025 09:10:52 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id 655C7402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512251; x=1792048251;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=XV+Po698whRK/yaeUpGRwe/UGTP2BNMy+a9UaFFzpjI=;
 b=H6Hm7wtsJp0w0E+bX5xGzBlNWIvH0evt3eVVzapgeX2jwZlmrc/zGCzm
 QK7JrZPeYAChhasvaR1dI5wlOANIYN9ozQUbpeleSm6MLMBsWhhbnC/aH
 5QHGkWsRyppdpZ+BOHkJe+kb2w6OEwTOb7UepGX+zJOAAIjFqmRxSA7wM
 bLEeNFK53/V3dFyGQjHHBiAjh9GAt/lGTty1eqZ8cLXOkrxJqt0kezeTo
 4ZG5f+JnSWopo28P7FHxUC8u5dz5GAyeZFLw13uhpwcWsr+wDMZq4bLyn
 We4fHuxLfocL71N6n2DTQYoRSnuTlIUk2PhbQ6WyfR+IwNyY5piAMjNyi A==;
X-CSE-ConnectionGUID: jgu4CK6fSh+1N7rNWbNiwg==
X-CSE-MsgGUID: rxfrIRnkQxCA2xONcuin4w==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4918549"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:10:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:9283]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525]
 with esmtp (Farcaster)
 id 2b46dd9c-ab1b-474f-8968-3cabdb2ea769; Wed, 15 Oct 2025 07:10:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2b46dd9c-ab1b-474f-8968-3cabdb2ea769
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:10:50 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:10:48 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 08/21] net/ena: rework sanity checks
Date: Wed, 15 Oct 2025 10:10:24 +0300
Message-ID: <20251015071024.602-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

1. Accurately check the return status of rte_intr_callback_unregister_sync
2. Add sanity checks of ring pointer on IO queue release

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index a2863f1e22..568aca1152 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -939,8 +939,8 @@ static int ena_close(struct rte_eth_dev *dev)
 	if (!adapter->control_path_poll_interval) {
 		rte_intr_disable(intr_handle);
 		rc = rte_intr_callback_unregister_sync(intr_handle, ena_control_path_handler, dev);
-		if (unlikely(rc != 0))
-			PMD_INIT_LOG_LINE(ERR, "Failed to unregister interrupt handler");
+		if (unlikely(rc < 0))
+			PMD_INIT_LOG_LINE(ERR, "Failed to unregister interrupt handler (%d)", rc);
 	} else {
 		rte_eal_alarm_cancel(ena_control_path_poll_handler, dev);
 	}
@@ -1020,6 +1020,9 @@ static void ena_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
 	struct ena_ring *ring = dev->data->rx_queues[qid];
 
+	if (!ring)
+		return;
+
 	/* Free ring resources */
 	rte_free(ring->rx_buffer_info);
 	ring->rx_buffer_info = NULL;
@@ -1040,6 +1043,9 @@ static void ena_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
 	struct ena_ring *ring = dev->data->tx_queues[qid];
 
+	if (!ring)
+		return;
+
 	/* Free ring resources */
 	rte_free(ring->push_buf_intermediate_buf);
 
-- 
2.17.1

