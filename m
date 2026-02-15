Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C732E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B0C1402F0;
	Sun, 15 Feb 2026 20:53:58 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 29A1F402EB
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:53:57 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso18495205e9.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185237;
 x=1771790037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=OiYSnJvxKmJhOeX/txwefPOVPr8Kvx0iWeyJMGOG8/C2YYUo0Wb8i2Yx87IR5LmlCc
 IfU4UP0OUEfhMlGFDYA4EHb2Xw1GRV6nL6wqw/epyXGHxUhPS8JVwkUtNdvJ5AlzBkgv
 6XE/Y3kGlWNTH2px9F0MLqJz92W9ONgzANxK0lhgSbu6WIB6awtQ+OEQgoHb7WoCcQHo
 9oQ04krwEj1nJSNREBMKYq3e1it9c4SiJ3XfBW0ru7A1WpjEfQLh3D0knM2qIegenlZw
 Rfh7TgYf8orhmCU2st2IJPpK0fR8S2i1cMxt8L2FHNfqsMyFxHcUOGlysrydI1G1/mx1
 bV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185237; x=1771790037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=ncu9pgvqlaOqG782uWNEnaSwekStMhZ1iNFZCNoBhiHMOP9iO7Zg6jkOuOtA17fF73
 kMBP3Y6HZYdviwUmgNnI4DtBYPtsjIeNhW6MYVgtu8QORPrPdhA1ZUYtTNTA3RcUxXPG
 2E9kBmeEKnHLqulii4xqcwXAdKWl/fOQ57FEQPoVMJaagiOF33CxZ2/b5z4IlnQgtSFv
 RX9fdysmIo8ozYuO3AATXy+06ERjPjrRu/tI75ceZLgV7flhee/xuvMPLu1dUtNn3vET
 kqvWSk+4OCBeG8mCeFm+7Me3IwlOf5dGARvHPw7to/fjbZ4hXc3CMSCHirYHtt+yW8JW
 PKeA==
X-Gm-Message-State: AOJu0YwInJ75UzQzo5Au7qqWxQKhibecTw/FVqOHbAZvQnbyFaqfhZoE
 66/zF3t9mYnIzdP4o4vF95kHE+2BuHsmF/B0tL3jLF9OKzUrKgNleJCvAB52oReHr6EKD/c4Zys
 K4+6oHqA=
X-Gm-Gg: AZuq6aLAKCSYvQd3CJCQFsGp/jMnVFHnxqi9y+zSx8sxiuOKalnSRcX5Q8ZQsr0WU0s
 OW2WKX5tetVE7ouaRPnb4SGkCeVVeJKjY3BGWXTo4miq7VlHyvY5u2Wm+zGUbSw/8bAsUl1KFrA
 v5Co2TH3DWmIEVASYnUWAbbL84tYrWDttd4yeD31flU4lyeXzWZds9CRXHoT871DCMeHOAhiFF+
 QNTmWrOCw0AnqETdiByyxed+Ee97s5LJEse9vCJmIGnj5eIQn6XLj+rZmKqyyLaiTttACevSGL+
 TLYm/GIXirqx4CguHexN110OJb3EFjRCxwWa4SFQpUpggtCzwKEymDv4xOfeLlR9XMWttHAl/59
 UH1l4BqV5myx4lrKXJpQxTNg2qwGYNrSGNeGLuVQv2ZDraW8uwQoqbFEILm2UxQ98hSco4kS3PC
 hXkzYrMzxiCnJnrRTT3O3DapEt0wzPLoUaqVjlF9EOV23jbRwGMYRzOsolEBITnA==
X-Received: by 2002:a05:600c:4f8a:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-48373a7592cmr125345855e9.32.1771185236616; 
 Sun, 15 Feb 2026 11:53:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:53:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/10] net/tap: replace runtime speed capability with constant
Date: Sun, 15 Feb 2026 11:52:20 -0800
Message-ID: <20260215195348.557945-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

The TAP/TUN virtual device always operates at 10G. The link speed is
set in the static initializer for pmd_link, so the runtime assignments
in rte_pmd_tap_probe() and rte_pmd_tun_probe() are redundant.

Replace tap_dev_speed_capa(), which dynamically computed speed
capabilities against pmd_link.link_speed, with a compile-time
constant TAP_SPEED_CAPA. Remove the unused 'speed' variable and
redundant assignments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 48 ++++++-----------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 7a8a98cddb..aa236cf967 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -891,39 +891,13 @@ tap_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static uint32_t
-tap_dev_speed_capa(void)
-{
-	uint32_t speed = pmd_link.link_speed;
-	uint32_t capa = 0;
-
-	if (speed >= RTE_ETH_SPEED_NUM_10M)
-		capa |= RTE_ETH_LINK_SPEED_10M;
-	if (speed >= RTE_ETH_SPEED_NUM_100M)
-		capa |= RTE_ETH_LINK_SPEED_100M;
-	if (speed >= RTE_ETH_SPEED_NUM_1G)
-		capa |= RTE_ETH_LINK_SPEED_1G;
-	if (speed >= RTE_ETH_SPEED_NUM_5G)
-		capa |= RTE_ETH_LINK_SPEED_2_5G;
-	if (speed >= RTE_ETH_SPEED_NUM_5G)
-		capa |= RTE_ETH_LINK_SPEED_5G;
-	if (speed >= RTE_ETH_SPEED_NUM_10G)
-		capa |= RTE_ETH_LINK_SPEED_10G;
-	if (speed >= RTE_ETH_SPEED_NUM_20G)
-		capa |= RTE_ETH_LINK_SPEED_20G;
-	if (speed >= RTE_ETH_SPEED_NUM_25G)
-		capa |= RTE_ETH_LINK_SPEED_25G;
-	if (speed >= RTE_ETH_SPEED_NUM_40G)
-		capa |= RTE_ETH_LINK_SPEED_40G;
-	if (speed >= RTE_ETH_SPEED_NUM_50G)
-		capa |= RTE_ETH_LINK_SPEED_50G;
-	if (speed >= RTE_ETH_SPEED_NUM_56G)
-		capa |= RTE_ETH_LINK_SPEED_56G;
-	if (speed >= RTE_ETH_SPEED_NUM_100G)
-		capa |= RTE_ETH_LINK_SPEED_100G;
-
-	return capa;
-}
+/* Speed capabilities for virtual TAP/TUN device (always 10G) */
+#define TAP_SPEED_CAPA (RTE_ETH_LINK_SPEED_10M | \
+			RTE_ETH_LINK_SPEED_100M | \
+			RTE_ETH_LINK_SPEED_1G | \
+			RTE_ETH_LINK_SPEED_2_5G | \
+			RTE_ETH_LINK_SPEED_5G | \
+			RTE_ETH_LINK_SPEED_10G)
 
 static int
 tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
@@ -936,7 +910,7 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = RTE_PMD_TAP_MAX_QUEUES;
 	dev_info->max_tx_queues = RTE_PMD_TAP_MAX_QUEUES;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->speed_capa = tap_dev_speed_capa();
+	dev_info->speed_capa = TAP_SPEED_CAPA;
 	dev_info->rx_queue_offload_capa = TAP_RX_OFFLOAD;
 	dev_info->rx_offload_capa = dev_info->rx_queue_offload_capa;
 	dev_info->tx_queue_offload_capa = TAP_TX_OFFLOAD;
@@ -2325,7 +2299,6 @@ set_mac_type(const char *key __rte_unused,
  * Open a TUN interface device. TUN PMD
  * 1) sets tap_type as false
  * 2) intakes iface as argument.
- * 3) as interface is virtual set speed to 10G
  */
 static int
 rte_pmd_tun_probe(struct rte_vdev_device *dev)
@@ -2373,7 +2346,6 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
 			}
 		}
 	}
-	pmd_link.link_speed = RTE_ETH_SPEED_NUM_10G;
 
 	TAP_LOG(DEBUG, "Initializing pmd_tun for %s", name);
 
@@ -2495,7 +2467,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 	const char *name, *params;
 	int ret;
 	struct rte_kvargs *kvlist = NULL;
-	int speed;
 	char tap_name[RTE_ETH_NAME_MAX_LEN];
 	char remote_iface[RTE_ETH_NAME_MAX_LEN];
 	struct rte_ether_addr user_mac = { .addr_bytes = {0} };
@@ -2545,8 +2516,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 		return 0;
 	}
 
-	speed = RTE_ETH_SPEED_NUM_10G;
-
 	/* use tap%d which causes kernel to choose next available */
 	strlcpy(tap_name, DEFAULT_TAP_NAME "%d", RTE_ETH_NAME_MAX_LEN);
 	memset(remote_iface, 0, RTE_ETH_NAME_MAX_LEN);
@@ -2587,7 +2556,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 				persist = 1;
 		}
 	}
-	pmd_link.link_speed = speed;
 
 	TAP_LOG(DEBUG, "Initializing pmd_tap for %s", name);
 
-- 
2.51.0

