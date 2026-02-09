Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A35E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E6A40697;
	Mon,  9 Feb 2026 19:40:59 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 786CB40679
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:40:57 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so1186848f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662457;
 x=1771267257; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO//WNJWlPmBcqqE0e+91zOe8/ppOcMuT8oPEyIDFLk=;
 b=GsTkN5CGQp6gKM/yiuU9bMzn/tRa20NoiUIiFJXMooeC4L0sAmw+CJlAfCnmGwvLD2
 /yAKpvtdjGxqBL8nRtBkN3B0disGmww/WP+4JG4r8lLhX5uHfue5G3g9dvJo9Uc4zuxp
 iv6oqbokyI74OoPwhaoEjAzHta5qcjkv8ikFKNVm088nXIHwg3qLMWXNrf7Dh2t6K7rl
 DwP33PXpomcIsMQpnChki7/jhGyfs3wLy4IFMrr+Ad4hz+sOBSsDdNeMJlgXyTtnQIwG
 zo+NJtvCgF8YioFSurmuUHKJfsAmVoTlXZnaNZwFX5Cs46Dn8BGijFa4Z/hcHKT2I4HE
 tDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662457; x=1771267257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TO//WNJWlPmBcqqE0e+91zOe8/ppOcMuT8oPEyIDFLk=;
 b=V8Kvulryly4IBSTCNs7yLwT8cKI8FQ+6IIKjfdaZ06ptFdMsy1OVphGfCONFPLIWpE
 3LklV0XrPMpUM5vZFRjGKLEeiFRBbSp9bhef7AmSZPxhUldTSEaFImHUq4Nu6swVrSh4
 2LxmcMDqUFPbMZ9+/vpmjj7hDPrKuZ9adQWcHXrjPOJvpnKJ/1g0g059/Fdriouy3t/X
 FXX1fKmKLa1L6+ZIgEYR7T7utHRUHnWoeHax2c+U3KIT/jydpirSmwRL2K/gF+XOWQzG
 G4x42wh3AP++EyyuALJjrB9cH5KzwF+l/jtJksfDqLipqU6pmngp7gln5+mhsaRU5qWn
 bFlw==
X-Gm-Message-State: AOJu0Yz+vIJAMim7W8RTPYPuP5ghuGUdeOuzS4cnTdSPfAA8x/QiehQ9
 LH+qbbez0OllQL+9H5Lenq7J0hcM26xCwKKEs6yspDYUIWe1R9A/dwVmgwAuAVF9kmi5frqjaJo
 UcXGJ
X-Gm-Gg: AZuq6aJxWP54r3PNbVbRCS6cweaHrhx+8tiUuHdZXxPfaXGyLBlg9hluyJjIlqVBjKx
 /YGraGI3CQ09mQL9f4c8UOgfgnZ+Mof0N0vwv3/EJM7TsNJBCNbec5c1c/uWudPq6jysBNzBmjH
 ahmU+2IiqJ5DhTSjmesyynCWLgsBCwIggQL2tELHoMX3gD5LF2/qItlmQ2UlgG1rz06ImUgZ7c3
 kAIO4WzIZHTTJy8s/3+5HHzu5Olt1C52jvI+ceh7hsK3Fe/4UO/mRZ991/BBr2o2uVY0sNzVyI0
 ka+6RAXXrCb3ySXqcmuqwTjsiVv6RQ0ObPCMaQhsI73F6u861FKR8PuWtLDdHaJsjgke2PKDRkH
 4tr5AbmH8zohGl6aoqSexau3QxXt4oRiECaA9c1UhNRUccW4ZoxacQ/lXoStODgx/J0I56+hH6x
 lVwgUgT04AaX3GFBWaojkIZ5D8G9gp9Ry9osm5hAtM6up0z3u1AmdvLKJWVIsF
X-Received: by 2002:a05:6000:4024:b0:437:6f6b:4f7d with SMTP id
 ffacd0b85a97d-4376f6b5079mr5873876f8f.19.1770662456960; 
 Mon, 09 Feb 2026 10:40:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 04/10] net/rtap: add statistics and device info
Date: Mon,  9 Feb 2026 10:39:03 -0800
Message-ID: <20260209184045.132774-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209184045.132774-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260209184045.132774-1-stephen@networkplumber.org>
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

Implement basic and per-queue statistics collection and the device
info query.

Stats tracked per rx queue: packets, bytes, errors, and missed.
Stats tracked per tx queue: packets, bytes, errors.

Device info reports:
  - Interface index from the kernel TAP device
  - Maximum queue counts
  - Default burst size and ring size

Enable AUTOFILL_QUEUE_XSTATS for automatic per-queue extended
statistics.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   2 +
 drivers/net/rtap/rtap.h           |   2 +
 drivers/net/rtap/rtap_ethdev.c    | 139 ++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index c064e1e0b9..9bef9e341d 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -5,6 +5,8 @@
 ;
 [Features]
 Scattered Rx         = P
+Basic stats          = Y
+Stats per queue      = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index a0bbb1a8a0..a93d7dae17 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -64,6 +64,8 @@ struct rtap_pmd {
 	int keep_fd;			/* keep alive file descriptor */
 	char ifname[IFNAMSIZ];		/* name assigned by kernel */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
+
+	uint64_t rx_drop_base;		/* value of rx_dropped when reset */
 };
 
 /* rtap_ethdev.c */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index a65a8b77ad..a8481d9864 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <net/if.h>
@@ -30,6 +31,14 @@
 
 #define RTAP_DEFAULT_IFNAME	"rtap%d"
 
+#define RTAP_DEFAULT_BURST	64
+#define RTAP_NUM_BUFFERS	1024
+#define RTAP_MAX_QUEUES		128
+#define RTAP_MIN_RX_BUFSIZE	RTE_ETHER_MIN_LEN
+#define RTAP_MAX_RX_PKTLEN	RTE_ETHER_MAX_JUMBO_FRAME_LEN
+
+static_assert(RTAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
+
 #define RTAP_IFACE_ARG		"iface"
 #define RTAP_PERSIST_ARG	"persist"
 
@@ -153,6 +162,132 @@ rtap_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+rtap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	dev_info->if_index = if_nametoindex(pmd->ifname);
+	dev_info->max_mac_addrs = 1;
+	dev_info->max_rx_pktlen = RTAP_MAX_RX_PKTLEN;
+	dev_info->min_rx_bufsize = RTAP_MIN_RX_BUFSIZE;
+	dev_info->max_rx_queues = RTAP_MAX_QUEUES;
+	dev_info->max_tx_queues = RTAP_MAX_QUEUES;
+
+	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
+		.burst_size = RTAP_DEFAULT_BURST,
+		.ring_size = RTAP_NUM_BUFFERS,
+		.nb_queues = 1,
+	};
+	dev_info->default_txportconf = (struct rte_eth_dev_portconf) {
+		.burst_size = RTAP_DEFAULT_BURST,
+		.ring_size = RTAP_NUM_BUFFERS,
+		.nb_queues = 1,
+	};
+	return 0;
+}
+
+/* Use sysfs to ask kernel what packets were dropped before making it to interface */
+static int
+rtap_get_rx_dropped(const char *ifname, uint64_t *rx_dropped)
+{
+	char path[256];
+
+	snprintf(path, sizeof(path), "/sys/class/net/%s/statistics/rx_dropped",
+		 ifname);
+
+	FILE *f = fopen(path, "r");
+	if (f == NULL) {
+		PMD_LOG_ERRNO(NOTICE, "open %s failed", path);
+		return -errno;
+	}
+
+	if (fscanf(f, "%"SCNu64, rx_dropped) != 1) {
+		PMD_LOG(NOTICE, "parse of rx_dropped failed");
+		fclose(f);
+		return -EIO;
+	}
+
+	fclose(f);
+	return 0;
+}
+
+static int
+rtap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	       struct eth_queue_stats *qstats)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		stats->ipackets += rxq->rx_packets;
+		stats->ibytes += rxq->rx_bytes;
+		stats->ierrors += rxq->rx_errors;
+
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxq->rx_packets;
+			qstats->q_ibytes[i] = rxq->rx_bytes;
+			qstats->q_errors[i] = rxq->rx_errors;
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+
+		stats->opackets += txq->tx_packets;
+		stats->obytes += txq->tx_bytes;
+		stats->oerrors += txq->tx_errors;
+
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = txq->tx_packets;
+			qstats->q_obytes[i] = txq->tx_bytes;
+		}
+	}
+
+	uint64_t rx_dropped = 0;
+	if (rtap_get_rx_dropped(pmd->ifname, &rx_dropped) == 0 &&
+	    rx_dropped > pmd->rx_drop_base)
+		stats->imissed = rx_dropped - pmd->rx_drop_base;
+
+	return 0;
+}
+
+static int
+rtap_stats_reset(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		rxq->rx_packets = 0;
+		rxq->rx_bytes = 0;
+		rxq->rx_errors = 0;
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+
+		txq->tx_packets = 0;
+		txq->tx_bytes = 0;
+		txq->tx_errors = 0;
+	}
+
+	rtap_get_rx_dropped(pmd->ifname, &pmd->rx_drop_base);
+	return 0;
+}
+
 static int
 rtap_dev_close(struct rte_eth_dev *dev)
 {
@@ -231,7 +366,10 @@ static const struct eth_dev_ops rtap_ops = {
 	.dev_start		= rtap_dev_start,
 	.dev_stop		= rtap_dev_stop,
 	.dev_configure		= rtap_dev_configure,
+	.dev_infos_get		= rtap_dev_info,
 	.dev_close		= rtap_dev_close,
+	.stats_get		= rtap_stats_get,
+	.stats_reset		= rtap_stats_reset,
 	.rx_queue_setup		= rtap_rx_queue_setup,
 	.rx_queue_release	= rtap_rx_queue_release,
 	.tx_queue_setup		= rtap_tx_queue_setup,
@@ -245,6 +383,7 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 	struct rtap_pmd *pmd = data->dev_private;
 
 	pmd->keep_fd = -1;
+	pmd->rx_drop_base = 0;
 
 	dev->dev_ops = &rtap_ops;
 
-- 
2.51.0

