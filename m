Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18340D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1631E4067A;
	Sun, 18 Jan 2026 17:59:59 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 73D3D40677
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:59:57 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so32041295e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755597;
 x=1769360397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouObco+SCq1Q/HgpjeOSJtfATRpw+prig6ES3tOxWpM=;
 b=pFKsTStNHIgrdlpE372mYWaAXLHG1jAioPBgcwtHJHYsetsxPiV9EzVl384SVHptBP
 8rRid6DLq7On+gzco/nDyV2zeS+1v5S9OsMc0sxVNXSxgUQtXLA+HT/IP4UNVup6Gh+7
 lDSH8LXdGvOOM1CUsDJ8j1jnlluaPhec4YC0u2Brq1+MXL1V7g7oOFPuxzvI2Rp9c8dh
 A8lL9ib2SGnF7UtLXp0u8zvr0gvzZl0Xt4RCyaeOXE1Oam4gH21kyW1ciZO6RSofy1sM
 21ZxI3q+Nd0Abux9UZc3KpUxrbolNkXKVNE1TposKzMqP5wPoTHdd8g8rwpeRtoiuXTU
 xXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755597; x=1769360397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ouObco+SCq1Q/HgpjeOSJtfATRpw+prig6ES3tOxWpM=;
 b=f1mr4PfQVv8Z9HMsOwcETISYUifvYIvmttN4OSjAaw5MENzv4YltH/7EJKYawQQsnp
 cGLt1mLtkltzG/7KQS5Yja1qiOuc5s1G5QUeMRC3CtSfob+7LY2dJr+zUo3Mj4BlHkqp
 cGi1ONZEdttRhTcoMm4EiYuyJZ7rxkee1RDNtW7PIFpPWCxAUDuqGytLoeKAxvpd7hDx
 6waFlbH8eeWlS479/KYQqyGEvkHoHjM9k/+eu1/sCkObh6U6e3//yKshUpCGWKp4hlQ4
 dC4CodSNZAM0NPlm/9iaSuBsTgvK8TYF6Tb8aV9kUi+JXXvthyxs2UhFE3IM57aojxyO
 48yA==
X-Gm-Message-State: AOJu0YwQXOzQUVOYtoALRR811GeURSgdV51F9IslKxwCXT8sH+yFSZQi
 0VwHDxfYfOVRBuWMXWmmLpnIXEfgNF/CvoBDPwatwiYjHFcRvISBMt9xCViZXzkP+Gooxsy4IxA
 GCCyt
X-Gm-Gg: AY/fxX5ic22smuuiKhLS7ZGTKUdTGyt4AxIk02vZlXd02MWCcULiDjX2j0GAwJ/fSGu
 GDaLf1WXIkCl+YMrbgoeYuKdgnSPE98HSBK+8/LGKUsBRQzapK2pmGlauw+62l+Zk33xQYstYZc
 /AgkXkx2zU6GeM7WkfZ01LVyAmMSwZVeJaDPlBXQjDYNEtI1XqugdCrr6GnZkEkDnCpUcJbrJ5H
 vz0mSpwPFFZnt3aKkrItW9NHvCWccwycDEzfKuFQfeMktrP7tIa00XjvounvjlG9gZ7uN+Kk02t
 a9IKlBCnYr/2NHZAtL/L9Q6woLuymDXwsi9AnAY/8B4bQvUBOEUUiC/iHX9nTgmdZaHRT2uFmP9
 pVwKAbsQU7GuxjvL4DRfuFxAhXijW5QU3ZIEA0jd7LkwLZ6oOOGwwBjmk2RljxEhFA+JMo8GABH
 m4bALwhjzb/LsnE55bro5hNbsDKnT1reLACVtemj2a3NlB3WiMrZe6HVZfjIiM
X-Received: by 2002:a05:600c:4448:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-4801e2fdd54mr104031005e9.6.1768755596945; 
 Sun, 18 Jan 2026 08:59:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 03/11] net/pcap: cleanup transmit of multi segment
Date: Sun, 18 Jan 2026 08:58:38 -0800
Message-ID: <20260118165944.41374-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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

The driver was not reporting multi segment in offload
flags but it can handle it.

The logic for handling transmit would allocate a worst case
size buffer on the stack which could be up to 9K.
If packet was transmitted larger than that it would get
truncated and log would get flooded.

Instead, allocate a buffer on stack only if necessary
and gracefully handle errors by incrementing transmit error
counter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 109 +++++++++++++++++----------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..e86aaf8bbc 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -22,7 +22,7 @@
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
+#define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
 #define RTE_ETH_PCAP_PROMISC 1
 #define RTE_ETH_PCAP_TIMEOUT -1
 
@@ -370,6 +370,21 @@ calculate_timestamp(struct timeval *ts) {
 	}
 }
 
+/* Like rte_pktmbuf_read() but allocate if needed */
+static inline const void *
+pcap_pktmbuf_read(const struct rte_mbuf *m,
+		  uint32_t off, uint32_t len, void **buf)
+{
+	if (likely(off + len <= rte_pktmbuf_data_len(m)))
+		return rte_pktmbuf_mtod_offset(m, char *, off);
+
+	*buf = malloc(len);
+	if (likely(*buf != NULL))
+		return rte_pktmbuf_read(m, off, len, *buf);
+	else
+		return NULL;
+}
+
 /*
  * Callback to handle writing packets to a pcap file.
  */
@@ -377,46 +392,43 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
+	pcap_dumper_t *dumper;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
-	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len, caplen;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
 
-	if (dumper == NULL || nb_pkts == 0)
+	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
-	/* writes the nb_pkts packets to the previously opened pcap file
-	 * dumper */
+	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		void *temp = NULL;
+		const uint8_t *data;
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
-		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+		header.caplen = len;
+
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (unlikely(data == NULL)) {
+			++dumper_q->tx_stat.err_pkts;
+			continue;
+		}
+
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
-		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
+		tx_bytes += len;
+		free(temp);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -444,15 +456,15 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	for (i = 0; i < nb_pkts; i++) {
+	for (i = 0; i < nb_pkts; i++)
 		tx_bytes += bufs[i]->pkt_len;
-		rte_pktmbuf_free(bufs[i]);
-	}
+
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -462,15 +474,11 @@ static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	int ret;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *tx_queue = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_t *pcap;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
@@ -479,35 +487,31 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
-				len, sizeof(temp_data));
-			rte_pktmbuf_free(mbuf);
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		void *temp = NULL;
+		const uint8_t *data;
+
+		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		if (unlikely(data == NULL)) {
+			++tx_queue->tx_stat.err_pkts;
 			continue;
 		}
 
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
-			break;
-		num_tx++;
-		tx_bytes += len;
-		rte_pktmbuf_free(mbuf);
+		if (likely(pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
+		} else {
+			++tx_queue->tx_stat.err_pkts;
+		}
+
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
+	tx_queue->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -745,6 +749,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

