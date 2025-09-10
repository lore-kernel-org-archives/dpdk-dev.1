Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55078CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 19:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C792A40687;
	Wed, 10 Sep 2025 21:04:55 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 1C54040663
 for <dev@dpdk.org>; Wed, 10 Sep 2025 21:04:51 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-7222f8f2b44so62237286d6.2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757531090;
 x=1758135890; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KBt0RzKHwp3LRKKEvLmEQ7WqFMBfzJDm+bTkqJqpec=;
 b=LuG2vR1f/D59nBYQ1rVhd6wqWos66FIzQ2SN3Ulin3CL+/fXVQm3xgyFytlZKTOUoD
 NRVsWhIQcRmykbHkrCEZptQb9pbQPDJE9CJ5wynUtUcbtrFO+xIrReVJsN78ZTRs+xFA
 BpCYnJ9xumYwu5gYj1muKzp3RZTbiiytTJTGG01JhaDGmUwjmJsMcZjDE6JiV4wJ5OKl
 gX31cYs8gvEdwf3VEj5QBSAwPAeKpopNERlPHHNEBhaVYkw6YaPmSkwfMfrJMGILcXyL
 q8NxqHgDob5bQNrQjBzfK1R0ng04sqos9TK6R3rVw/3S+Ox++z/q14kji6hWX2jCj0JW
 DSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757531090; x=1758135890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KBt0RzKHwp3LRKKEvLmEQ7WqFMBfzJDm+bTkqJqpec=;
 b=E5W6AZikflNwp5Fl61jOOF4u6u7xwx0DBT8LRK20MTqLaeU2LvtDVOmtxbzM2Tvveh
 dVwim45HfKucD+FD9oswUa8OS3LyRTRXREVjisOKUcWBg06fgY98swglEWhZEJtmstfr
 ug1imE6dB1CJz8+eY6XqAlD39ZTo1CptNwd8gOKjN2cz5Uvs6h9t/fRPxolN1wjcTtcn
 Q9I8paCoKSJpp9nUWiG2smSZMc+HdRn4wvqxl0hpBCRHpvh3HlOGtXs7AVEvTmvt6SW7
 ayodh9wD7SP7hL35Jk3Hqnafan2u3y4wl9B95YyY/Xy1kC5glLTnWHqg/eHtoHmUBvnR
 2sLQ==
X-Gm-Message-State: AOJu0YyULqCugg1lm+mTf2sTIBzGvA9z/0zaKkJ2fF1BZ95ZbObxukha
 PgiTmmZEzR1OmPXUMx7/A8+oUxuUiz+EV37PGM3wOLqslKH7m3FRjN6vSUtcJdGK4JAkDizJsY0
 CETg=
X-Gm-Gg: ASbGnct8oqW61AGBLlwWL1JyrFFDPVA/JwHllV4diaTKQjU/nztIfynrtPAnVlv50oH
 PfKso6C1Y9ekZ+g3nSrkX1FSP0KZGgaTbOiONw3avpIsfMhid+bnxqVlajXsDH6I13QHhU0MUbq
 +D1KPLqqRzvOrf2LwfUgJWoWCEL3tuUw1UnkB2QAjuDk9pPu7TiJiXt/D0yZwi07kBhK/Hj7kXw
 lPG0/ASBz25YmSGAmT7ZsMNmT4dPCbjPpKYI1PnEEKheFWrAm3Vp7zzmiAHnAc6spwjYPcNLax9
 Cy2MY/zphWb2R7x+LLPcBZW/Lt0HM3ziCHUB47wG3DffLOziG2gc8O9snOGxjGySFQFmV5SpxL4
 SfUmoTf5MkngPBTj+FwUY2ZmCIv0BjApLZlLXSLm13BTekx978g61WMVE4CUHF9Df/F95ELd9L9
 l+GqwdGE/FJgu3ojCFon4=
X-Google-Smtp-Source: AGHT+IGLKtrBavnUiQNCpbQoht+40isvVjhxNVxOMeeaz0DxtIbL1auipWTeI0Rt6qitwwCT4lqBmw==
X-Received: by 2002:a05:6214:f6b:b0:72b:b049:758b with SMTP id
 6a1803df08f44-73921b43972mr194082546d6.23.1757531089963; 
 Wed, 10 Sep 2025 12:04:49 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c81319e1sm488856d6.61.2025.09.10.12.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:04:49 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v2 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Date: Wed, 10 Sep 2025 15:04:36 -0400
Message-Id: <20250910190436.995899-4-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910190436.995899-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250910190436.995899-1-ed.czeck@atomicrules.com>
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

