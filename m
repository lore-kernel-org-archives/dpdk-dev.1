Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F8C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA803427C7;
	Wed, 16 Apr 2025 16:01:07 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5B81342799
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A91F7E0872;
 Wed, 16 Apr 2025 18:00:58 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A91F7E0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812059;
 bh=ddzobAqAzRTKWh7sY8HTrDMA1kCa2myP0obXfquBvtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yn4aAeaaxaSt2bTsYO8j9LJavLxV0nylO/HAFF2ScJOtBu6ymoPiUC7pEOgcsURGa
 3/uhWN2o0TeDnjYjQFL/Nyh0taqzCFZVCSqCmje0XsINwB2RwsuILPkdvuljxLFnSA
 ivrHrEUaNf2DyP3QO3QIozv/Fg0i5UhxpQzVt3YuepZEYMwc5w2g+45lk2DS2vN11+
 K9tAjuTnZ2GMaWE1/6ugR31RqqwAQVHWn3+aH9STSMNHaBaryD7lyqcPaWazahlM/i
 91KR51Qw6K/hvq6e37Cw7qCl6r/tzBw0iRXT8IMRGD56PkGK2NsVdisWb4VLTbSYLl
 u1joO9a3qgH3A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 34/46] common/sfc_efx/base: fill in MAC statistics mask on
 Medford4
Date: Wed, 16 Apr 2025 18:00:04 +0400
Message-Id: <20250416140016.36127-35-ivan.malov@arknetworks.am>
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

Let client drivers know which MAC statistics can be accessed.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_mac.c       |  2 +-
 drivers/common/sfc_efx/base/medford4_impl.h |  9 ++++++
 drivers/common/sfc_efx/base/medford4_mac.c  | 31 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 3c29db0016..6abe2046e8 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -105,7 +105,7 @@ static const efx_mac_ops_t	__efx_mac_medford4_ops = {
 	ef10_mac_loopback_set,			/* emo_loopback_set */
 #endif	/* EFSYS_OPT_LOOPBACK */
 #if EFSYS_OPT_MAC_STATS
-	ef10_mac_stats_get_mask,		/* emo_stats_get_mask */
+	medford4_mac_stats_get_mask,		/* emo_stats_get_mask */
 	efx_mcdi_mac_stats_clear,		/* emo_stats_clear */
 	efx_mcdi_mac_stats_upload,		/* emo_stats_upload */
 	efx_mcdi_mac_stats_periodic,		/* emo_stats_periodic */
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index 8b232c516a..2fbf1495d1 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -56,6 +56,15 @@ extern	__checkReturn		efx_rc_t
 medford4_mac_reconfigure(
 	__in			efx_nic_t *enp);
 
+#if EFSYS_OPT_MAC_STATS
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_mac_stats_get_mask(
+	__in			efx_nic_t *enp,
+	__inout_bcount(sz)	uint32_t *maskp,
+	__in			size_t sz);
+#endif /* EFSYS_OPT_MAC_STATS */
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
index c037c29b92..b8a5aade16 100644
--- a/drivers/common/sfc_efx/base/medford4_mac.c
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -83,4 +83,35 @@ medford4_mac_reconfigure(
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
 }
+
+#if EFSYS_OPT_MAC_STATS
+	__checkReturn		efx_rc_t
+medford4_mac_stats_get_mask(
+	__in			efx_nic_t *enp,
+	__inout_bcount(sz)	uint32_t *maskp,
+	__in			size_t sz)
+{
+	efx_port_t *epp = &(enp->en_port);
+	unsigned int i;
+	efx_rc_t rc;
+
+	for (i = 0; i < EFX_ARRAY_SIZE(epp->ep_np_mac_stat_lut); ++i) {
+		const struct efx_mac_stats_range rng[] = { { i, i } };
+
+		if (epp->ep_np_mac_stat_lut[i].ens_valid == B_FALSE)
+			continue;
+
+		rc = efx_mac_stats_mask_add_ranges(maskp, sz, rng, 1);
+		if (rc != 0)
+			goto fail1;
+	}
+
+	/* TODO: care about VADAPTOR statistics */
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+#endif /* EFSYS_OPT_MAC_STATS */
 #endif /* EFSYS_OPT_MEDFORD4 */
-- 
2.39.5

