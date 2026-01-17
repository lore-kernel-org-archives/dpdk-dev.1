Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71DFCA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6826442F35;
	Sat, 17 Jan 2026 23:00:48 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 08AD742F27
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:48 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so2740536f8f.2
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687247;
 x=1769292047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iV+tsYO3+o3mQ1rhmYyAhZHEH5gg6rzxtJfYNcVk1J8=;
 b=WmXtDNsVkvvttPQTkUxhFDSW6nFnSUBAbzRU57+F2Nw+hh0mR+WX2n38tyl99TQS9W
 PdO+fDVeWR6hKjeRffIcLEtn/b5EyMBzkW0nII2sWgrU0d9Cq6tMKsGeg4sImogswKcF
 RlTEwYK/0LMDUPPPCyar+CQk/V1fH8Uhwb7dydK0bds4Xo8ZPoFR0oXfntlFu/JuPFue
 WPYwzw4reS+dZKXzHb8D51XXRcbM5c019z32vGMElvzbyA1cJPlejdwaU5zHBIJGkSf+
 CA6MKBG/YjHyNSvnTFFMUvgQnEL0m1pTwb318MqSn71qNaK6gROBw1Ruo7gLNVJksQqD
 Weiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687247; x=1769292047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iV+tsYO3+o3mQ1rhmYyAhZHEH5gg6rzxtJfYNcVk1J8=;
 b=bDTiU+IoNLZrNerTIzKxnvUk9tM79xoVJOo9dkFoPkm1fs0r6iaEOkQRnIsRrKnPwr
 t2vEuDeCToI/0TbLnWq/lj4ZpSha/wfmLyJvLAqbAGaMfYgumKWUi0vzZui0vSorIohh
 +ygBFF6z4rrgyPCuFSw3szVxXtm9O3hRa1VLFR9pANTU+zyTyDaHDDjFDL69c10pq44y
 jRmOVSyawUcfvzwumyRjAiXYs+w/HFulbY0JFe0u/64jkC1rPrRkxIanaTnjtFpD+9hh
 M7TuPYYc47NCX9HClaVAWgXQfVdCg0Qxtz0Wx+TFa+Ss7j7LwFw8UBIOKJqUuXm/qDjD
 t3dA==
X-Gm-Message-State: AOJu0YwZcYb6+5PhrvYlBRhfgbRq4z+wsTSI+GgOnzqel1hmvbf8g/TU
 uBVjtzEm4GqQDpBhb1GPgRJypYhUk8NZEluOrSrk5ic22vFThdu8r6szC9n1qY9qJrUUth3Nd9S
 pWZME
X-Gm-Gg: AY/fxX6lYyVgSUqi2hDx+gTgKLW6IoRkVAK35GtTAZyEaUMFfsKIyNtJQlvwgmUhyW8
 Zl8yxPaZmyKjKG1wU+U+9vOsggOXlGKKmZe7N69NkYI6kw0hkxy2NujrBUbCCF2seqfl/3Ychj3
 5zQrbpxhKJg5u39eUom4fMnu7Qux3bBXepFmQqagu0OlxOI2rq02AuUoT8Cr8Kb6CCncS2gj3fX
 Iz8s+ix1bmEme3JCESIXV6yiOaMHGoLkE8G1GGzRtdjw4zxAGaR6CpHmfJ5bB6F0CfE49c3ihdN
 a0FpfVoC/7tTEyRAun2Z1iu+oYpX4gr76TAyAYJBrMqoXkAATEZTtyYN8NHp+hqIh6hOtbRLopE
 dwOSbWYM/Nfd4libl+NmeNVoexELQx+LqOv9bvmrrf/x6LtTnkt+TO/CdbvL6LD0luAO8fvVohd
 eaw3Y0L2xk1mq4v2kmoi8rQkvh4cSsRHAaTfPvQd3ivBKBhwIRyw==
X-Received: by 2002:a05:6000:2911:b0:430:b100:f594 with SMTP id
 ffacd0b85a97d-4356a082ed5mr8655652f8f.50.1768687246952; 
 Sat, 17 Jan 2026 14:00:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 04/11] net/pcap: support setting MTU
Date: Sat, 17 Jan 2026 13:57:03 -0800
Message-ID: <20260117220030.273471-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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
index 060b2f4df5..e75bf03051 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -19,3 +19,4 @@ Power8               = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+MTU update           = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 22c9cb5928..0c65a2dffc 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -750,6 +750,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
+	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
@@ -1008,6 +1010,17 @@ eth_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
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
@@ -1021,6 +1034,7 @@ static const struct eth_dev_ops ops = {
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

