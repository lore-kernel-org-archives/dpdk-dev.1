Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78690C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99679410D2;
	Tue, 15 Sep 2026 10:56:13 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 693BC40290;
 Tue, 15 Sep 2026 10:56:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 5C0692C0B19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1789462569; bh=9YnWDr/VcVKvwKXOZGjTX1gX4AQEcHJuNdXuUC6c/oQ=;
 h=From:To:CC:Subject:Date:From;
 b=ZAf6aJiNPhquCOpZqflpsSCSnr1w6Wh8xbh8QtAPcfbI7pzp4xYnTaFR4+ragwQQA
 aKaMJ0mz7bcb0lpfN5k/PD4mioMK4Q2BYAlwtYA2nY5oqi/7/vB/97XkXiTpozpoCJ
 j0GThGycVDT/4Oyb5VV6HVRY644KihSmfRrnZvPk=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 5C0692C0B19;
 Tue, 15 Sep 2026 11:56:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 0AF652C0BBE
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 0AF652C0BBE;
 Tue, 15 Sep 2026 11:56:09 +0300 (MSK)
From: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Damodharam Ammepalli
 <damodharam.ammepalli@broadcom.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sokolov Evgeny
 <Evgeny.Sokolov@infotecs.ru>
Subject: [PATCH] net/bnxt: fix ctx_dma_arr allocation size
Date: Tue, 15 Sep 2026 08:56:06 +0000
Message-ID: <20260915085606.430987-1-Evgeny.Sokolov@infotecs.ru>
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

ctx_dma_arr stores rte_iova_t entries, but the allocation size was
calculated using sizeof(rte_iova_t *) instead of sizeof(rte_iova_t).

Use the correct element size when allocating the array to match the
actual data type stored in ctx_dma_arr.

Fixes: 4371b402c7b ("net/bnxt: fix array overflow")
Cc: stable@dpdk.org

Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
---
 drivers/net/bnxt/bnxt_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index a2429561b9..2754725566 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5054,7 +5054,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
 
 	snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%x_%d",
 		 suffix, idx, bp->eth_dev->data->port_id);
-	ctx_pg->ctx_dma_arr = rte_zmalloc(name, sizeof(rte_iova_t *) * rmem->nr_pages, 0);
+	ctx_pg->ctx_dma_arr = rte_zmalloc(name, sizeof(rte_iova_t) * rmem->nr_pages, 0);
 	if (ctx_pg->ctx_dma_arr == NULL)
 		return -ENOMEM;
 
-- 
2.30.2

