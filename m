Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488AC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE35240E35;
	Wed, 23 Apr 2025 18:00:50 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BE88040BA6
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1C4BEE02EB;
 Wed, 23 Apr 2025 20:00:39 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1C4BEE02EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424039;
 bh=LsY1hd01br2yCVdM/LIL1Y7mQ8LQ7bwrJ/L4/MfF/4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SW8g/gQ+sME533ttHrF+Yckp6fGPfbSCgh65VdL6I1bZ5qq/V6Y5CyaqRISWy9eYV
 TFCSnmGvsZL8IJSHvIBfLm/11/cwS94toB5LtEr20xwRx24PWvBfOeezfKM+bHvr9c
 8okEpleeWRy1tkqa2sifXYEEt/OwuICDOa29KWlxsnKFjuNig7MU0iVUm/Oo8RE974
 Bv41gEMZi1rUK7DVkLcToj0nvMlRVL99iRDaBh1YPXHXOWiH7qC0VRQkV9oRVl0nUY
 lid0kkF6yVKkw0T7zvZ1gGhRn6J8TkV0SzGS5lU1RJkHOzCTc2DEfmsc+Kz4nfp2Xf
 nUqBuk38O1tTg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 33/45] common/sfc_efx/base: fill in MAC statistics mask on
 Medford4
Date: Wed, 23 Apr 2025 19:59:50 +0400
Message-Id: <20250423160002.35706-34-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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
index ade4379a19..23c59f18ed 100644
--- a/drivers/common/sfc_efx/base/medford4_mac.c
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -89,4 +89,35 @@ medford4_mac_reconfigure(
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
+	/* TODO: care about VADAPTOR statistics when VF support arrives */
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

