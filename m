Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA9CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 17:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E9240A84;
	Thu, 18 Jun 2026 19:25:54 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id B6F6D40649
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:25:51 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30bf854d5feso1524830eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781803551;
 x=1782408351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0ed7+4kD3XSFBh1j3TE2ag5P/wTb+G8kCvoJ2G4cds=;
 b=lJ6/GqZflq28k3Naxn5y/13VvymLXoWstsWVwhShiL8vvlxYmQzeUzS7q3IrejvS7u
 NwFW6pD1T2LC0B/v8tDtgM/V3fUKHFAg0LtsDBV00lOubQDfH/bI/8SUIv0SI1JbdcXe
 +1l4yJuzbsRKBUbiO4hStHdYBv3Qr5B0gbVLXgRYQrM7reCqrXQJh6Z/0eu6OKjLoy6Q
 jGIe1TUDzi58wOolffc9xJEF+1U54aE/UEj1jcNQGwevtR2GLGDG4naP0ziBbA/P3w74
 wFV1/QztkvBbbBobQxd3fdb7v/6AukKdHiTcOW+PYFw6ZlcxziSZDw9TlWG1+rvDnBRt
 EomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781803551; x=1782408351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0ed7+4kD3XSFBh1j3TE2ag5P/wTb+G8kCvoJ2G4cds=;
 b=f2Ail7byZMd9SUHBAPGONXe7WG+ZIQtQt6t4xsZ2X0EZIaPcXVzDlpiTRoOqHupjWK
 f1nplh4cFVP1Kg1syzBJrZWcSD2tcU0iA5pRdSep92BPQtOwDKPYQLg1QwPomBXHms5q
 qesnXDgyOkOxp/lVo/bkcdPU9ajlLSLzZ7CWJRhZ3gW9EOmjk3f5FJ3ZieNub4L96oOO
 LevBl66voGefOYlco9JLqbL854c1yOPsl9YPRobr3gitjp4njNE/N5MnKjy6ulT5GK77
 hdHjABWbvMeMlidD97i3hrgreoElcGnISIYYRVsOv0MqPcoh4cJkfd9mABUZSniJuHEj
 owLg==
X-Gm-Message-State: AOJu0YwyqJh/8+kFzdCz3ZF7PpVfUIszDsyIy6M2NrRpqU2j73Oe4IIt
 BygdIdY5D+It8QaCR+QaqTmL9BDfcrBbJr9svB13xQF556lOJrakjQI9kMVM/Krx4iqVLDRO11s
 GZJs4
X-Gm-Gg: AfdE7ck9YI3jEqD71WA8fxTPsyRB94w8i9kssBI1p0n5zD6pbxzYUdj0sdfLczqhnWk
 Cp6SQ3GX4tT3Owbjx9DjQ+c3+++hx3DNohQp4u7rz/riBX/muhbl1itdLnnwlCIlrlLsELdT4rU
 5XzRALjHotCSiJSeXHFGeprz0F8RiELTLHl1bp6CYQe8rnBXiX43hpTNORhgB5RwMm/n9A+31gq
 eX8aASaGIYciu0Dtj2drmebbYDPSd4hhXh1K7MI4QNW9IS6XfC2wI3Wd3WcE4u1NcJJcq6r9kxU
 eYpf7u7xH4qZYF1iGh43kPITYUVzFrmqLRIwwNQqCGi2Bb8bBLuyF2qg13ApkYOFwGM52JTcdO/
 aHFCJs/8m2dNtvG6TjqXYzfiSSPj1Lt3it5xgVQha5KTvG6Wj/2tfZGPOyXrYinrMVTBbp2wNo8
 p/ShntqOrsnAUIwWriNx/mutmwrvYVnuMQZ90OqDwIzNNoJrtaSNg=
X-Received: by 2002:a05:7300:220d:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-30c06fea49cmr132869eec.3.1781803550679; 
 Thu, 18 Jun 2026 10:25:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670a1b4sm122443eec.8.2026.06.18.10.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:25:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v3 2/4] net/axgbe: fix Rx queue leak on descriptor init failure
Date: Thu, 18 Jun 2026 10:21:57 -0700
Message-ID: <20260618172544.338758-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618172544.338758-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260618172544.338758-1-stephen@networkplumber.org>
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
rte_pktmbuf_alloc_bulk().

Fixes: 7c4158a5b592 ("net/axgbe: add DMA programming and start/stop")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_dev.c | 43 +++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 482d3d8062..10ddecf968 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -1011,13 +1011,29 @@ static void wrapper_tx_desc_init(struct axgbe_port *pdata)
 
 static int wrapper_rx_desc_init(struct axgbe_port *pdata)
 {
-	struct axgbe_rx_queue *rxq;
-	struct rte_mbuf *mbuf;
 	volatile union axgbe_rx_desc *desc;
-	unsigned int i, j;
+	unsigned int i, j, k;
 
+	/* Allocate all receive buffers up front. */
 	for (i = 0; i < pdata->eth_dev->data->nb_rx_queues; i++) {
-		rxq = pdata->eth_dev->data->rx_queues[i];
+		struct axgbe_rx_queue *rxq = pdata->eth_dev->data->rx_queues[i];
+
+		if (rte_pktmbuf_alloc_bulk(rxq->mb_pool, rxq->sw_ring, rxq->nb_desc) != 0) {
+			PMD_DRV_LOG_LINE(ERR, "RX mbuf alloc failed queue_id = %u, nb_desc = %u",
+					 i, rxq->nb_desc);
+			for (k = 0; k < i; k++) {
+				rxq = pdata->eth_dev->data->rx_queues[k];
+
+				rte_pktmbuf_free_bulk(rxq->sw_ring, rxq->nb_desc);
+				memset(rxq->sw_ring, 0, rxq->nb_desc * sizeof(*rxq->sw_ring));
+			}
+			return -ENOMEM;
+		}
+	}
+
+	/* Buffers are available; publish them to the hardware */
+	for (i = 0; i < pdata->eth_dev->data->nb_rx_queues; i++) {
+		struct axgbe_rx_queue *rxq = pdata->eth_dev->data->rx_queues[i];
 
 		/* Initialize software ring entries */
 		rxq->mbuf_alloc = 0;
@@ -1026,22 +1042,11 @@ static int wrapper_rx_desc_init(struct axgbe_port *pdata)
 		desc = AXGBE_GET_DESC_PT(rxq, 0);
 
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
-			desc->read.baddr =
-				rte_cpu_to_le_64(
-					rte_mbuf_data_iova_default(mbuf));
+			desc->read.baddr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
 			rte_wmb();
 			AXGMAC_SET_BITS_LE(desc->read.desc3,
 						RX_NORMAL_DESC3, OWN, 1);
-- 
2.53.0

