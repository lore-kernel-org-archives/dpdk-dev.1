Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C8C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27E25410E7;
	Wed, 16 Apr 2025 16:00:45 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6ED1C40EDF
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BADAAE0872;
 Wed, 16 Apr 2025 18:00:37 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BADAAE0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812038;
 bh=9vZZiUFCjcN9i3O1DEU0TsJRxz0oL36iVQmHPv3/vNs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WsSDiDlsJJ9NIb9eosEsQTKV9supTlYVM+ufTolCwZCAFGx+fLZTm0smQvLlC5P3K
 Xk5gFkHNa8zOIGFHmjroXztaMT/4hWBpZQpDKfrIlVNnc4fG2Iysf/Q9pitXhLiJa+
 exxsZKYen8BFbOsEhsVp/pl2aB5PobTPoMzGnnYgr6BXzaNDiB7pgNN5bj3wR/Pv+9
 EH/cZUrgWAxAv02K8l7AJ5VXqJOK+R4/nR/U4K85x0kC0Ois5A4mr+xbU8eK9Mz2tT
 cwr8AV/2T3OEtZz8XXD9o+6o0zqnahx8qV78wQvUeDImHBHg1CHS//2wmEkOIKEaOv
 Kl9smSVzVZaWw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 15/46] net/sfc: add Medford4 with only full feature datapath
 engine
Date: Wed, 16 Apr 2025 17:59:45 +0400
Message-Id: <20250416140016.36127-16-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

