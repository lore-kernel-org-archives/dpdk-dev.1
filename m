Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD58C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088304066A;
	Thu, 22 May 2025 15:29:55 +0200 (CEST)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com
 [99.78.197.219])
 by mails.dpdk.org (Postfix) with ESMTP id A163D402E5;
 Thu, 22 May 2025 15:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920593; x=1779456593;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=OUihANmsHYo+HbVyPhznuYe7BqkfQHKd9jTaRug4Twg=;
 b=SwgtdNbtthcG9zO/sqBO7+sUHd6qKoI+VkdG0tETWs0nP++kAJ4UymRP
 +rIhjYcrqbqQEeI4obrE0Wpia8xd8sDdfqsmR6UxGJIX1azrWCfFMIOGZ
 A+UKFYR/pz2CsIOo41BqmYLauuPUq80M/4+uqlz/sxpERI/C4RTv0gxAg
 esH8fABWDBqvtnN2eRB5yFZAfvqLmuvtvj/VlNhJsBXll1+geWvIiuCPH
 7BhJHwq3pTmOS+wSMoIH+1MNIhzYwvRUOSyTyC01M6z7WsIPCX6RjblS/
 uxVOosRpO/RN2LeEscaV7Ivb+lat3sol23WuBmPQCX1jXURvABqgMp7KF Q==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="199833922"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80008.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:29:49 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:32896]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525]
 with esmtp (Farcaster)
 id 5018a578-2828-4a93-aa13-90c640e6fade; Thu, 22 May 2025 13:29:48 +0000 (UTC)
X-Farcaster-Flow-ID: 5018a578-2828-4a93-aa13-90c640e6fade
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:29:48 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:29:46 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v3 5/7] net/ena: fix unhandled interrupt config failure
Date: Thu, 22 May 2025 16:29:30 +0300
Message-ID: <20250522132930.3473-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
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

