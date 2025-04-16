Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468DC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CD1A40E34;
	Wed, 16 Apr 2025 16:00:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 02844402BB
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 371BCE1149;
 Wed, 16 Apr 2025 18:00:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 371BCE1149
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812026;
 bh=nWV5LpVTuKPzhjAixapvzO9KOb4Ud1Rehz6g5uEQUdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JLJ70ZZYXQamhJjqTqfZdcdzc3Vs/uyQp0wI29nFuAwolnAI1ZKrRxgz0wjsfnszP
 rT7nYWIsZUJVZ1yaIySDX3x6j8ZmMws35ecLsX1a/Pl6j1J5rYeaQ9npjjjPyMChhi
 6w43PwmL57Nt+oXf4HHRXKzj2WW1POhqRPnVCM1rGPWtKmJVl7ZND08e1jlhGGzoP7
 J64+77qShoAy8VlOxXslvbOD8AILH1V/hwg3O5HWNH92G7E1xIBDRspqoVsXQwKNJD
 R9HoHkYXFoVkxG12Isnp9FnHqi24rufHnibFUmRX1r0XKdE7bqbxlT0lqfuOC1/Xq6
 aR2dR40NM1mnQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 01/46] common/sfc_efx/base: add Medford4 PCI IDs to common code
Date: Wed, 16 Apr 2025 17:59:31 +0400
Message-Id: <20250416140016.36127-2-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Later patches will use this to implement support for Medford4.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 5773cb00b3..dabf2e0e0b 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -64,6 +64,7 @@ typedef enum efx_family_e {
 	EFX_FAMILY_MEDFORD,
 	EFX_FAMILY_MEDFORD2,
 	EFX_FAMILY_RIVERHEAD,
+	EFX_FAMILY_MEDFORD4,
 	EFX_FAMILY_NTYPES
 } efx_family_t;
 
@@ -172,6 +173,10 @@ efx_family_probe_bar(
 #define	EFX_PCI_DEVID_RIVERHEAD			0x0100
 #define	EFX_PCI_DEVID_RIVERHEAD_VF		0x1100
 
+#define	EFX_PCI_DEVID_MEDFORD4_PF_UNINIT	0x0C13
+#define	EFX_PCI_DEVID_MEDFORD4			0x0C03
+#define	EFX_PCI_DEVID_MEDFORD4_VF		0x1C03
+
 #define	EFX_MEM_BAR_SIENA			2
 
 #define	EFX_MEM_BAR_HUNTINGTON_PF		2
-- 
2.39.5

