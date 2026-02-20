Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC858C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8F444067C;
	Fri, 20 Feb 2026 06:48:50 +0100 (CET)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 35E3540670
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:47 +0100 (CET)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-895071c5527so19620316d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566526;
 x=1772171326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+jD9ABD9JOm+QJjM0YR4HIUEuQzTP0rFoibB9IpyPg=;
 b=B7Ax87ig/NV8YlwuEikYI29iHIYZE4n1UfERtmbTEgJuuwUI1P8mC/TJ4NTKgjkX7w
 xY56VbXaCTKLhVaattou5Vt5O3XIGZvELpUulZmWxBBc1xuZSmlcd03feQ+mWZAtdxx4
 +rDI1b5x32pExliomIpoYPDUo8YSsRXrG8DlTPN3PSDNvxa9+m5OfJLCkZBBWAugWAjR
 dulJG3ur7dCf3BhzOC5UjvgE1KGOfhpRDqn/znr55eLEGK4TGboFERz42VGVq6xR9S1Z
 EFpjs/PQcKSTAZJKx6rwWt9uZfltQlijIK6R1zRyV9ZUgETKVJ5YtoOrDaIxbag9aKHM
 +R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566526; x=1772171326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y+jD9ABD9JOm+QJjM0YR4HIUEuQzTP0rFoibB9IpyPg=;
 b=goLDNOJRlXoTlcYTs9h41NAnS7ZVTNGZHlict0OQBgg5NAcjEszwHw/jdazWt37HSn
 duCM/x0yLxMR+vV3xSGGRRoRQ+mIGtSvwY0vVqCvxAwhe3pU43LiL/+j9xmgEBUtjDOo
 W8kEXsbp/4mexbZWABAaSPVYROjF9o7B2l5nXxUGUH7Md6suPWCtelKmSN+Gk+c9SGuw
 oPK7BinBtEvB8HRWoMg0u61w4WKYz+jMEJ64GdfNtBU/Z4ALaFugBBhKxQZVTiG7x7j5
 WrEkZa6PfrQnY25sZ4orEZDQj/ptzSttHTUQQUcQ83b97nbyL2OSOY4lb8ME0o4A+vVF
 Dp+Q==
X-Gm-Message-State: AOJu0Yy8QzcPegB8bBxmOL6Mo87mY4R+7wqZyVmcrW4f1ZHYHZN4UuzV
 qypabj7z+2U6A+nA9qwq7mluQYY2RrQJpn08gS9Q1Zc93x89ClrwQEDZqV/EDMHxht5cwuO7J/Q
 itAMR
X-Gm-Gg: AZuq6aITPoi+oxpDLltcT3X8mxkxMtKgsunSaq7U8fstna8aPhewagj/LEdUDG1yXXF
 g/omB8TK4GOWGtD3eDee+zFQFe80MvTcrlgz1RKurLQGHemuS/5OMoaPAKdY7QHC3a5OT0WJJGj
 ankKQHVKaO5bwMmBn8zt6lTbASuUfyQGs0FEbb8n01mE7bmydahafDoQcVbPw2IJcwmE8QOUBl3
 ol88HZ09KM4BwvjNcDcr9rnkQzrM5r9rrMdi4iEtfTGK90XPC1tmNCXzh03fv8395jq0f5sVBmb
 ORxQ7zj0ZvSjI7TSGcPhQFV0fnmL4LOEojyFHmgIvU+/jZY6nuQgURA/zITMoFZCwjazX+Wgkxu
 voTOknCTCuksqmLMKJuH7EiZ/oRFvlLmOwl4b8Ou+HnE46XAilDDGU/Sz8NK5h6Cs+i7DSN+MO6
 ha4E14JblwN+NmVEyoyQMjt0KfnRgMp4x2wzvID/pMLFw4Msr80QXhWRdGEL4PrQ==
X-Received: by 2002:a05:6214:e88:b0:896:f42f:bf18 with SMTP id
 6a1803df08f44-8974049d5c3mr315607936d6.54.1771566526464; 
 Thu, 19 Feb 2026 21:48:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 08/23] net/pcap: replace stack bounce buffer
Date: Thu, 19 Feb 2026 21:45:43 -0800
Message-ID: <20260220054834.1632201-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

