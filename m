Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572EBCA1010
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 21:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9458840EE6;
	Wed,  3 Sep 2025 23:28:58 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 28AF240ED6
 for <dev@dpdk.org>; Wed,  3 Sep 2025 23:28:55 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-80cc99fe980so42975885a.2
 for <dev@dpdk.org>; Wed, 03 Sep 2025 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1756934934;
 x=1757539734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oK7sRXecBV25WR7AzenlI85P75JgjXfz285wrUQS3r4=;
 b=aK0YnQC9V66rDi8vuCFJEh3pG8cKOgRMVTQYjASS8XcF7pD9c9eYcWYN89E+8pcPsP
 +tbdqjENw1B9VEvNvHMLU7Ut6ea9Cp5bDB8zj189SYV92f5ZpDmgTVlZI7f47ZCpCzTR
 8KUe3jotEU0vFxm/eeJMdMxnII27ghxNU2JdKSdxbqwfoWzVUgubEmWyQ+VoJytSaDbk
 BLsGuA5D8gSsXTiIwKaTwXmev04qxbVFrz80NYcfXVYbguIisWKs7G4SzQ/OShjDcuWj
 dQxyMKjX+Wue4FpRAme1P08YBoOmQtYE2X09K7/DaKp1QMPLDklexFLYOD/15HUC+h/V
 dc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756934934; x=1757539734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oK7sRXecBV25WR7AzenlI85P75JgjXfz285wrUQS3r4=;
 b=S8rktkuW8BrqTGngPgQ/SsxkbsRJtOVc7TipFxzdlUcIXNhRejTNcniDW+P0OhjWcR
 OeU6TICdjvvuxziFiAFlKkLo5MPGg7L8VFBerfVlML67W2IYYNQSLs1Il4d+zBiB3EIr
 5SwqO8jocN2vaffpnuqZ+F4558mFUuJ4r3VRQdS2Gy2Fgj6F/WT8/AJ34uiIJlfEfCfQ
 0eFxIEJ2GW2OcXvjf4N4QGAyCvmqDNhPk8DooX2lY4Qwo6577rYpIBLc5GQQ70XRvODW
 MUuKjBjRqJwCo7kjOlaIBVjr3dlm87U/2P9vwhr7cGQ3kORHBAr/0e3oe9Ny9KEv9+44
 CCdw==
X-Gm-Message-State: AOJu0Yy1A/d/jBSKrNkjtusea8EjzHabjJjW3/R+hAqq/Cx/a1YydSGP
 NLWcpbeGt/ks1Lt0V+3xvpLbMweADDEPPqzG84Npskmy8kKoMo97+1sxBhMMoG/yc67pYKcSMis
 TGYs=
X-Gm-Gg: ASbGncv4Z8c2Mb6qgKalKAvL9lcSP6CAg0pOcaWu+B6ew/qlg7yD1NuEf3mrqtrsM27
 RQZ2DQVDsrRvqpe10+U2hKWBazH1QFQ9yuUV7tRoDuJWxCbk4tiJ26vc7nDEVJ4jlL18q69OaHR
 0IQXh+cDlMRz8xtwPWcWykMbJETht/8YoDuUAhDFOAB2P5ASfG8KO/36cuoCbYIqdZNVM3uaaoT
 sM5APhFJaugYbstEqHeqEgoS4hfIEj3A63AJwa9g0drZCsPjbM52nTpDvc5rG0MTm5B7QE75KaY
 W80gb+OT78O1pACAY2xT/FjnLM8tTNLwqK8xUaafXr+sZ1HTSQ1uzb5btLsZb4a+CULUgQPEQN2
 ZK45/0yj6W4Qvgzu+PdM1bW7w9vQ45EyLHm3jayvJblpSKrKWWeZKuMcpJx+/04tnnDijsZkD+X
 WA35paT98W
X-Google-Smtp-Source: AGHT+IF3rYefRptWojqIK3On6f4uA5V7W2gXqch6Eb8RKU4v1tto+p4nbWJW3B98h8HcwuyISoZaSw==
X-Received: by 2002:a05:620a:a510:b0:800:4027:58fd with SMTP id
 af79cd13be357-80040275aadmr1310466685a.82.1756934934001; 
 Wed, 03 Sep 2025 14:28:54 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aaaa1d6f4sm175929385a.42.2025.09.03.14.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 14:28:53 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>
Subject: [PATCH 4/4] net/ark: improve Rx queue recovery after mbuf exhaustion
Date: Wed,  3 Sep 2025 17:28:45 -0400
Message-Id: <20250903212846.268492-4-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212846.268492-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
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

use 4-K page aligned buffers
reduce message spew
attempt to allocate smaller chunks of buffers

Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
---
 drivers/net/ark/ark_ethdev_rx.c | 37 ++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 1b5c4b64a4..2e7646fa23 100644
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
 
@@ -185,12 +184,12 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	queue->reserve_q =
 		rte_zmalloc_socket("Ark_rx_queue mbuf",
 				   nb_desc * sizeof(struct rte_mbuf *),
-				   512,
+				   4096,
 				   socket_id);
 	queue->paddress_q =
 		rte_zmalloc_socket("Ark_rx_queue paddr",
 				   nb_desc * sizeof(rte_iova_t),
-				   512,
+				   4096,
 				   socket_id);
 
 	if (queue->reserve_q == 0 || queue->paddress_q == 0) {
@@ -265,6 +264,9 @@ eth_ark_recv_pkts(void *rx_queue,
 		return 0;
 	if (unlikely(nb_pkts == 0))
 		return 0;
+	if (unlikely(queue->starvation))
+		eth_ark_rx_seed_mbufs(queue);
+
 	prod_index = queue->prod_index;
 	cons_index = queue->cons_index;
 	if (prod_index == cons_index)
@@ -453,7 +455,7 @@ eth_ark_rx_stop_queue(struct rte_eth_dev *dev, uint16_t queue_id)
 static inline int
 eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
 {
-	uint32_t limit = (queue->cons_index & ~(ARK_RX_MPU_CHUNK - 1)) +
+	uint32_t limit = RTE_ALIGN_FLOOR(queue->cons_index, ARK_RX_MPU_CHUNK) +
 		queue->queue_size;
 	uint32_t seed_index = queue->seed_index;
 
@@ -461,23 +463,34 @@ eth_ark_rx_seed_mbufs(struct ark_rx_queue *queue)
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
+				       "Could not allocate %u mbufs from pool"
+				       " for RX queue %u;"
+				       " %u free buffers remaining in queue\n",
+				       ARK_RX_MPU_CHUNK, queue->queue_index,
+				       queue->seed_index - queue->cons_index);
+			queue->starvation = 1;
+		}
 		return -1;
 	}
+	queue->starvation = 0;
 
 	if (ARK_DEBUG_CORE) {		/* DEBUG */
 		while (count != nb) {
-- 
2.34.1

