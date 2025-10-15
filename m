Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5ECCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D76F40E2E;
	Wed, 15 Oct 2025 14:08:47 +0200 (CEST)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.13.214.179]) by mails.dpdk.org (Postfix) with ESMTP id 9014A40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530125; x=1792066125;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=XV+Po698whRK/yaeUpGRwe/UGTP2BNMy+a9UaFFzpjI=;
 b=tvewjrS695pjdnE8mtD8CW9rabNJ3nR1W7mzD/xwIdxNX9iirWEof+Um
 Z5NH7xwCI5mAstJ00ihowqPyM5d6r63XJD21VlZgREMWfw4q2UgEMpLs0
 gP7DAgc+ncEfIGv7m4+I3fph8aAyf/IHJXWM5fga8+hCrlW0JMuWJxpUA
 w1ieyrOQtQAwD51Jk47mtypaOBspmm0TbOj4mxWmvXdy9PgSst15xyhOO
 MRIXoopNYm3Ts5QcSGpEhfbBCUBWRalRVbkbqZUkymMyMxV8KlQbsXfbW
 ODe25LaoqW9EoM2nIlTHFCWEQ6DzomzhUWpL29zBgc6TypUq621aaIwKn A==;
X-CSE-ConnectionGUID: n7Gyc6WhR62QNKEUTD0qYA==
X-CSE-MsgGUID: svK4WAtwQfeoU09/Pv0cag==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4929191"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:08:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:16364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.168:2525]
 with esmtp (Farcaster)
 id 795cb8b1-e22e-46e4-a0dc-7a4e1470efc4; Wed, 15 Oct 2025 12:08:42 +0000 (UTC)
X-Farcaster-Flow-ID: 795cb8b1-e22e-46e4-a0dc-7a4e1470efc4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:08:37 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:08:35 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 07/20] net/ena: rework sanity checks
Date: Wed, 15 Oct 2025 15:08:25 +0300
Message-ID: <20251015120825.2488-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
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

