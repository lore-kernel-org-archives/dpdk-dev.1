Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B8C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76FBB402F2;
	Fri, 20 Feb 2026 18:06:23 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 28B8D4027B
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:21 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb4136d865so270078285a.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607180;
 x=1772211980; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=Y1ZpN29zOkN5VwDURadIn06kvh5mvjIMMeo29+WhBuBSVeJff8ZySAF1EFrIzk6bL9
 fCTTrgl+R8rfwx1sjB9+myXSHD4V+uVoTMcDoqwONY0VY6Q10B1fmG/FOf0X+/kMchAi
 hww7CDnwRIGN7EGbkeySxzLgyKF3E5K+TQK/+5IecsZfI7slh27CezqtJdiiqlUgY3q9
 i6EuXNE9knoQd56YHq4h8U2KxnyHokJ+gCDbtKafEb4pPbMGJ+ZLggH/L5zwfELepyum
 qZSY//k1G6+CDv0BpumPE1Gb/zQezdRgwb6DjoqohmJmvvPapfZdcRwdKuzTFbkabxlY
 igxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607180; x=1772211980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20R19dCnc/BbP+s8EiCxdL8VBzClIClf5xdw2NhyXmI=;
 b=IOb6KDkKuTAqE3bAXJu227WOqWnuBeX8BGUDETU+lzj+FosmCeXJsPLi53WlEyFoYY
 OKOO/3imIy9dVlcvrjhe7onSLJEbJwfsfzdY4wwk8ZV75QPRFLoFhXLmOwQIK3ypKl4Y
 npd+wUAo8aer/l3B9d70T7Gz13DaJCOjNwp6XC1YRkDurPVWhfsaDvK/1wafqORdN5KP
 wLwtlXJEFdQlHMdtiuL90P9HX/AiL1X+zq0sh0fv7NTgLR0KrmdwNxFH301JXXOyNT/l
 zQ0XEXFb5IHIiOMSWAubw6gWNRmePMW+F0VAeYtADSowG+BE/orzYRiSNgOH1GHrHrLC
 JuUA==
X-Gm-Message-State: AOJu0Yx4QsstfTMIpc1TX9POl5y/PAihN7C0kzKQa3/NjfLOusTE8pIs
 cQnGpZuIkAYkBUWyZ+mY8XSjZjT0lgVSccS6TxSrg711rMhq2UaZrljWu81HLrohwO74rm3cj8A
 Hfezf
X-Gm-Gg: AZuq6aJ3kiHbfklskCytgOp1+f6b2u3YQ3nXMoxmn/citPyhRa363VD53a36KOVqY+0
 Br7EDgOeul6tbJ3aenJ2/E3/87wCziNdPbCnUnO55s64FN6IbJWPIKpo++brviPX2Y4FzlimGza
 vVA0GABUDzf/aTDoOF4gPrnW7uxf9TsFsQOWP+S9KeDBGWTkCuStN1pQsTqLP0eu75238sTTxYs
 3I92rdUjfKsThr+hv/bA6d2/aqZEu4qYN4fDiaP1tAU1gGoi3GryKn2v+zLdVeKqYNCk/Y8f+qq
 67Mm+MbnwM7dqM/45t862yDvNDplsoEI7GRduOEyXbn/JyvCqd36MdUe5+pwoVLxhDTtn2U1Sgi
 CI4y9u4C4zFRn6VBgi2tUH5ArwiaYzQvBYn1Ct2eS0Njv/pGg/znOyUTrePlDH49hxqdhDxficZ
 bt0e7TJFrBG/YclVMMT0k0cBjKtCfDK7cxTU9TW0xEIIRPxCvnSRQVVlORpQUzzQ==
X-Received: by 2002:a05:622a:1195:b0:501:13b1:14cd with SMTP id
 d75a77b69052e-5070bba48d9mr8438691cf.3.1771607180028; 
 Fri, 20 Feb 2026 09:06:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 01/10] net/tap: replace runtime speed capability with
 constant
Date: Fri, 20 Feb 2026 09:02:01 -0800
Message-ID: <20260220170614.75560-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

