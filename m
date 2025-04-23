Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA2C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6467340B92;
	Wed, 23 Apr 2025 18:00:35 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 7464840A6D
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C520FE02AA;
 Wed, 23 Apr 2025 20:00:28 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C520FE02AA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424029;
 bh=xHAN5w1b9QUXxVlPS6g0sPErpmcE+XXKEKvpzzqYk+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pqs1detZxMD2hBkZrDwJMLIowblYtmpBQ9JJ6TTUFsbKRJh70fLqSrs9p6o0H5JrY
 GBx4Pq6ahAEQtvUIQ1Okx9rV6vF3zkTUFT1QTNvcOdjmYdgjx4xpYG4mQXAneKq/oO
 /jCvxPDqNZN67Lb2sxfsCgIj+TDNlnAUgIxg48E2K9tk1Q/rcKZsr1C2fA0DymDBtx
 cbSU8dx3D6kgB3Z/MXY2Ksfp1TdaltezOTHSW+QuHP/1XYzfKfN57JKjtRJ6FBVBRC
 TYpU12zPwSdcreDVQXph9JXFrgPeh6wt8Dbql6ttk+P8XR2EdWgkkpTBm1eWIVZjsb
 KkUxgO6a1XjbA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 20/45] common/sfc_efx/base: provide defaults on netport
 attach path
Date: Wed, 23 Apr 2025 19:59:37 +0400
Message-Id: <20250423160002.35706-21-ivan.malov@arknetworks.am>
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

Fill in some port information, including legacy Siena fields.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 432185f311..abb8e20e4d 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -12,13 +12,57 @@ efx_np_supported(
 	return (enp->en_family >= EFX_FAMILY_MEDFORD4) ? B_TRUE : B_FALSE;
 }
 
+static				void
+efx_np_assign_legacy_props(
+	__in			efx_nic_t *enp)
+{
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
+
+	memset(encp->enc_phy_revision, 0, sizeof (encp->enc_phy_revision));
+	encp->enc_phy_type = 0;
+
+#if EFSYS_OPT_NAMES
+	memset(encp->enc_phy_name, 0, sizeof (encp->enc_phy_name));
+#endif /* EFSYS_OPT_NAMES */
+
+#if EFSYS_OPT_PHY_STATS
+	encp->enc_mcdi_phy_stat_mask = 0;
+#endif /* EFSYS_OPT_PHY_STATS */
+
+#if EFSYS_OPT_PHY_FLAGS
+	encp->enc_phy_flags_mask = 0;
+#endif /* EFSYS_OPT_PHY_FLAGS */
+
+#if EFSYS_OPT_BIST
+	encp->enc_bist_mask = 0;
+#endif /* EFSYS_OPT_BIST */
+
+	encp->enc_mcdi_mdio_channel = 0;
+	encp->enc_port = 0;
+}
+
 	__checkReturn	efx_rc_t
 efx_np_attach(
 	__in		efx_nic_t *enp)
 {
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
+	efx_port_t *epp = &(enp->en_port);
+
 	if (efx_np_supported(enp) == B_FALSE)
 		return (0);
 
+	/*
+	 * Some EFX properties are mostly leftover from Siena era
+	 * and we prefer to initialise those to harmless defaults.
+	 */
+	efx_np_assign_legacy_props(enp);
+
+#if EFSYS_OPT_PHY_LED_CONTROL
+	encp->enc_led_mask = 1U << EFX_PHY_LED_DEFAULT;
+#endif /* EFSYS_OPT_PHY_LED_CONTROL */
+
+	epp->ep_fixed_port_type = EFX_PHY_MEDIA_INVALID;
+	epp->ep_module_type = EFX_PHY_MEDIA_INVALID;
 	return (0);
 }
 
-- 
2.39.5

