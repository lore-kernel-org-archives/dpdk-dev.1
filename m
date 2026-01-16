Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDAC982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 16:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC8E42E73;
	Fri, 16 Jan 2026 17:44:55 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id C56284026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 17:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768581885;
 bh=Fl4BSnwuf1bRrTlXe34lOyH5GpwmzsuCkdlRfRaKpvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Itbwre8npq1EbqJOQMRdgSHHJnxKc2t45im6FRYnIfx2bX1yC1VFypAeL2CorwvXL
 mOfCp7U7F05lSKyuZjMucjtVYqotK0uTgPMKRZL4oi0D+C9Y9b7WdxPPrSwJrmY3JU
 NWINMuKuWQUWX+MEvtF0MFGwl0nVaoFDyA9+yop2xeSoIZU0LPlYnH+fNqSQUJgs38
 cXMinaLC3IvkHfLWtR619Ja3y+2HJ0e7O4rsKXiKLrRVnO0Eyvx9o87+nlWnYhPUcZ
 ZomhCziJ8+BPsSFWa7iIgkZCLfhT4t53ps9/YginifPKQoRL0AOhjg2fwMm2UagoDw
 gwf3HgQA0uOCA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 9818F1180080;
 Fri, 16 Jan 2026 17:44:45 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 7/8] net/nfb: report firmware version
Date: Fri, 16 Jan 2026 17:44:35 +0100
Message-ID: <20260116164436.1649047-8-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116164436.1649047-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260116164436.1649047-1-spinler@cesnet.cz>
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

The firmware is described by project name and project version.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_ethdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index c31c5cc7e4..8a152fe7ad 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -498,6 +498,31 @@ nfb_eth_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		nc_rxmac_set_mac(internals->rxmac[i], index, 0, 0);
 }
 
+static int
+nfb_eth_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
+		size_t fw_size)
+{
+	int ret;
+	const char *proj_name, *proj_vers;
+	struct pmd_internals *priv = (struct pmd_internals *)
+			dev->process_private;
+
+	proj_name = nc_info_get_fw_project_name(priv->nfb, NULL);
+	proj_vers = nc_info_get_fw_project_version(priv->nfb, NULL);
+
+	if (proj_name == NULL)
+		proj_name = "";
+	if (proj_vers == NULL)
+		proj_vers = "";
+
+	ret = snprintf(fw_version, fw_size, "%s;%s", proj_name, proj_vers);
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
@@ -524,6 +549,7 @@ static const struct eth_dev_ops ops = {
 	.mac_addr_set = nfb_eth_mac_addr_set,
 	.mac_addr_add = nfb_eth_mac_addr_add,
 	.mac_addr_remove = nfb_eth_mac_addr_remove,
+	.fw_version_get = nfb_eth_fw_version_get,
 };
 
 /**
-- 
2.52.0

