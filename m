Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78E2C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CDE9410DF;
	Wed, 16 Apr 2025 16:00:44 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id A758A40ED9
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id F3A81E11BF;
 Wed, 16 Apr 2025 18:00:36 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am F3A81E11BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812037;
 bh=9GqSQS6fYlxYjLWCwtIMMzwvqHrP90iCjpoISbzH3AA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U9lk34d35ovICuwvgPwzso6dZW3d/RkRTQ5ePnDq4PWvZcR4s+cF1nAozPFT5XvBi
 2391B7EGjad45dcKqR14YdBLsYIg06INjJ0EDHGH5tVqWSqCgaCCFvqx7bhvg2aV8l
 /WL1MXb/dfBRH+RMRc3Uf/T0iak90owm7qBTC7ihg25wJF8CfrcWOVK9g2Vo0UeUHP
 NVxd46CLiGmBVxfYiQeyLdTeMjEyeGbIpb6iBRom/KGTosMDHoxMz0z9uMqIwy10Lr
 l1Wgrl+/sKoG6hlGCZUQ+kWwgTHEWl+cvwIPmi4zaeq21XWQV4I0eYoLO8y/0tlGVw
 QKjev0Vhhvaaw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 14/46] common/sfc_efx/base: update X4 BAR layout and PCI IDs
Date: Wed, 16 Apr 2025 17:59:44 +0400
Message-Id: <20250416140016.36127-15-ivan.malov@arknetworks.am>
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

The BAR layout on X4 has changed to put MSI-X (and CXL) in BAR0/1,
and moved the main memory BAR to be BAR2/3. Update definitions to
match the updated hardware and cmodel.

Also add PCI IDs used for functions which only have the full feature
(X2 style) datapath engines, and do not support the low latency
datapath engine.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx.h     | 12 +++++++++---
 drivers/common/sfc_efx/base/efx_nic.c |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 442dfa0830..a9ed3f423f 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -173,9 +173,15 @@ efx_family_probe_bar(
 #define	EFX_PCI_DEVID_RIVERHEAD			0x0100
 #define	EFX_PCI_DEVID_RIVERHEAD_VF		0x1100
 
+/*
+ * Medford4 has low latency (LL) and full feature (FF) datapath engines.
+ * Some Medford4 functions have FF and LL datapath, others only have FF.
+ */
 #define	EFX_PCI_DEVID_MEDFORD4_PF_UNINIT	0x0C13
-#define	EFX_PCI_DEVID_MEDFORD4			0x0C03
-#define	EFX_PCI_DEVID_MEDFORD4_VF		0x1C03
+#define	EFX_PCI_DEVID_MEDFORD4			0x0C03	/* X4 PF, FF+LL */
+#define	EFX_PCI_DEVID_MEDFORD4_VF		0x1C03	/* X4 VF, FF+LL */
+#define	EFX_PCI_DEVID_MEDFORD4_NO_LL		0x2C03	/* X4 PF, FF only */
+#define	EFX_PCI_DEVID_MEDFORD4_NO_LL_VF		0x3C03	/* X4 VF, FF only */
 
 #define	EFX_MEM_BAR_SIENA			2
 
@@ -190,7 +196,7 @@ efx_family_probe_bar(
 /* FIXME Fix it when memory bar is fixed in FPGA image. It must be 0. */
 #define	EFX_MEM_BAR_RIVERHEAD			2
 
-#define	EFX_MEM_BAR_MEDFORD4			0
+#define	EFX_MEM_BAR_MEDFORD4			2
 
 /* Error codes */
 
diff --git a/drivers/common/sfc_efx/base/efx_nic.c b/drivers/common/sfc_efx/base/efx_nic.c
index 5bcc0a04ff..1ec684da40 100644
--- a/drivers/common/sfc_efx/base/efx_nic.c
+++ b/drivers/common/sfc_efx/base/efx_nic.c
@@ -87,6 +87,8 @@ efx_family(
 			 */
 		case EFX_PCI_DEVID_MEDFORD4:
 		case EFX_PCI_DEVID_MEDFORD4_VF:
+		case EFX_PCI_DEVID_MEDFORD4_NO_LL:
+		case EFX_PCI_DEVID_MEDFORD4_NO_LL_VF:
 			*efp = EFX_FAMILY_MEDFORD4;
 			*membarp = EFX_MEM_BAR_MEDFORD4;
 			return (0);
-- 
2.39.5

