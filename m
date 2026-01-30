Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B2EE6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B7340677;
	Fri, 30 Jan 2026 18:35:22 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 8E0EF40647
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:08 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48068127f00so20208195e9.3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794508;
 x=1770399308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1J+D/6wTPbHBG42ig6K1FeXy0o2SOrxUJMQu5sahtE=;
 b=VTH5BDr4iYUM+zoXTtij0W6ly3M+ZXTjJiKUQpMq9VC9jXgdKG3aeKwACI5CLLBvRr
 kLwciMFfVvBIuF8jf3xOfAdIMLO5aMKMLO5z1FyoZZKG9unSaeLJxbMc4dshm7V4kyba
 0D8M3rWEo4np1wV5lR0MCU8hOcrmhfvKW5kz9MNDT78LCFzdcrAPzK52OnfnovZWiNiG
 MKbJGiK7JM/QC3A7MTsoUBMCxYbpseNibwEa7MiVo+D32QqGLaVyNyUNwrT93mqWenQx
 VNBi8hKfFHucyNLn9p2JSK564xx0vzgGQqVhKQsIflzCslgX/JSZzjuaCIT93U7Xm6+p
 28AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794508; x=1770399308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1J+D/6wTPbHBG42ig6K1FeXy0o2SOrxUJMQu5sahtE=;
 b=LFts+oYnXeXVawwAxud2lm3aVdbBvHhIML7hQEC24EV7KCbiJgDoN2eX/o9mp8WkxW
 kx1nxq5uDolHN21QxVYdCTJzNNLT2cq5rDHhwT+3/9sEC/l3ul07IImPs8nD3otAOIDn
 PBecpF9ygUnHjlV6YkchB63L+QgNF8mGh95LBD9lFyDPHOorkb0KBFWhyu8icHlKj0HC
 OPodW/1v0ZhDWNC5bacGfnx9p1PqRk3tSSq0N+azK6mUwgUktONvgo87a/b5s1qvLqj4
 IXyIFyfmbYUitbL7qb8YFp8U2swY6ZHtC3dOaEgeHz8jg2QBntH7MbwWnjhNwaV9TYTi
 jQPQ==
X-Gm-Message-State: AOJu0YzwhoWl58hxQUGkePEFmD0+zXdxjEG+L188BwdEcs5Kge1xF40g
 e6CBLMd6KosEZbovw539Bnx3LKnuB8W2RT4PLRQTQatsA7Khz/PPJHWGQh+4AHjk4Bfir6IGDIh
 +vLM8
X-Gm-Gg: AZuq6aJr+Js6swYnixosigAocNBy+n+lK4HscrMDfPCVM5dyMJPakd11DRnI0NKRbSD
 u3/rNRmL6dpDyy1ByEctBa28USTQIwzMn4rITgfpXawSz/kAxZFlSondUYVtBio3z2Hz06Pb9Do
 ESv0dMLMs2fFYeVTiU/L0wNb9M9aKJ4qkr4Q9bdNOB4zqIeGr9wE2Hrt+7w4DZiQgMd3JP6+B2G
 uG2oG6PU4XmFMriuESXnDSRXI+IYFvCA67gi1B8xwHcXBaIctAle3N0JNZEn9mGQgwhdxxHizGx
 21twCUC/bFTsH8XrpeKQj+JtMvYosaqU/upA3Oj6hwtemxb+q61+yGqjx3LT3SFhQEm38PFoV0T
 RmVB1vYTouAsPSU7F8o+UOFFTet12NPaYLDEkcgppGZOqqKnqFPLqjpLAiuwNeQZxBLHf9yxPvv
 xYyUtaic0ZgZmZUkCH5dHwi4Y4+yV44VNGPPhVQmmLArGhkGwKyR4Itud5pILG
X-Received: by 2002:a05:600c:3f16:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-482db4569c0mr45298345e9.1.1769794508133; 
 Fri, 30 Jan 2026 09:35:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 07/19] net/pcap: allocate Tx bounce buffer
Date: Fri, 30 Jan 2026 09:33:20 -0800
Message-ID: <20260130173447.14546-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

To handle possible multi segment mbufs, the driver would allocate
a worst case 64k buffer on the stack. Since each Tx queue is
single threaded, better to allocate the buffer from hugepage
with rte_malloc when queue is setup.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 41 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 61ba50e356..1a186142d3 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <unistd.h>
 #include <pcap.h>
 
 #include <rte_cycles.h>
@@ -91,6 +92,9 @@ struct pcap_tx_queue {
 	struct queue_stat tx_stat;
 	char name[PATH_MAX];
 	char type[ETH_PCAP_ARG_MAXLEN];
+
+	/* Temp buffer used to for non-linear packets */
+	uint8_t *bounce_buf;
 };
 
 struct pmd_internals {
@@ -392,11 +396,12 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
 	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
+	unsigned char *temp_data;
 	size_t len, caplen;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
+	temp_data = dumper_q->bounce_buf;
 
 	if (dumper == NULL || nb_pkts == 0)
 		return 0;
@@ -406,10 +411,6 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		mbuf = bufs[i];
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
@@ -419,7 +420,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		 * a pointer to temp_data after copying into it.
 		 */
 		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+			  rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
 
 		num_tx++;
 		tx_bytes += caplen;
@@ -474,11 +475,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_t *pcap;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
+	unsigned char *temp_data;
 	size_t len;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
+	temp_data = tx_queue->bounce_buf;
 
 	if (unlikely(nb_pkts == 0 || pcap == NULL))
 		return 0;
@@ -486,13 +488,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		mbuf = bufs[i];
 		len = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
-				len, sizeof(temp_data));
-			continue;
-		}
 
 		/* rte_pktmbuf_read() returns a pointer to the data directly
 		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
@@ -962,7 +957,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -970,11 +965,26 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
+	pcap_q->bounce_buf = rte_malloc_socket(NULL, RTE_ETH_PCAP_SNAPSHOT_LEN,
+					       RTE_CACHE_LINE_SIZE, socket_id);
+	if (pcap_q->bounce_buf == NULL)
+		return -ENOMEM;
+
 	dev->data->tx_queues[tx_queue_id] = pcap_q;
 
 	return 0;
 }
 
+static void
+eth_tx_queue_release(struct rte_eth_dev *dev, uint16_t tx_queue_id)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct pcap_tx_queue *pcap_q = &internals->tx_queue[tx_queue_id];
+
+	rte_free(pcap_q->bounce_buf);
+	pcap_q->bounce_buf = NULL;
+}
+
 static int
 eth_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
@@ -1015,6 +1025,7 @@ static const struct eth_dev_ops ops = {
 	.dev_infos_get = eth_dev_info,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
+	.tx_queue_release = eth_tx_queue_release,
 	.rx_queue_start = eth_rx_queue_start,
 	.tx_queue_start = eth_tx_queue_start,
 	.rx_queue_stop = eth_rx_queue_stop,
-- 
2.51.0

