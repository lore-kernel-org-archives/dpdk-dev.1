Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4AD77881
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 17:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF62440691;
	Fri, 23 Jan 2026 18:22:55 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 652AA4021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 18:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769188966;
 bh=l5cm/3v9qXD4X1/ePqzkUp/LusrH7mNE1/H4OgJGVB8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VEvQAu2f2g5L1d3hXaf3Qplp4xeKibTwHphaE9y3/g5GB3TtNZlUUe9CUwNDCm7n7
 RAaTJG0Lv+PPFUVSn2VjvhuSSXxQYvMlInNgiwZ78cNnNrFNbt69V1eq3tChsD0P3O
 LBkaMixMgoBzYt5hZ3MRWY80PySjJNpmkEmI2UjXPJyGn/nBw6BJIhLGDfgqDzK/Fl
 pqEQoC0JclYAy0cfoGJQvcWr6k/XBCsF4QunTRkt4Mo9syIRI31Jg/bDwBHKcfLhTN
 rDc3pHRdIoEIsCyrdABVMul3W/MGoRjHbg4sGe3lhfvNObRQ566aeoHTYmLx6sF0fo
 QFtJWUvfTV5IA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 3BDFE1180072;
 Fri, 23 Jan 2026 18:22:46 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v5 7/8] net/nfb: report firmware version
Date: Fri, 23 Jan 2026 18:22:23 +0100
Message-ID: <20260123172224.1567362-8-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123172224.1567362-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260123172224.1567362-1-spinler@cesnet.cz>
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
index 4da00915dd..9eabe18fd0 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -487,6 +487,32 @@ nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
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
@@ -513,6 +539,7 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_set = nfb_eth_mac_addr_set,
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
+	.fw_version_get = nfb_eth_fw_version_get,
 };
 
 /**
-- 
2.52.0

