Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A445C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:04:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D429340E16;
	Wed, 23 Apr 2025 18:00:45 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 33AD840B97
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 87BADE032D;
 Wed, 23 Apr 2025 20:00:35 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 87BADE032D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424036;
 bh=Jox8aqHEPrnJowoQbZl6U4QtuvWor1OfnlsR4kynpNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F+KqU6EYq++c748El5ykzTJkM3UkT1lwZ/ulKeuMiTVHchEy3ysDKOJkNsflHNpSY
 jog6ZfrtaW8utBqj6wYg7GlLq9xB1TbnjotQ1OvvwNb8rnaUxoGK5EkEScC/NO5Y7t
 aR0rfZeEafNTyaDyIDVu/sZJl97ypxdVNkuLc6OT24GSLur+fyP53cmKO2zKEkfbnB
 bafM8bDF6YUmzpY1hl86w1kLowgIN74xZ0OKTE0QQfBW+3/1CWYEYzqRvsWtunc0Gj
 /Y1gGiX/TYBe/C9U8ObALOvcizf0GLJyCwmMCq/4HoNS3ab2xcn9YQwsjodnQVdFaE
 nSIaigSEMy8Sw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 29/45] common/sfc_efx/base: implement PHY link control for
 Medford4
Date: Wed, 23 Apr 2025 19:59:46 +0400
Message-Id: <20250423160002.35706-30-ivan.malov@arknetworks.am>
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

Use new MCDI to select loopback, speed, flow control and FEC.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_impl.h     |   6 +
 drivers/common/sfc_efx/base/ef10_phy.c      |   2 +-
 drivers/common/sfc_efx/base/efx_impl.h      |  11 +
 drivers/common/sfc_efx/base/efx_np.c        | 260 ++++++++++++++++++++
 drivers/common/sfc_efx/base/efx_phy.c       |   2 +-
 drivers/common/sfc_efx/base/medford4_impl.h |   5 +
 drivers/common/sfc_efx/base/medford4_phy.c  |  65 +++++
 7 files changed, 349 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_impl.h b/drivers/common/sfc_efx/base/ef10_impl.h
index b872ec626c..df4fd77833 100644
--- a/drivers/common/sfc_efx/base/ef10_impl.h
+++ b/drivers/common/sfc_efx/base/ef10_impl.h
@@ -814,6 +814,12 @@ mcdi_phy_decode_link_mode(
 	__out			unsigned int *fcntlp,
 	__out			efx_phy_fec_type_t *fecp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_mcdi_phy_set_led(
+	__in		efx_nic_t *enp,
+	__in		efx_phy_led_mode_t phy_led_mode);
+
 #if EFSYS_OPT_BIST
 
 LIBEFX_INTERNAL
diff --git a/drivers/common/sfc_efx/base/ef10_phy.c b/drivers/common/sfc_efx/base/ef10_phy.c
index 8c3de273b4..114543e156 100644
--- a/drivers/common/sfc_efx/base/ef10_phy.c
+++ b/drivers/common/sfc_efx/base/ef10_phy.c
@@ -473,7 +473,7 @@ efx_mcdi_phy_set_link(
 	return (rc);
 }
 
-static	__checkReturn	efx_rc_t
+	__checkReturn	efx_rc_t
 efx_mcdi_phy_set_led(
 	__in		efx_nic_t *enp,
 	__in		efx_phy_led_mode_t phy_led_mode)
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 63ff112194..15cf62506e 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1936,6 +1936,17 @@ efx_np_mac_state(
 	__in		efx_np_handle_t nph,
 	__out		efx_np_mac_state_t *msp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_np_link_ctrl(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__in		const uint8_t *cap_mask_sup_raw,
+	__in		efx_link_mode_t loopback_link_mode,
+	__in		efx_loopback_type_t loopback_mode,
+	__in		uint32_t cap_mask_sw,
+	__in		boolean_t fcntl_an);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 409fe05772..26abc82dbf 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -647,3 +647,263 @@ efx_np_mac_state(
 
 	return (rc);
 }
+
+static					void
+efx_np_cap_mask_sw_to_hw(
+	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
+	__in				unsigned int hw_sw_map_nentries,
+	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
+	__in				size_t hw_cap_data_nbytes,
+	__in				uint32_t mask_sw,
+	__out				uint8_t *mask_hwp)
+{
+	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
+	    hw_cap_data, hw_cap_data_nbytes) {
+		uint32_t flag_sw = 1U << hw_sw_map->encm_sw;
+
+		if ((mask_sw & flag_sw) != flag_sw)
+			continue;
+
+		mask_hwp[CAP_BYTE(hw_sw_map)] |= CAP_FLAG(hw_sw_map);
+		mask_sw &= ~(flag_sw);
+	}
+}
+
+/*
+ * Convert the given EFX PHY capability mask to the HW representation.
+ *
+ * The mapping of a capability from EFX to HW can be one to many. Use
+ * the given fraction of raw HW netport capability data to choose the
+ * first supported HW capability bit encountered for a particular EFX
+ * one and proceed with handling the next EFX bit, if any, afterwards.
+ *
+ * Do not check the input mask for leftover bits (unknown to EFX), as
+ * inputs should have been validated by efx_phy_adv_cap_set() already.
+ */
+#define	EFX_NP_CAP_MASK_SW_TO_HW(					\
+	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
+	    _mask_sw, _mask_hwp)					\
+	efx_np_cap_mask_sw_to_hw((_hw_sw_cap_map),			\
+	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
+	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
+		    MC_CMD_##_hw_cap_section),				\
+	    MC_CMD_##_hw_cap_section##_LEN,				\
+	    (_mask_sw), (_mask_hwp))
+
+static					void
+efx_np_cap_sw_mask_to_hw_enum(
+	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
+	__in				unsigned int hw_sw_map_nentries,
+	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
+	__in				size_t hw_cap_data_nbytes,
+	__in				uint32_t mask_sw,
+	__out				boolean_t *supportedp,
+	__out_opt			uint16_t *enum_hwp)
+{
+	unsigned int sw_nflags_req = 0;
+	unsigned int sw_nflags_sup = 0;
+	uint32_t sw_check_mask = 0;
+	unsigned int i;
+
+	for (i = 0; i < hw_sw_map_nentries; ++i) {
+		uint32_t flag_sw = 1U << hw_sw_map->encm_sw;
+		unsigned int byte_idx = CAP_BYTE(hw_sw_map);
+		uint8_t flag_hw = CAP_FLAG(hw_sw_map);
+
+		if (byte_idx >= hw_cap_data_nbytes) {
+			++(hw_sw_map);
+			continue;
+		}
+
+		if ((mask_sw & flag_sw) == flag_sw) {
+			if ((sw_check_mask & flag_sw) == 0)
+				++(sw_nflags_req);
+
+			sw_check_mask |= flag_sw;
+
+			if ((hw_cap_data[byte_idx] & flag_hw) == flag_hw) {
+				mask_sw &= ~(flag_sw);
+
+				if (enum_hwp != NULL)
+					*enum_hwp = hw_sw_map->encm_hw;
+			}
+		}
+
+		++(hw_sw_map);
+	}
+
+	if (sw_check_mask != 0 && (mask_sw & sw_check_mask) == sw_check_mask) {
+		/* Failed to select the enum by at least one capability bit. */
+		*supportedp = B_FALSE;
+		return;
+	}
+
+	*supportedp = B_TRUE;
+}
+
+/*
+ * Convert (conceivably) the only EFX capability bit of the given mask to
+ * the HW enum value, provided that the capability is supported by the HW,
+ * where the latter follows from the given fraction of HW capability data.
+ */
+#define	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(					\
+	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
+	    _mask_sw, _supportedp, _enum_hwp)				\
+	efx_np_cap_sw_mask_to_hw_enum((_hw_sw_cap_map),			\
+	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
+	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
+		    MC_CMD_##_hw_cap_section),				\
+	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
+	    (_supportedp), (_enum_hwp))
+
+	__checkReturn	efx_rc_t
+efx_np_link_ctrl(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__in		const uint8_t *cap_data_raw,
+	__in		efx_link_mode_t loopback_link_mode,
+	__in		efx_loopback_type_t loopback_mode,
+	__in		uint32_t cap_mask_sw,
+	__in		boolean_t fcntl_an)
+{
+	uint32_t flags = 1U << MC_CMD_LINK_FLAGS_IGNORE_MODULE_SEQ;
+	uint8_t loopback = MC_CMD_LOOPBACK_V2_NONE;
+	uint16_t link_tech = MC_CMD_ETH_TECH_NONE;
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_LINK_CTRL_IN_LEN,
+	    MC_CMD_LINK_CTRL_OUT_LEN);
+	uint8_t *cap_mask_hw_pausep;
+	uint8_t *cap_mask_hw_techp;
+	uint16_t cap_enum_hw;
+	boolean_t supported;
+	efx_mcdi_req_t req;
+	boolean_t phy_an;
+	efx_rc_t rc;
+	uint8_t fec;
+
+	req.emr_out_length = MC_CMD_LINK_CTRL_OUT_LEN;
+	req.emr_in_length = MC_CMD_LINK_CTRL_IN_LEN;
+	req.emr_cmd = MC_CMD_LINK_CTRL;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, LINK_CTRL_IN_PORT_HANDLE, nph);
+
+	cap_mask_hw_pausep = MCDI_IN2(req, uint8_t,
+	    LINK_CTRL_IN_ADVERTISED_PAUSE_ABILITIES_MASK);
+
+	cap_mask_hw_techp = MCDI_IN2(req, uint8_t,
+	    LINK_CTRL_IN_ADVERTISED_TECH_ABILITIES_MASK);
+
+	if (loopback_mode != EFX_LOOPBACK_OFF) {
+#if EFSYS_OPT_LOOPBACK
+		uint16_t cap_enum_sw;
+
+		switch (loopback_mode) {
+		case EFX_LOOPBACK_DATA:
+			loopback = MC_CMD_LOOPBACK_V2_AUTO;
+			break;
+		case EFX_LOOPBACK_PCS:
+			loopback = MC_CMD_LOOPBACK_V2_POST_PCS;
+			break;
+		default:
+			rc = ENOTSUP;
+			goto fail1;
+		}
+
+		rc = efx_np_sw_link_mode_to_cap(loopback_link_mode,
+					    &cap_enum_sw);
+		if (rc != 0)
+			goto fail2;
+
+		EFX_NP_CAP_ENUM_SW_TO_HW(efx_np_cap_map_tech,
+		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_enum_sw,
+		    &supported, &link_tech);
+
+		if (supported == B_FALSE) {
+			rc = ENOTSUP;
+			goto fail3;
+		}
+#else /* ! EFSYS_OPT_LOOPBACK */
+		rc = ENOTSUP;
+		goto fail1;
+#endif /* EFSYS_OPT_LOOPBACK */
+	} else if (cap_mask_sw & (1U << EFX_PHY_CAP_AN)) {
+		EFX_NP_CAP_MASK_SW_TO_HW(efx_np_cap_map_tech,
+		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    cap_mask_hw_techp);
+
+		if (fcntl_an != B_FALSE) {
+			EFX_NP_CAP_MASK_SW_TO_HW(efx_np_cap_map_pause,
+			    ETH_AN_FIELDS_PAUSE_MASK, cap_data_raw, cap_mask_sw,
+			    cap_mask_hw_pausep);
+		}
+
+		flags |= 1U << MC_CMD_LINK_FLAGS_AUTONEG_EN;
+		link_tech = MC_CMD_ETH_TECH_AUTO;
+	} else {
+		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_tech,
+		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    &supported, &link_tech);
+
+		if (supported == B_FALSE) {
+			rc = ENOTSUP;
+			goto fail4;
+		}
+	}
+
+	/* The software mask may have no requested FEC bits. Default is NONE. */
+	cap_enum_hw = MC_CMD_FEC_NONE;
+
+	/*
+	 * Compared to older EF10 interface, in netport MCDI, FEC mode is a
+	 * single enum choice. For compatibility, do not enforce only single
+	 * requested FEC bit in the original mask.
+	 *
+	 * No requested FEC bits in the original mask gives supported=TRUE.
+	 */
+	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
+	    ETH_AN_FIELDS_FEC_REQ, cap_data_raw, cap_mask_sw,
+	    &supported, &cap_enum_hw);
+
+	if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0 && supported == B_FALSE) {
+		rc = ENOTSUP;
+		goto fail5;
+	}
+
+	EFSYS_ASSERT(cap_enum_hw <= UINT8_MAX);
+	fec = cap_enum_hw;
+
+	MCDI_IN_SET_WORD(req, LINK_CTRL_IN_LINK_TECHNOLOGY, link_tech);
+	MCDI_IN_SET_DWORD(req, LINK_CTRL_IN_CONTROL_FLAGS, flags);
+	MCDI_IN_SET_BYTE(req, LINK_CTRL_IN_LOOPBACK, loopback);
+	MCDI_IN_SET_BYTE(req, LINK_CTRL_IN_FEC_MODE, fec);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail6;
+	}
+
+	return (0);
+
+fail6:
+	EFSYS_PROBE(fail6);
+
+fail5:
+	EFSYS_PROBE(fail5);
+
+fail4:
+	EFSYS_PROBE(fail4);
+
+fail3:
+	EFSYS_PROBE(fail3);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index 0f748e32a4..e3b9d20d59 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -72,7 +72,7 @@ static const efx_phy_ops_t	__efx_phy_rhead_ops = {
 static const efx_phy_ops_t	__efx_phy_medford4_ops = {
 	medford4_phy_power,		/* epo_power */
 	NULL,				/* epo_reset */
-	ef10_phy_reconfigure,		/* epo_reconfigure */
+	medford4_phy_reconfigure,	/* epo_reconfigure */
 	medford4_phy_verify,		/* epo_verify */
 	ef10_phy_oui_get,		/* epo_oui_get */
 	medford4_phy_link_state_get,	/* epo_link_state_get */
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index f24c9d1e6c..795fd45bd4 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -34,6 +34,11 @@ medford4_phy_link_state_get(
 	__in			efx_nic_t *enp,
 	__out			efx_phy_link_state_t *eplsp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn		efx_rc_t
+medford4_phy_reconfigure(
+	__in			efx_nic_t *enp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 6a61645384..cc4e77587b 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -83,6 +83,71 @@ medford4_phy_link_state_get(
 	*eplsp = els.epls;
 	return (0);
 
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn		efx_rc_t
+medford4_phy_reconfigure(
+	__in			efx_nic_t *enp)
+{
+	efx_link_mode_t loopback_link_mode;
+	efx_port_t *epp = &(enp->en_port);
+	efx_loopback_type_t loopback;
+	efx_phy_led_mode_t led;
+	boolean_t supported;
+	efx_rc_t rc;
+
+	rc = efx_mcdi_link_control_supported(enp, &supported);
+	if (rc != 0)
+		goto fail1;
+
+	if (supported == B_FALSE)
+		goto exit;
+
+#if EFSYS_OPT_LOOPBACK
+	loopback_link_mode = epp->ep_loopback_link_mode;
+	loopback = epp->ep_loopback_type;
+#else /* ! EFSYS_OPT_LOOPBACK */
+	loopback_link_mode = EFX_LINK_UNKNOWN;
+	loopback = EFX_LOOPBACK_OFF;
+#endif /* EFSYS_OPT_LOOPBACK */
+
+	rc = efx_np_link_ctrl(enp, epp->ep_np_handle, epp->ep_np_cap_data_raw,
+		    loopback_link_mode, loopback, epp->ep_adv_cap_mask,
+		    epp->ep_fcntl_autoneg);
+	if (rc != 0)
+		goto fail2;
+
+#if EFSYS_OPT_PHY_LED_CONTROL
+	led = epp->ep_phy_led_mode;
+#else /* ! EFSYS_OPT_PHY_LED_CONTROL */
+	led = EFX_PHY_LED_DEFAULT;
+#endif /* EFSYS_OPT_PHY_LED_CONTROL */
+
+	rc = efx_mcdi_phy_set_led(enp, led);
+	if (rc != 0) {
+		/*
+		 * If LED control is not supported by firmware, we can
+		 * silently ignore default mode set failure
+		 * (see FWRIVERHD-198).
+		 */
+		if (rc == EOPNOTSUPP && led == EFX_PHY_LED_DEFAULT)
+			goto exit;
+
+		goto fail3;
+	}
+
+exit:
+	return (0);
+
+fail3:
+	EFSYS_PROBE(fail3);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
-- 
2.39.5

