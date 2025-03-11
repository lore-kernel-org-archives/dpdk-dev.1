Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A8C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E53A74065B;
	Wed, 12 Mar 2025 00:54:45 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 96678402D6
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:42 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2243803b776so111856635ad.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737282;
 x=1742342082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZJGpF3r/ltLfuGV6qt65I55MfKQyFtz38LMirAOGD4=;
 b=OzF9d3VUbJotVn9lmfw6H/6Deyg7yDt9JgVd8N09VsHQJVO0c/Cxj35Nm3NmRJMg4d
 fiOVOh29yCiu5D142yz+Qt2ldFOLFvM/4aTFu89LNSqxVKKFjsjmkoxEOM79tMP0JXYK
 9DfKp+cb/DcGwHy20Uvd5B9ZULOaXXAY5u6l7kjGfnhArBpADjAQ4rJ3Pp7J41ORAKmP
 TjfXiDK2owe3W51q/y1e2SlC++uqAJOVtkInXIu59b+bFC2INDf1WkQeSIcOy5Rzs/PK
 fxCc3q4ebRC/TYBbIT8npchmjwRDH2i/PiUWvQIxV1IAN3z2U1YGxyBtwjcdK2hLKmfi
 x8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737282; x=1742342082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZJGpF3r/ltLfuGV6qt65I55MfKQyFtz38LMirAOGD4=;
 b=CDFnfCz4RUV1+3TMz2RfCbGufFiBiuLcFLVMs5K6NzIPNOW6K7RcTUswxszyA7VD8s
 6apLcIjU+Cl+OtGRVEQ3DUYroRrRC4n9wmWufTTSm6cxRfGmMGrbxbyAb1IuZs8qN+Ds
 oTyRcFYOzsRliEPivIYOi88AjdbPLA5nroqfLbibcxUXUcZK/TlGLvyqkbeB46PhzJV4
 Yc4zDMxQIU3H18ShOhVlpmcXNgU4r+lMojE7ieYbBqM3hDLEIFh0xeEykK79m4/xzb7d
 bJCnSm+MdQhPq+WjCo9lrHCqwjsu2S9/pdnuY0GSdJFm0LEgaTsvWLB0eURNNHUgPaJj
 0FVw==
X-Gm-Message-State: AOJu0Ywh9sUKf0nT3RaM0vt+1fJbYgUyn5NMJlF3dl8WgocuDLkkAjGf
 Sx489yaMtxZ/zszr340If9mrky3y7KLrCqAeys1o3YFRNEZ7iMEwcSY4GgRUwlebCXIVEpuXF/x
 2
X-Gm-Gg: ASbGncvYhzGFYQJWOq5RU5bA4ZbjOg7vCyQNt13EL6vZ6oM8rv6/g0gYPoH2UJbz17v
 m+gSJkP7wMQe+hI9K3n1aZqYFELaLvujcgBYR4bNFAXni25T3SPhAVdgIiaHPkAUQZpiScXbpf6
 V4CFuSuP+V/f9stu7WWcePm0iKv6qyQxhzDzUP0T7/cdgxeUts+NrxNjAs5ieKuRTcqOs1nwKp5
 IrggUGX744evBkwCV0CRlf9sI6Lm7lQvle8q7K2/Wjz/bMPWQDaSA9gTuvwqUSpuLOYXfHqh9JJ
 V2xdFsgERKWxyarCdDFUSCYuejtT5CpyUz2uZutznVoQB3ampwi6IxUlKp53B2RHaEB7Jy2qU+E
 f/lug/kIJoUg/Ns8ujMQMjg==
X-Google-Smtp-Source: AGHT+IGCsUTrophZpdNqNbQa6l8cMabfqIm5nAoTEe0Jr7G82yQF4O6csfLgkP7E548IDjVXN0FleA==
X-Received: by 2002:a17:902:f541:b0:21f:dbb:20a6 with SMTP id
 d9443c01a7336-22428ab7345mr255598135ad.33.1741737281794; 
 Tue, 11 Mar 2025 16:54:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 3/9] net/ioring: implement control functions
Date: Tue, 11 Mar 2025 16:51:21 -0700
Message-ID: <20250311235424.172440-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

These internal ops, just force changes to kernel visible net device.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |  3 ++
 drivers/net/ioring/rte_eth_ioring.c | 69 +++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index d4bf70cb4f..199c7cd31c 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -5,6 +5,9 @@
 ;
 [Features]
 Link status          = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
 Linux		     = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 8c89497b1a..fe3c72098c 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -13,6 +13,7 @@
 #include <sys/socket.h>
 #include <net/if.h>
 #include <linux/if.h>
+#include <linux/if_arp.h>
 #include <linux/if_tun.h>
 
 #include <bus_vdev_driver.h>
@@ -163,6 +164,30 @@ eth_dev_set_link_down(struct rte_eth_dev *dev)
 	return eth_dev_change_flags(dev, 0, ~IFF_UP);
 }
 
+static int
+eth_dev_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, IFF_PROMISC, ~0);
+}
+
+static int
+eth_dev_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, 0, ~IFF_PROMISC);
+}
+
+static int
+eth_dev_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, IFF_ALLMULTI, ~0);
+}
+
+static int
+eth_dev_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, 0, ~IFF_ALLMULTI);
+}
+
 static int
 eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -183,6 +208,44 @@ eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	return 0;
 };
 
+static int
+eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+	struct ifreq ifr = { .ifr_mtu = mtu };
+	int ret;
+
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	ret = ioctl(pmd->ctl_sock, SIOCSIFMTU, &ifr);
+	if (ret < 0) {
+		PMD_LOG(ERR, "ioctl(SIOCSIFMTU) failed: %s", strerror(errno));
+		ret = -errno;
+	}
+
+	return ret;
+}
+
+static int
+eth_dev_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+	struct ifreq ifr = { };
+	int ret;
+
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+	memcpy(ifr.ifr_hwaddr.sa_data, addr, sizeof(*addr));
+
+	ret = ioctl(pmd->ctl_sock, SIOCSIFHWADDR, &ifr);
+	if (ret < 0) {
+		PMD_LOG(ERR, "ioctl(SIOCSIFHWADDR) failed: %s", strerror(errno));
+		ret = -errno;
+	}
+
+	return ret;
+}
+
 static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
@@ -209,6 +272,12 @@ static const struct eth_dev_ops ops = {
 	.link_update		= eth_link_update,
 	.dev_set_link_up	= eth_dev_set_link_up,
 	.dev_set_link_down	= eth_dev_set_link_down,
+	.mac_addr_set		= eth_dev_macaddr_set,
+	.mtu_set		= eth_dev_mtu_set,
+	.promiscuous_enable	= eth_dev_promiscuous_enable,
+	.promiscuous_disable	= eth_dev_promiscuous_disable,
+	.allmulticast_enable	= eth_dev_allmulticast_enable,
+	.allmulticast_disable	= eth_dev_allmulticast_disable,
 };
 
 
-- 
2.47.2

