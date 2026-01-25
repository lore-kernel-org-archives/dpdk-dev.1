Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D9E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24BE840609;
	Sun, 25 Jan 2026 20:23:32 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 6D796402C1
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:23 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-435a517be33so2319570f8f.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369003;
 x=1769973803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H106flWNsCbUe/FEvrvtFGyVOB494Sc/sjm/xPnhhNc=;
 b=063bclRtpqIzStObnULR+wlyKRWmFyW/tHfyDJK94fJjk+SPSwy6JlUcrldqZEZidh
 YSqzNcR2UvOUwiuBUVAqPN1VSgnbHHRdWUOxJT00/GxZH21ra/PykBYZ9T66Dktio00C
 Bg4RzKskdh/FzLOYq/3o3c3P4/z4OFMpufWDx7Yv+RiqPHaulCiO522FOu9F+BTwFa/G
 80lY3i9jKN7At9WFvh7oPJYAruqd+SwgKzhjl3qZEVoZwNQ/YeIpp1Vtz6nskwMORLPG
 ljNC8OKliJgKyFHxGt4Xy4K2SijzUcajCIGktVZcQBI1Nj3jp2GvK7wjTfJct6tszpgX
 DSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369003; x=1769973803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H106flWNsCbUe/FEvrvtFGyVOB494Sc/sjm/xPnhhNc=;
 b=Kor3OhERq0upUn7o0VUE5vtKOrOz8ud0+qMPcWubEn5QK6h8XBHIg52bY0tLVa/dvX
 dM7/QQ4L2IieZ71iVUI4u6ffeAIPW4CNtbAdru/g4vOtMjdkeqvJDi1qHOPRrzgtMM+w
 5xDA0CrXZOCKEBMPvhQfSoR/yAwHQCCmfDOPkrGHArQeRlCt0X/lhEDrj2WTtG9lkNvW
 cvN40Z1PuKHgP/zoVSByC6C8Eh49o/uD2+3xHLa7mVxsy0OtlLPUwCLUc5RtHFRkHvkA
 osLswu7F0+GKR0Ot1KyF8tEOuAPKy4cVbLznFzBKcTxOfTkARnsm7+7nhC4QTMCzY6bp
 wEKQ==
X-Gm-Message-State: AOJu0YzhHLs++QJotncPPO3lBp5jooLCT6YREfEYxYpkCQgq79eQ+nbZ
 Wad7aYHhj8knUpRBZARy44tSoaOfzQJAuY3qZgKLiurKZLmlgX1FZktXvVRRAwRRaz0bM1GrjAg
 8HGiW
X-Gm-Gg: AZuq6aL94uR0k6Mf6ekkjfZARHZ4PMfp3VyzU6q36JBw45NZJ3ZXYZFAUcjX15poeVd
 pxLn9RAgzPFunsWqbiHavG3ZbW6viNRwn6atr2wF3n2rkWuDoKl5aPzNq7vQ2bzPn+th+b0B9CX
 jFQaTufYEyIheZkm1BDrsBuM7qYc+d3OoIqCAusVuCnx5AToaFcEBmFlgpfBcCMPj4aaeNaL9bW
 TppLVhI0uEhHCTnKxBXUT7UkzY7JOBkUMkq+prbGwyd3AXdrcTZwLal/wlZGfVtcMhUO+ne1/4/
 N13jRql3xOh09nkJ3enz5TBUtu20k7albfI8eY2MhJdPASNZBfsIoIWKm40HtFqIQOp2Zj12sR1
 AMd5PSHQSPcjLczVKM1ltmf0LRArGUdw4b1ZG3AC3vB1+NLiMdxlyB6TX3itimlgTeqNTTZP/lt
 qRUVFNmBwMg5yNlTKlDdLQq9GwkTNAk7SVIfV4H2QdJzz7TkE1Ow==
X-Received: by 2002:a05:6000:184f:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-435ca198c6bmr3998626f8f.47.1769369002933; 
 Sun, 25 Jan 2026 11:23:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 07/13] net/pcap: support MTU configuration in single
 interface mode
Date: Sun, 25 Jan 2026 11:20:05 -0800
Message-ID: <20260125192248.497563-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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

Implement the mtu_set dev_op to allow MTU changes when the pcap PMD is
attached to a real network interface (single interface mode).
The MTU change is passed through to the underlying device via ioctl.

This is supported on Linux and FreeBSD. On Windows, the operation
returns -ENOTSUP (for now).

Also report min_mtu and max_mtu in device info.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 14 ++++++++++++++
 drivers/net/pcap/pcap_osdep.h          |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c  | 24 ++++++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c    | 22 ++++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_windows.c  |  6 ++++++
 7 files changed, 69 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index b0dac3cca7..d2f5ee6039 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -19,3 +19,4 @@ Power8               = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+MTU update           = Y
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 76d81ac524..41f96ad1af 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -57,6 +57,7 @@ New Features
 
 * **Updated PCAP ethernet driver.**
 
+  * Added support for setting MTU in single interface mode.
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 537d66ed30..54f71fa17f 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -748,6 +748,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
@@ -1006,6 +1008,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1019,6 +1032,7 @@ static const struct eth_dev_ops ops = {
 	.rx_queue_stop = eth_rx_queue_stop,
 	.tx_queue_stop = eth_tx_queue_stop,
 	.link_update = eth_link_update,
+	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 };
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index a0e2b5ace9..7eacfce24f 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -15,5 +15,6 @@ extern int eth_pcap_logtype;
 
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
+int osdep_iface_mtu_set(int index, uint16_t mtu);
 
 #endif
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 0185665f0b..40244c51fb 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -8,6 +8,8 @@
 #include <net/if.h>
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
+#include <sys/ioctl.h>
+#include <sys/sockio.h>
 
 #include "pcap_osdep.h"
 
@@ -55,3 +57,25 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	free(buf);
 	return 0;
 }
+
+int
+osdep_iface_mtu_set(int ifindex, uint16_t mtu)
+{
+	struct ifreq ifr = { .ifr_mtu = mtu };
+	char ifname[IFNAMSIZ];
+	int s, ret;
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	s = socket(PF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+
+	ret = ioctl(s, SIOCSIFMTU, &ifr);
+	close(s);
+
+	return (ret < 0) ? -errno : 0;
+}
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index df976417cb..567ab89bd6 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -40,3 +40,25 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	close(if_fd);
 	return 0;
 }
+
+int
+osdep_iface_mtu_set(int ifindex, uint16_t mtu)
+{
+	struct ifreq ifr = { .ifr_mtu = mtu };
+	char if_name[IFNAMSIZ];
+	int s, ret;
+
+	if (if_indextoname(ifindex, if_name) == NULL)
+		return -errno;
+
+	rte_strscpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+
+	s = socket(PF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	ret = ioctl(s, SIOCSIFMTU, &ifr);
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

