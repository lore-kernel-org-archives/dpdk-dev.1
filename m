Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D279E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D424067A;
	Mon,  9 Feb 2026 19:41:00 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 1B61240696
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:40:59 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so47060f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662459;
 x=1771267259; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2ulEejtPdkPZ9tBcCbA0GKRek3PougiuaYgMNZ+/Fg=;
 b=LdOjHb+P8snrznPywDkG3qc/T6mjx6EzNA8ClKxcuK3Hko5QvwEK3VZbXmnKzZ+JWe
 UOHhfk+SqO6QRswwJdSvH6aCYYfatDDYqQytjA6V0amiqbGn5Dgii60xozOju5KlFxXU
 wBV+SGoBr9TXGAxZB7jpPY8qWmji+WIabLImcFVVqzbDtu2DI7t4Dc9KHpXfMkQmLJI9
 wV2CmdJd4MaHevTiwWBlV1S//aLr1O+lqLDD6C8ikKKmU9y/pMh8j2NcA6cyRdW+s1y8
 /JpI6lQsvloTDvORCkMM6W8Z1/poh/K3v0pNqyowVnNd0iSgyh8B6mjgf1+WODSJdYcY
 XpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662459; x=1771267259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X2ulEejtPdkPZ9tBcCbA0GKRek3PougiuaYgMNZ+/Fg=;
 b=Iz5sJNVwtKi4awJMbNHIZGIkii+dC49ubvzNUlqI3tFKl4sV2ftSe2p4nXO1juG8BS
 kTnf/nQGIVqjf+XxFyr1tg/hM+R0VvT/I+P1Qh1tHu+ZvbfUnCR4kK/OzchAE7m11wc3
 fxjy7ihKkcASLSemjNo7md2VpmHgcE7a06bV8ufdTOAutINH6xv9tcTD1NmSTjJvdNfF
 t5yPdSu5/KsApBYK/UUE37leW6amTc7XMTTOeAsjPP9hZRZEY/OCD/nJF2PGLtXLQKZL
 z1a7bJh+RRxwtjPLEnzNRjANKwzY75zQ+Pi63JrDR3suEXvBPbKRQ5Yj8tguDkMEG4gw
 tzOQ==
X-Gm-Message-State: AOJu0YxMeby+IhQdUJjwqPIdVtGrFZjeITMKbisSK6tQlU+4+JDim+WF
 dA9CUUs++FVk4WbtTR32mo8LsiulzULF2EkVT2KT8GueXF3VKcyJA6jpxt0DoUxcXKutOK7aodo
 +uIs/
X-Gm-Gg: AZuq6aJhMNdBpcQEJrleFEk2sOkXHuRdIXy5fEXsZPoDniFuvHyC/wuDBUKjSzeD3a8
 FSd5CxSSKME6UnsMWU4XvM55Hlh6V7Z7iqezkeoTxHFYViMrIs7VimdRM6qNlosqgvh4PHbftDj
 kWb3aym5mk1HqGkyJBHPJAVNa5FlEZYSqv5JcEOq33hqC5BZpuIR9I1f+kGTnQy78c/1rtFFCm9
 l55A3m8VpFvQtfZ4qCi+e5CjFsGe3n/w4vq6kCrsW+9unMgsuKq2/DhmaH7Q4+msyETnekf0o7u
 w86pKqo9OQaTGW1DXMCD6nHLSRGqxqhxdtFp6jGo/9kpCXhzG06WaRE2pX4IZl5eHM+qUXGQx6C
 K0QChioeTrgZuJu7bUD5rstZFW+tyuERyX3G0MRXlhH4yfFeoZi8gxb9UdEwVCLB4C0f4SKtWt7
 alOFWcEOJVu3I/CMpAr7c9YAswpZi/nPPKN8vGIEOiCiMXEpusYQ==
X-Received: by 2002:a05:6000:2913:b0:435:bbd7:18d8 with SMTP id
 ffacd0b85a97d-436293410ffmr18864464f8f.17.1770662458525; 
 Mon, 09 Feb 2026 10:40:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 05/10] net/rtap: add link and device management operations
Date: Mon,  9 Feb 2026 10:39:04 -0800
Message-ID: <20260209184045.132774-6-stephen@networkplumber.org>
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

Add device management operations for the TAP interface:
  - Link up/down control via SIOCSIFFLAGS
  - Link status query via SIOCGIFFLAGS
  - Promiscuous mode enable/disable
  - All-multicast mode enable/disable
  - MTU configuration via SIOCSIFMTU
  - MAC address configuration via SIOCSIFHWADDR

These operations manipulate the kernel TAP interface flags and
parameters through ioctl calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   4 +
 drivers/net/rtap/rtap.h           |   1 +
 drivers/net/rtap/rtap_ethdev.c    | 172 ++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index 9bef9e341d..ce0804d795 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -4,6 +4,10 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
 Scattered Rx         = P
 Basic stats          = Y
 Stats per queue      = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index a93d7dae17..99f413f001 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -71,6 +71,7 @@ struct rtap_pmd {
 /* rtap_ethdev.c */
 int rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id);
 void rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id);
+int rtap_link_update(struct rte_eth_dev *dev, int wait_to_complete);
 
 /* rtap_rxtx.c */
 uint16_t rtap_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts);
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index a8481d9864..591fe91eac 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -108,9 +108,170 @@ rtap_tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 	return -1;
 }
 
+static int
+rtap_change_flags(struct rte_eth_dev *dev, uint32_t flags, uint32_t mask)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { 0 };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	int ret = ioctl(sock, SIOCGIFFLAGS, &ifr);
+	if (ret < 0) {
+		PMD_LOG_ERRNO(ERR, "Unable to get flags for %s", ifr.ifr_name);
+		goto error;
+	}
+
+	/* NB: ifr.ifr_flags is type short */
+	ifr.ifr_flags &= mask;
+	ifr.ifr_flags |= flags;
+
+	ret = ioctl(sock, SIOCSIFFLAGS, &ifr);
+	if (ret < 0)
+		PMD_LOG_ERRNO(ERR, "Unable to set flags for %s", ifr.ifr_name);
+error:
+	close(sock);
+	return (ret < 0) ? -errno : 0;
+}
+
+static int
+rtap_get_flags(struct rte_eth_dev *dev, short *flags)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0) {
+		PMD_LOG_ERRNO(ERR, "socket failed");
+		return -1;
+	}
+
+	struct ifreq ifr = { 0 };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	int ret = ioctl(sock, SIOCGIFFLAGS, &ifr);
+	if (ret == 0)
+		*flags = ifr.ifr_flags;
+	else
+		PMD_LOG_ERRNO(ERR, "ioctl(SIOCGIFFLAGS)");
+	close(sock);
+	return ret;
+}
+
+static int
+rtap_set_link_up(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, IFF_UP, (uint16_t)~0);
+}
+
+static int
+rtap_set_link_down(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, 0, ~IFF_UP);
+}
+
+static int
+rtap_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, IFF_PROMISC, ~0);
+}
+
+static int
+rtap_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, 0, ~IFF_PROMISC);
+}
+
+static int
+rtap_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, IFF_ALLMULTI, ~0);
+}
+
+static int
+rtap_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	return rtap_change_flags(dev, 0, ~IFF_ALLMULTI);
+}
+
+int
+rtap_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
+{
+	struct rte_eth_link link = {
+		.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN,
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_autoneg = RTE_ETH_LINK_FIXED,
+		.link_status = RTE_ETH_LINK_DOWN,
+	};
+	short flags = 0;
+
+	if (rtap_get_flags(dev, &flags) < 0)
+		return -1;
+
+	if (flags & IFF_UP)
+		link.link_status = RTE_ETH_LINK_UP;
+
+	rte_eth_linkstatus_set(dev, &link);
+	return 0;
+}
+
+static int
+rtap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { .ifr_mtu = mtu };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	int ret = ioctl(sock, SIOCSIFMTU, &ifr);
+	if (ret < 0) {
+		PMD_LOG(ERR, "ioctl(SIOCSIFMTU) failed: %s", strerror(errno));
+		ret = -errno;
+	}
+	close(sock);
+
+	return ret;
+}
+
+static int
+rtap_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { 0 };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+	memcpy(ifr.ifr_hwaddr.sa_data, addr, sizeof(*addr));
+
+	int ret = ioctl(sock, SIOCSIFHWADDR, &ifr);
+	if (ret < 0) {
+		PMD_LOG(ERR, "ioctl(SIOCSIFHWADDR) failed: %s", strerror(errno));
+		ret = -errno;
+	}
+	close(sock);
+
+	return ret;
+}
+
 static int
 rtap_dev_start(struct rte_eth_dev *dev)
 {
+	int ret = rtap_set_link_up(dev);
+
+	if (ret != 0)
+		return ret;
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -127,6 +288,8 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_set_link_down(dev);
+
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
@@ -368,6 +531,15 @@ static const struct eth_dev_ops rtap_ops = {
 	.dev_configure		= rtap_dev_configure,
 	.dev_infos_get		= rtap_dev_info,
 	.dev_close		= rtap_dev_close,
+	.link_update		= rtap_link_update,
+	.dev_set_link_up	= rtap_set_link_up,
+	.dev_set_link_down	= rtap_set_link_down,
+	.mac_addr_set		= rtap_macaddr_set,
+	.mtu_set		= rtap_mtu_set,
+	.promiscuous_enable	= rtap_promiscuous_enable,
+	.promiscuous_disable	= rtap_promiscuous_disable,
+	.allmulticast_enable	= rtap_allmulticast_enable,
+	.allmulticast_disable	= rtap_allmulticast_disable,
 	.stats_get		= rtap_stats_get,
 	.stats_reset		= rtap_stats_reset,
 	.rx_queue_setup		= rtap_rx_queue_setup,
-- 
2.51.0

