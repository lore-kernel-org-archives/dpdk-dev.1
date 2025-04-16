Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275DC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA5D40E3B;
	Wed, 16 Apr 2025 16:00:29 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 12DD340E22
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id F2787E11AD;
 Wed, 16 Apr 2025 18:00:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am F2787E11AD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812027;
 bh=n0csAkkJsqbZbzgbCKGlbNTYJwGSHIaX1TQKx7i+wMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mQorLfeShTGm2xceF5fDvS7ajtsZbpsmVDvivg8lsKAmK3hIzJUbnhSqntTYnLyT2
 yrkxUZMa6bHJS1/cu93dvAIQ0ECqdvd9H+M1KYbwldtF6maznhDz74ewRyOk7kuU/N
 e1dPi9FWlMwmRuaF5X7+SXjTf8eOs/BjgoJRVzSNquJyyHkahMbVYKxfdNuM4d3etW
 JVKAQhUuAd5nVkcKWos+xUjTN8jkcCUQ5x6ci/mkLpOdh+EbTiqmrFTW/CrH0KTHzS
 EBjUHjuarYg4+3D+32vkFARi6NYm/8Vq16Q+gB5pclVtAKsD00eOkN+bs2A8zess/E
 +M86nq0StCMqQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 02/46] common/sfc_efx/base: add efsys option for Medford4
Date: Wed, 16 Apr 2025 17:59:32 +0400
Message-Id: <20250416140016.36127-3-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_check.h | 24 ++++++++++++++----------
 drivers/common/sfc_efx/efsys.h          |  2 ++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_check.h b/drivers/common/sfc_efx/base/efx_check.h
index 66b38eeae0..0b9f4fb516 100644
--- a/drivers/common/sfc_efx/base/efx_check.h
+++ b/drivers/common/sfc_efx/base/efx_check.h
@@ -32,7 +32,8 @@
 
 /* Check family options for EF10 architecture controllers. */
 #define	EFX_OPTS_EF10()	\
-	(EFSYS_OPT_HUNTINGTON || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
+	(EFSYS_OPT_HUNTINGTON || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || \
+	EFSYS_OPT_MEDFORD4)
 
 #ifdef EFSYS_OPT_FALCON
 # error "FALCON is obsolete and is not supported."
@@ -197,7 +198,7 @@
 
 #if EFSYS_OPT_IMAGE_LAYOUT
 /* Support signed image layout handling */
-# if !(EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
+# if !(EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4)
 #  error "IMAGE_LAYOUT requires MEDFORD or MEDFORD2"
 # endif
 #endif /* EFSYS_OPT_IMAGE_LAYOUT */
@@ -338,8 +339,10 @@
 
 #if EFSYS_OPT_ALLOW_UNCONFIGURED_NIC
 /* Support adapters with missing static config (for factory use only) */
-# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
-#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2"
+# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || \
+	EFSYS_OPT_MEDFORD4)
+#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2 " \
+	"or MEDFORD4"
 # endif
 #endif /* EFSYS_OPT_ALLOW_UNCONFIGURED_NIC */
 
@@ -352,22 +355,23 @@
 
 #if EFSYS_OPT_RX_ES_SUPER_BUFFER
 /* Support equal stride super-buffer mode */
-# if !(EFSYS_OPT_MEDFORD2)
-#  error "ES_SUPER_BUFFER requires MEDFORD2"
+# if !(EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4)
+#  error "ES_SUPER_BUFFER requires MEDFORD2 or MEDFORD4"
 # endif
 #endif
 
 /* Support hardware assistance for tunnels */
 #if EFSYS_OPT_TUNNEL
-# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
-#  error "TUNNEL requires RIVERHEAD or MEDFORD or MEDFORD2"
+# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || \
+	EFSYS_OPT_MEDFORD4)
+#  error "TUNNEL requires RIVERHEAD or MEDFORD or MEDFORD2 or MEDFORD4"
 # endif
 #endif /* EFSYS_OPT_TUNNEL */
 
 #if EFSYS_OPT_FW_SUBVARIANT_AWARE
 /* Advertise that the driver is firmware subvariant aware */
-# if !(EFSYS_OPT_MEDFORD2)
-#  error "FW_SUBVARIANT_AWARE requires MEDFORD2"
+# if !(EFSYS_OPT_MEDFORD2 || EFSYS_OPT_MEDFORD4)
+#  error "FW_SUBVARIANT_AWARE requires MEDFORD2 or MEDFORD4"
 # endif
 #endif
 
diff --git a/drivers/common/sfc_efx/efsys.h b/drivers/common/sfc_efx/efsys.h
index 41fa3da762..e63cbdbe8f 100644
--- a/drivers/common/sfc_efx/efsys.h
+++ b/drivers/common/sfc_efx/efsys.h
@@ -125,6 +125,8 @@ prefetch_read_once(const volatile void *addr)
 #define EFSYS_OPT_MEDFORD2 1
 /* Enable Riverhead support */
 #define EFSYS_OPT_RIVERHEAD 1
+/* Disable Medford4 support (not supported yet) */
+#define EFSYS_OPT_MEDFORD4 0
 
 #ifdef RTE_DEBUG_COMMON_SFC_EFX
 #define EFSYS_OPT_CHECK_REG 1
-- 
2.39.5

