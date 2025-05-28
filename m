Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D02C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C15AB4028D;
	Wed, 28 May 2025 12:27:27 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id CB50040279;
 Wed, 28 May 2025 12:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1748428046; x=1779964046;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=QYOpVP/rwg+GF0M/ZYSibUU5VIjEukh7g5aOQ86HDkA=;
 b=V5ndyvTiUfEtGIh8t4iZcHD8/KjLRr5kwQVS4aZJWXBuJ5EhKgo0oclI
 ZKIs81olZuVdyL8JneYgtW9WFdvpXPMRUf0Wo8tzFFfyy4kAZnrsKVw8x
 IS5/weCfc3bNUh9VX5y7Vd0QvK0dz246M86HaNJAEl3007t9lqtJ3W+cY
 QS+qijfiAf0Qu7RiXZOowh1KUMGnRNUCj/vqgZWQQ+qFpugOMJBd94F/y
 /RdyBs1LKYejzEQqHdpDs1VcbILd/EVnoNR5VeEye4R487L+T11qo/DXU
 fEyoJiAQEvWb/bkH1uharEDVhm8ftvWIIPCeTew0Aiw3N7Ij4c7N9TwBP w==;
X-IronPort-AV: E=Sophos;i="6.15,320,1739836800"; d="scan'208";a="24456643"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 10:27:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:39782]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.141:2525]
 with esmtp (Farcaster)
 id 91bbca18-7ee7-4904-b3ac-a1b2f9cf55a3; Wed, 28 May 2025 10:27:23 +0000 (UTC)
X-Farcaster-Flow-ID: 91bbca18-7ee7-4904-b3ac-a1b2f9cf55a3
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:27:23 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 28 May 2025 10:27:21 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v4 5/7] net/ena: fix unhandled interrupt config failure
Date: Wed, 28 May 2025 13:27:03 +0300
Message-ID: <20250528102703.9932-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
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
index 27749f232b..8c245d6805 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -67,6 +67,8 @@ New Features
 
   * Added support for enabling fragment bypass mode for egress packets.
     This mode bypasses the PPS limit enforced by EC2 for fragmented egress packets on every ENI.
+  * Fixed the device initialization routine to correctly handle failure during the registration
+    or enabling of interrupts when operating in control path interrupt mode.
 
 * **Updated virtio driver.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 18aa25f6c7..8ba4f3a9cf 100644
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

