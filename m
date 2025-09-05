Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17916CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 14:45:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA6AC40668;
	Fri,  5 Sep 2025 16:45:29 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 89422402DB;
 Fri,  5 Sep 2025 16:45:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.74.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DAD62E0F51;
 Fri,  5 Sep 2025 18:45:24 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DAD62E0F51
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1757083525;
 bh=n4LFiZbhx+FsSs3a7iouvmbg46iBcvDGvFhfAmv3ajE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FbBMeAXfAhEDDZGkCplX1MpOEJlzvAU7QRdPpXyLlEh5jckRACF/0uIX/41AmK00n
 eNxz//9YgnIgXzHoR0DDwJn2OGyPGz4etSJiGJQzTTxY8Zq9zB6cpRHjRSi5NHMyNA
 AEQFQALwJKeD+673Wd8tHk8Qy1T4k8RaURLiPTkmQ21mo1QHXk6R96HAbePftsNtT5
 YgKTtRCOckd6UvSd/iIB2OHPj538TRz2nKRArw8uTwhS6wxwcIffopv4uO8+25n5ZU
 ROoHsuX32ZP3+lzeSJLTOcQUccBbajiwJNilvg3Ya5nRKs5GOD77Tkt4m26szrPHYp
 FJBaGpOtdN9AA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 3/4] common/sfc_efx/base: fix auto FEC selection for netport
 MCDI
Date: Fri,  5 Sep 2025 18:45:13 +0400
Message-ID: <20250905144514.11698-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905144514.11698-1-ivan.malov@arknetworks.am>
References: <20250905144514.11698-1-ivan.malov@arknetworks.am>
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

Currently, the driver's request to have automatic FEC is ignored. Fix that.

Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 69a5a75b6c..54305ee61e 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1368,8 +1368,10 @@ efx_np_link_ctrl(
 		}
 	}
 
-	/* The software mask may have no requested FEC bits. Default is NONE. */
-	cap_enum_hw = MC_CMD_FEC_NONE;
+	if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) == 0)
+		cap_enum_hw = MC_CMD_FEC_NONE;
+	else
+		cap_enum_hw = MC_CMD_FEC_AUTO;
 
 	/*
 	 * Compared to older EF10 interface, in netport MCDI, FEC mode is a
-- 
2.47.2

