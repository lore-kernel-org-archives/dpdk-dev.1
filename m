Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5297BCD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 19:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C97E74066A;
	Fri,  8 May 2026 21:11:16 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA7140431
 for <dev@dpdk.org>; Fri,  8 May 2026 21:11:14 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c45281a06so4145517c88.1
 for <dev@dpdk.org>; Fri, 08 May 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778267474;
 x=1778872274; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpIN94tVs8Td/W8xjB7O0MS9xx79DTfVD02AVzTbGSU=;
 b=WYOcEi9BgEAuN9oR9cxnnLYBp9WXlrX4fb3A9zfN7bXfL2F7XT5VSw/9aJVqP9bV0x
 xJrLZcai84nvUDcpqo1QJQzV4ehDLu939TCDD2ysdcVrEw59GL2Y1iyyOVPXn2yP5iIc
 DgYyjFN2iWtK6zLC27PwJzU0oyckpR51xWsOuuDcZSBETm4ia/DBrXkCXaHP/pknM0eo
 yK8uVBGKGLD8Su7/6GePw8qiaPjVZ2Ubf5sDbVwK1Xzp14xH7v7xPlWXpiM3qtQ5XTN0
 BbhR5sfkmovCV51CXQxa7QvPBp4SwJwtbOYhwaQPPkhJaMiRBCd+iNtjXi4D2ijgJD34
 Jg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778267474; x=1778872274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cpIN94tVs8Td/W8xjB7O0MS9xx79DTfVD02AVzTbGSU=;
 b=caog359vg3ZvheGtxdXzRo8g3asf5s0no5XGHSPgxyEsNQYqM3g+XTdHbBW14yJEqZ
 0I5igrTz2p9PXy3fgwYJfZV/Ed+4RoF5QNGI7PFluqLjrk5TUFdWkufbggA2yPVYw7Nk
 5Lr/pKN497oG/Kfu/fYbK7yjrWhthPk0QqwItB8Pytidaqh4Z3XpEbkspQ+que4UpNoB
 ZAg/blsZmBukBQFZG07ARFnAyYdsvQH2t+d41cTv84crjSDbINoe5hkiLsNpzUIkPfmt
 YGan6Br1Kwvr6xLU+VF9/YYvr7QcY6Z413q+m/namaVnUO1mBvfhecEy8I+PJf33tZpA
 1l6Q==
X-Gm-Message-State: AOJu0YwnncW+obHrxqu7mt5Ll9dgshPA8yWMq3jPEmbcCY8CrgHi8Uvw
 azGVvkkPm0d0HzPen6AvxA6H/nUtGUivrtj7pvvjmSnUMhgOjuQftciGO+6WGDc3uevH42zBrjL
 XiVSB
X-Gm-Gg: AeBDietgI4Un0pvqpT/Tiz8HwILb00I3KR5wbCpuiJQzha0AYYlS3yG0Pzd/xf4/txb
 3HBlNqzuhcHJ9A7RM914iiAMBtOKf9Lk2RIEuPzl/u5nDJ8cGGMW/eU50lFFm4TfLCGrHOXZGSP
 fv6x0sNtZTwMYKpaOiq8EH3pOtEq6GcG+xpTSHBjAIiiTRObwfjkEo1SVkxvVJHFiv/HgEGO7s5
 GQMJIHcSbtAtlOQh/xyLMgJ6U8XKnpiQIUVOMfuv+CmWW4FSmyT4ds0aKisbTOb0Jypvkc/eKE9
 bqSqC4uFJxYh9xWTc3N8RdH+6pAhcD6QTHxGO134eQ6YPO/T403fEdgVRqNJnoLlzdzus52lLh3
 Wrg+xvU2FL1T4+7XAzDADj2n3gy6QFarF4ahO5NpPa4/wqUfpNDkUpoQv7Mds79LtrY8iD86wAO
 zsZUw26Mw8VS0/2489s6Da/u9QbDUSD3lD5j21S1KN831Ogw2EuDDRhQ==
X-Received: by 2002:a05:7022:238f:b0:12d:ca31:f1b6 with SMTP id
 a92af1059eb24-131853e5dcdmr7599450c88.18.1778267473546; 
 Fri, 08 May 2026 12:11:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1329fc4bf3fsm212796c88.5.2026.05.08.12.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 12:11:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v2 2/4] net/axgbe: fix Rx queue leak on descriptor init failure
Date: Fri,  8 May 2026 12:10:50 -0700
Message-ID: <20260508191109.734377-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508191109.734377-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260508191109.734377-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When wrapper_rx_desc_init() fails to allocate an mbuf for queue i,
only queue i is released. Queues 0 through i-1 have already been
fully populated with mbufs assigned to sw_ring entries and
programmed into hardware descriptors, but are never cleaned up.
This leaks all mbufs from the previously initialized queues.

Fix by allocating all needed buffers ahead of time with
rte_pktmbuf_alloc_bulk() and on failure unwind the queues
that are already setup.

Fixes: 7c4158a5b592 ("net/axgbe: add DMA programming and start/stop")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_dev.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 482d3d8062..9eabe0dfa8 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -1011,13 +1011,11 @@ static void wrapper_tx_desc_init(struct axgbe_port *pdata)
 
 static int wrapper_rx_desc_init(struct axgbe_port *pdata)
 {
-	struct axgbe_rx_queue *rxq;
-	struct rte_mbuf *mbuf;
 	volatile union axgbe_rx_desc *desc;
 	unsigned int i, j;
 
 	for (i = 0; i < pdata->eth_dev->data->nb_rx_queues; i++) {
-		rxq = pdata->eth_dev->data->rx_queues[i];
+		struct axgbe_rx_queue *rxq = pdata->eth_dev->data->rx_queues[i];
 
 		/* Initialize software ring entries */
 		rxq->mbuf_alloc = 0;
@@ -1025,19 +1023,18 @@ static int wrapper_rx_desc_init(struct axgbe_port *pdata)
 		rxq->dirty = 0;
 		desc = AXGBE_GET_DESC_PT(rxq, 0);
 
+		if (!rte_pktmbuf_alloc_bulk(rxq->mb_pool, rxq->sw_ring, rxq->nb_desc)) {
+			PMD_DRV_LOG_LINE(ERR, "RX mbuf alloc failed queue_id = %u, nb_desc = %u",
+					 i, rxq->nb_desc);
+			for (unsigned int k = 0; k < i; k++)
+				axgbe_dev_rx_queue_release(pdata->eth_dev, k);
+			return -ENOMEM;
+		}
+
 		for (j = 0; j < rxq->nb_desc; j++) {
-			mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
-			if (mbuf == NULL) {
-				PMD_DRV_LOG_LINE(ERR, "RX mbuf alloc failed queue_id = %u, idx = %d",
-					    (unsigned int)rxq->queue_id, j);
-				axgbe_dev_rx_queue_release(pdata->eth_dev, i);
-				return -ENOMEM;
-			}
-			rxq->sw_ring[j] = mbuf;
-			/* Mbuf populate */
-			mbuf->next = NULL;
-			mbuf->data_off = RTE_PKTMBUF_HEADROOM;
-			mbuf->nb_segs = 1;
+			struct rte_mbuf *mbuf = rxq->sw_ring[j];
+
+			/* mbuf is in reset state (nb_segs = 1, headroom, etc)  */
 			mbuf->port = rxq->port_id;
 			desc->read.baddr =
 				rte_cpu_to_le_64(
-- 
2.53.0

