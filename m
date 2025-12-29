Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E7DE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B28F4064C;
	Mon, 29 Dec 2025 22:35:40 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 031CB402E9;
 Mon, 29 Dec 2025 22:35:38 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 51191E14A6;
 Tue, 30 Dec 2025 01:35:37 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 51191E14A6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044137;
 bh=DQWXg40GF9PiN4xZTgqPdRyygpLjYlzlRBGwu3A4UCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AaUibHkqjYaortdqAPGBpTPHtGIcE1mVy6ckkTWSM1YyV6eieHUVVj0qz3UaBCvbl
 lV8QLeXqOHc+1XFneyJMU0uzJMkJBZbhXqAngQtCDSMjSHp0QS7eMCXvAV+YkcKE89
 V+xB/+LUoB04wDCpykFesQtNa5zB+Fl+uVlWSMzoAJ7i3P5V+Nd9zG7d1pfkBRXYki
 MFngomIoGzrPUWzSxRNt5U2inH6mURcDl+vSkTP2293XgczjMKtfKE3IUSBssfVMgL
 4IRtLNaip9Hp8E45fW0SUrmKKvlBI40kyn+XhptPzczbslwon1nUlKtbDChA0c9mgc
 X3RJgQHjM8Eyg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 3/9] common/sfc_efx/base: fix indication of requestable FEC
 flags
Date: Tue, 30 Dec 2025 01:35:21 +0400
Message-ID: <20251229213527.37907-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

Without these, the client driver will not allow to change default FEC mode.
The existing code assumes that the FW supplies them in the 'FEC_REQ' field
of the 'GET_FIXED_PORT_PROPERTIES' MCDI, but that is not the case. Arrange
the code to reuse the snippet from pre-X4 EF10 attach path to set the bits.

Fixes: a90549f527eb ("common/sfc_efx/base: get netport fixed capabilities on probe")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/ef10_nic.c | 57 ++++++++++++++------------
 drivers/common/sfc_efx/base/efx_np.c   |  2 +-
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index 627144cfb0..9af4259d38 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -2220,35 +2220,23 @@ efx_mcdi_nic_board_cfg(
 
 	encp->enc_board_type = board_type;
 
-	if (efx_np_supported(enp) != B_FALSE)
-		goto skip_phy_props;
-
-	/* Fill out fields in enp->en_port and enp->en_nic_cfg from MCDI */
-	if ((rc = efx_mcdi_get_phy_cfg(enp)) != 0)
-		goto fail8;
+	if (efx_np_supported(enp) == B_FALSE) {
+		/*
+		 * Fill out fields in enp->en_port and enp->en_nic_cfg from MCDI
+		 */
+		rc = efx_mcdi_get_phy_cfg(enp);
+		if (rc != 0)
+			goto fail8;
 
-	/*
-	 * Firmware with support for *_FEC capability bits does not
-	 * report that the corresponding *_FEC_REQUESTED bits are supported.
-	 * Add them here so that drivers understand that they are supported.
-	 */
-	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_BASER_FEC))
-		epp->ep_phy_cap_mask |=
-		    (1u << EFX_PHY_CAP_BASER_FEC_REQUESTED);
-	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_RS_FEC))
-		epp->ep_phy_cap_mask |=
-		    (1u << EFX_PHY_CAP_RS_FEC_REQUESTED);
-	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_25G_BASER_FEC))
-		epp->ep_phy_cap_mask |=
-		    (1u << EFX_PHY_CAP_25G_BASER_FEC_REQUESTED);
+		/* Obtain the default PHY advertised capabilities */
+		rc = ef10_phy_get_link(enp, &els);
+		if (rc != 0)
+			goto fail9;
 
-	/* Obtain the default PHY advertised capabilities */
-	if ((rc = ef10_phy_get_link(enp, &els)) != 0)
-		goto fail9;
-	epp->ep_default_adv_cap_mask = els.epls.epls_adv_cap_mask;
-	epp->ep_adv_cap_mask = els.epls.epls_adv_cap_mask;
+		epp->ep_default_adv_cap_mask = els.epls.epls_adv_cap_mask;
+		epp->ep_adv_cap_mask = els.epls.epls_adv_cap_mask;
+	}
 
-skip_phy_props:
 	/* Check capabilities of running datapath firmware */
 	if ((rc = ef10_get_datapath_caps(enp)) != 0)
 		goto fail10;
@@ -2483,6 +2471,7 @@ ef10_nic_probe(
 {
 	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	efx_drv_cfg_t *edcp = &(enp->en_drv_cfg);
+	efx_port_t *epp = &(enp->en_port);
 	efx_rc_t rc;
 
 	EFSYS_ASSERT(EFX_FAMILY_IS_EF10(enp));
@@ -2506,6 +2495,22 @@ ef10_nic_probe(
 	if (rc != 0)
 		goto fail5;
 
+	/*
+	 * Firmware with support for *_FEC capability bits does not
+	 * report that the corresponding *_FEC_REQUESTED bits are supported.
+	 * Add them here so that drivers understand that they are supported.
+	 */
+
+	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_BASER_FEC))
+		epp->ep_phy_cap_mask |=
+		    (1u << EFX_PHY_CAP_BASER_FEC_REQUESTED);
+	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_RS_FEC))
+		epp->ep_phy_cap_mask |=
+		    (1u << EFX_PHY_CAP_RS_FEC_REQUESTED);
+	if (epp->ep_phy_cap_mask & (1u << EFX_PHY_CAP_25G_BASER_FEC))
+		epp->ep_phy_cap_mask |=
+		    (1u << EFX_PHY_CAP_25G_BASER_FEC_REQUESTED);
+
 	/*
 	 * Set default driver config limits (based on board config).
 	 *
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index ca0eb09b4a..45f3cd07ed 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1392,7 +1392,7 @@ efx_np_link_ctrl(
 		 * no 'FEC_REQUESTED' bits, use 'NONE' or 'AUTO' from above.
 		 */
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
-		    ETH_AN_FIELDS_FEC_REQ, cap_data_raw, cap_mask_sw,
+		    ETH_AN_FIELDS_FEC_MASK, cap_data_raw, cap_mask_sw,
 		    NULL, NULL, &supported, &cap_enum_hw);
 
 		if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0
-- 
2.47.3

