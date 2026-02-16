Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA92E83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:04:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB2340649;
	Tue, 17 Feb 2026 00:04:47 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 6B2AB4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:46 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso3774166f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283086;
 x=1771887886; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=FCrOqhCI1ocuLkSwLjAnDhuEWa5w3UMhAyD3XmVQfmXfwaCExwcSM6mWsNQ/zBpsKs
 pZqWIEDH/tvVBoKkMLsz+aX2bYL18EhkYhVcQkiTY+YlRhu6fAPCy3+k5tDsT+T3kofE
 lUJkHMX8kaPQ+n/4pQ5z65T17V2HsDuaenAb3xTMVNiLZw7FeKHQscRt9hJwFWYrDeOM
 fuhjUYiK1H2sEq29bEFIA+qg/cTFBOhMJr99bW2BoJTpA9BQLCXly80Yn1MYLWLrZLRA
 qTeyQXQ6faABarbmhldgfzFHtfpw26eFAINa9u7tHuN/KIfhbiR/OlUuSr40ZNrczp6D
 SO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283086; x=1771887886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=qr2QcEYgri5J7I25IXNuJld5DP2ehE57EaI2jl7gCqUbEC3Qc1lEkL0d/v3T8AhLco
 dSE2SbBciQYCFyjzvSCY9RmQul8dour6bCIK48GzzP45KVVMtnUlEJp0egnwrVGAJkel
 YVc2jaThAXwz1j1PkwRcBH4Rnh+/zOC8Lr7+zDmqFFzkKlOTlYSq3g3Ua6oFSnn4gm8t
 ezBX9Huq/FkvLJWiaQwb2h3hLmYA2sAbvMlUS9kZzzmOnWColiR5GxUPh/0WToiGHYHW
 XwdS/T5SSOMpNLxbq4qy9mNtoB0z93B+e3wOxGGnL9z5tj844Wq7HMABItTobx+cZSD5
 CkWg==
X-Gm-Message-State: AOJu0YwSt+cBmHXrd4BwOFle3EcUlpGTqSlkh/n1IhtFbSmsCWSgXbLn
 wFn5nudJvmViYl/22QeyISTvQIO8ubhG9sEY+mylR0b3/aoXMsqVd4bUKaZd6VSg3sAUpNlqER5
 KH8tywbs=
X-Gm-Gg: AZuq6aL//YV988VVIc0KoIrTZC38X445klvTyyLi2yT16Ib1ImEKbg/q1cpehubj4lX
 2kW4EU3tqTdut70Oh0jOLOHnp/vpYE4tDtvyo1HbbvyrHZ3472t/xRWFXUNeDaWc807zpqqKWAv
 aFPhDllRGX261QV6fbTrK872cZd5FbKciGhT9VUi82qdCHwNbSzFoIOxCs1lIBIFY6w9DgGqrCa
 F7OCoL9a3u3tWQ2C238rzPlTzoJEQmi7AGdFc80GQP2CC/bEkwSMvdCdVHV6P9dpPEY0Rq1gzH7
 nu/2y4RTlhTsM2kfg1unKnXhhDVHbEOMh6mtTiZEQNjjdbZm6re8BK8cyRc6z8nwDpnIOSIdQKS
 xyir8pf3Q3WxDj9+zhvnbzTH1xgkmPfpKqC4Y3hcPRq8oEG0RCBr22OZT4Kqgt92UI5dH2egd2p
 t6RLIrknCV037B9u2nD0quhFcUowQ3QvvFF3fAbyfrl93P5nbSqLgge5HjK9pOlQ==
X-Received: by 2002:a05:6000:288f:b0:437:7010:1cfd with SMTP id
 ffacd0b85a97d-4379d5db5a9mr21018566f8f.4.1771283085860; 
 Mon, 16 Feb 2026 15:04:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 02/11] net/tap: replace runtime speed capability with
 constant
Date: Mon, 16 Feb 2026 15:02:26 -0800
Message-ID: <20260216230437.847578-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

