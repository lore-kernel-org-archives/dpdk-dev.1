Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5877F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67C9B4069F;
	Wed, 15 Apr 2026 16:48:21 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3A83340687
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:19 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-47952228f05so1992005b6e.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264498;
 x=1776869298; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyalasysJlPdibjKnXvfd7oiWH3kcw+5X46h8LoA3C4=;
 b=BMirlDNlWMNyU58+h+BTzKu92K+/h3RhkeU8Z5pfdQFNLm9Cc43/8Eq9GsYzlgLROE
 pgmQ43WtZDcXbUTEjguW73ZCy2qFsN8Tc3W+P0QYRR9LIipHBtY4+U/W5J9vnenQpOWZ
 dFEkDlv55pCwNSnU/NIjzPkKDuDA5hn373QMimsW2YzJw3AixCq57esLqpn7bf7PXn4P
 2lcwlTle0FW6r2JqUymTyrvU1Nzu23v2ljiho9mq/VxD0HmPR0BMPEWxduTwIuuujPPH
 SWGMFbOdAI86ILdhqjFsZf4eUzBCRhEJNxGjMVXjrHZ58ZqqSyF1dPvfCawvLFO4NnKj
 zK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264498; x=1776869298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZyalasysJlPdibjKnXvfd7oiWH3kcw+5X46h8LoA3C4=;
 b=Ppun1m8ioWRZs5Bl5S51vjjj0+d4UmEC8LSoBE1SJjoMyLyDAroqZ65uEXmT3Ottdw
 Uhl95exBVaVKPXjAE3Q0BrZEMymni/ZBcOycKDGsX58RHdPI8QoQJmgMbiZHo6edm5yZ
 VaT1vAVVA8W4Rpz01EBctDEvTvtGH4WJUjEFsAqrHgIMq07GonpBblihr0Yl/BZnIHAz
 BgNKwUbq11diMaUVpzAoFgLkfXliyDI/ysZ438PhuHX0Q9h/XZnxXMsLbgrhTIPWmkPI
 XzvEUSmgTIWXt/Dd/PaT3vC0g80pSCgLBI4h1hdnPgeQ90BZWc123coRkZM2oYhYzbgE
 Og5g==
X-Gm-Message-State: AOJu0YwFPMgjpcjX8TSInSDC3WHSiSg9TOvohAnlFvL2eWT7tGXkVj5o
 tKbw3Bnmwz4TrYC2R+iK2Q25/+z3r4JX76o6yrg4f/rq6xYj38y8JoDUctxcbGSsfJeXSxHrLTD
 d32sR
X-Gm-Gg: AeBDievBax+9zpDr7M62/qAFRtRa4TZRnjRardLUmn3rS6iFbf2sNBiY/ao61lTzGpt
 sbsi5YplD2srhfLV8B3cVbw54dHCVYvl/7P+2qj6dYsd0LJrYa0q1uMg0P08+fGNSZqRLY3q7Ii
 RElgoRC7iRUwDViR4gLg8uqSQ1qQXXO879TKDs/Cxvwjs5LHHMxL+FFnm6IjKl1lugNrfWGQNyo
 s/ovv7Q9aL2wOHKrRMuUP6m8Gu2LZpZJhxpywZgCdg9hd/caTaytbOfBYQRDpu7fRZ0jR/2gYjm
 P3ssODYnDRNsfESTrYbLmSJiJmdYfSbo5hJnW3asg4NdgdiF60RwoVXYzSEfksf6EjggWVLHFcN
 GuNA4SIPGdVlsZswfxCM2RduMnykoa/F+nJJueEvEFBeAg+0jeGy1xjAvLAocYpLyNI823cDzED
 herlYgTvWQbJbNJsVI1cdQfRV4Z5QCsddKu7gv2C+N7hc=
X-Received: by 2002:a05:6808:4f21:b0:467:d71:7f1a with SMTP id
 5614622812f47-4772c385991mr11092419b6e.21.1776264498404; 
 Wed, 15 Apr 2026 07:48:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 08/24] net/pcap: replace stack bounce buffer
Date: Wed, 15 Apr 2026 07:45:57 -0700
Message-ID: <20260415144717.226161-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 60 +++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index ebc96fafe5..02d5cb591f 100644
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
@@ -404,12 +406,11 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
+		struct rte_mbuf *mbuf = bufs[i];
+		size_t len, caplen;
+
+		len = rte_pktmbuf_pkt_len(mbuf);
+		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
@@ -449,9 +450,6 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	for (i = 0; i < nb_pkts; i++) {
 		tx_bytes += bufs[i]->pkt_len;
 		rte_pktmbuf_free(bufs[i]);
@@ -460,7 +458,7 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -470,30 +468,30 @@ static uint16_t
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
@@ -966,7 +964,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -974,11 +972,26 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
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
@@ -1019,6 +1032,7 @@ static const struct eth_dev_ops ops = {
 	.dev_infos_get = eth_dev_info,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
+	.tx_queue_release = eth_tx_queue_release,
 	.rx_queue_start = eth_rx_queue_start,
 	.tx_queue_start = eth_tx_queue_start,
 	.rx_queue_stop = eth_rx_queue_stop,
-- 
2.53.0

