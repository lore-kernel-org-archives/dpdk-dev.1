Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27FC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AA3740E5E;
	Wed, 16 Apr 2025 16:00:34 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4BBBC40E26
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8EDF1E11C0;
 Wed, 16 Apr 2025 18:00:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8EDF1E11C0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812031;
 bh=u6nwCUk1oUiqspolugzoHK84n9494sdeMPiOK85yHj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KccvK6sRKfHc9jwDTI0R/kd84x1IN1Uuon7n0NBQcngq/NoMvamreXxRxb5JoBudY
 GcvYdxbwqse+sJdEmA6Ag7hnQOrC9rfwDRrq0gZWnXYCE7akTsUsEeacLoy/qzULaK
 5plblmDw1y0YKyqrcRnu6m3YovEKBguF2+i4/MFRRtlBI4OruMoEQoJeGffIp+yAXq
 poHLgmjjVll5Pb6N4mKmKR+SIXC/3maFGIju9JZEn8STRyM7ZFXxmnNJVryhkkiE4L
 pcR3CqRgvM6CTKZengKfoacMjsiWBjkHrcVMOKRt/zILICfWY12su4k4C+E9Aza5yt
 ZS5nWdVM351RQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 06/46] common/sfc_efx/base: add Medford4 support to INTR module
Date: Wed, 16 Apr 2025 17:59:36 +0400
Message-Id: <20250416140016.36127-7-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_intr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_intr.c b/drivers/common/sfc_efx/base/efx_intr.c
index 792302f540..8fdef839db 100644
--- a/drivers/common/sfc_efx/base/efx_intr.c
+++ b/drivers/common/sfc_efx/base/efx_intr.c
@@ -158,6 +158,12 @@ efx_intr_init(
 		break;
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+	case EFX_FAMILY_MEDFORD4:
+		eiop = &__efx_intr_ef10_ops;
+		break;
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 	default:
 		EFSYS_ASSERT(B_FALSE);
 		rc = ENOTSUP;
-- 
2.39.5

