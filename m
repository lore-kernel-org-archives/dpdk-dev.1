Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F5EC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82EB9427B5;
	Wed, 16 Apr 2025 16:01:04 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0D4C74278F
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5589EE11C0;
 Wed, 16 Apr 2025 18:00:56 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5589EE11C0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812056;
 bh=onHkD11m0I80Jtrm82Cy6cSUCezdPph/jqosXrmQ6bo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2JKFk1THSQIzH/eh2iq9PV6lhIhms5cy1TRNOExPD6ryhKSDcmluErBL4a/YX5+H0
 loktMB+GDG6wt3kkeyaVgJCkENEWEXTJGvZCe1t+x8Z80NQuU317EhMKerLGaMe8Gq
 WMOWOqKha/I/NfXS3VMdZp/fHhA4LqQQ071E4unkxUPflUDjXMFhpkJG15D+gz6287
 UX157MKuARfDWrJiZ8i/gc4DXWaS34ztx8KcLhjmVoHcJGsAdhtXA1/bm4aU152/ZW
 x1lIcK61xIOnRwM8OprShyM1fNEO8Og4zDnh4BaErY8rCbfwW3hL5icyHw7hbMMSa4
 I2D6aIvSLhVjA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 31/46] common/sfc_efx/base: introduce Medford4 stub for MAC
 methods
Date: Wed, 16 Apr 2025 18:00:01 +0400
Message-Id: <20250416140016.36127-32-ivan.malov@arknetworks.am>
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

Provide only a small subset of methods for now. Next patches
will augment the file with more, based on newer netport MCDI.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_mac.c       | 32 +++++++++++-
 drivers/common/sfc_efx/base/medford4_impl.h | 12 +++++
 drivers/common/sfc_efx/base/medford4_mac.c  | 54 +++++++++++++++++++++
 drivers/common/sfc_efx/base/meson.build     |  1 +
 4 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/common/sfc_efx/base/medford4_mac.c

diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index a2cbf02b46..dde0e5ab87 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -89,6 +89,31 @@ static const efx_mac_ops_t	__efx_mac_rhead_ops = {
 };
 #endif	/* EFSYS_OPT_RIVERHEAD */
 
+#if EFSYS_OPT_MEDFORD4
+static const efx_mac_ops_t	__efx_mac_medford4_ops = {
+	medford4_mac_poll,			/* emo_poll */
+	medford4_mac_up,			/* emo_up */
+	ef10_mac_addr_set,			/* emo_addr_set */
+	ef10_mac_pdu_set,			/* emo_pdu_set */
+	ef10_mac_pdu_get,			/* emo_pdu_get */
+	ef10_mac_reconfigure,			/* emo_reconfigure */
+	ef10_mac_multicast_list_set,		/* emo_multicast_list_set */
+	ef10_mac_filter_default_rxq_set,	/* emo_filter_default_rxq_set */
+	ef10_mac_filter_default_rxq_clear,
+					/* emo_filter_default_rxq_clear */
+#if EFSYS_OPT_LOOPBACK
+	ef10_mac_loopback_set,			/* emo_loopback_set */
+#endif	/* EFSYS_OPT_LOOPBACK */
+#if EFSYS_OPT_MAC_STATS
+	ef10_mac_stats_get_mask,		/* emo_stats_get_mask */
+	efx_mcdi_mac_stats_clear,		/* emo_stats_clear */
+	efx_mcdi_mac_stats_upload,		/* emo_stats_upload */
+	efx_mcdi_mac_stats_periodic,		/* emo_stats_periodic */
+	ef10_mac_stats_update			/* emo_stats_update */
+#endif	/* EFSYS_OPT_MAC_STATS */
+};
+#endif /* EFSYS_OPT_MEDFORD4 */
+
 	__checkReturn			efx_rc_t
 efx_mac_pdu_set(
 	__in				efx_nic_t *enp,
@@ -271,6 +296,11 @@ efx_mac_drain(
 	EFSYS_ASSERT3U(enp->en_mod_flags, &, EFX_MOD_PORT);
 	EFSYS_ASSERT(emop != NULL);
 
+	if (efx_np_supported(enp) != B_FALSE) {
+		/* Only pre-Medford4 boards have supported MAC drain control. */
+		return (0);
+	}
+
 	if (epp->ep_mac_drain == enabled)
 		return (0);
 
@@ -955,7 +985,7 @@ efx_mac_select(
 
 #if EFSYS_OPT_MEDFORD4
 	case EFX_FAMILY_MEDFORD4:
-		emop = &__efx_mac_ef10_ops;
+		emop = &__efx_mac_medford4_ops;
 		type = EFX_MAC_MEDFORD4;
 		break;
 #endif /* EFSYS_OPT_MEDFORD4 */
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index 795fd45bd4..6aa065c730 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -39,6 +39,18 @@ extern	__checkReturn		efx_rc_t
 medford4_phy_reconfigure(
 	__in			efx_nic_t *enp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_mac_poll(
+	__in		efx_nic_t *enp,
+	__out		efx_link_mode_t *link_modep);
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_mac_up(
+	__in		efx_nic_t *enp,
+	__out		boolean_t *mac_upp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
new file mode 100644
index 0000000000..57ddbecfaa
--- /dev/null
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -0,0 +1,54 @@
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
+medford4_mac_poll(
+	__in		efx_nic_t *enp,
+	__out		efx_link_mode_t *link_modep)
+{
+	efx_port_t *epp = &(enp->en_port);
+	ef10_link_state_t els;
+	efx_rc_t rc;
+
+	rc = medford4_phy_get_link(enp, &els);
+	if (rc != 0)
+		goto fail1;
+
+	epp->ep_adv_cap_mask = els.epls.epls_adv_cap_mask;
+	epp->ep_fcntl = els.epls.epls_fcntl;
+
+	*link_modep = els.epls.epls_link_mode;
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	*link_modep = EFX_LINK_UNKNOWN;
+	return (rc);
+}
+
+	__checkReturn	efx_rc_t
+medford4_mac_up(
+	__in		efx_nic_t *enp,
+	__out		boolean_t *mac_upp)
+{
+	ef10_link_state_t els;
+	efx_rc_t rc;
+
+	rc = medford4_phy_get_link(enp, &els);
+	if (rc != 0)
+		goto fail1;
+
+	*mac_upp = els.els_mac_up;
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+#endif /* EFSYS_OPT_MEDFORD4 */
diff --git a/drivers/common/sfc_efx/base/meson.build b/drivers/common/sfc_efx/base/meson.build
index 937e3820a0..f18011e186 100644
--- a/drivers/common/sfc_efx/base/meson.build
+++ b/drivers/common/sfc_efx/base/meson.build
@@ -57,6 +57,7 @@ sources = [
         'hunt_nic.c',
         'medford_nic.c',
         'medford2_nic.c',
+        'medford4_mac.c',
         'medford4_phy.c',
         'rhead_ev.c',
         'rhead_intr.c',
-- 
2.39.5

