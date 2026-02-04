Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA2E95394
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 12:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2837940695;
	Wed,  4 Feb 2026 13:32:11 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 341DF402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 13:32:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770208323;
 bh=8ym1Na1JV1mlRFiwaWCbP/sLmgaqcymLZfS4qkuqk2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gswLvKMxN3AzNuhgvcUtGDUtLWUA0HgrbobQ+9OMDXF6+2tE5H6pn4yPgpnctCIEp
 k/vqul1vmAcCmTkFPevNVioqh+e6boVm/DdoZTx7xL7x5gJqFLtlDDttOhEx62xshu
 6yV7UzvC3Bl50PqDBJ3OzvRVLPp+hoLslVdgygVW1RVBRdzSLomm/7X6spsj4I9ZAG
 g0HZfTTmoZEEG1s2uytmrA9fqrYSTRa66F+7Zz6MpiIECr0RqS7K73mDg4MLznr/Zq
 +qApz06AXlR0OOc0aXNOnyC8VS4DTTRUjwBtwI2C2PlBuROCuxLWkHin1zndDrElfZ
 J3ElskV40JS2g==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 0BD611180072;
 Wed,  4 Feb 2026 13:32:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v7 7/8] net/nfb: report firmware version
Date: Wed,  4 Feb 2026 13:31:36 +0100
Message-ID: <20260204123137.123171-8-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204123137.123171-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
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

Report the firmware version, which is described
by project name and project version.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 56bbe75a28..157f04a891 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -488,6 +488,32 @@ nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		nc_rxmac_set_mac(internals->rxmac[i], index, 0, 0);
 }
 
+static int
+nfb_eth_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
+		size_t fw_size)
+{
+	int ret;
+	const char *proj_name, *proj_vers;
+	struct pmd_internals *intl = dev->process_private;
+
+	proj_name = nc_info_get_fw_project_name(intl->nfb, NULL);
+	proj_vers = nc_info_get_fw_project_version(intl->nfb, NULL);
+
+	if (proj_name == NULL)
+		proj_name = "";
+	if (proj_vers == NULL)
+		proj_vers = "";
+
+	ret = snprintf(fw_version, fw_size, "%s;%s", proj_name, proj_vers);
+	if (ret < 0)
+		return ret;
+
+	if (ret >= (signed int)fw_size)
+		return strlen(proj_name) + 1 + strlen(proj_vers) + 1;
+
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = nfb_eth_dev_start,
 	.dev_stop = nfb_eth_dev_stop,
@@ -514,6 +540,7 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_set = nfb_eth_mac_addr_set,
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
+	.fw_version_get = nfb_eth_fw_version_get,
 };
 
 /**
-- 
2.53.0

