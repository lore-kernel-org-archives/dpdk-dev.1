Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D843EF99C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 131F04064F;
	Fri, 13 Feb 2026 19:53:39 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id A1CC7402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771008811;
 bh=/3pO92aCH8mhW7o7hxNOuu/DDMy0OQuhZKehBL/2TtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AqRV4MqvXWpKPhD4Gk0hD7iEAy8XRRgyiDdTgurJcnArFJG9RNVggiGoK+sa0+JXV
 tOEr+2idae4OVpmNaDrpu7HNFO2L1GwmNwqgoKI4rRXnWeF6YDKezYEfpXH4tdIdiC
 Z4DXt1G4T7K74aYlIj6Cr6S1axp9WcRSpaS37ie4Rz1cWVLUYlNJSbEkUDOjCIAZJ9
 N3Uu3op2viIKaOw4Vn+XhX1RVMoi93/sCsuiiCugab9Ku6OtKrOD/PA8ArHtklYfEn
 xEPTpkUeqYD2ErTmx9QGSkp7su31PR+sYXrQLT7dxa0BvYafqOwWo4cgChIwG+z9sd
 2Hx1BY7WfVORg==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 7A82A1180082;
 Fri, 13 Feb 2026 19:53:31 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v8 6/8] net/nfb: add compatible cards to driver PCI ID table
Date: Fri, 13 Feb 2026 19:53:15 +0100
Message-ID: <20260213185317.1893353-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213185317.1893353-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260213185317.1893353-1-spinler@cesnet.cz>
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
index b064b45c47..72580e4fcb 100644
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
index 826a2504c7..1b481c0312 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -841,8 +841,12 @@ static const struct rte_pci_id nfb_pci_id_table[] = {
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
2.53.0

