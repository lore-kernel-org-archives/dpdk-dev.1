Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF1C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:03:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C04D4270A;
	Wed, 16 Apr 2025 16:00:53 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0AD1B410DD
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 57AE9E1149;
 Wed, 16 Apr 2025 18:00:43 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 57AE9E1149
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812043;
 bh=AmMcLIDMK6QLWd3XA2z9G1T9AtRqKR7OorvLymB38fc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RtingfNol43KLnB9DQXVCHLwYqetf7TQO5KGJdhvnzgO/6L4uDzejkz+K0FR4KBlE
 F4z4YPaDSnrSzwgmsFZq0yVBrK7Cu6CX8U0bqLthGETlppX4ipsTiByqZe8JyTEco2
 L39ex2JT63zaSE1k0dxDHOgfCi9hMISa+R7Te+U9nCw4W39kMyc+szQos2B1+4FiEb
 AOBsG4GixzwuCsf9m6i2pDBAz9zenskEFIN/p2cOvRkaZrcQC7LEUVXyygZSpRuaJD
 d3zTU5mtCUpe49Y+P24yFTTR0FjoELWmboOqXCu4JToWqNjvZNrla5lLD20f0FadRI
 rJJ88wZppxhzA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 21/46] common/sfc_efx/base: provide defaults on netport attach
 path
Date: Wed, 16 Apr 2025 17:59:51 +0400
Message-Id: <20250416140016.36127-22-ivan.malov@arknetworks.am>
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

Fill in some port information, including legacy Siena fields.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 432185f311..3200bc0a90 100644
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

