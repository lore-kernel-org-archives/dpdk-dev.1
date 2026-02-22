Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241EDC636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A12E940656;
	Sun, 22 Feb 2026 18:32:39 +0100 (CET)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id 6821F4064F
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:33 +0100 (CET)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-67997ce9e1cso2137228eaf.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781553;
 x=1772386353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn2zDqQPsOYy9m6AE6FajOfs895V8N2myRXAf3D7r3w=;
 b=1Q0F6mt4OfR8YzPVcdFehVdeA3XLuSjC0thPiB22t1EJ6kXbRxMgPHwBvPF0YHO27t
 47CnV6TwMe+r/mXQueIpiaBKTK6eW5dxJIXkdxAoxj+bh7FbL2dCLZPKR/rCWrRc4cuq
 ZSUX2QKTKDMhEiToQvAdZoVR90USraFGwXDiimXwM/vPaZO5gsMvyXaCLfQSmaQwXY3u
 qpYEoioiwg261NLb/gff9ZvWjRcMOErtVy2w+yAcwFx+ygxJDteXOn6Fw86Exja+4ZL+
 wTVyB6wmPQ2J5bPr1YpUoH+nnYIw9Eh26ysGYveBnOsHYxV/9v9yuDoCZPCJF6FdXlr2
 rjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781553; x=1772386353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hn2zDqQPsOYy9m6AE6FajOfs895V8N2myRXAf3D7r3w=;
 b=A3wGS5RjorffTOzBmrhxexcoe5WDaKLSXOmOhdrbT0JjjDogO2v/T1/p59EPfPYi2B
 hJuUICKeg+rw7ryrEct96fL7EH8tTXwu5I8rkMA34z+XCL4OJ7IcaoqtA6395z3elSXX
 pc2fvr6Jc2/IfooSsFhGKrhlw0HC7j0n5pvX7u8KgVhhK+QnFe9zuM0P2cb58P+UAyXS
 q2Oy2UAEhxXdAayrkHKCsJhNSg3DVlcGjyVJIFpOBEO5E6g06KQLGLBA6SwcAUy3+kOE
 M9G0mKb7n4+d9owSJI4S1XbifF1v0M64H6BXUiUmfGi8myFYoVs5x1LuaGfFpwHoJhBT
 J+iw==
X-Gm-Message-State: AOJu0Yyuu9ov96OYnMYXonVjEJwNpULay/p2MVTAwJMepBbcr5Nx8pN4
 6RLltLheN3PLCQh3DFxeqyqxhit6Et/QwhA7iBxhNve1ipDO7pp1n06FDUI6GnBRh6WFHHipJi7
 n/96E
X-Gm-Gg: AZuq6aI5taXiHpQ9hOyRSjQ6o08iWp+txBMJDpRBaCArVq8Pu43tg3x3I0HXJZgrgun
 SbvQKiQBDn/2nTVbutA9Gzwvq55oEkMPmzusRY+Npgs+ajPNlUXpCAwDZmQDYNuIA3ip4R/MTIY
 ZAClCmAOrXPfOyu3bx0nLFElvI1zj5O4zgDIP6G94CyjLmhzAhUNyU2NjVOMd9gbBCDiJArBxl/
 Qh3ziXhwpKglV5iEj+5bA3HaY7lsasNXA8HBFaPcFZJZxyZ+QdQ8M/Fz6+0JzU54FZChRJM9HL3
 7+Vfjf8sXA+7EXDQ8cDUZqNKS5YxGtWUVm8fs9d8Qq/4GSD/ULqQobezo+FKSoIhPX6d9dnzmjB
 DuWy7k8N5UXn8stTJEMFBuShDuL3Xrmt3RJSsokEdb8lrEPobmjWiujYN1sM/TunVWTnflooZcW
 6aZ2abE0f6RHoiTtYmR2rxG0ee6TRR4pICo1Zv0ToeutdkR0HNc9Mhe08G7IPIJQ==
X-Received: by 2002:a05:6820:16a6:b0:662:c263:c9b4 with SMTP id
 006d021491bc7-679c4257f15mr3463753eaf.9.1771781552675; 
 Sun, 22 Feb 2026 09:32:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 04/19] net/tap: replace runtime speed capability with
 constant
Date: Sun, 22 Feb 2026 09:30:39 -0800
Message-ID: <20260222173225.522754-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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
index 08d51c3a45..9dac0eced9 100644
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
@@ -2314,7 +2288,6 @@ set_mac_type(const char *key __rte_unused,
  * Open a TUN interface device. TUN PMD
  * 1) sets tap_type as false
  * 2) intakes iface as argument.
- * 3) as interface is virtual set speed to 10G
  */
 static int
 rte_pmd_tun_probe(struct rte_vdev_device *dev)
@@ -2362,7 +2335,6 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
 			}
 		}
 	}
-	pmd_link.link_speed = RTE_ETH_SPEED_NUM_10G;
 
 	TAP_LOG(DEBUG, "Initializing pmd_tun for %s", name);
 
@@ -2484,7 +2456,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 	const char *name, *params;
 	int ret;
 	struct rte_kvargs *kvlist = NULL;
-	int speed;
 	char tap_name[IFNAMSIZ];
 	char remote_iface[IFNAMSIZ];
 	struct rte_ether_addr user_mac = { .addr_bytes = {0} };
@@ -2534,8 +2505,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 		return 0;
 	}
 
-	speed = RTE_ETH_SPEED_NUM_10G;
-
 	/* use tap%d which causes kernel to choose next available */
 	strlcpy(tap_name, DEFAULT_TAP_NAME "%d", IFNAMSIZ);
 	memset(remote_iface, 0, IFNAMSIZ);
@@ -2576,7 +2545,6 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 				persist = 1;
 		}
 	}
-	pmd_link.link_speed = speed;
 
 	TAP_LOG(DEBUG, "Initializing pmd_tap for %s", name);
 
-- 
2.51.0

