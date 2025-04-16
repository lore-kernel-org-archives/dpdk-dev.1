Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F7C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE3BA410D3;
	Wed, 16 Apr 2025 16:00:42 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E5BEF40EAB
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 394B5E1149;
 Wed, 16 Apr 2025 18:00:36 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 394B5E1149
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812036;
 bh=8+zCDRtCSS/Gin0Zu3Dio3kSNl91F91LNKh2kYGJJ0Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LH9ITWbMb3WGsRl5XRnMOqvXTWrADOPPnKjM+oZzNNWNIP3WUuyF4U19GccJWVIOk
 Yfv+LXeRF57qck0ZjgOcRiG2nO0lF0qMS8VLjseTAtOpzReKUERgNgqiRr5QRZZ4Hw
 L6e5V/0dE/LYN+YVzWNite/jvNTQNlRHOo9s3w1SnOK+GZHYfE2tigeFf0aSaUu/+v
 DEcjAA9wkBM0HZaKUrbGEtwzKbvalBOTZ6A/fT/S09EKXmJXafq5VIqgUsmLIgNPLV
 ClcdL+q/vgqeUickZInkt4bLvALKThvSaJlzAqKWuXK/FnZlpeKuDjh70j/+bFvzvC
 MijPnOEL57ucw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 13/46] drivers: enable support for AMD Solarflare X4 adapter
 family
Date: Wed, 16 Apr 2025 17:59:43 +0400
Message-Id: <20250416140016.36127-14-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Enable support for Medford4 (X4) adapters X4522 and X4542.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/efsys.h | 4 ++--
 drivers/net/sfc/sfc_ethdev.c   | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/efsys.h b/drivers/common/sfc_efx/efsys.h
index e63cbdbe8f..ea68d3bd1a 100644
--- a/drivers/common/sfc_efx/efsys.h
+++ b/drivers/common/sfc_efx/efsys.h
@@ -125,8 +125,8 @@ prefetch_read_once(const volatile void *addr)
 #define EFSYS_OPT_MEDFORD2 1
 /* Enable Riverhead support */
 #define EFSYS_OPT_RIVERHEAD 1
-/* Disable Medford4 support (not supported yet) */
-#define EFSYS_OPT_MEDFORD4 0
+/* Enable Medford4 support */
+#define EFSYS_OPT_MEDFORD4 1
 
 #ifdef RTE_DEBUG_COMMON_SFC_EFX
 #define EFSYS_OPT_CHECK_REG 1
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 82fbdbae9c..3e57c902df 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -2829,6 +2829,7 @@ sfc_eth_dev_set_ops(struct rte_eth_dev *dev)
 	case EFX_FAMILY_HUNTINGTON:
 	case EFX_FAMILY_MEDFORD:
 	case EFX_FAMILY_MEDFORD2:
+	case EFX_FAMILY_MEDFORD4:
 		avail_caps |= SFC_DP_HW_FW_CAP_EF10;
 		avail_caps |= SFC_DP_HW_FW_CAP_RX_EFX;
 		avail_caps |= SFC_DP_HW_FW_CAP_TX_EFX;
@@ -3301,6 +3302,8 @@ static const struct rte_pci_id pci_id_sfc_efx_map[] = {
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD_VF) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD2) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD2_VF) },
+	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4) },
+	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4_VF) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_XILINX, EFX_PCI_DEVID_RIVERHEAD) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_XILINX, EFX_PCI_DEVID_RIVERHEAD_VF) },
 	{ .vendor_id = 0 /* sentinel */ }
-- 
2.39.5

