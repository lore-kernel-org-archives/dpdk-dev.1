Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34A3C53209
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C71A24042E;
	Fri, 20 Feb 2026 06:04:18 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 32494402DB
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:16 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb420fbb5dso107431285a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563855;
 x=1772168655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=fHjD8RmiICdUWzopSY4CSZM1UfynhboxdMsFQ9KTeE5SahBljhDiKgfNjq5qL0pmnc
 Sn4T/zmPvhLxN2qx428n+iOE086xSaovMfQe+7HawNf2tDUUVedhYykPnzdAddto9j/j
 HEn9lhSHEHGLv15asqJMzLH6t0P/TaHDhTufdZ7SbV1ocR0KdZLYJ99cjFIFmecwl4lj
 f9WQvj9TzOLGzPUN14fu7wJgFgk7xbypUwtxxLyzp4ewiBcxV/pAsEPdiNQvvaT3Gqee
 lx0cRqIFcyoD7ShPkDTBWhycQgFLv+Te2LJH22bW4L9fCFpwLQc0E3ZQYbLCOiogKANL
 dP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563855; x=1772168655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=FXXII9Ea5Bpzs8ARhkyvXLfiQ6dY1Ob7v49+8LnVtmfVBUvs/jGAQhcd81cfpHWhjR
 IkZfZgftXzcKXRAdutRExb1R9MSaCc4r9MCkbfDY2j8LudFz0DKe21X8pEIcMuxTx5dn
 lCj6a5ax2dYtb3JcbFNAHgEtxpNV+vNbFNLUB9xUUAn7e/X48MdNaTwu+/U2n+UZ0m17
 3pZwqRCBM3Ov2FoOoT5ymMgTYj1ad2Geu0RS6N21thqbfO+0+/1GRz3OInjMS5kh30j5
 opforzlLUWXLRKZE521fiOi85Htd0ECnJjKFw6mYqYsjLOiIF5DcJ+iWVBfw9McXpLzc
 RMKQ==
X-Gm-Message-State: AOJu0YweO5D74Wa9FETzCC9bvduFoPdercPcN719GhWr+xBuThON1+OB
 iGGS9QyHxCmVu5crjYBJzXdFR0rR8wMMQL4dgHPefbXNC5sTw3hjt9vh4LS5HQ7o2bBUHlQq5HD
 hxMnr
X-Gm-Gg: AZuq6aIx+tXt2uC8qNREaw6cMGeISSXsNCaTlX4e1V255NgMEjF2CAG8hM47CEZWEES
 wbu9TZdz+cDUHvKoDNydAODD2Vsps60BwbNWt6ofEm9QLseV57XAqjv7OmZx5zcrbGyyi0Owi9/
 keX1Rhpa5JMddVL9JQrGklOQTeU2endl7qjfXs60PUUy4skDgodmm3q4KJYPtdrdukoKrEh8Vpk
 LOtYGjnUAx8vJfs8r1jtcJWNc+uLc7HF04dSXrRm7c3czI3X+uVg6T5i+tZOG4iLeuHdfcIY5sO
 m1AwaGvGZ0kuMMSS2e/F1H9w8V39+uAQlmbY9hsDUvNXPCn2EAvNNjV88yy20ooHnLV/uqvzthm
 J1nuCc+Mx/EzLK8rUnm8EgoCy11N4LEtEjgc0V5v4XtHAZjo7OaWGkMeEE+nagxWr3oJ+DgzcJO
 BRbiw0YiwNDYe/x3DTt+YAJ41R+cCa90Ol3oudPAMd1KRmD87T0gZbcOF2G87hjA==
X-Received: by 2002:a05:620a:4154:b0:8c1:ab1c:f2da with SMTP id
 af79cd13be357-8cb740c655fmr892412085a.70.1771563855397; 
 Thu, 19 Feb 2026 21:04:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 02/10] net/tap: replace runtime speed capability with
 constant
Date: Thu, 19 Feb 2026 21:02:04 -0800
Message-ID: <20260220050409.1571022-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

