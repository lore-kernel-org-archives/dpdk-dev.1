Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC259C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DED9402C0;
	Thu, 22 Jan 2026 08:27:38 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id CC7E6400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769066849;
 bh=wU1wPhM/okexBGywyhOnjhZZ+HW0wNWngS9f5XZ+kr0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OtanfmL+ZhYc8H6n3LGRppyb9GyR9lMMAt6LtuuqzqdqiRSb3SLBGIrceBpVzNjmO
 L6xeebHUh9rAVdYPX2mf9Kl2vPB8VXIzAJSiByGrXqWMz36iDs2pw68TIydC6Gh5Iv
 1NKT4paPOnp0hsiUyKi6mNHPJuhzlhHMdzKGfGDOYABl5EZuqs5IQO63ZGV6knGMcy
 yO43VUAIA3focBPoMDVs/4c8z5TTeWve2YT0FdIMsNPyOuXy+obV53kgungMFJmWY+
 oVg5RjM8SDqVIOnV6QjctGpN7JINWYVJ8hzwQVZ7q+nbXydjADSckw20oMQKKduM4a
 YefidbPqSrDyw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id A39BF118007E;
 Thu, 22 Jan 2026 08:27:29 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 6/8] net/nfb: add compatible cards to driver PCI ID table
Date: Thu, 22 Jan 2026 08:27:17 +0100
Message-ID: <20260122072719.505185-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
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

The nfb driver is compatible with:
- NFB-200G2QL card secondary PCI device
- FB2CGHH card
- COMBO-400G1 card
- Common CESNET-NDK cards

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb.h        | 5 +++++
 drivers/net/nfb/nfb_ethdev.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/nfb/nfb.h b/drivers/net/nfb/nfb.h
index cfbc50251f..0e35e00d2e 100644
--- a/drivers/net/nfb/nfb.h
+++ b/drivers/net/nfb/nfb.h
@@ -24,13 +24,18 @@ extern int nfb_logtype;
 /* PCI Vendor ID */
 #define PCI_VENDOR_ID_NETCOPE 0x1b26
 #define PCI_VENDOR_ID_SILICOM 0x1c2c
+#define PCI_VENDOR_ID_CESNET  0x18ec
 
 /* PCI Device IDs */
 #define PCI_DEVICE_ID_NFB_40G2  0xcb80
 #define PCI_DEVICE_ID_NFB_100G2 0xc2c1
 #define PCI_DEVICE_ID_NFB_200G2QL 0xc250
+#define PCI_DEVICE_ID_NFB_200G2QL_E1 0xc251
 #define PCI_DEVICE_ID_FB2CGG3   0x00d0
+#define PCI_DEVICE_ID_FB2CGHH   0x00d2
 #define PCI_DEVICE_ID_FB2CGG3D  0xc240
+#define PCI_DEVICE_ID_COMBO400G1 0xc400
+#define PCI_DEVICE_ID_CESNET_NDK_COMMON 0xc000
 
 /* Max index of ndp rx/tx queues */
 #define RTE_ETH_NDP_MAX_RX_QUEUES 32
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 59e5a51b58..e2959c3a04 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -788,8 +788,12 @@ static const struct rte_pci_id nfb_pci_id_table[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NETCOPE, PCI_DEVICE_ID_NFB_40G2) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NETCOPE, PCI_DEVICE_ID_NFB_100G2) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NETCOPE, PCI_DEVICE_ID_NFB_200G2QL) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NETCOPE, PCI_DEVICE_ID_NFB_200G2QL_E1) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_SILICOM, PCI_DEVICE_ID_FB2CGG3) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_SILICOM, PCI_DEVICE_ID_FB2CGHH) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_SILICOM, PCI_DEVICE_ID_FB2CGG3D) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_CESNET, PCI_DEVICE_ID_COMBO400G1) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_CESNET, PCI_DEVICE_ID_CESNET_NDK_COMMON) },
 	{ .vendor_id = 0, }
 };
 
-- 
2.52.0

