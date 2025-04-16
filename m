Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DCC369C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E346242D27;
	Wed, 16 Apr 2025 16:01:17 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 54972427B7
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9C84AE11AD;
 Wed, 16 Apr 2025 18:01:05 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9C84AE11AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812066;
 bh=yn7dgllXmp5w8IeKrzgNVUVAswXZbKQnfwpxhqQivB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EzmdeBbnGmqAOKRitqSp0CHaQcjz0k2m++ciL4YA3C/sBz3Oe0ax4QflurPiF6lqW
 t7bfd3tojdcYl8ehSV5bcoWR9GW4/8ILYxelgbPb6+eTRqjtDODk8uTBo+Z4jGrmeB
 6Ii3Tj84k8lNUZXNzj94j6z6hfWHuF3tx4nMWLM6jeT2di39Y+6h5eKWAYCR/i3hwu
 C6ePMepK4qmb5KzfXpI70syXtTfoJla83zaOShY6SvnESEzNRQ4q2XGLMTuqirXYqY
 947nrrWkYad0WtNEWpQyYZUKotmj6TnwlfjM2BuMCcZaaELQb4MCrjtiw4bM2zz2rX
 IQf7M5vQq0ZEg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 43/46] net/sfc: offer support for 200G link ability on new
 adaptors
Date: Wed, 16 Apr 2025 18:00:13 +0400
Message-Id: <20250416140016.36127-44-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

New adaptors (for instance, Medford4) can support 200G speed.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/sfc/sfc.c        |  5 ++++-
 drivers/net/sfc/sfc_ethdev.c | 15 +++++++++++++++
 drivers/net/sfc/sfc_port.c   |  6 ++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 938c967430..69747e49ae 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -126,7 +126,8 @@ sfc_phy_cap_from_link_speeds(uint32_t speeds)
 				(1 << EFX_PHY_CAP_25000FDX) |
 				(1 << EFX_PHY_CAP_40000FDX) |
 				(1 << EFX_PHY_CAP_50000FDX) |
-				(1 << EFX_PHY_CAP_100000FDX);
+				(1 << EFX_PHY_CAP_100000FDX) |
+				(1 << EFX_PHY_CAP_200000FDX);
 	}
 	if (speeds & RTE_ETH_LINK_SPEED_1G)
 		phy_caps |= (1 << EFX_PHY_CAP_1000FDX);
@@ -140,6 +141,8 @@ sfc_phy_cap_from_link_speeds(uint32_t speeds)
 		phy_caps |= (1 << EFX_PHY_CAP_50000FDX);
 	if (speeds & RTE_ETH_LINK_SPEED_100G)
 		phy_caps |= (1 << EFX_PHY_CAP_100000FDX);
+	if (speeds & RTE_ETH_LINK_SPEED_200G)
+		phy_caps |= (1 << EFX_PHY_CAP_200000FDX);
 
 	return phy_caps;
 }
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 05933b1d39..80eb39e58d 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -117,6 +117,8 @@ sfc_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_50G;
 	if (sa->port.phy_adv_cap_mask & (1u << EFX_PHY_CAP_100000FDX))
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_100G;
+	if (sa->port.phy_adv_cap_mask & (1u << EFX_PHY_CAP_200000FDX))
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_200G;
 
 	dev_info->max_rx_queues = sa->rxq_max;
 	dev_info->max_tx_queues = sa->txq_max;
@@ -2442,6 +2444,19 @@ sfc_fec_get_capa_speed_to_fec(uint32_t supported_caps,
 		}
 		num++;
 	}
+	if (supported_caps & (1u << EFX_PHY_CAP_200000FDX)) {
+		if (speed_fec_capa != NULL) {
+			speed_fec_capa[num].speed = RTE_ETH_SPEED_NUM_200G;
+			speed_fec_capa[num].capa =
+				RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC) |
+				RTE_ETH_FEC_MODE_CAPA_MASK(AUTO);
+			if (rs) {
+				speed_fec_capa[num].capa |=
+					RTE_ETH_FEC_MODE_CAPA_MASK(RS);
+			}
+		}
+		num++;
+	}
 
 	return num;
 }
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index 5e80003ca1..0a31a394d5 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -144,6 +144,8 @@ sfc_port_init_dev_link(struct sfc_adapter *sa)
 static efx_link_mode_t
 sfc_port_phy_caps_to_max_link_speed(uint32_t phy_caps)
 {
+	if (phy_caps & (1u << EFX_PHY_CAP_200000FDX))
+		return EFX_LINK_200000FDX;
 	if (phy_caps & (1u << EFX_PHY_CAP_100000FDX))
 		return EFX_LINK_100000FDX;
 	if (phy_caps & (1u << EFX_PHY_CAP_50000FDX))
@@ -649,6 +651,10 @@ sfc_port_link_mode_to_info(efx_link_mode_t link_mode,
 		link_info->link_speed  = RTE_ETH_SPEED_NUM_100G;
 		link_info->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 		break;
+	case EFX_LINK_200000FDX:
+		link_info->link_speed  = RTE_ETH_SPEED_NUM_200G;
+		link_info->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		break;
 	default:
 		SFC_ASSERT(B_FALSE);
 		/* FALLTHROUGH */
-- 
2.39.5

