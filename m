Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE79EE20B6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5ECF4065B;
	Fri,  6 Feb 2026 18:04:44 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 879F040431
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=AHjsR6GYioKIH0KMD3W8KFEbA2ZL6aa16zg8V1/aBKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gQsuoew3SUjRXI0ZD7qTxUGKPpmCLj0spxR7imEhg2Up2ij3KnRs3ub1onghZBl9C
 BJak2065TvyCmMHpHBQ9pLJW82zuJHAej3vjqX2EsL684aMnVEPJVClMSxZCLx76FW
 oc994ihAGwjdRklZDXJjdHtkU5STlWVL4Zhsgo4Lq/OPJm9P4+tBzOUV+TdJ7rA7dZ
 NZObD+0SE/hv+no9wiV7s1Xvv2T+CjkTsVEXgiUs9rVj/A0v7kttRFqeGDh3A+Oiq2
 ApooyTUN8Pk0ppnP3ovyDWpbE8bYNTgpK2+Jq7xMLxkDhQtNa2SdR1pp+0A353ALsG
 jQjkcH2qujU6Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 5EF051180072;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 4/7] net/nfb: support setting RS-FEC mode
Date: Fri,  6 Feb 2026 18:04:32 +0100
Message-ID: <20260206170435.302184-5-spinler@cesnet.cz>
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

Enable basic configuration of the RS-FEC link mode over MDIO.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 950754f4cf..b927d006e7 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -575,6 +575,66 @@ nfb_eth_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
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
+	nfb_mdio_if_write_pma(if_info, NFB_MDIO_PMA_RSFEC_CR, reg);
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
@@ -602,6 +662,8 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
 	.fw_version_get = nfb_eth_fw_version_get,
+	.fec_get = nfb_eth_fec_get,
+	.fec_set = nfb_eth_fec_set,
 };
 
 /**
-- 
2.53.0

