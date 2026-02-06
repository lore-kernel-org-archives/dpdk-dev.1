Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57226EE20BC
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C43C40654;
	Fri,  6 Feb 2026 18:04:43 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 737C64042C
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=yL/BOSchP/ZTqvv7SPOIkpzybj/fk8N+JsdsxXvssZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lXh+hxVGlnkde4f7qVJFRcop7fR4uns0Klz3Hah0lnxo8EpPCMfQBnbr2ALYdBsQC
 eFBmMwljqYVCjEmcmY05qDclS3e+7HQQMbtsvaGx2JYLQo+5i+leOQo5WNeJDYFxny
 xssT+kk2nP0eNS1mG4M5r8wieDAM35TA8+gLA3x/NbZtTdtg/6OkaC0AnXf6NXAtXc
 ZMOGbMndy0jVURxIBKGfVGjDXW+xnkGDnLbJZG/pWCGSr5cXlX11e6TpTccTKUvZP9
 VwjaYlzMI9/ET1LGy1CqHMfOnkEu0ASEUONCitmYrk8ytMk6oS2KpSsKZ1VZu3Dgta
 7NCi5+RPbI/3A==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 454891180081;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 3/7] net/nfb: support real link-up/down config
Date: Fri,  6 Feb 2026 18:04:31 +0100
Message-ID: <20260206170435.302184-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

Use the standard PMA reset bit in the MDIO registers
to configure of the link-up/link-down state.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 437aed9ae7..950754f4cf 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -410,6 +410,29 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static int
+nfb_eth_dev_set_link(struct pmd_internals *intl, bool val)
+{
+	int reg;
+	struct mdio_if_info *if_info;
+
+	if (!intl->max_eth)
+		return 0;
+
+	if_info = &intl->eth_node[0].if_info;
+
+	reg = nfb_mdio_if_read_pma(if_info, NFB_MDIO_PMA_CTRL);
+	if (reg < 0)
+		return reg;
+
+	/* Update PMA Reset flag if necessary (Reset flag set means link down) */
+	if ((reg & NFB_MDIO_PMA_CTRL_RESET) != (val ? 0 : NFB_MDIO_PMA_CTRL_RESET)) {
+		reg ^= NFB_MDIO_PMA_CTRL_RESET;
+		return nfb_mdio_if_write_pma(if_info, NFB_MDIO_PMA_CTRL, reg);
+	}
+	return 0;
+}
+
 /**
  * DPDK callback to bring the link UP.
  *
@@ -422,17 +445,16 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 static int
 nfb_eth_dev_set_link_up(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->process_private;
-
+	struct pmd_internals *internals = dev->process_private;
 	uint16_t i;
+
 	for (i = 0; i < internals->max_rxmac; ++i)
 		nc_rxmac_enable(internals->rxmac[i]);
 
 	for (i = 0; i < internals->max_txmac; ++i)
 		nc_txmac_enable(internals->txmac[i]);
 
-	return 0;
+	return nfb_eth_dev_set_link(internals, true);
 }
 
 /**
@@ -447,17 +469,17 @@ nfb_eth_dev_set_link_up(struct rte_eth_dev *dev)
 static int
 nfb_eth_dev_set_link_down(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->process_private;
+	struct pmd_internals *internals = dev->process_private;
 
 	uint16_t i;
+
 	for (i = 0; i < internals->max_rxmac; ++i)
 		nc_rxmac_disable(internals->rxmac[i]);
 
 	for (i = 0; i < internals->max_txmac; ++i)
 		nc_txmac_disable(internals->txmac[i]);
 
-	return 0;
+	return nfb_eth_dev_set_link(internals, false);
 }
 
 static uint64_t
-- 
2.53.0

