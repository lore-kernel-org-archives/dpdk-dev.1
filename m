Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E2CEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA48840DFD;
	Tue,  6 Jan 2026 19:33:20 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 1ABBA40DDB
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:19 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8440cb2dbeso49260166b.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724399;
 x=1768329199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/FgwKfLuYGsXjmv90rpiDZttlKQovdPvwpGfX77hJU=;
 b=fIGsapYYFb3XhxbFtl8Qd9Ole0CoCLwgBI1P0Vng/R3Y5aqN6Xq5GcLCMcVNZ3OLgD
 0FBObc0siXk2z+Mt9qoysP68atX4fQGACPGFhd5X56Lfh2tt5JhEG97Z47ebm5/Bd4b2
 qXa3ivjrbRg/6eBPGXHRE12nfazSbqoumTkRx1lK8Kgotk1rpxfNxeb3uP+e91GaVMN3
 txWRF5rq+kySVMLxuJHDS7xjPWe0VHjrycxD5WuPv2Ez0wzqcAnGdoIEtfcLfhIYDgVF
 bn1n3sUgNN4QEUDCWMS2h/IkzuBNOrx7s1pDLcsNzsN0TisZpfVXVV6jLe/rMgsOcm3D
 fktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724399; x=1768329199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/FgwKfLuYGsXjmv90rpiDZttlKQovdPvwpGfX77hJU=;
 b=gfm2mO4SQkg/5oBnVBN0MlBFgbt0LQ19BYbmcPa+Z0JlLqTClEJwtQoUqCnZ7CvjHi
 UCcoEvSVSkVVp7kcvSDpYiKoFzC6PVElvqduZnV/gYQrcb6uXymR9GR2LEpxnxuiFUBk
 0l1uv+uV13iv/pPErVioePRs7ctEiFfZMdb3vOdyr9kOY5B+MovrT2963YjYw+/lIUcL
 9LXjpFbwi8LItWsAIHrpUHHcygGw6dMmV/Z73IbBKzSL0BnXotrS4Hdz7alebyJ5rJfa
 sBy9/yayiyiTIjSUV4b5c6SeWAKim+jKfPPcWg87sS+Y6/dwzEHkY+jRJmYa6G2WY+pQ
 9HFw==
X-Gm-Message-State: AOJu0YxMP7sDA+Q6K4ToPQsXZK56sVVgJaca5Bd8EO9VTYBd+KQQhKSQ
 0XGp9or4ZqcNZzra4KgCBCfIIyEpEj+D57N+SatToH9mPa7pOOkykqaJJTpBb+OVBX9jKjBis35
 RTEh7U+w=
X-Gm-Gg: AY/fxX61BDvfnhPcFyNkw1YnXy+LwxMp7Uz4zKdxb1JPUIPOdsni1/ZzRPXxq+tBK+U
 c+pRQ8Sniv8PFvlYORdgTVmEtXJj37/jrB2wTBqgA/C4vdB4RYe+6r83Y70w9jBkfW/CYyZ9pzO
 j78LhoqVwIE1TQEJV+5QLPF5IWmoyW5i2WbgyzyfuJXi+rfqYywe5uf3SKU4nG91wbAOmRRpdjV
 zpba+qWQqiX7/WgczDmc74vHsQLw5MygyumTT36pK3Hjo7Mpc19nAcT67OoG8aewQH0c/SGkbjf
 +urRirFmo//FWDiPZlpj83wpwwah4K5iqCwfVpD1hi2lZ25kTOdZGj/DG3TYDBCXThFKfRHwjf1
 3Eo1lrmRGRYzyyQr5cE4QeEznsYV9Bwttd/lkqXDc9C4we6wosrZZxTUOvhZ/yeXDH5mfdkfR6J
 ZpNNtxTGgCxea6CTcCxOC6p+1/bQLmswwLeA77hKVmlo7CRerR0A==
X-Google-Smtp-Source: AGHT+IH2G+da7lmYeWaTPpe5EEmCKOOqPNXqQ4S31gY7eBWNksRsqmutJ/d0MvIDP9zAzSjkbcoz6g==
X-Received: by 2002:a17:906:ef0c:b0:b84:2023:8fb2 with SMTP id
 a640c23a62f3a-b844516a72bmr7737366b.5.1767724398624; 
 Tue, 06 Jan 2026 10:33:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/12] net/pcap: support MTU set
Date: Tue,  6 Jan 2026 10:26:41 -0800
Message-ID: <20260106182823.192350-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

When used as single interface useful to support pass through
of MTU setting to enable larger frames.

Cleanup the transmit logic so that if packet sent exceeds MTU
is an error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c        | 94 +++++++++++++++------------
 drivers/net/pcap/pcap_osdep.h         |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c | 26 ++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 21 ++++++
 drivers/net/pcap/pcap_osdep_windows.c |  5 ++
 5 files changed, 104 insertions(+), 43 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..f4cb444395 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -22,7 +22,7 @@
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-#define RTE_ETH_PCAP_SNAPLEN RTE_ETHER_MAX_JUMBO_FRAME_LEN
+#define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
 #define RTE_ETH_PCAP_PROMISC 1
 #define RTE_ETH_PCAP_TIMEOUT -1
 
@@ -377,46 +377,46 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
-	struct pcap_pkthdr header;
 	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len, caplen;
+	uint16_t mtu;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
+	mtu = rte_eth_devices[dumper_q->port_id].data->mtu;
 
-	if (dumper == NULL || nb_pkts == 0)
+	if (unlikely(dumper == NULL || nb_pkts == 0))
 		return 0;
 
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
+		size_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint8_t temp_data[RTE_ETH_PCAP_SNAPLEN];
+		struct pcap_pkthdr header;
+
+		if (unlikely(len > mtu))
+			continue;
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
-		header.caplen = caplen;
+		header.caplen = len;
+
 		/* rte_pktmbuf_read() returns a pointer to the data directly
 		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
 		 * a pointer to temp_data after copying into it.
 		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+		const uint8_t *data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
-		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
+		tx_bytes += len;
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -444,15 +444,15 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -462,52 +462,45 @@ static uint16_t
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
+	uint16_t mtu;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
+	mtu = rte_eth_devices[tx_queue->port_id].data->mtu;
 
 	if (unlikely(nb_pkts == 0 || pcap == NULL))
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
+		size_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint8_t temp_data[RTE_ETH_PCAP_SNAPLEN];
+
+		if (unlikely(len > mtu))
 			continue;
-		}
 
 		/* rte_pktmbuf_read() returns a pointer to the data directly
 		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
 		 * a pointer to temp_data after copying into it.
 		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
-			break;
-		num_tx++;
-		tx_bytes += len;
-		rte_pktmbuf_free(mbuf);
+		const uint8_t *data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+
+		if (likely(pcap_sendpacket(pcap, data, len) == 0)) {
+			num_tx++;
+			tx_bytes += len;
+		}
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
+	tx_queue->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
@@ -745,6 +738,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 
 	return 0;
 }
@@ -1002,6 +997,18 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	return 0;
 }
 
+static int
+eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	if (internals->single_iface)
+		return osdep_iface_mtu_set(internals->if_index, mtu);
+
+	return 0;
+}
+
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -1015,6 +1022,7 @@ static const struct eth_dev_ops ops = {
 	.rx_queue_stop = eth_rx_queue_stop,
 	.tx_queue_stop = eth_tx_queue_stop,
 	.link_update = eth_link_update,
+	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 };
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..3c8b7ff27b 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -14,5 +14,6 @@ extern int eth_pcap_logtype;
 
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
+int osdep_iface_mtu_set(int index, uint16_t mtu);
 
 #endif
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 32e4a2bee7..0279dbf00b 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -4,9 +4,12 @@
  * All rights reserved.
  */
 
+#include <unistd.h>
 #include <net/if.h>
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
+#include <sys/ioctl.h>
+#include <sys/sockio.h>
 
 #include "pcap_osdep.h"
 
@@ -54,3 +57,26 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	free(buf);
 	return 0;
 }
+
+int osdep_iface_mtu_set(int ifindex, uint16_t mtu)
+{
+	char ifname[IFNAMSIZ];
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	int s = socket(AF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	struct ifreq ifr = { 0 };
+	if (s < 0)
+		return -EINVAL;
+
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_mtu = mtu;
+
+	int ret = ioctl(s, SIOCSIFMTU, &ifr);
+	close(s);
+	return (ret < 0) ? -errno : 0;
+}
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index 97033f57c5..d180e9b4b4 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -40,3 +40,24 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	close(if_fd);
 	return 0;
 }
+
+int
+osdep_iface_mtu_set(int ifindex, uint16_t mtu)
+{
+	char ifname[IFNAMSIZ];
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	int s = socket(PF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	struct ifreq ifr = { .ifr_mtu = mtu };
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+
+	int ret = ioctl(s, SIOCSIFMTU, &ifr);
+	close(s);
+
+	return (ret < 0) ? -errno : 0;
+}
diff --git a/drivers/net/pcap/pcap_osdep_windows.c b/drivers/net/pcap/pcap_osdep_windows.c
index 1d398dc7ed..fde0db9961 100644
--- a/drivers/net/pcap/pcap_osdep_windows.c
+++ b/drivers/net/pcap/pcap_osdep_windows.c
@@ -116,3 +116,8 @@ osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
 	free(info);
 	return ret;
 }
+
+int osdep_iface_mtu_set(int index __rte_unused, uint16_t mtu __rte_unused)
+{
+	return -ENOTSUP;
+}
-- 
2.51.0

