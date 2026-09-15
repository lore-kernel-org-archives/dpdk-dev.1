Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129BC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E185E40A77;
	Tue, 15 Sep 2026 11:05:29 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id DE7A04003C;
 Tue, 15 Sep 2026 11:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 311E62C0BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789463127; bh=fGNEUBzJqemoS+ShOhpK856LEB7F2EspDli7UWE3Hkg=;
 h=From:To:CC:Subject:Date:From;
 b=uWU8/VFc2DRDc+1F2C4jf8pSPizcyCW3zUAubUIiTyKMZWMIwBdOFAurYnxKsi5XS
 c2cU9W/6zCw4rcDi5ciVvZRmUNpoATcpq66SaHPirPGp/I/CEZjUiIHPGHkMs8/zUJ
 NyRSVcUEOlDA2y+JjYvL4hGt0Cd9YQMqmt0Duk9s=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 311E62C0BAF;
 Tue, 15 Sep 2026 12:05:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt C35B72C0B6E
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id C35B72C0B6E;
 Tue, 15 Sep 2026 12:05:26 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: remove redundant Rx queue array check
Date: Tue, 15 Sep 2026 09:05:24 +0000
Message-ID: <20260915090524.431183-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-01.infotecs-nt (10.17.0.3) To
 msk-exch-02.infotecs-nt (10.17.0.2)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/09/15 05:24:00 #28584173
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
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

From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>

The rx_queues array is allocated during device configuration
before nb_rx_queues is set. Since bnxt_rx_queue_setup_op() is
called from rte_eth_rx_queue_setup(), which validates the queue
index against nb_rx_queues, the rx_queues NULL check is redundant.

Remove the unnecessary condition.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Cc: stable@dpdk.org
---
 drivers/net/bnxt/bnxt_rxq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 023cb0e174..a89d5ab611 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -370,11 +370,9 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		return -EINVAL;
 	}
 
-	if (eth_dev->data->rx_queues) {
-		rxq = eth_dev->data->rx_queues[queue_idx];
-		if (rxq)
-			bnxt_rx_queue_release_op(eth_dev, queue_idx);
-	}
+	rxq = eth_dev->data->rx_queues[queue_idx];
+	if (rxq)
+		bnxt_rx_queue_release_op(eth_dev, queue_idx);
 	rxq = rte_zmalloc_socket("bnxt_rx_queue", sizeof(struct bnxt_rx_queue),
 				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq) {
-- 
2.30.2

