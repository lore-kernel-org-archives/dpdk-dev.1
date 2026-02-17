Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB611E6816F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C85C54064E;
	Tue, 17 Feb 2026 12:03:30 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id B9D3A402AC
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=gy71HZ7qvzND92MRHcB8mEblllA0xqgrcaLFeab6FYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YMqeGCYGn8kAdc7bt0hKK2LvKB0jLPl8ERIs9BbRvjdIVWG2RSO7kFSK77D7dKvfU
 OB9wtD5ujtPVujA/3Cc+XRCjtt7Z8zNL538zq0Do1ti5hYlcAO66OwTn5uyLGot3Ky
 g5xEVAmm/6U3wcVPfPNORm/mOVkkufT7arggZZScauS8AidvXLm/Q5gxLgLY49h3jG
 +qy1cCoMXS64s8RuVSvmT+0iOrYDDRwAQNJC40URJ6ar5p1BDASHS/ShK7IuBxPy7B
 3vPMApVYr/3saVu9pDQvq8tsekvtTqJdPQjd0pbOOboJ6HYlgdKt3AKywyHZbu9Szl
 qTQwbBzJRU95g==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 90F131180140;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 3/6] net/nfb: support real link-up/down config
Date: Tue, 17 Feb 2026 12:03:21 +0100
Message-ID: <20260217110324.3344310-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217110324.3344310-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
 <20260217110324.3344310-1-spinler@cesnet.cz>
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
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/nfb/nfb_ethdev.c           | 42 +++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index d408551955..8a7e1010fb 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -67,6 +67,7 @@ New Features
   * Report firmware version and correct Ethernet link speed.
   * Common CESNET-NDK-based adapters have been added,
     including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
+  * Added support for configuration of the Link Up / Link Down state.
 
 
 Removed Items
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 9b173c0f89..abb108a280 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -426,6 +426,29 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
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
@@ -438,10 +461,14 @@ nfb_eth_link_update(struct rte_eth_dev *dev,
 static int
 nfb_eth_dev_set_link_up(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->process_private;
-
+	int ret;
+	struct pmd_internals *internals = dev->process_private;
 	uint16_t i;
+
+	ret = nfb_eth_dev_set_link(internals, true);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < internals->max_rxmac; ++i)
 		nc_rxmac_enable(internals->rxmac[i]);
 
@@ -463,10 +490,15 @@ nfb_eth_dev_set_link_up(struct rte_eth_dev *dev)
 static int
 nfb_eth_dev_set_link_down(struct rte_eth_dev *dev)
 {
-	struct pmd_internals *internals = (struct pmd_internals *)
-		dev->process_private;
+	int ret;
+	struct pmd_internals *internals = dev->process_private;
 
 	uint16_t i;
+
+	ret = nfb_eth_dev_set_link(internals, false);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < internals->max_rxmac; ++i)
 		nc_rxmac_disable(internals->rxmac[i]);
 
-- 
2.53.0

