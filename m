Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCAD4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B1464069F;
	Sun, 18 Jan 2026 18:00:01 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 0905340674
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:59:59 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso23039865e9.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755598;
 x=1769360398; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2rtsWtIgb19biNZY7WZkv502iS1OiGGYVpVVyxr1LE=;
 b=03LDNMxZTwRxIbeboWVXDqiJOpDeSUZHe1+t/UZd6yzQhhjKrVdoxCACrDsY3aJw5j
 iyuGQ4XVP9c2hiX4BBrkAPovzcg7TI5HnoQR6ms3wknF9AVC0z2GLpFnWcYBdVUa6tsN
 5NZUBn2OACgEl312IvBnBngkhC82/1ssuCiPM0+aHbQGnzb5n81HIZBmeLcpbTx1YtHw
 WvwfGFeJMg+2QiWNiE5VztaiQvVSRPNTamsRZ37nalrv0NSHRVLMZgRI68etJZyWHIm7
 APkoeSzLusioOaYzD3M64I6mhPxNV9nlihrS01Sk7O3tMd8nxYEnkl6UmieojQoG1X3t
 Wg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755598; x=1769360398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o2rtsWtIgb19biNZY7WZkv502iS1OiGGYVpVVyxr1LE=;
 b=mZn8RjN98wDkBt4kYu/G3RMqI8QQlfDSUeWN1SnxX7/b8PUJ7lOKwojaBVdQ/M7Lez
 8siWokr11Nzn7LRYHfIh3Hh3Y2GSNUWIP/5IYylCGwtX5ftxpotkhv6KPFI/hdqMiykw
 g4NfXZQ7V7ygtI4qjOULDb8Zx8C0gH1yUib0vARxCl73pt3JQVZdhGbuTQvPn8iKtAZW
 VnjICPeYvf0C30FjWQMSJPJDMuCIDWk8DRyGU+xyjcgaT9KYE7/0ItwOnNbmXQMpA9nk
 vCgn5tmpY8PbScCeJC96zQkfiUTm5GlXuk/nMdQyENhR2iCjola5AoAJZlgQ2u2Xr1cd
 1D2g==
X-Gm-Message-State: AOJu0YzaYIKG4/HUwRG00jHhrkhzSAgQZ3kFTMBek5Ay1YZ1kBtsiCTK
 Lm4M8F8eSyrd87HFb822qDEte+/H5rukfha+PuKH3cKF8TG7v3O5yxuvTcjX+4SjUsJiGYNP5E/
 sZbvq
X-Gm-Gg: AY/fxX4RzCvf5BSo5CMv7S6ezmaxpz42xFVTZwPgkDfpx8tx5QbYpgpd1pd834YVAgU
 4K+2cTpxmdvgQrXNqmrReQpPT0djq44dxsUlBGN16BYse8bBSdCe6EYwRios1sQ4NNIJ2QC0ysZ
 Qg5tpQvUcNBn/sLCUcjHTiGHS/LOoGoCxAxafAixhf4KxtpIJyxLR4jQIP1gtWhnzlpPn5A9ykg
 HT7CWBlofoLpeF3U/9fWpESRhF0Yfal9ddD8tUNCQudVnzdz/ukd2McDmMVJ+N+vaE04ZVrtBn5
 pVjCUMVNyiEjWC0EwegGMgpsqPHqrU2qnrxvf7larKo4MWc7SGDQYvp6Y1TDkesrCeVDYiY39/s
 FjD2NsvkeTCjOTk62noE/JRQhobouwiCYf3tBqGPNNLl3Epd7jr6DvGiw+HyaAliW9hC7/fpvJI
 SgG2E64CQ4wZZ3Z4RUqA1o8ntQ8Las2qh7XsvY8qdz1YbrEJNCr4KoZ2a2l9hZ
X-Received: by 2002:a05:600c:524f:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4801e685697mr92849415e9.16.1768755598623; 
 Sun, 18 Jan 2026 08:59:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 04/11] net/pcap: support setting MTU
Date: Sun, 18 Jan 2026 08:58:39 -0800
Message-ID: <20260118165944.41374-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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

If PCAP PMD is used in single interface mode, it can pass
the MTU setup to the device. Only implemented on
Linux and FreeBSD.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini     |  1 +
 drivers/net/pcap/pcap_ethdev.c        | 14 ++++++++++++++
 drivers/net/pcap/pcap_osdep.h         |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c | 26 ++++++++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 21 +++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_windows.c |  6 ++++++
 6 files changed, 69 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index b0dac3cca7..d2f5ee6039 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -19,3 +19,4 @@ Power8               = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+MTU update           = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index e86aaf8bbc..5683c44892 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -749,6 +749,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
@@ -1007,6 +1009,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1020,6 +1033,7 @@ static const struct eth_dev_ops ops = {
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

