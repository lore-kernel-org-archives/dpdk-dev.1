Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D75CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A139340689;
	Mon, 15 Sep 2025 17:02:30 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id B5300406BA
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:02:27 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-76e2efbd84cso30479516d6.1
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757948547;
 x=1758553347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enkIeW/0de/kP3Q2u7lws1QiVQmVxKbELny4wiZSCRY=;
 b=L43zpyN2UmNYJLx5UMrOqfAhUHEkyG/72PKEBXIsCwhB9dAz7EJpPc0PKjNovxHTeo
 tRmFnBx9Jy/UO8j+cWqya1r80HuIpwCHYfGTCVvFLfNqxYJKblce0rpSB6g88thRKG0F
 5op3WTucjdK4VtYFRczjJgt0H9LPTXovS+XIssUdU7KFvqoLgzC0HWBI4Brc/YPHkBuB
 3RZWnOmxPCmDt6U51y1NL1Bs+MiB/0n/RSWXUCGSru/yCYz8yvh8oBEp1RjVac6+n8UM
 LvItbr/jDSsyNr1Ya44m5wuOXF1jQompz73ZgSKUN+K/oy9nwf5aYltiPd5oI/IrZvT6
 mFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757948547; x=1758553347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enkIeW/0de/kP3Q2u7lws1QiVQmVxKbELny4wiZSCRY=;
 b=HQNwmaHpsdPpQNU/4WmHJ+Fuoh6K0JsuszYYd2YZ2cWFGagqYCP1dWiocHJGS80G3o
 ggozz4MG1oK6/Oab0E0R7HvJVh70ddiyNLmOJ8vqrJ/a37JEXpZWMkOgGRX9wMkfH6WT
 Mr5o7zVH353SFqIehrcUjDPLJ6/qByDHUOZzeFmKfhhDd0nALqgLALCMlYhORbNSCZeT
 7P1c0r3T0gI4JNpEhES0reTgQwIk9CMobEObM614mwyvc0YCt9CkGjgh2YcHZ8YT7bOx
 S/j4vkK2MDOcI/RpGKma99bnSBHutoMRmqWbqXx2KdlPh8HAFffxml6HAgeKTopQxikG
 7fww==
X-Gm-Message-State: AOJu0YwRA+wJiZ7RGkHyI6BfCSOGDeaAkpbZh/Zcym0X0VOdy09vCCdf
 5BITDVlUw1uFG/ZmQs9JpfghsdLFvpuHWY40DBb+olcApwZFckqg3dUwWb2r41ZQuBt/rg6WkfR
 oaDs=
X-Gm-Gg: ASbGncsuRMjS7nDL3w6YK7J5E5WQVl+qclkKnwbHGrUq/zfZybqcS8IZza47uqFkWxE
 zvJMGC1/+p0BoFS1mRF9aNTSWmb3K16Im7vrIz2W51FX9U/Vep/FUx7FMvykRtJJZJCaHlfdVG5
 2a1JrBU982YtaY5XVTJui/KZs/Hd0eGHaijIe0rAVaGD0wbXl2E2eoRn2xeQkCvtxSEt05M8Kg0
 86bFynM6T4h8AeBXVbrE0EXTNKJOLHl3ooq4KZiwIGHis9KpNkurSysqlJRk6pUx8s7El8BTC3e
 mdssSsNFsMZsEY6T758dkCQGtLM2jO6Qm0S/cZVslxWK5p+SzKc9Nh1Q4XsJoinQmhUtKYenY5m
 6c1oq+uh94Tm30etnF+XcnQr2+50x7uAjCq4AjhOB4I3otmb2Z0IKuXWR8q5zXv1awc7ZZ6Btvs
 UfirOf8bJ3BX29TOA2HXBIG6Bmq67isA==
X-Google-Smtp-Source: AGHT+IHOVwlFUvTXTp2MiD1ubNlcMdvxOYWX3+w4cncx7P8H2uQB/rSJ1LAm6nxG5q+8rfgG0yyHNg==
X-Received: by 2002:a05:6214:c4b:b0:72a:2cf6:76bf with SMTP id
 6a1803df08f44-767c70133b2mr146795276d6.53.1757948546510; 
 Mon, 15 Sep 2025 08:02:26 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783edc88db3sm18930486d6.66.2025.09.15.08.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:02:25 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH v3 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Date: Mon, 15 Sep 2025 11:02:04 -0400
Message-Id: <20250915150204.1719628-4-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915150204.1719628-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250915150204.1719628-1-ed.czeck@atomicrules.com>
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

use 4-K aligned buffers to reduce PCIe requests
reduce message spew
attempt to allocate smaller chunks of buffers during starvation

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
v3:
- Use #define for pcie boundary

The PCIE spec states "requests must not specify an Address/Length
combination that causes a Memory Space access to cross a 4-KB
boundary."  Buffer alignment to 4KB boundaries will minimize the
number of 4-KB boundary in a given buffer and then can reduce
TLP read requests from FPGA to host.

v2:
- reduced message to single line.
- Added comments on buffer alignment.  PCIe devices deal with page
size of 4096 bytes.  By aligning this buffer to a 4K boundary, we
will reduce the number of PCIe read requests.
---
 drivers/net/ark/ark_ethdev_rx.c | 35 ++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 1b5c4b64a4..98fd52949b 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -14,6 +14,7 @@
 #define ARK_RX_META_SIZE 32
 #define ARK_RX_META_OFFSET (RTE_PKTMBUF_HEADROOM - ARK_RX_META_SIZE)
 #define ARK_RX_MPU_CHUNK (64U)
+#define ARK_PCIE_BOUNDARY 4096
 
 /* Forward declarations */
 struct ark_rx_queue;
@@ -42,6 +43,7 @@ struct __rte_cache_aligned ark_rx_queue {
 	rx_user_meta_hook_fn rx_user_meta_hook;
 	void *ext_user_data;
 
+	uint32_t starvation;
 	uint32_t dataroom;
 	uint32_t headroom;
 
@@ -57,8 +59,6 @@ struct __rte_cache_aligned ark_rx_queue {
 	/* The queue Index is used within the dpdk device structures */
 	uint16_t queue_index;
 
-	uint32_t unused;
-
 	/* next cache line - fields written by device */
 	alignas(RTE_CACHE_LINE_MIN_SIZE) RTE_MARKER cacheline1;
 
@@ -187,10 +187,11 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 				   nb_desc * sizeof(struct rte_mbuf *),
 				   512,
 				   socket_id);
+	/* Align buffer to PCIe's boundary size to reduce upstream read request TLPs from FPGA */
 	queue->paddress_q =
 		rte_zmalloc_socket("Ark_rx_queue paddr",
 				   nb_desc * sizeof(rte_iova_t),
-				   512,
+				   ARK_PCIE_BOUNDARY,
 				   socket_id);
 
 	if (queue->reserve_q == 0 || queue->paddress_q == 0) {
@@ -265,6 +266,9 @@ eth_ark_recv_pkts(void *rx_queue,
 		return 0;
 	if (unlikely(nb_pkts == 0))
 		return 0;
+	if (unlikely(queue->starvation))
+		eth_ark_rx_seed_mbufs(queue);
+
 	prod_index = queue->prod_index;
 	cons_index = queue->cons_index;
 	if (prod_index == cons_index)
@@ -453,7 +457,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 static inline int
 eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 {
-	uint32_t limit = (queue->cons_index & ~(ARK_RX_MPU_CHUNK - 1)) +
+	uint32_t limit = RTE_ALIGN_FLOOR(queue->cons_index, ARK_RX_MPU_CHUNK) +
 		queue->queue_size;
 	uint32_t seed_index = queue->seed_index;
 
@@ -461,23 +465,32 @@ eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
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

