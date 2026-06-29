Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3967C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD5F840661;
	Mon, 29 Jun 2026 07:21:37 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 90AE9402D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B0C71A0AC3;
 Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 45D1A1A0FC0;
 Mon, 29 Jun 2026 07:05:32 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C60F1180008C;
 Mon, 29 Jun 2026 13:05:31 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 4/9] net/enetc: update random MAC generation code
Date: Mon, 29 Jun 2026 10:35:22 +0530
Message-Id: <20260629050527.981200-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260629050527.981200-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
 <20260629050527.981200-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Use rte_eth_random_addr() instead of manual rte_rand() based MAC
generation. Also handle VF path by writing to ENETC_SIPMAR0/1 instead
of ENETC_PSIPMAR0/1 when running as a VF.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/enetc_ethdev.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index 8196377..55b0e0b 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -195,20 +195,18 @@ enetc_hardware_init(struct enetc_eth_hw *hw)
 	}
 
 	if ((high_mac | low_mac) == 0) {
-		char *first_byte;
-
 		ENETC_PMD_NOTICE("MAC is not available for this SI, "
 				"set random MAC");
-		mac = (uint32_t *)hw->mac.addr;
-		*mac = (uint32_t)rte_rand();
-		first_byte = (char *)mac;
-		*first_byte &= 0xfe;	/* clear multicast bit */
-		*first_byte |= 0x02;	/* set local assignment bit (IEEE802) */
-
-		enetc_port_wr(enetc_hw, ENETC_PSIPMAR0(0), *mac);
-		mac++;
-		*mac = (uint16_t)rte_rand();
-		enetc_port_wr(enetc_hw, ENETC_PSIPMAR1(0), *mac);
+		rte_eth_random_addr(hw->mac.addr);
+		high_mac = *(uint32_t *)hw->mac.addr;
+		low_mac = *(uint16_t *)(hw->mac.addr + 4);
+		if (hw->device_id == ENETC_DEV_ID_VF) {
+			enetc_wr(enetc_hw, ENETC_SIPMAR0, high_mac);
+			enetc_wr(enetc_hw, ENETC_SIPMAR1, low_mac);
+		} else {
+			enetc_port_wr(enetc_hw, ENETC_PSIPMAR0(0), high_mac);
+			enetc_port_wr(enetc_hw, ENETC_PSIPMAR1(0), low_mac);
+		}
 		enetc_print_ethaddr("New address: ",
 			      (const struct rte_ether_addr *)hw->mac.addr);
 	}
-- 
2.25.1

