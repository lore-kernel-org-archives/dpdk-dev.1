Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EDE6816F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E721340657;
	Tue, 17 Feb 2026 12:03:31 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id D4507400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=zTd3N85+elaHULWTDZJ6uuEfNAI87oEorv4m0UDqS2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aQi/29obh9Imz2HDfoLGM2NZlGfktHnpR9wWxJdA/JgPozrcRzwRVLMg/ogABE9OH
 gPbbUZ8rz42Wmkn3TIFlMF2esZ2s88E72jkTzVivOWml7AEXHlRhHyjJBNw20QN4hI
 qk7SipRDHWvYddk0F+vnLpKWEjzQ455NxvVlvOfqNTC3bjXcY6ygJaZNAC4UesHy18
 oJ94mIadblPgBNqsI0E+v878jG9Oc3XacFKGaszP0UBX8iNgwTW2/2TnkQfaWrV7kS
 4Y0WsQMj2j4osWKEqm+zSu0zkluV1lwGCp2KL5sB+9TZIZXF47E3jT0rWJ9sLqKOJg
 pI6heYa3AtiEw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id AB3201180141;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 4/6] net/nfb: support setting RS-FEC mode
Date: Tue, 17 Feb 2026 12:03:22 +0100
Message-ID: <20260217110324.3344310-5-spinler@cesnet.cz>
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

Enable basic configuration of the RS-FEC link mode over MDIO.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/rel_notes/release_26_03.rst |  2 +-
 drivers/net/nfb/nfb_ethdev.c           | 65 ++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 8a7e1010fb..ac76ac5b67 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -67,7 +67,7 @@ New Features
   * Report firmware version and correct Ethernet link speed.
   * Common CESNET-NDK-based adapters have been added,
     including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
-  * Added support for configuration of the Link Up / Link Down state.
+  * Added support for configuration of the RS-FEC mode, Link Up / Link Down state.
 
 
 Removed Items
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index abb108a280..a556ceca67 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -601,6 +601,69 @@ nfb_eth_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 	return 0;
 }
 
+static int
+nfb_eth_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
+{
+	int reg;
+	struct pmd_internals *intl = dev->process_private;
+	struct mdio_if_info *if_info;
+
+	*fec_capa = 0;
+	if (!intl->max_eth)
+		return 0;
+
+	if_info = &intl->eth_node[0].if_info;
+
+	reg = nfb_mdio_if_read_pma(if_info, NFB_MDIO_PMA_RSFEC_CR);
+	if (reg < 0)
+		return -EIO;
+
+	*fec_capa = (reg & NFB_MDIO_PMA_RSFEC_CR_ENABLE) ?
+			RTE_ETH_FEC_MODE_CAPA_MASK(RS) :
+			RTE_ETH_FEC_MODE_CAPA_MASK(NOFEC);
+
+	return 0;
+}
+
+static int
+nfb_eth_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa)
+{
+	int ret;
+	uint32_t fec_capa2 = 0;
+	int reg;
+
+	struct pmd_internals *intl = dev->process_private;
+	struct mdio_if_info *if_info;
+
+	if (!intl->max_eth)
+		return 0;
+
+	if_info = &intl->eth_node[0].if_info;
+
+	if (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(AUTO))
+		return -EINVAL;
+
+	reg = nfb_mdio_if_read_pma(if_info, NFB_MDIO_PMA_RSFEC_CR);
+	if (reg < 0)
+		return -EIO;
+
+	reg = (fec_capa & RTE_ETH_FEC_MODE_CAPA_MASK(RS)) ?
+			(reg | NFB_MDIO_PMA_RSFEC_CR_ENABLE) :
+			(reg & ~NFB_MDIO_PMA_RSFEC_CR_ENABLE);
+	ret = nfb_mdio_if_write_pma(if_info, NFB_MDIO_PMA_RSFEC_CR, reg);
+	if (ret < 0)
+		return -EIO;
+
+	ret = nfb_eth_fec_get(dev, &fec_capa2);
+	if (ret)
+		return ret;
+
+	if (fec_capa != fec_capa2)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = nfb_eth_dev_start,
 	.dev_stop = nfb_eth_dev_stop,
@@ -628,6 +691,8 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
 	.fw_version_get = nfb_eth_fw_version_get,
+	.fec_get = nfb_eth_fec_get,
+	.fec_set = nfb_eth_fec_set,
 };
 
 /**
-- 
2.53.0

