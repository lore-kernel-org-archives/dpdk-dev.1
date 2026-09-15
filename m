Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26DC88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D48BC40E72;
	Tue, 15 Sep 2026 10:47:42 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC2F406A2;
 Tue, 15 Sep 2026 10:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 972282C0BBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462060; bh=Ms2D0enKLnYhMSfuCmYYFpb5nxW8IfZk/DTwDTMZHPY=;
 h=From:To:CC:Subject:Date:From;
 b=JUNn8TAomF6uYuosDqCC1RDf8AN++hTxsuYmgt6ixStnCnbMROfpCtWW5pnjycApN
 yNJT8rNhqJWVcamze80R13LoYWKi8nRP/TcmSbrhitJFR4ijpB+h4E1a9Jn/RLIacM
 v+PBsKm/Y29mOSo5k42qF5OevqMyEElrpB1U+XjA=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 972282C0BBE;
 Tue, 15 Sep 2026 11:47:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 5EF3F2C0BAF
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 5EF3F2C0BAF;
 Tue, 15 Sep 2026 11:47:40 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <kalesh-anakkur.purayil@broadcom.com>, 
 Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: remove redundant NULL checks in RX path
Date: Tue, 15 Sep 2026 08:47:38 +0000
Message-ID: <20260915084738.430772-1-Evgeny.Sokolov@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.20.76]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
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

rxbd and rx_buf are assigned the addresses of array elements, which
cannot be NULL.

Remove the redundant NULL checks from the jumbo frame receive path.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_rxr.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 0fab4ddf78..98bdbc136a 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -74,15 +74,6 @@ static inline int bnxt_alloc_ag_data(struct bnxt_rx_queue *rxq,
 
 	rxbd = &rxr->ag_desc_ring[prod];
 	rx_buf = &rxr->ag_buf_ring[prod];
-	if (rxbd == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Jumbo Frame. rxbd is NULL");
-		return -EINVAL;
-	}
-
-	if (rx_buf == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "Jumbo Frame. rx_buf is NULL");
-		return -EINVAL;
-	}
 
 	mbuf = __bnxt_alloc_rx_data(rxq->agg_mb_pool);
 	if (!mbuf) {
-- 
2.30.2

