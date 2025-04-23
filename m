Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2121EC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA73C409FA;
	Wed, 23 Apr 2025 18:00:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5AA1B40670
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:23 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id ADF81E0159;
 Wed, 23 Apr 2025 20:00:22 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am ADF81E0159
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424023;
 bh=9vZZiUFCjcN9i3O1DEU0TsJRxz0oL36iVQmHPv3/vNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LuH26acH4qvXVLd+V4TWdKjkYdT4edsXTUpb00ros+9h8sry+Rt6TCn3xpfhCfXNf
 uMmtN31dEul0pcFSQDXQvBTOtu8OSLQnBo4OnQMd06FjkATexgy8mBh67rSnSpqpMA
 bdsMIwgspJ8BdxiMqPn/GTQg6if7D3UC9Wm1Y9Sv2wLZRnGZrQmN+oRx9OW60RE1JP
 h2ig+09nSBQ/YauE8WB7WNhp1lY5lDL1Ys4dUWG2P7TcyUi19eAfLAVtCg9nJW2C58
 QmuSGdKOBEYWrpHFcYmoJkBXr5nMrisH2RGJE9qtv+BmQavTBiKrP5dmsna+Gy59M5
 LafTMo3Pv28jw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 14/45] net/sfc: add Medford4 with only full feature
 datapath engine
Date: Wed, 23 Apr 2025 19:59:31 +0400
Message-Id: <20250423160002.35706-15-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Add PCI IDs for Medford4 functions that only have the full feature
datapath engine (no support for low latency datapath engine).

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/net/sfc/sfc_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 3e57c902df..05194918f9 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3304,6 +3304,8 @@ static const struct rte_pci_id pci_id_sfc_efx_map[] = {
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD2_VF) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4_VF) },
+	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4_NO_LL) },
+	{ RTE_PCI_DEVICE(EFX_PCI_VENID_SFC, EFX_PCI_DEVID_MEDFORD4_NO_LL_VF) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_XILINX, EFX_PCI_DEVID_RIVERHEAD) },
 	{ RTE_PCI_DEVICE(EFX_PCI_VENID_XILINX, EFX_PCI_DEVID_RIVERHEAD_VF) },
 	{ .vendor_id = 0 /* sentinel */ }
-- 
2.39.5

