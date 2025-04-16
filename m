Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E6C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 548C640ED6;
	Wed, 16 Apr 2025 16:00:37 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C3A2D40E49
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1D88AE11AD;
 Wed, 16 Apr 2025 18:00:32 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1D88AE11AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812032;
 bh=aCvxDPkYdARJQCJGO72SfGeYsGcb2fczfZI6xJyXUk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1Q4dePzo5MOspTwP3iDUPupcxuTFrxHkH6qOpD7XMDqAFfXRmwO/+A9ExM9CNCljd
 05A56rOwQVuw0plgBIXfWmefCt53F64RwaIZi7OxiBmOE6wQEF71wvKAE0KICI1fAb
 WUjvi3DLrmaykiiZaoL5Xsey4Uu4EY9UAZIrxsPjUptDnZVcM6zjCFBoE3TYYMFZnd
 gXVAzHPaf4OJApYqef8XGSThmKbnzRXqwDbKm499ITRachp4nBDX/8A6aGAXqY5SHi
 TLOfgmGRoB458xsiArcpg0ekmMUUEBGIeyrQI9u/t3koYMO+1K6Aq9/febxgr1lBJ/
 mp3rsyH+24JWA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 08/46] common/sfc_efx/base: add Medford4 support to PHY module
Date: Wed, 16 Apr 2025 17:59:38 +0400
Message-Id: <20250416140016.36127-9-ivan.malov@arknetworks.am>
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

Use common EF10 method table for that.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_phy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index d55becae18..3d792f20b8 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -114,6 +114,12 @@ efx_phy_probe(
 		break;
 #endif	/* EFSYS_OPT_MEDFORD2 */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		epop = &__efx_phy_ef10_ops;
+	break;
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		rc = ENOTSUP;
 		goto fail1;
-- 
2.39.5

