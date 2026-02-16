Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8731E83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 787B540693;
	Mon, 16 Feb 2026 19:14:24 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 55A4940673
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:22 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4362197d174so2331558f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265662;
 x=1771870462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+jD9ABD9JOm+QJjM0YR4HIUEuQzTP0rFoibB9IpyPg=;
 b=fji9vz78UCfn7qk2suHtR/eYKEOFSTZ0dJwfrjKi6H66fZBxU290TO19NxTx0lgye9
 10xdpKmm4L0VS/ntkeYANg6i2JxD9r1nu8ViwsijD/qk6bSopPxknGYw+dnhThN+lv+E
 15r6uWmO5iZd9Q1QPSIIxRMrcQB9sIkeH6cGeZ4DNrhwH4RfH9jMoHh6o6ze2yAVzmfl
 xLH0BM9WJxWTF4XciA9EZW2l6UvQ1sdxBDkGKUCCq5wBwGXblkXn/eIMHIcuUmE+dTgH
 NmKEr0LD+pFs53cc7eIVqkWh5tDwfi8ajte2Q3VqeaeScxENDZXMA66rtc10juA4bHo4
 fY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265662; x=1771870462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y+jD9ABD9JOm+QJjM0YR4HIUEuQzTP0rFoibB9IpyPg=;
 b=mUnKRvBugevitStz+VxTlzcNUz3y40KVS1xcv2V8dG6K9uKq5SQF8Xslms6gJ2RWln
 pBVwo67IO7L+fm4amZa0gYwDcuBXYxXEhltPXhoL0x6xtotdrTKtEX7tCQjB6Re/Lzme
 88gKekCZIbwN1rqbiQjD2MLYrWOELnzJyywUGjrHL2p6sVbEtN8g4A4+/DztteHzB3ac
 N6L6FmkMW2Z+IOUAeAPys//Xu1BZ8SKKJfDSBAlkporPTfwTQxbvWKNM8Ur+xj8dZrgd
 6jTeVhEXw7bAooEJv+G9igstFaoH+YJ4Kum+xDNj3q2akoeeWMQdGPxK+yJCRukxdX6n
 3P/A==
X-Gm-Message-State: AOJu0Ywi/uoO5jx05+aaAjLYLglZDXwGBB67OvfJZ6iiTcx7/UeR/hLr
 rtB5KxJahi6Td+sweLLiwFF0IXTBdSEFhdSWZJSD28SrQOVWmZWdHOgumxCHzEP1U4VZdKR+snC
 yXvXc6EU=
X-Gm-Gg: AZuq6aIaqxqpiqZkikeH91rFKs0MlPVdMNdrgVNXB84zsGwuVdRQTUX982e4zRyx/U7
 iQ/4+YcDdblpfXbH2mTfPxlRbZAGn7OsLaxiFyKQqXwaulzeMybK4/b8OgUbFnI8gdXx/+iHm3r
 RLnFxgEhCrRBCNQaPaEbwDYuuSQRmEFjKXk+eF2nJosQ4xFavjoEPKTXuoz4NI/vsmz0DJtYUOH
 2lF9dKSVIvHCDSodgc/oRckNni8EIN3rZlwGF5WgLIASHoGstcs5g7QvpfD1oclDY1IwVCgqNyp
 DQ7qit8VhkJCM6xQzYUMdvEwzAPKfjLE5SwT+MYxKDRO3NOeb8FqKxquhmdFpCH7qGLRsGA4HYC
 39R3mXRSStOs3F00LZ6kMVddQIB95FVrXKtr89zaKZdoksfdhEccUHIv0/Iat1UqM3X6OkREf8X
 R3FkZ32/bJQCYPr2HZgiz3I3MS2sXlo+w54fWdi8IWeZ6YTediqE6o2hQo5BlSlQ==
X-Received: by 2002:a05:6000:430b:b0:436:30b0:759f with SMTP id
 ffacd0b85a97d-437978dc8f8mr20666488f8f.27.1771265661851; 
 Mon, 16 Feb 2026 10:14:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 07/21] net/pcap: replace stack bounce buffer with
 per-queue allocation
Date: Mon, 16 Feb 2026 10:12:02 -0800
Message-ID: <20260216181407.428877-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

Replace the 64K stack-allocated bounce buffer with a per-queue
buffer allocated from hugepages via rte_malloc at queue setup.
This is necessary because the buffer may be used in a secondary
process transmit path where the primary process allocated it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 57 +++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index fedf461be4..4cf5319839 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -91,6 +91,9 @@ struct pcap_tx_queue {
 	struct queue_stat tx_stat;
 	char name[PATH_MAX];
 	char type[ETH_PCAP_ARG_MAXLEN];
+
+	/* Temp buffer used for non-linear packets */
+	uint8_t *bounce_buf;
 };
 
 struct pmd_internals {
@@ -385,18 +388,17 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
 	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len, caplen;
+	unsigned char *temp_data;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
+	temp_data = dumper_q->bounce_buf;
 
 	if (dumper == NULL || nb_pkts == 0)
 		return 0;
@@ -404,12 +406,10 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
+		struct rte_mbuf *mbuf = bufs[i];
+		size_t len, caplen;
+
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
@@ -449,9 +449,6 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	for (i = 0; i < nb_pkts; i++) {
 		tx_bytes += bufs[i]->pkt_len;
 		rte_pktmbuf_free(bufs[i]);
@@ -460,7 +457,7 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -470,30 +467,30 @@ static uint16_t
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
+	unsigned char *temp_data;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
+	temp_data = tx_queue->bounce_buf;
 
 	if (unlikely(nb_pkts == 0 || pcap == NULL))
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
+		struct rte_mbuf *mbuf = bufs[i];
+		size_t len = rte_pktmbuf_pkt_len(mbuf);
+		int ret;
+
 		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
+				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
 			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
-				len, sizeof(temp_data));
+				"Dropping multi segment PCAP packet. Size (%zd) > max size (%u).",
+				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 			rte_pktmbuf_free(mbuf);
 			continue;
 		}
@@ -966,7 +963,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -974,11 +971,26 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
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
@@ -1019,6 +1031,7 @@ static const struct eth_dev_ops ops = {
 	.dev_infos_get = eth_dev_info,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
+	.tx_queue_release = eth_tx_queue_release,
 	.rx_queue_start = eth_rx_queue_start,
 	.tx_queue_start = eth_tx_queue_start,
 	.rx_queue_stop = eth_rx_queue_stop,
-- 
2.51.0

