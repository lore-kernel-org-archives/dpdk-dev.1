Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A527E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8665C40695;
	Tue,  3 Feb 2026 00:13:07 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 5CB554066F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:05 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432da746749so2852758f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073985;
 x=1770678785; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLCtjq/yCmh0mi0gPys6ayLsb/ztdx36b1x5ujqKU4Q=;
 b=Rjb6E2KdEH1bZaW8CXJUIeihEmDqZ25YWfExPuRnokTcC822laynRRbUcL3faV2edQ
 zzWtrPAspP7JDpfkYymnNC6Ee0r8ajqlpWPxynitORTbjw09gDbESJVvFBRin3nqyY0b
 cJOt64FmHS+1Bq0VlIwQAQ1GE8klKuuh/lPa92vSefgLyOJ2aLjhshlluki2yQiP1xi/
 G/4lMFlCtzUA6pUnfqlGtU9ocPbEfg0S/BPiprwYkqFxGIdjurK5t8P0x+POePKxCqcI
 liVkeEiH805foGMwfkes0WcJ3G6FwqGwRIfnS0yOOHYm1mJp1BsiadBQnglXh29j5ZUU
 oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073985; x=1770678785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLCtjq/yCmh0mi0gPys6ayLsb/ztdx36b1x5ujqKU4Q=;
 b=u/aM+kkKA07wHhO9OWCmlAUvomjJBnd1+2Pf3dN49x4npcUHy5ihkgkPnU4dFpXvB0
 wq3YjNEh+fJmvW/QD7SXtbiI6HYbhKnyNqAdNRkYB2owyFNX9CdWila88BcbsIybkg0C
 wCdyJNyqa4jPQiD6nQL9a976CE8nOnWztx1lmxhG0YUGZQkvYWYk6HufUsPJjcZr7IMJ
 McuPI8HebdylHz+gk4M0IrDvAzVL8XPQC967NL8oawUObRDww+F2chjLQ99yq6SJxhnz
 d1w7+0kHTvzmbmgFxCF0bj8cAojI6yAK+0Du9CfmuSXi057iMy8xYQYN0ctHU489AGxf
 nuPA==
X-Gm-Message-State: AOJu0YzdMY1jf9Ba4jer/XBhGM+onulj2/Q4ejBX+YqQDsvxefLvw5/8
 ZHY0f76peCsxhXD5PgW8BUTJH4sVvQfJ9AfHciLkk4G0rkABBhhPmqIi+vfVOIs5tEpv+aHWe6B
 honkr
X-Gm-Gg: AZuq6aIV36K7VmEu7FtrrgfKxkI3UMhlYpnSOBtJL1eUG4rNYoSr1a47V77lzjkAYnQ
 hilI9dh29Cz+jUniSPmg/YWRtLcLJ/DXSMnonlIODkwGPEN+fsmMhDGMBja1HqsKlSVNNVPS+oG
 O5m9KslxPQD2krqVlicsxF/cbF1I5tHdrxjmZDmHK/2w1lA6rAQyIL4+laa3Q3v9sIDrYHDUb8d
 uEP9AZqKAjQs0FGp4++jelFPjSNogiIacE+2FIIWcZeEtzmd1slkydaN1nMofq3XlfATcoMdPYS
 SEeMcXbDl5A9wHrjka3w8ji+KLMJQyWY+Nn3ZcDzBDCFpo5+nDQnwoegGQgL8bW4GPg6x4E802U
 zAQjMFutT2H6iaqWKU8yswA2jzxfasi0vL1YjZTDF383hkQwmim7NfGucv58GSgqN5jud4A0SGv
 PdJHw9tCTd8eBiDs5ywt5UirXAhbLBspr0OsO1GqVI2JPFeIv9tA==
X-Received: by 2002:a05:6000:3105:b0:435:db9b:5eb5 with SMTP id
 ffacd0b85a97d-435f3a7dcefmr18631131f8f.3.1770073984901; 
 Mon, 02 Feb 2026 15:13:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 07/19] net/pcap: allocate Tx bounce buffer
Date: Mon,  2 Feb 2026 15:09:10 -0800
Message-ID: <20260202231245.216433-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

The buffer needs to be come from huge pages because the primary
process may start the device but the bounce buffer could be used
in transmit path by secondary process.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 41 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 61ba50e356..a89379ea9c 100644
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
+	/* Temp buffer used for non-linear packets */
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

