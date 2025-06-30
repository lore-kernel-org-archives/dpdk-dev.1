Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F950C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B432A40669;
	Mon, 30 Jun 2025 13:15:51 +0200 (CEST)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
 by mails.dpdk.org (Postfix) with ESMTP id 3E6AD40264;
 Mon, 30 Jun 2025 13:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282150; x=1782818150;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Bu9V+Tprvb8yz8yYyFBLp9pbhN0qGd7EEnAMhckfWEo=;
 b=rchbLTf7wDoqq0dQ1qVrOEgMYf81ZGdnTIRexaoKu72tjN8YY7QZ/81X
 XkOhUidzNEG/CcLJ1XRxoY2wbN+kW4hP8F0oEzhW45fLOl5SBhYpe8xCb
 6JKSu6cD2gnIcJETcWOqUthC5BAI3v6YDLFuww4Ew8hsB+nQfCHTZIC3y
 gdzaQloiylAOMnG6K72cFei6yF6V3WadXG8GoRnZSnNAzVsiWgWkiRodH
 lWZ7U89H5yTWUxJ3t35v3XI+M12JKi7qQ+CZe2j8kJ6gtI2ca+2A5mhdC
 rTP/9agnZ917n4hmIPx1gHHznbZPGaCUGKkIjVsDNv2w+DOjni6m6oJZK Q==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="211678442"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:15:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:64187]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.139:2525]
 with esmtp (Farcaster)
 id 47e6e77a-77d5-4e04-bfb0-82864ab81b36; Mon, 30 Jun 2025 11:15:47 +0000 (UTC)
X-Farcaster-Flow-ID: 47e6e77a-77d5-4e04-bfb0-82864ab81b36
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:15:46 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:15:44 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 5/7] net/ena: fix unhandled interrupt config failure
Date: Mon, 30 Jun 2025 14:15:25 +0300
Message-ID: <20250630111525.3534-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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
index 822b3d4595..6c09ad30dd 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -76,6 +76,8 @@ New Features
 
   * Added support for enabling fragment bypass mode for egress packets.
     This mode bypasses the PPS limit enforced by EC2 for fragmented egress packets on every ENI.
+  * Fixed the device initialization routine to correctly handle failure during the registration
+    or enabling of interrupts when operating in control path interrupt mode.
 
 * **Added Mucse rnp net driver.**
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 8ef6e55248..eb33ca2c6e 100644
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

