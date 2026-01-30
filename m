Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95164D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71FEB40676;
	Fri, 30 Jan 2026 02:14:07 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id F2A5D40661
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:01 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so17601655e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735641;
 x=1770340441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1J+D/6wTPbHBG42ig6K1FeXy0o2SOrxUJMQu5sahtE=;
 b=rlQnfWm/mJdlDtpTl9SA9KLV1bmwLV/9rfZK/SQOrfxLB5Smz+WkklbcibCZGHTGvD
 LGgKKIwazl1iaiIHqcNim1DAgcrN70YV60b/sB2oNZOx+/jiMgn8JgJbIK89PEOZXIiA
 QYiubVHJIyzXO4Wnix+ogTVLEyC0m4ixX7M/UR7NI/aae+Rkkaigp+zQyXUxHd5+oGNY
 c6VO6Ub7yCG6OHtRGs6OEGsfIAJdyOaybAxEWYf9wV2h4PImNLzfEF254J332DO2FJZo
 4yJ6qd8d85vGayG5r17y85/Ds6wuAndm6FFRHHGqh2rxHdPzjWJjYGIM2VJZHfKdSz03
 +fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735641; x=1770340441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E1J+D/6wTPbHBG42ig6K1FeXy0o2SOrxUJMQu5sahtE=;
 b=pjBckHdWoE+NM3+7UCOcPS/zn3a3SmT8oyFGVl7K97xLkvMqrN2Ztqi++tZV98HxJP
 LN5foiFXdRBRlpaPU1keKYzbxFvKis3XTGZ2i+reURohMrDd02kOzgCV5gqp5odaplKS
 Xv5TbJC6uiqXpao7SE4fvwoLmHxrimZtpxp2Qy+PNUKg7yMN9hjdaDWXaToBUFzOeMp0
 J2Zj2NpJpyUTyzELfm3z9IaAioBuAR+89s0CFbQh7tR17Aaysy8jq72TQzmsClS7vHOC
 WgK0nQRHQ/LAuGIymkCgk0joP6O6tNVUSbmfai5EKc/PzQ5Ea4SHOucSeGa95LDPoOKK
 ZHHQ==
X-Gm-Message-State: AOJu0YyRFG1lSPnYDZYNMSMZb2iByxVY9PnbpHMjPADMwEDm83vfUD2/
 VdsuVuAGuwCoVM979ElbVr8r3yOC/HBizIy5M2szVtAYXdVwQj7XJfmOkiha+Ool/FwO6z7IPFe
 BaBm+
X-Gm-Gg: AZuq6aKvR9DOY3VRSI/HE5E5WbHeQZ8euCfEE1TQ8vxdrGlCsjvzam5ibxsQGHQkl8l
 attR8EHoUxNDf4ag4c1gi4v3zgCGkfdL14eMh7e1SJmwwwCi9+ypG1tTSY0lJDkXmV8Y7oC7Z4d
 zA06Fzpp7LEorokdPMpTsmfDbJN/u45nzsEvSpJ9ldh12l09sjSOXPbBBw94f4aIbieIXm1cm7w
 be+PhNGaLOLj6UzrAn9U/JYaiIiyQDXUOKBNm1nJTs5EmRQZbNdN03o+APjklsaOXntb5stGRU4
 PqivAX7AHhdsjOq6ITdgHm2v8GP4YqD3p2Zytl5DcEElWhN28BV79aPJsH8nAZk/6aEH2uWEAIO
 V7c1AohA1S4MoQ0hbDpuPbBs6aFtpstanw3tQQT3rTsdbrVS1UW+qLsJjbXhxxcHBxyYaz2Fb+i
 mOArVMgdT6933dM4vgtachga9HjcUHNwg/9+iarF+/pj++2ctyIA==
X-Received: by 2002:a05:600c:6214:b0:480:1c53:208b with SMTP id
 5b1f17b1804b1-482db49da0bmr9862995e9.36.1769735641548; 
 Thu, 29 Jan 2026 17:14:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 07/19] net/pcap: allocate Tx bounce buffer
Date: Thu, 29 Jan 2026 17:12:23 -0800
Message-ID: <20260130011344.204233-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

