Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4106C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6030B402E9;
	Thu, 13 Mar 2025 22:52:10 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 50A6C402C3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:06 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-224341bbc1dso31010095ad.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902725;
 x=1742507525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZJGpF3r/ltLfuGV6qt65I55MfKQyFtz38LMirAOGD4=;
 b=KaTAlDGPlcWTf3LW1PMBnDmo8WQqQLXYEU+x4xIvq8s0KeGcTASAHtCnNF1Lqevj+S
 2xyF09OFtYWwKl/cU4hyBQsf+kI1g5uwN3VEJnYokaypj9bphXMakPqebM23RcBGZZ1Z
 umdtqWHzimT3YnA7v9KSXU4Y3LeuKADBuZsIwn7DTDLnPNJ+c5+LwDA+pAEhC6oWPNCt
 pCSnbvwpOytEspbZTvjf00lEfgpepi2grd8Zee8CyMRWWPFL9FoaGrEJAsi09ysv8u0T
 /o0SAD+KYMC7MYlDaq8EhLJoMsSMKNq6zZNdHNcscWn/JayP5RJ/hBqWG5vkD6oaCnr2
 oG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902725; x=1742507525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZJGpF3r/ltLfuGV6qt65I55MfKQyFtz38LMirAOGD4=;
 b=CJl7AelKiuK4ACB6Vu03LKwbOZowUGL2cnt0eM7OrrG0/QtIdZWUyV6u8BLr8hWBV9
 /BcrvIr/8ZlD34YKKbT2lWfDvid3qmC02oV4gnMjt3YcENI/IGHJtuFUlWMiPU4tVuNH
 KvC5kUXLh/NTN8ub+0ZIxNEFgDbPGU81LDe5MsmIRvDhn+QfgY1oHOq05mU9xLHvsnYH
 DgZuj9ZRXNOhJr7bAqzaPzFSSlTBQqW1hgaH14Y14l3EHmYRxt3ofoEm16FYKf2mNo0p
 D54/jJhaX6FpAKXj0QATVh7vjAQzNRlIbrm1WXX90Vbgp9otAhgQFWuw3IYJniHSRW1F
 mZIw==
X-Gm-Message-State: AOJu0Yy2UfQpH+6uPDglHQAHcresk8r1BKmrzqRYCCookd2YXg3bDJIg
 g5rer8u7ULFjK7pZoQ6jcA7B2h7g8QFftLlISUZRJ+XhxmqvbV9omrrZTeNz9ZiHs33mB8Zo91A
 O
X-Gm-Gg: ASbGncuG1vzBi0QNjpiTBbSalxdOpvLmT7S60PDj+e1eI/M49kh2BUo5bUQm3TRGFjL
 ObHs/rc8bGeIIXefDM/rb651rpTxHgQZx9ddVnJZyeuU9we3P8ZgS+6h+kek9YKp7zcmTACnWjx
 vNsirvYz6ZgFHF7tAMP3SDwMnNpIPczv3p4GToJ07EDdb8nnaA6uLUeOHLloHOVFN1ZhB/NWGPj
 6VvhufstyKNL0LiPeX9OkdDnns+iRSxU/QtajtaS6jEFemQVjWOkShmr21h9fISx1LdyHxeUJz3
 SD8WMQERsedzoNLi7pFrLyiQFL+PbrvA1yP/TD7DEEVYKhUPoNnYeidvUs1uTQVA/w0TuXc6ynd
 ibJiH5X+023t3yF3K64roCA==
X-Google-Smtp-Source: AGHT+IEwWUE1tSj/IcED18nyXE/99gWde5+eCJNgrQec58owXfgHAZrVZET0CCPiYKbUcRlYrinAWg==
X-Received: by 2002:a17:902:d588:b0:223:5ada:891e with SMTP id
 d9443c01a7336-225e0a241e9mr2522105ad.7.1741902725524; 
 Thu, 13 Mar 2025 14:52:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 03/10] net/ioring: implement control functions
Date: Thu, 13 Mar 2025 14:50:54 -0700
Message-ID: <20250313215151.292944-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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

