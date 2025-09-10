Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CACA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 18:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09FD040673;
	Wed, 10 Sep 2025 20:57:37 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id EC50140672
 for <dev@dpdk.org>; Wed, 10 Sep 2025 20:57:34 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-72226768824so60251046d6.2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757530654;
 x=1758135454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KBt0RzKHwp3LRKKEvLmEQ7WqFMBfzJDm+bTkqJqpec=;
 b=PPmkmXu9CCWbmuMFaFNvi1LBeAkxjwsVwqbbLT9x9x7F9dKIR8NMynE2TtUWpRrhP+
 F8aAZub/HPRSa26hp6VWKYLSy9r6eaQIk7+RKTuKcFbXrAe85qkgFdbw/z5Pl8NFa9LC
 YwxvAks1NSYjXklOe6zBgMAx2gRxVSkgni1EtedAwQg8DAPETfwziXwOD0qEdHy+msj6
 aLtsYDVEVSTP4mgEzFezHtnlS+tc4Rt7ouxnU7rZ/WM5ExzCauhcywhv1+q3QGJeQmQT
 6QUx1fxo2JI3700yx89Af1fjZ7xqK3+ilJehTJVf9EKhGd4UhKUBTGnLQglFB4op/alW
 tdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757530654; x=1758135454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KBt0RzKHwp3LRKKEvLmEQ7WqFMBfzJDm+bTkqJqpec=;
 b=wQ/mOT4e2uk/VH+Bvsjs6+vTss0oHSuHBj/7T1WpmeewKmTghsBmCk/C4LrIdZWaBm
 lQEGP3fRgSwjW2S53NxxY75DPyDAJ0pofDdJpgrMolxgKXhf1U0HkJxN08YIZ3eL4/Jf
 Mb2vIzOl8kf6I3POUC7BwTstiEMvcZtk5VFYmrKKnYuUqbGIafd8qaS1pu2g76yoBmRC
 0DpxKCtfsAu+AiQi3YduK/opTprkMJp4Ow77v65c+TU6UpokEAl0lJ+eZdBA6PT/d4yb
 luQVVxWMFLEfD6zKbbqD6yjhme/ihjPmUlBS2yA49okqvD44wyiuqNU46fT0RNFD6TxL
 ryjA==
X-Gm-Message-State: AOJu0YypYidIlC/Lz36Te4MCf52L8joHAn2BLxDCJjYdHBTqLQYaaIVX
 U1VGsXFL+JhFf8Th6XIuzHPtstxEQ7Kd0Ti3gVTRLzbvRu9BXFWcbuEfC+At6PhDRB/aBQ8zMwe
 568U=
X-Gm-Gg: ASbGncunDdR9UztMzRMLY6OjPhRboP0dlzY2LOErmDP3NFeToeBh2AyIxiO26NuUdqj
 g8SKPSC0KBWvvarxnycqKUxPvLM3mmn4hRFsSJmNHl8S9cKohaMJC2yMinOFa5462G58rwFV9aT
 /PIHKfd05o73RdCXmcNBSKZPyOAn3x6gBCG+dG8C0xSXLa668ayVC1PmJO4EpmIhL5gWo8MQibO
 5cwtwL/blwE/nsnpc8ko2Nmf0m58ArZ4a9HveJFXdhKFRxproRbIx4iRzz9d5YHr9ZtxfM9z/Ot
 EwuBpzRVKo0uiesm93kjRDPXQ3aGyCxtXr9AoAKSDnQPBlf3nphsObpd0klsrtNEKjR+o1E+72V
 TewzdfcwK/16DpRvo0mL9EN2eDHbKsnPOxscXerL5KBEP76yTsyo9v+dsC2baNhwC6kYIS5yUGP
 JZflSyxsTz
X-Google-Smtp-Source: AGHT+IEla3Xob6mnB4nRAMrAdFm4xpAWKYiqnMaao/9FwCdjZv9h3/W3xksFLKzbqloyYCwK+IgsIQ==
X-Received: by 2002:a05:6214:5bc6:b0:73a:b556:43a8 with SMTP id
 6a1803df08f44-73ab55643e5mr146133946d6.24.1757530653778; 
 Wed, 10 Sep 2025 11:57:33 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c955968csm376176d6.73.2025.09.10.11.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:57:33 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Date: Wed, 10 Sep 2025 14:57:20 -0400
Message-Id: <20250910185720.995300-4-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910185720.995300-1-ed.czeck@atomicrules.com>
References: <20250910185720.995300-1-ed.czeck@atomicrules.com>
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

use 4-K page aligned buffers to reduce PCIe requests
reduce message spew
attempt to allocate smaller chunks of buffers during starvation

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
v2:
- reduced message to single line.
- Added comments on buffer alignment.  PCIe devices deal with page
size of 4096 bytes.  By aligning this buffer to a 4K boundary, we
will reduce the number of PCIe read requests.
---
 drivers/net/ark/ark_ethdev_rx.c | 34 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 1b5c4b64a4..74f6d70d1e 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -42,6 +42,7 @@ struct __rte_cache_aligned ark_rx_queue {
 	rx_user_meta_hook_fn rx_user_meta_hook;
 	void *ext_user_data;
 
+	uint32_t starvation;
 	uint32_t dataroom;
 	uint32_t headroom;
 
@@ -57,8 +58,6 @@ struct __rte_cache_aligned ark_rx_queue {
 	/* The queue Index is used within the dpdk device structures */
 	uint16_t queue_index;
 
-	uint32_t unused;
-
 	/* next cache line - fields written by device */
 	alignas(RTE_CACHE_LINE_MIN_SIZE) RTE_MARKER cacheline1;
 
@@ -187,10 +186,11 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 				   nb_desc * sizeof(struct rte_mbuf *),
 				   512,
 				   socket_id);
+	/* Align buffer to PCIe's page size of 4K to reduce upstream read requests from FPGA */
 	queue->paddress_q =
 		rte_zmalloc_socket("Ark_rx_queue paddr",
 				   nb_desc * sizeof(rte_iova_t),
-				   512,
+				   4096,
 				   socket_id);
 
 	if (queue->reserve_q == 0 || queue->paddress_q == 0) {
@@ -265,6 +265,9 @@ eth_ark_recv_pkts(void *rx_queue,
 		return 0;
 	if (unlikely(nb_pkts == 0))
 		return 0;
+	if (unlikely(queue->starvation))
+		eth_ark_rx_seed_mbufs(queue);
+
 	prod_index = queue->prod_index;
 	cons_index = queue->cons_index;
 	if (prod_index == cons_index)
@@ -453,7 +456,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 static inline int
 eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 {
-	uint32_t limit = (queue->cons_index & ~(ARK_RX_MPU_CHUNK - 1)) +
+	uint32_t limit = RTE_ALIGN_FLOOR(queue->cons_index, ARK_RX_MPU_CHUNK) +
 		queue->queue_size;
 	uint32_t seed_index = queue->seed_index;
 
@@ -461,23 +464,32 @@ eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 	uint32_t seed_m = queue->seed_index & queue->queue_mask;
 
 	uint32_t nb = limit - seed_index;
+	int status;
 
 	/* Handle wrap around -- remainder is filled on the next call */
 	if (unlikely(seed_m + nb > queue->queue_size))
 		nb = queue->queue_size - seed_m;
 
 	struct rte_mbuf **mbufs = &queue->reserve_q[seed_m];
-	int status = rte_pktmbuf_alloc_bulk(queue->mb_pool, mbufs, nb);
+	do {
+		status = rte_pktmbuf_alloc_bulk(queue->mb_pool, mbufs, nb);
+		if (status == 0)
+			break;
+		/* Try again with a smaller request, keeping aligned with chunk size */
+		nb = RTE_ALIGN_FLOOR(nb / 2, ARK_RX_MPU_CHUNK);
+	} while (nb >= ARK_RX_MPU_CHUNK);
 
 	if (unlikely(status != 0)) {
-		ARK_PMD_LOG(NOTICE,
-			    "Could not allocate %u mbufs from pool"
-			    " for RX queue %u;"
-			    " %u free buffers remaining in queue\n",
-			    nb, queue->queue_index,
-			    queue->seed_index - queue->cons_index);
+		if (queue->starvation == 0) {
+			ARK_PMD_LOG(NOTICE,
+				    "Could not allocate %u mbufs from pool for RX queue %u; %u free buffers remaining\n",
+				    ARK_RX_MPU_CHUNK, queue->queue_index,
+				    queue->seed_index - queue->cons_index);
+			queue->starvation = 1;
+		}
 		return -1;
 	}
+	queue->starvation = 0;
 
 	if (ARK_DEBUG_CORE) {		/* DEBUG */
 		while (count != nb) {
-- 
2.34.1

