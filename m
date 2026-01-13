Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC576D2F32D
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09EA1402EA;
	Tue, 13 Jan 2026 20:25:46 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 5446C4028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:44 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-652fec696c9so2162432a12.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332344;
 x=1768937144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7Iuf77CA/xk4iG/Y4iSadjeleroTUhL9tOyTOCMyvU=;
 b=vMAWIkjCdSIgvX7ol06mfM1GQG7mHOOOPJvXuuk1Msvmk711Ep6Z0tOx0IagYaOaEZ
 Z2J8MwwhtBOiudtXbnn0OHq7KOyR0XAkBK6Cuw9gWCIva7X4Uh6Bq0sb8gs9p6rQ5cfG
 f+Jdnlm+UDClmlaD14ajKXDt5UrHHZ5u99DXVEBS/e+JU5Rj7QB6B3p9JR4k1RO88FNl
 +/aDc3QQhsMb3WqYfY4BCROTAzuSP3O/MVljCSR3N2n1pMP0UVMHgtc3b1YwhwgCRoP0
 Cwzqn+g56jsyTgbv1Yi9vCSMVpr8YM6t6FP/KVtKZDTonN/OMvuIvFPkfAsLtjp/Om5J
 X/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332344; x=1768937144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7Iuf77CA/xk4iG/Y4iSadjeleroTUhL9tOyTOCMyvU=;
 b=MaajWMJ5ACGl3jHWcvpmb4TKMJE6DCm1d7wezp/akHC5jTd1fa7ATSw9ZiRq6R2Ntj
 nMZuHrqPZSIO3VB2HjGWT1+ijss7zIQR/q12O4OshlkmLETi8MYxrORyiDtFQx13A8Zr
 ET8fjHjYSFJc9pHA44NwI8aGwwIsYEXKjaw8y/qKGoYS1PsFliytGBXz76TPX14DRiil
 sZ0Fx+RTZMdPyzrxfKaRrL0CaxKu87da2RbbGPKVI+Ah1fTF3hFqmaLU8ZBacLoxjgEx
 Pb1ANP7IBo5+Bda7gmKdeo+nnQEQPl6ussm5sU+nwF5IWwrLGEuSyBFP08q0WwzVZxCB
 i6aw==
X-Gm-Message-State: AOJu0Yzj7lJs8Gaf+yuTIykdQqnIPEdio/vQrZiitYEP17AZCjUqGaor
 JYKN7U14eU6s37S29JA42yac4Fclt/XCW9VhaaVN/PZo+xt2pWwUyUreOKmrwNydnYfUy6VCd5W
 ALHz/
X-Gm-Gg: AY/fxX5l+sMdqQeQiEXtzWOE2hlsPSfm9K9GC+PfRQcV0lGJnQnY29wSKuVp2AWzvcr
 vgcUw8R+r4aC1T3R8pHtchxkfivapNLupp/XNxyjvT/eLYd4v6nNW5X1BbS66+qjQTBeBwc7gzl
 1CfhYES4vHpqONS1eL0J9vAR36UJ2EV/RfnzkoPEXp8r9v5yhuG0YX0N+cOQuobsHXB/h1SoZf3
 EPXLyUVeb1JtaTAfYQqBJqbmRw+bf2O5dq7I1SDKCZwZGCjAbxrakPG9oS7NIe1W9eFMaStNJHp
 aoENdHXyDn1RzpzY74n/Oi6QKIz7aJcxdpm3pu7GsCYG9bbGHQqj5UdQf5fHDjq7qTcZlcGyXkY
 AQd1jlyzI7WDjL22R6tyYFxN+yycz4ZiCWq/72LQGKugdwM0G7uIpYW8bIhrs2Qb0muU7+mLVsZ
 R2Jmw0MwSQEq/ssW/yFghtnsWOZKJYDwb3+FeYZZkfjZ+tsnHcSA==
X-Received: by 2002:a05:6402:2348:b0:649:cb54:b7a9 with SMTP id
 4fb4d7f45d1cf-653ec446a2emr57208a12.21.1768332343740; 
 Tue, 13 Jan 2026 11:25:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 3/9] net/pcap: support MTU set
Date: Tue, 13 Jan 2026 11:23:35 -0800
Message-ID: <20260113192530.116470-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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
it is counted as an error and packet is silently dropped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini     |  1 +
 drivers/net/pcap/pcap_ethdev.c        | 93 ++++++++++++++-------------
 drivers/net/pcap/pcap_osdep.h         |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c | 26 ++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 21 ++++++
 drivers/net/pcap/pcap_osdep_windows.c |  6 ++
 6 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 060b2f4df5..e75bf03051 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -19,3 +19,4 @@ Power8               = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+MTU update           = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..564c40e26e 100644
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
@@ -1002,6 +997,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -1015,6 +1021,7 @@ static const struct eth_dev_ops ops = {
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
index 32e4a2bee7..697b7029dd 100644
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
+int
+osdep_iface_mtu_set(int ifindex, uint16_t mtu)
+{
+	struct ifreq ifr = { 0 };
+	char ifname[IFNAMSIZ];
+	int s, ret;
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	s = socket(AF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_mtu = mtu;
+
+	ret = ioctl(s, SIOCSIFMTU, &ifr);
+	close(s);
+
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
index 1d398dc7ed..00df67b8fc 100644
--- a/drivers/net/pcap/pcap_osdep_windows.c
+++ b/drivers/net/pcap/pcap_osdep_windows.c
@@ -116,3 +116,9 @@ osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
 	free(info);
 	return ret;
 }
+
+int
+osdep_iface_mtu_set(int index __rte_unused, uint16_t mtu __rte_unused)
+{
+	return -ENOTSUP;
+}
-- 
2.51.0

