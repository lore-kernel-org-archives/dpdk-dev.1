Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B373C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EB5C42D26;
	Wed, 21 May 2025 16:05:14 +0200 (CEST)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
 by mails.dpdk.org (Postfix) with ESMTP id C582F4028F;
 Wed, 21 May 2025 16:05:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836313; x=1779372313;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=OUihANmsHYo+HbVyPhznuYe7BqkfQHKd9jTaRug4Twg=;
 b=f5E4KT5VOREkYNevCmv2eQmmNXRFW0fcI5HImyHSW4/I5vorx9mEKkUJ
 IZPBb5KPnV+3jnTroZdyqug4zZJ2UlHYB/zhicVKi2GiuKZpqIkLgsR/u
 LuQ81o8DoWak7o94aXekGqs4iMogYe8pN+Dtz36be61PG+8xfjw9GSWmn
 1QcNUpSu2p/bxLuRLlVfprqsHvckUPxJv1v7kElUCK6vNdtIXHzpuzyAo
 T2fvI98DeqHUyUQdC5NvpLwAeP8GtiOqhHwEzSO5zMLiTnWYxA4uJ4cBL
 9j8eHDSQynnY66nsj32aklvpLvMQ56eIC+iVYQbmb1UQtknuTdnE/dHyZ Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="501069490"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:04:52 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:61425]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.17:2525]
 with esmtp (Farcaster)
 id a1451a59-293c-479d-8987-3afbdfd6d991; Wed, 21 May 2025 14:04:51 +0000 (UTC)
X-Farcaster-Flow-ID: a1451a59-293c-479d-8987-3afbdfd6d991
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:04:49 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:04:47 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 5/8] net/ena: fix unhandled interrupt config failure
Date: Wed, 21 May 2025 17:04:32 +0300
Message-ID: <20250521140432.2643-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

Fixed the device initialization routine to correctly handle
failure during the registration or enabling of interrupts
when operating in control path interrupt mode.

Fixes: ca1dfa85f0d3 ("net/ena: add control path pure polling mode")
Cc: stable@dpdk.org
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 doc/guides/rel_notes/release_25_07.rst |  2 ++
 drivers/net/ena/ena_ethdev.c           | 20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 07b5feabc4..e7fecace4f 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -59,6 +59,8 @@ New Features
 
   * Added support for enabling fragment bypass mode for egress packets.
     This mode bypasses the PPS limit enforced by EC2 for fragmented egress packets on every ENI.
+  * Fixed the device initialization routine to correctly handle failure during the registration
+    or enabling of interrupts when operating in control path interrupt mode.
 
 * **Added Mucse rnp net driver.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 4caad9006e..f26f08ca85 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -2465,8 +2465,16 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (!adapter->control_path_poll_interval) {
 		/* Control path interrupt mode */
-		rte_intr_callback_register(intr_handle, ena_control_path_handler, eth_dev);
-		rte_intr_enable(intr_handle);
+		rc = rte_intr_callback_register(intr_handle, ena_control_path_handler, eth_dev);
+		if (unlikely(rc < 0)) {
+			PMD_DRV_LOG_LINE(ERR, "Failed to register control path interrupt");
+			goto err_stats_destroy;
+		}
+		rc = rte_intr_enable(intr_handle);
+		if (unlikely(rc < 0)) {
+			PMD_DRV_LOG_LINE(ERR, "Failed to enable control path interrupt");
+			goto err_control_path_destroy;
+		}
 		ena_com_set_admin_polling_mode(ena_dev, false);
 	} else {
 		/* Control path polling mode */
@@ -2485,6 +2493,14 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 
 	return 0;
 err_control_path_destroy:
+	if (!adapter->control_path_poll_interval) {
+		rc = rte_intr_callback_unregister_sync(intr_handle,
+					ena_control_path_handler,
+					eth_dev);
+		if (unlikely(rc < 0))
+			PMD_INIT_LOG_LINE(ERR, "Failed to unregister interrupt handler");
+	}
+err_stats_destroy:
 	rte_free(adapter->drv_stats);
 err_indirect_table_destroy:
 	ena_indirect_table_release(adapter);
-- 
2.17.1

