Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4756C87FCF
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 Aug 2025 04:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D9B64025D;
	Sun, 10 Aug 2025 06:46:17 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 696AB400D5
 for <dev@dpdk.org>; Sun, 10 Aug 2025 06:46:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.64.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8001DE0B08;
 Sun, 10 Aug 2025 08:46:13 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8001DE0B08
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754801174;
 bh=GPPyzsC1VFg/Qc6jW57AiUde/+2BtGzK5cs6W+VOTDE=;
 h=From:To:Cc:Subject:Date:From;
 b=XgwsjkenbPpwKDMsOpfd40XoK7tBt21pxlc/sRwafc0XHQqQHApbYGMI8RSaEfryD
 Rhyi1L9WCVjkL37FWy7NMfCQHY8GRnYOnh7NMA4f7XnXK59zvI8EFXojbZ/bC12ADp
 MdJgXzOtK8/iMD4ri2dOf5bmDdx+iYgCAdXULnFzrXpkOtlFX3GbLZNks5Ng/CyGy7
 PVrwmLizjJocGbuIaPt1S/0QLT/7+kBTGcZV+yjv7dmbeHlfdoqyI+Ji2V9a8o9MPd
 ePj1kN+/3rgpJ/6SHFB0MJIhtio9nkLDl1m/IpUbzxoucnTgFTAsZCsaKCoPu2L+OS
 LDWKnhvFwqsjg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 1/1] common/sfc_efx/base: enable parallel detect via netport
 MCDI
Date: Sun, 10 Aug 2025 08:46:05 +0400
Message-Id: <20250810044605.7911-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
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

When autoneg is enabled, also enable parallel detect, to try
to discover link tech/FEC settings that result in link up.

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 222d81c12e..af685e2cdf 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1349,6 +1349,7 @@ efx_np_link_ctrl(
 			    NULL, NULL, cap_mask_hw_pausep);
 		}
 
+		flags |= 1U << MC_CMD_LINK_FLAGS_PARALLEL_DETECT_EN;
 		flags |= 1U << MC_CMD_LINK_FLAGS_AUTONEG_EN;
 		link_tech = MC_CMD_ETH_TECH_AUTO;
 	} else {
-- 
2.17.1

