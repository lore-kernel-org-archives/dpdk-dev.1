Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F2AC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35BE34279D;
	Wed, 16 Apr 2025 16:01:00 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E79D041101
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 131F7E11BE;
 Wed, 16 Apr 2025 18:00:51 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 131F7E11BE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812051;
 bh=9z9/Py9tb+VM8zi6l2IZHgdaS4JXmZUDa2i8UaBSLnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m86cmdPHcMbGXTO4C8lq4KX0NXPTJnsQ2KxQlBnqrBtW3ZJyi3R+lqE0YQvVS53KE
 SZQLLc8yH0D/FIDFWY3L/3Cp4KE4c4MZe/aJti5MkUB2DY8o/ppGgloVAoeuu7MeOt
 vi9mWxP/dYt9sSG7739ZA/CADGPmYcLEwpGJkgOHeHNTmnhhltA4eIsCqVyybJcTag
 +4TymlA6HX1LuVghNa2WBC4rmzuoT9QE/6RbjP4mXY5yI22mXBbDYsSab5WlDw0bZn
 9+pkgesmzaw76ReGQ27IJ1GMBMnG65JXtAiMgqqPkFTBoMYiu1OfLDChgsppi0AWuo
 JGTHOyv4dMY0Q==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 27/46] common/sfc_efx/base: introduce Medford4 stub for PHY
 methods
Date: Wed, 16 Apr 2025 17:59:57 +0400
Message-Id: <20250416140016.36127-28-ivan.malov@arknetworks.am>
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

Provide only a couple of no-op methods for now. Next patches
will augment the file with more, based on newer netport MCDI.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h      |  4 +++
 drivers/common/sfc_efx/base/efx_phy.c       | 22 +++++++++++++++-
 drivers/common/sfc_efx/base/medford4_impl.h | 29 +++++++++++++++++++++
 drivers/common/sfc_efx/base/medford4_phy.c  | 28 ++++++++++++++++++++
 drivers/common/sfc_efx/base/meson.build     |  1 +
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/common/sfc_efx/base/medford4_impl.h
 create mode 100644 drivers/common/sfc_efx/base/medford4_phy.c

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 3a9c6fe3fd..16b7f7640d 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -45,6 +45,10 @@
 #include "rhead_impl.h"
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+#include "medford4_impl.h"
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 #ifdef	__cplusplus
 extern "C" {
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index 3d792f20b8..537865767a 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -68,6 +68,26 @@ static const efx_phy_ops_t	__efx_phy_rhead_ops = {
 };
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+static const efx_phy_ops_t	__efx_phy_medford4_ops = {
+	medford4_phy_power,		/* epo_power */
+	NULL,				/* epo_reset */
+	ef10_phy_reconfigure,		/* epo_reconfigure */
+	medford4_phy_verify,		/* epo_verify */
+	ef10_phy_oui_get,		/* epo_oui_get */
+	ef10_phy_link_state_get,	/* epo_link_state_get */
+#if EFSYS_OPT_PHY_STATS
+	ef10_phy_stats_update,		/* epo_stats_update */
+#endif	/* EFSYS_OPT_PHY_STATS */
+#if EFSYS_OPT_BIST
+	ef10_bist_enable_offline,	/* epo_bist_enable_offline */
+	ef10_bist_start,		/* epo_bist_start */
+	ef10_bist_poll,			/* epo_bist_poll */
+	ef10_bist_stop,			/* epo_bist_stop */
+#endif	/* EFSYS_OPT_BIST */
+};
+#endif	/* EFSYS_OPT_MEDFORD4 */
+
 	__checkReturn	efx_rc_t
 efx_phy_probe(
 	__in		efx_nic_t *enp)
@@ -116,7 +136,7 @@ efx_phy_probe(
 
 #if EFSYS_OPT_MEDFORD4
 	case EFX_FAMILY_MEDFORD4:
-		epop = &__efx_phy_ef10_ops;
+		epop = &__efx_phy_medford4_ops;
 	break;
 #endif	/* EFSYS_OPT_MEDFORD4 */
 
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
new file mode 100644
index 0000000000..ec8b3cec86
--- /dev/null
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Copyright(c) 2025 Advanced Micro Devices, Inc.
+ */
+#ifndef	_SYS_MEDFORD4_IMPL_H
+#define	_SYS_MEDFORD4_IMPL_H
+
+#include "efx.h"
+
+#ifdef	__cplusplus
+extern "C" {
+#endif
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_phy_power(
+	__in		efx_nic_t *enp,
+	__in		boolean_t power);
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_phy_verify(
+	__in		efx_nic_t *enp);
+
+#ifdef	__cplusplus
+}
+#endif
+
+#endif	/* _SYS_MEDFORD4_IMPL_H */
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
new file mode 100644
index 0000000000..3e6080b4de
--- /dev/null
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Copyright(c) 2025 Advanced Micro Devices, Inc.
+ */
+#include "efx.h"
+#include "efx_impl.h"
+#include "medford4_impl.h"
+
+#if EFSYS_OPT_MEDFORD4
+	__checkReturn	efx_rc_t
+medford4_phy_power(
+	__in		efx_nic_t *enp,
+	__in		boolean_t power)
+{
+	if (power)
+		enp->en_reset_flags |= EFX_RESET_PHY;
+
+	return (0);
+}
+
+	__checkReturn	efx_rc_t
+medford4_phy_verify(
+	__in		efx_nic_t *enp)
+{
+	_NOTE(ARGUNUSED(enp))
+	return (0);
+}
+#endif	/* EFSYS_OPT_MEDFORD4 */
diff --git a/drivers/common/sfc_efx/base/meson.build b/drivers/common/sfc_efx/base/meson.build
index 02d5b2fbb9..937e3820a0 100644
--- a/drivers/common/sfc_efx/base/meson.build
+++ b/drivers/common/sfc_efx/base/meson.build
@@ -57,6 +57,7 @@ sources = [
         'hunt_nic.c',
         'medford_nic.c',
         'medford2_nic.c',
+        'medford4_phy.c',
         'rhead_ev.c',
         'rhead_intr.c',
         'rhead_nic.c',
-- 
2.39.5

