Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0770FF9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75357406B6;
	Tue, 14 Apr 2026 18:10:27 +0200 (CEST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44]) by mails.dpdk.org (Postfix) with ESMTP id 895AC4065F
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:24 +0200 (CEST)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-4243bf9be36so995714fac.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183024;
 x=1776787824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyalasysJlPdibjKnXvfd7oiWH3kcw+5X46h8LoA3C4=;
 b=ZSfm3EmJbFM28uzH+/yWJTBylpaYV48fE0jBZTO1eE17EtGKGTpNoC+bGuVpjt0Aig
 TN1IF9VwTXBljHJ+Q8hCEMGKFMOEQDJb+MJtPOmQ/sDW2U/0dm6oC6LP66UQxMpiut3B
 DDQJQ31/qMi4x+Ns23Vnof3R7Xg8SUUliZHBB3DAEVO47IbcP4e3L2J3iKfnV8QBh7Je
 RZZ9n2S6D+SPWb6+qKJapgJ+4aQI7RM8kJId0GBBmHtVDSKzC1fxOHHQpVM+vp43o8Dz
 xVTl7PVZ2f+6kiVIPkspOdrx81Rj0w0m98vbDR2aTrEyVJS33xiPdhw/+ieDuJuZMkSk
 Dxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183024; x=1776787824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZyalasysJlPdibjKnXvfd7oiWH3kcw+5X46h8LoA3C4=;
 b=qH6Tl58coILv6O16J9ICAYqrjZe4c0RjG57pmJep22hECHayxKDRBZ1/Fjc/6lkN3f
 qSC12rNezjMnFL/i1ZJvJzwWp+tN33El7FVbiA2brJZxZ1HZqi6efVO1TWev6o62Wxxw
 9ooJy+RRUmhRW2fuYHO4eki3EkMlmxPZ0x4tIYtwekPPSBoL+tUNei3En9PvLs4r9OhL
 UxPNqGlvp7OBqWHgwmStz1WLvR7B+FOFnZPZvXXdpDRrvPux4Sc4K7BDk3CQcoWLfK2S
 UGUt3qM+zzsHuFTQ1UU0PSP7DP5MqHzDzWQgJYfpZv83zkpUxMpDUfOvjH+Lu7i99wih
 a2Ew==
X-Gm-Message-State: AOJu0YxTqbZ22BJLzwrxpcTh//YvrzKLv9wxCLWJcNN1OQ7VJetmVI4h
 OgyaqcL3m3gZC18sTn9LeiNSzT/L9r0i85hMh05XxevSGGprZrfnIKdwwM40tdBpp3YUTC6KEV9
 kjk5k
X-Gm-Gg: AeBDietu7o2jCZU7G1RQsGPavCi+TB70QO0n4VPCPge9Qg10IdRBx5Ck/vkPwBFufIt
 rSl/RY+r72bjqYO3vZQu2ucDzhZn70sfD3uzrpJVzMt6rbFO3jxxptAzyPMFYyzSQaHIHOwJs6r
 eKkXLv9in0lFkFCckI0XW44VvigSHwMHwdPijencsV/TQVTOE7WDGZM7Ysj9jq9vOpIYpyV5es3
 k7E64pSPD1JWnBwEsGcSEa9rbhFsvClIyV1gGT3LI2QtP3+W1atAX03dy5jTLwyqpGSd5JyYGV8
 u7ivR8ZQhDn/zWCSqWBEaNi4MtQv6b7iAlzBZvY4CRA2cMYogbDS7lo48M2GgANW5ryLFJVUHT6
 w01xuYzlOWznyomt21eIuWJy8b8NeSAmSwo2M6Pm3slyqsqh/bGSV44xcJylZ140ocbzt1PI5zJ
 SiuxmTbRLJ8gOS7Fr/MZTcC7VVpfw7sZfy59EpzuC9euI=
X-Received: by 2002:a05:6870:1428:b0:41c:9be8:c367 with SMTP id
 586e51a60fabf-423e1119c68mr10207106fac.36.1776183023756; 
 Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 08/24] net/pcap: replace stack bounce buffer
Date: Tue, 14 Apr 2026 09:07:59 -0700
Message-ID: <20260414161011.756101-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

