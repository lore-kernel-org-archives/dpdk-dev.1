Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157ABC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BECB40DD1;
	Wed, 23 Apr 2025 18:00:41 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3375A40B8C
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 82B28E0343;
 Wed, 23 Apr 2025 20:00:32 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 82B28E0343
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424033;
 bh=g3raMFSK898M+OatlIXh15Z6RV0Tj6RslxHV5tDVUwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=16FnmfV38cOaR+UajuG0CIgJzewI+R0LtMgkIg0EHDmfmesZudHSLo1lqPyD+57zl
 RIBLiKiEB/Awmo2+d9NVQFdwEuOm67o/eZR8Gdf0dnHXpXTpDSUEVB9O7ON5m/qpET
 FnQO3p+/q1quxAUHHt/w+OpM7Y+RjO82fwJxYlWvgurOEz5L2U0JExHYZYwy7VrAUR
 4AV+NfXz9VTfMBN12z6+Z6zMZSQI0x9lQO9KmIPsXC3KatJM2EJL1Osgw1MYeOn0bh
 F4kBEKMnDVNaAhBGVlydcvvvrRPsvutwiaeU0d7K2EKoD0qxCYJD8U3wNlgLM53v+U
 ZM0WwJzorCPyg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 25/45] common/sfc_efx/base: fill in loopback modes on
 netport probe
Date: Wed, 23 Apr 2025 19:59:42 +0400
Message-Id: <20250423160002.35706-26-ivan.malov@arknetworks.am>
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

Indicate support for some of the loopback modes known to EFX.
Such have been technology-dependent, but, on netport capable
NICs, they are backed by new generic modes, that are tied to
the stages in the processing chain where loopback can happen.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx.h      |   1 +
 drivers/common/sfc_efx/base/efx_impl.h |   2 +
 drivers/common/sfc_efx/base/efx_np.c   | 157 ++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 2c6af5f6b5..7ffa1f4cbd 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -655,6 +655,7 @@ typedef enum efx_link_mode_e {
 	EFX_LINK_25000FDX,
 	EFX_LINK_50000FDX,
 	EFX_LINK_100000FDX,
+	EFX_LINK_200000FDX,
 	EFX_LINK_NMODES
 } efx_link_mode_t;
 
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index a3e60fd19b..3a9c6fe3fd 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -382,6 +382,8 @@ typedef struct efx_port_s {
 	const efx_phy_ops_t	*ep_epop;
 
 	efx_np_handle_t		ep_np_handle;
+	efx_qword_t		ep_np_loopback_cap_mask;
+	uint8_t			ep_np_cap_data_raw[MC_CMD_ETH_AN_FIELDS_LEN];
 } efx_port_t;
 
 typedef struct efx_mon_ops_s {
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index eac3bb06ee..1b670435db 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -232,7 +232,9 @@ static	__checkReturn		efx_rc_t
 efx_np_get_fixed_port_props(
 	__in			efx_nic_t *enp,
 	__in			efx_np_handle_t nph,
-	__out_opt		uint32_t *sup_cap_maskp)
+	__out_opt		uint8_t *sup_cap_rawp,
+	__out_opt		uint32_t *sup_cap_maskp,
+	__out_opt		efx_qword_t *loopback_cap_maskp)
 {
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN,
@@ -268,6 +270,18 @@ efx_np_get_fixed_port_props(
 	if (sup_cap_maskp != NULL)
 		efx_np_cap_hw_data_to_sw_mask(cap_data, sup_cap_maskp);
 
+	if (sup_cap_rawp != NULL) {
+		memcpy(sup_cap_rawp,
+		    MCDI_OUT2(req, const uint8_t,
+			    GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES),
+		    MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_LEN);
+	}
+
+	if (loopback_cap_maskp != NULL) {
+		*loopback_cap_maskp = *MCDI_OUT2(req, efx_qword_t,
+		    GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2);
+	}
+
 	return (0);
 
 fail2:
@@ -333,6 +347,139 @@ efx_np_link_state(
 	return (rc);
 }
 
+#if EFSYS_OPT_LOOPBACK
+static	__checkReturn		efx_rc_t
+efx_np_sw_link_mode_to_cap(
+	__in			efx_link_mode_t link_mode,
+	__out			uint16_t *capp)
+{
+	switch (link_mode) {
+	case EFX_LINK_1000FDX:
+		*capp = EFX_PHY_CAP_1000FDX;
+		break;
+	case EFX_LINK_10000FDX:
+		*capp = EFX_PHY_CAP_10000FDX;
+		break;
+	case EFX_LINK_40000FDX:
+		*capp = EFX_PHY_CAP_40000FDX;
+		break;
+	case EFX_LINK_25000FDX:
+		*capp = EFX_PHY_CAP_25000FDX;
+		break;
+	case EFX_LINK_50000FDX:
+		*capp = EFX_PHY_CAP_50000FDX;
+		break;
+	case EFX_LINK_100000FDX:
+		*capp = EFX_PHY_CAP_100000FDX;
+		break;
+	case EFX_LINK_200000FDX:
+		*capp = EFX_PHY_CAP_200000FDX;
+		break;
+	default:
+		return (EINVAL);
+	}
+
+	return (0);
+}
+
+static					void
+efx_np_cap_enum_sw_to_hw(
+	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
+	__in				unsigned int hw_sw_map_nentries,
+	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
+	__in				size_t hw_cap_data_nbytes,
+	__in				uint16_t enum_sw,
+	__out				boolean_t *supportedp,
+	__out_opt			uint16_t *enum_hwp)
+{
+	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
+	    hw_cap_data, hw_cap_data_nbytes) {
+		if (hw_sw_map->encm_sw != enum_sw)
+			continue;
+
+		if (enum_hwp != NULL)
+			*enum_hwp = hw_sw_map->encm_hw;
+
+		*supportedp = B_TRUE;
+		return;
+	}
+
+	*supportedp = B_FALSE;
+}
+
+/*
+ * Convert the given EFX PHY capability enum value to the HW counterpart,
+ * provided that the capability is supported by the HW, where the latter
+ * is detected from the given fraction of raw HW netport capability data.
+ *
+ * As the mapping of a capability from EFX to HW can be one to many, use
+ * the first supported HW capability bit, in accordance with the HW data.
+ */
+#define	EFX_NP_CAP_ENUM_SW_TO_HW(						\
+	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
+	    _enum_sw, _supportedp, _enum_hwp)				\
+	efx_np_cap_enum_sw_to_hw((_hw_sw_cap_map),			\
+	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
+	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
+		    MC_CMD_##_hw_cap_section),				\
+	    MC_CMD_##_hw_cap_section##_LEN, (_enum_sw),			\
+	    (_supportedp), (_enum_hwp))
+
+static				void
+efx_np_assign_loopback_props(
+	__in			efx_nic_t *enp)
+{
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
+	efx_port_t *epp = &(enp->en_port);
+	efx_qword_t lbm_off;
+	efx_qword_t lbm_sup;
+	unsigned int i;
+
+	EFX_ZERO_QWORD(lbm_off);
+	EFX_SET_QWORD_BIT(lbm_off, EFX_LOOPBACK_OFF);
+
+	/*
+	 * Netport MCDI capable NICs support loopback modes which are
+	 * generalisations of the existing modes that specify roughly
+	 * where in the processing chain the loopback occurs, without
+	 * the need to refer to the specific technology. Provide some
+	 * to users under the guise of older technology-specific ones.
+	 */
+	EFX_ZERO_QWORD(lbm_sup);
+	EFX_SET_QWORD_BIT(lbm_sup, EFX_LOOPBACK_OFF);
+
+	if (EFX_TEST_QWORD_BIT(epp->ep_np_loopback_cap_mask,
+			    MC_CMD_LOOPBACK_V2_AUTO))
+		EFX_SET_QWORD_BIT(lbm_sup, EFX_LOOPBACK_DATA);
+
+	if (EFX_TEST_QWORD_BIT(epp->ep_np_loopback_cap_mask,
+			    MC_CMD_LOOPBACK_V2_POST_PCS))
+		EFX_SET_QWORD_BIT(lbm_sup, EFX_LOOPBACK_PCS);
+
+	for (i = 0; i < EFX_ARRAY_SIZE(encp->enc_loopback_types); ++i) {
+		boolean_t supported = B_FALSE;
+		uint16_t cap_enum_sw;
+		efx_rc_t rc;
+
+		rc = efx_np_sw_link_mode_to_cap(i, &cap_enum_sw);
+		if (rc != 0) {
+			/* No support for this link mode => no loopbacks. */
+			encp->enc_loopback_types[i] = lbm_off;
+			continue;
+		}
+
+		EFX_NP_CAP_ENUM_SW_TO_HW(efx_np_cap_map_tech,
+		    ETH_AN_FIELDS_TECH_MASK, epp->ep_np_cap_data_raw,
+		    cap_enum_sw, &supported, NULL);
+
+		if (supported != B_FALSE)
+			encp->enc_loopback_types[i] = lbm_sup;
+		else
+			encp->enc_loopback_types[i] = lbm_off;
+	}
+}
+#endif /* EFSYS_OPT_LOOPBACK */
+
 	__checkReturn	efx_rc_t
 efx_np_attach(
 	__in		efx_nic_t *enp)
@@ -367,7 +514,8 @@ efx_np_attach(
 	 * don't necessarily have access to these details.
 	 */
 	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
-		    &epp->ep_phy_cap_mask);
+		    epp->ep_np_cap_data_raw, &epp->ep_phy_cap_mask,
+		    &epp->ep_np_loopback_cap_mask);
 	if (rc != 0)
 		goto fail2;
 
@@ -379,6 +527,11 @@ efx_np_attach(
 		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
 
 	epp->ep_adv_cap_mask = ls.enls_adv_cap_mask;
+
+#if EFSYS_OPT_LOOPBACK
+	efx_np_assign_loopback_props(enp);
+#endif /* EFSYS_OPT_LOOPBACK */
+
 	return (0);
 
 fail3:
-- 
2.39.5

