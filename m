Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A472BC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:00:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E1B40430;
	Wed, 23 Apr 2025 18:00:16 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8F230400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C668FE0142;
 Wed, 23 Apr 2025 20:00:11 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C668FE0142
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424012;
 bh=2o0OGhqUlSYiSDFeiC6Du2wnhNfqW2Gkznvu0fb+qyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2KP2xP/8wUij19DlUk6de6axdyhwoybl94svbF2NHc5qX4/tzYONW6doyYk5L0AUg
 e+kQxFyJdpAjcL4a4SE2twd321klVJPlSEEn6ZqP1JgwG7sGFEJRPEMq6HKPqd/wAz
 gg3gS/tnArOjNClPVdiqz3cMqEQbPu1brMtg3Izvs+FxBiO3wysHBtMowL6+d+qvrc
 vb9nUwfZJY2it7aNQGWCxJkL46mMdb1Rc1pQodM2xn8y72cQC/Vb4epBcQi04iCck3
 g2KSmG6x+vtw0VYe0Bw/S32Vd6RU7D4SzjUX6vifdxNNQSx8WzDwogEqlB1UQLJHFh
 zpneHR9XfQYuw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Subject: [PATCH v2 01/45] common/sfc_efx/base: add Medford4 PCI IDs to common
 code
Date: Wed, 23 Apr 2025 19:59:18 +0400
Message-Id: <20250423160002.35706-2-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Later patches will use this to implement support for Medford4.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Signed-off-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 5773cb00b3..635b44ab37 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -64,6 +64,7 @@ typedef enum efx_family_e {
 	EFX_FAMILY_MEDFORD,
 	EFX_FAMILY_MEDFORD2,
 	EFX_FAMILY_RIVERHEAD,
+	EFX_FAMILY_MEDFORD4,
 	EFX_FAMILY_NTYPES
 } efx_family_t;
 
@@ -172,6 +173,16 @@ efx_family_probe_bar(
 #define	EFX_PCI_DEVID_RIVERHEAD			0x0100
 #define	EFX_PCI_DEVID_RIVERHEAD_VF		0x1100
 
+/*
+ * Medford4 has low latency (LL) and full feature (FF) datapath engines.
+ * Some Medford4 functions have FF and LL datapath, others only have FF.
+ */
+#define	EFX_PCI_DEVID_MEDFORD4_PF_UNINIT	0x0C13
+#define	EFX_PCI_DEVID_MEDFORD4			0x0C03	/* X4 PF, FF+LL */
+#define	EFX_PCI_DEVID_MEDFORD4_VF		0x1C03	/* X4 VF, FF+LL */
+#define	EFX_PCI_DEVID_MEDFORD4_NO_LL		0x2C03	/* X4 PF, FF only */
+#define	EFX_PCI_DEVID_MEDFORD4_NO_LL_VF		0x3C03	/* X4 VF, FF only */
+
 #define	EFX_MEM_BAR_SIENA			2
 
 #define	EFX_MEM_BAR_HUNTINGTON_PF		2
-- 
2.39.5

