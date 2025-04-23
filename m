Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31CCC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:04:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEB440E13;
	Wed, 23 Apr 2025 18:00:44 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 82F5F40B95
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C59A6E035C;
 Wed, 23 Apr 2025 20:00:34 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C59A6E035C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424035;
 bh=gbCUrS9qQUJGVwBe6J/W2IIAm35hyhEQY7FsnjtvXlI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dq8jx18TpdOpurvbAR+UHcLpuXL2VJYF13SK8Ni2RlzXF4ltnbteQFdtQyF8xBA5/
 D0yGbsIcSebMft7/278v52QVZ6wOgWF6VW1dFCnUydb+UauxbGcjCk2fQtLiBo7flJ
 VubQh7USVs3bq1cvJ4NPUVGXmmGK+NO4kzP5PgENBflWQZS++T5kYdBPxnaeAd4365
 Az6UJGVD6tli5RQ8IN5jenIGIBDPPBD92SkZBesBzSLq/WTPZjPD0F/rOTjFqsgn41
 aiQL6Nt5pabj3c8yekhLE5hIbdPbldhZ/WQtBxQF5Xs0u+xlJJoJ/7gYIXY0ijxaLu
 pXdJBz4mT+pAg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 28/45] common/sfc_efx/base: provide PHY link get method on
 Medford4
Date: Wed, 23 Apr 2025 19:59:45 +0400
Message-Id: <20250423160002.35706-29-ivan.malov@arknetworks.am>
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

To do so, make use of new netport MCDI supported by Medford4.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_phy.c      |  8 ++
 drivers/common/sfc_efx/base/efx.h           |  4 +-
 drivers/common/sfc_efx/base/efx_impl.h      | 19 ++++
 drivers/common/sfc_efx/base/efx_np.c        | 97 ++++++++++++++++++++-
 drivers/common/sfc_efx/base/efx_phy.c       |  2 +-
 drivers/common/sfc_efx/base/medford4_impl.h | 12 +++
 drivers/common/sfc_efx/base/medford4_phy.c  | 62 +++++++++++++
 7 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_phy.c b/drivers/common/sfc_efx/base/ef10_phy.c
index d458199c7a..8c3de273b4 100644
--- a/drivers/common/sfc_efx/base/ef10_phy.c
+++ b/drivers/common/sfc_efx/base/ef10_phy.c
@@ -118,6 +118,8 @@ mcdi_phy_decode_link_mode(
 
 	if (!up)
 		*link_modep = EFX_LINK_DOWN;
+	else if (speed == 200000 && fd)
+		*link_modep = EFX_LINK_200000FDX;
 	else if (speed == 100000 && fd)
 		*link_modep = EFX_LINK_100000FDX;
 	else if (speed == 50000 && fd)
@@ -160,6 +162,12 @@ mcdi_phy_decode_link_mode(
 	case MC_CMD_FEC_RS:
 		*fecp = EFX_PHY_FEC_RS;
 		break;
+	case MC_CMD_FEC_IEEE_RS_INT:
+		*fecp = EFX_PHY_FEC_IEEE_RS_INT;
+		break;
+	case MC_CMD_FEC_ETCS_RS_LL:
+		*fecp = EFX_PHY_FEC_ETCS_RS_LL;
+		break;
 	default:
 		EFSYS_PROBE1(mc_pcol_error, int, fec);
 		*fecp = EFX_PHY_FEC_NONE;
diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 7ffa1f4cbd..6ca108cffe 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -4010,7 +4010,9 @@ efx_nic_set_fw_subvariant(
 typedef enum efx_phy_fec_type_e {
 	EFX_PHY_FEC_NONE = 0,
 	EFX_PHY_FEC_BASER,
-	EFX_PHY_FEC_RS
+	EFX_PHY_FEC_RS,
+	EFX_PHY_FEC_IEEE_RS_INT,
+	EFX_PHY_FEC_ETCS_RS_LL,
 } efx_phy_fec_type_t;
 
 #define EFX_PHY_CAP_FEC_BIT(_fec_bit) (1U << EFX_PHY_CAP_##_fec_bit)
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 16b7f7640d..63ff112194 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1907,7 +1907,14 @@ efx_np_detach(
 
 typedef struct efx_np_link_state_s {
 	uint32_t		enls_adv_cap_mask;
+	uint32_t		enls_lp_cap_mask;
+	efx_loopback_type_t	enls_loopback;
+	uint32_t		enls_speed;
+	uint8_t			enls_fec;
+
 	boolean_t		enls_an_supported;
+	boolean_t		enls_fd;
+	boolean_t		enls_up;
 } efx_np_link_state_t;
 
 LIBEFX_INTERNAL
@@ -1917,6 +1924,18 @@ efx_np_link_state(
 	__in		efx_np_handle_t nph,
 	__out		efx_np_link_state_t *lsp);
 
+typedef struct efx_np_mac_state_s {
+	uint32_t	enms_fcntl;
+	boolean_t	enms_up;
+} efx_np_mac_state_t;
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_np_mac_state(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__out		efx_np_mac_state_t *msp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 1b670435db..409fe05772 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -301,7 +301,9 @@ efx_np_link_state(
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_LINK_STATE_IN_LEN,
 	    MC_CMD_LINK_STATE_OUT_V3_LEN);
+	uint32_t status_flags;
 	efx_mcdi_req_t req;
+	uint32_t v3_flags;
 	efx_rc_t rc;
 
 	req.emr_out_length = MC_CMD_LINK_STATE_OUT_V3_LEN;
@@ -324,12 +326,43 @@ efx_np_link_state(
 		goto fail2;
 	}
 
+	status_flags = MCDI_OUT_DWORD(req, LINK_STATE_OUT_STATUS_FLAGS_LO);
+	v3_flags = MCDI_OUT_DWORD(req, LINK_STATE_OUT_V3_FLAGS);
 	memset(lsp, 0, sizeof (*lsp));
 
-	if (MCDI_OUT_DWORD(req, LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT) !=
+	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE) &&
+	    MCDI_OUT_DWORD(req, LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT) !=
 	    MC_CMD_AN_NONE)
 		lsp->enls_an_supported = B_TRUE;
 
+	if (v3_flags & (1U << MC_CMD_LINK_STATE_OUT_V3_FULL_DUPLEX_LBN))
+		lsp->enls_fd = B_TRUE;
+
+	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_LINK_UP))
+		lsp->enls_up = B_TRUE;
+
+	lsp->enls_speed = MCDI_OUT_DWORD(req, LINK_STATE_OUT_V3_LINK_SPEED);
+	lsp->enls_fec = MCDI_OUT_BYTE(req, LINK_STATE_OUT_FEC_MODE);
+
+#if EFSYS_OPT_LOOPBACK
+	switch (MCDI_OUT_BYTE(req, LINK_STATE_OUT_LOOPBACK)) {
+	case MC_CMD_LOOPBACK_V2_NONE:
+		lsp->enls_loopback = EFX_LOOPBACK_OFF;
+		break;
+	case MC_CMD_LOOPBACK_V2_AUTO:
+		lsp->enls_loopback = EFX_LOOPBACK_DATA;
+		break;
+	case MC_CMD_LOOPBACK_V2_POST_PCS:
+		lsp->enls_loopback = EFX_LOOPBACK_PCS;
+		break;
+	default:
+		rc = EINVAL;
+		goto fail3;
+	}
+#else /* ! EFSYS_OPT_LOOPBACK */
+	_NOTE(ARGUNUSED(lbp))
+#endif /* EFSYS_OPT_LOOPBACK */
+
 	if (lsp->enls_an_supported != B_FALSE)
 		lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
 
@@ -337,8 +370,21 @@ efx_np_link_state(
 	    MCDI_OUT2(req, const uint8_t, LINK_STATE_OUT_ADVERTISED_ABILITIES),
 	    &lsp->enls_adv_cap_mask);
 
+	if (lsp->enls_an_supported != B_FALSE)
+		lsp->enls_lp_cap_mask |= 1U << EFX_PHY_CAP_AN;
+
+	efx_np_cap_hw_data_to_sw_mask(
+	    MCDI_OUT2(req, const uint8_t,
+		    LINK_STATE_OUT_LINK_PARTNER_ABILITIES),
+	    &lsp->enls_lp_cap_mask);
+
 	return (0);
 
+#if EFSYS_OPT_LOOPBACK
+fail3:
+	EFSYS_PROBE(fail3);
+#endif /* EFSYS_OPT_LOOPBACK */
+
 fail2:
 	EFSYS_PROBE(fail2);
 
@@ -552,3 +598,52 @@ efx_np_detach(
 	if (efx_np_supported(enp) == B_FALSE)
 		return;
 }
+
+	__checkReturn	efx_rc_t
+efx_np_mac_state(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__out		efx_np_mac_state_t *msp)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_MAC_STATE_IN_LEN,
+	    MC_CMD_MAC_STATE_OUT_LEN);
+	efx_mcdi_req_t req;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_MAC_STATE_OUT_LEN;
+	req.emr_in_length = MC_CMD_MAC_STATE_IN_LEN;
+	req.emr_cmd = MC_CMD_MAC_STATE;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, MAC_STATE_IN_PORT_HANDLE, nph);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	if (req.emr_out_length_used < MC_CMD_MAC_STATE_OUT_LEN) {
+		rc = EMSGSIZE;
+		goto fail2;
+	}
+
+	memset(msp, 0, sizeof (*msp));
+
+	if (MCDI_OUT_DWORD(req, MAC_STATE_OUT_MAC_FAULT_FLAGS) == 0)
+		msp->enms_up = B_TRUE;
+
+	msp->enms_fcntl = MCDI_OUT_DWORD(req, MAC_STATE_OUT_FCNTL);
+	return (0);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+
+	return (rc);
+}
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index 537865767a..0f748e32a4 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -75,7 +75,7 @@ static const efx_phy_ops_t	__efx_phy_medford4_ops = {
 	ef10_phy_reconfigure,		/* epo_reconfigure */
 	medford4_phy_verify,		/* epo_verify */
 	ef10_phy_oui_get,		/* epo_oui_get */
-	ef10_phy_link_state_get,	/* epo_link_state_get */
+	medford4_phy_link_state_get,	/* epo_link_state_get */
 #if EFSYS_OPT_PHY_STATS
 	ef10_phy_stats_update,		/* epo_stats_update */
 #endif	/* EFSYS_OPT_PHY_STATS */
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index ec8b3cec86..f24c9d1e6c 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -22,6 +22,18 @@ extern	__checkReturn	efx_rc_t
 medford4_phy_verify(
 	__in		efx_nic_t *enp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_phy_get_link(
+	__in		efx_nic_t *enp,
+	__out		ef10_link_state_t *elsp);
+
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_phy_link_state_get(
+	__in			efx_nic_t *enp,
+	__out			efx_phy_link_state_t *eplsp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 3e6080b4de..6a61645384 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -25,4 +25,66 @@ medford4_phy_verify(
 	_NOTE(ARGUNUSED(enp))
 	return (0);
 }
+
+	__checkReturn	efx_rc_t
+medford4_phy_get_link(
+	__in		efx_nic_t *enp,
+	__out		ef10_link_state_t *elsp)
+{
+	efx_np_handle_t nph = enp->en_port.ep_np_handle;
+	efx_np_link_state_t ls;
+	efx_np_mac_state_t ms;
+	uint32_t fcntl;
+	efx_rc_t rc;
+
+	rc = efx_np_link_state(enp, nph, &ls);
+	if (rc != 0)
+		goto fail1;
+
+	elsp->epls.epls_adv_cap_mask = ls.enls_adv_cap_mask;
+	elsp->epls.epls_lp_cap_mask = ls.enls_lp_cap_mask;
+	elsp->els_loopback = ls.enls_loopback;
+
+	rc = efx_np_mac_state(enp, nph, &ms);
+	if (rc != 0)
+		goto fail2;
+
+	elsp->els_mac_up = ms.enms_up;
+
+	mcdi_phy_decode_link_mode(enp, ls.enls_fd, ls.enls_up, ls.enls_speed,
+			    ms.enms_fcntl, ls.enls_fec,
+			    &elsp->epls.epls_link_mode,
+			    &elsp->epls.epls_fcntl,
+			    &elsp->epls.epls_fec);
+
+	elsp->epls.epls_ld_cap_mask = 0;
+	return (0);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn		efx_rc_t
+medford4_phy_link_state_get(
+	__in			efx_nic_t *enp,
+	__out			efx_phy_link_state_t *eplsp)
+{
+	ef10_link_state_t els;
+	efx_rc_t rc;
+
+	rc = medford4_phy_get_link(enp, &els);
+	if (rc != 0)
+		goto fail1;
+
+	*eplsp = els.epls;
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
 #endif	/* EFSYS_OPT_MEDFORD4 */
-- 
2.39.5

