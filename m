Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE91C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8060040ED1;
	Wed, 23 Apr 2025 18:01:01 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 43E2C40E1C
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 8386EE02AA;
 Wed, 23 Apr 2025 20:00:46 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 8386EE02AA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424047;
 bh=1dkHrXvWgC9fcL/RmMoHSLVW5QzJZtPNDoOWaFBH9lY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oalSq4xkX2GhRFFiQGdRUCnJRA1iq66k2n7pLMFHSsB5Mw4OoxLqWmslK2SV6bUbh
 /m+H8ptm5+KzvnqDDnOrEiPh5HbRuUAfVI1eKfO2i1+qPSfrZXjUknevE1HSp0M6+1
 7re1aH3PFLe14z/IESqWVreaGvkOZerMvdU9PxcN04J5LGibsgRcTHgjBZg5jMfoKg
 LY5YBbaPIWfe4ANGnw/YofBc16qOsTfUWS5WIq0xLh2sk0niBQem0A3KvFO5SX7n+e
 VLJyXw5+qogztP5d7xpf4CqwnQhJzbncXFcodM7wq/enMWI9tMsa/DADQXP/s0Pi39
 yTAZP56wofYnw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 43/45] common/sfc_efx/base: support controls for netport
 lane count
Date: Wed, 23 Apr 2025 20:00:00 +0400
Message-Id: <20250423160002.35706-44-ivan.malov@arknetworks.am>
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

On netport MCDI capable adaptors, link modes exported by libefx can be
backed by different technologies with different lane counts. Allow the
client drivers to get and set the lane count and query possible values.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_phy.c     |   2 +
 drivers/common/sfc_efx/base/efx.h          |  29 ++++
 drivers/common/sfc_efx/base/efx_impl.h     |   4 +
 drivers/common/sfc_efx/base/efx_np.c       | 189 +++++++++++++++++++--
 drivers/common/sfc_efx/base/efx_phy.c      |  62 ++++++-
 drivers/common/sfc_efx/base/efx_port.c     |   1 +
 drivers/common/sfc_efx/base/medford4_phy.c |   5 +-
 drivers/common/sfc_efx/sfc_base_symbols.c  |   1 +
 8 files changed, 278 insertions(+), 15 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_phy.c b/drivers/common/sfc_efx/base/ef10_phy.c
index 114543e156..aaad105735 100644
--- a/drivers/common/sfc_efx/base/ef10_phy.c
+++ b/drivers/common/sfc_efx/base/ef10_phy.c
@@ -338,6 +338,8 @@ ef10_phy_get_link(
 			    fec, &elsp->epls.epls_link_mode,
 			    &elsp->epls.epls_fcntl, &elsp->epls.epls_fec);
 
+	elsp->epls.epls_lane_count = EFX_PHY_LANE_COUNT_DEFAULT;
+
 	if (req.emr_out_length_used < MC_CMD_GET_LINK_OUT_V2_LEN) {
 		elsp->epls.epls_ld_cap_mask = 0;
 	} else {
diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 7b43a89551..8958f1b170 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -1266,6 +1266,28 @@ efx_phy_lp_cap_get(
 	__in		efx_nic_t *enp,
 	__out		uint32_t *maskp);
 
+typedef enum efx_phy_lane_count_e {
+	EFX_PHY_LANE_COUNT_DEFAULT = 0,
+	EFX_PHY_LANE_COUNT_1 = 1,
+	EFX_PHY_LANE_COUNT_2 = 2,
+	EFX_PHY_LANE_COUNT_4 = 4,
+	EFX_PHY_LANE_COUNT_10 = 10,
+	EFX_PHY_LANE_COUNT_NTYPES,
+} efx_phy_lane_count_t;
+
+/*
+ * Instruct the port to use the specified lane count. For this to work, the
+ * active subset of advertised link modes must include at least one mode that
+ * supports this value. This API works only on netport MCDI capable adaptors.
+ *
+ * To query the current lane count, use efx_phy_link_state_get().
+ */
+LIBEFX_API
+extern	__checkReturn	efx_rc_t
+efx_phy_lane_count_set(
+	__in		efx_nic_t *enp,
+	__in		efx_phy_lane_count_t lane_count);
+
 LIBEFX_API
 extern	__checkReturn	efx_rc_t
 efx_phy_oui_get(
@@ -1760,6 +1782,12 @@ typedef struct efx_nic_cfg_s {
 	 * to have exact speed/duplex, efx_port_poll() needs to be invoked.
 	 */
 	boolean_t		enc_link_ev_need_poll;
+	/*
+	 * An array of masks to tell which link mode supports which lane counts.
+	 * For bit definitions, see 'efx_phy_lane_count_t'. It is only filled in
+	 * on netport MCDI capable adaptors.
+	 */
+	efx_dword_t		enc_phy_lane_counts[EFX_LINK_NMODES];
 } efx_nic_cfg_t;
 
 #define	EFX_PCI_VF_INVALID 0xffff
@@ -4072,6 +4100,7 @@ typedef struct efx_phy_link_state_s {
 	unsigned int		epls_fcntl;
 	efx_phy_fec_type_t	epls_fec;
 	efx_link_mode_t		epls_link_mode;
+	efx_phy_lane_count_t	epls_lane_count;
 } efx_phy_link_state_t;
 
 LIBEFX_API
diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 43964ccdba..69268546d2 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -396,6 +396,8 @@ typedef struct efx_port_s {
 	uint8_t			ep_np_cap_data_raw[MC_CMD_ETH_AN_FIELDS_LEN];
 	/* Lookup table providing DMA buffer field IDs by EFX statistic IDs. */
 	efx_np_stat_t		ep_np_mac_stat_lut[EFX_MAC_NSTATS];
+	/* Client-requested lane count for the physical link. */
+	efx_phy_lane_count_t	ep_np_lane_count_req;
 } efx_port_t;
 
 typedef struct efx_mon_ops_s {
@@ -1916,6 +1918,7 @@ efx_np_detach(
 typedef struct efx_np_link_state_s {
 	uint32_t		enls_adv_cap_mask;
 	uint32_t		enls_lp_cap_mask;
+	efx_phy_lane_count_t	enls_lane_count;
 	efx_loopback_type_t	enls_loopback;
 	uint32_t		enls_speed;
 	uint8_t			enls_fec;
@@ -1953,6 +1956,7 @@ efx_np_link_ctrl(
 	__in		const uint8_t *cap_mask_sup_raw,
 	__in		efx_link_mode_t loopback_link_mode,
 	__in		efx_loopback_type_t loopback_mode,
+	__in		efx_phy_lane_count_t lane_count,
 	__in		uint32_t cap_mask_sw,
 	__in		boolean_t fcntl_an);
 
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 3cefdda0e9..a19c986691 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -86,6 +86,7 @@ struct efx_np_cap_map {
 	uint16_t	encm_sw;
 };
 
+/* NOTE: keep this in sync with 'efx_np_tech_to_lane_count'. */
 static const struct efx_np_cap_map efx_np_cap_map_tech[] = {
 	/* 1G */
 	{ MC_CMD_ETH_TECH_1000BASEKX, EFX_PHY_CAP_1000FDX },
@@ -292,6 +293,71 @@ efx_np_get_fixed_port_props(
 	return (rc);
 }
 
+static efx_phy_lane_count_t efx_np_tech_to_lane_count[] = {
+	/* 1G */
+	[MC_CMD_ETH_TECH_1000BASEKX] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_1000BASEX] = EFX_PHY_LANE_COUNT_1,
+
+	/* 10G */
+	[MC_CMD_ETH_TECH_10GBASE_KR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_10GBASE_CR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_10GBASE_SR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_10GBASE_LR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_10GBASE_LRM] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_10GBASE_ER] = EFX_PHY_LANE_COUNT_1,
+
+	/* 25GBASE */
+	[MC_CMD_ETH_TECH_25GBASE_CR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_25GBASE_KR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_25GBASE_SR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_25GBASE_LR_ER] = EFX_PHY_LANE_COUNT_1,
+
+	/* 40G */
+	[MC_CMD_ETH_TECH_40GBASE_KR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_40GBASE_CR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_40GBASE_SR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_40GBASE_LR4] = EFX_PHY_LANE_COUNT_4,
+
+	/* 50G */
+	[MC_CMD_ETH_TECH_50GBASE_CR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_50GBASE_KR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_50GBASE_SR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_50GBASE_KR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_50GBASE_SR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_50GBASE_CR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_50GBASE_LR_ER_FR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_50GBASE_DR] = EFX_PHY_LANE_COUNT_1,
+
+	/* 100G */
+	[MC_CMD_ETH_TECH_100GBASE_KR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_100GBASE_SR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_100GBASE_CR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_100GBASE_LR4_ER4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_100GBASE_KR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_100GBASE_SR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_100GBASE_CR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_100GBASE_LR2_ER2_FR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_100GBASE_DR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_100GBASE_KR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_100GBASE_SR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_100GBASE_LR_ER_FR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_100GBASE_CR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_100GBASE_DR] = EFX_PHY_LANE_COUNT_1,
+	[MC_CMD_ETH_TECH_100GBASE_CR10] = EFX_PHY_LANE_COUNT_10,
+
+	/* 200G */
+	[MC_CMD_ETH_TECH_200GBASE_KR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_200GBASE_SR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_200GBASE_LR4_ER4_FR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_200GBASE_DR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_200GBASE_CR4] = EFX_PHY_LANE_COUNT_4,
+	[MC_CMD_ETH_TECH_200GBASE_KR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_200GBASE_SR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_200GBASE_LR2_ER2_FR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_200GBASE_DR2] = EFX_PHY_LANE_COUNT_2,
+	[MC_CMD_ETH_TECH_200GBASE_CR2] = EFX_PHY_LANE_COUNT_2,
+};
+
 	__checkReturn	efx_rc_t
 efx_np_link_state(
 	__in		efx_nic_t *enp,
@@ -304,6 +370,7 @@ efx_np_link_state(
 	uint32_t status_flags;
 	efx_mcdi_req_t req;
 	uint32_t v3_flags;
+	uint16_t tech;
 	efx_rc_t rc;
 
 	req.emr_out_length = MC_CMD_LINK_STATE_OUT_V3_LEN;
@@ -378,6 +445,13 @@ efx_np_link_state(
 		    LINK_STATE_OUT_LINK_PARTNER_ABILITIES),
 	    &lsp->enls_lp_cap_mask);
 
+	tech = MCDI_OUT_WORD(req, LINK_STATE_OUT_LINK_TECHNOLOGY);
+
+	if (tech < EFX_ARRAY_SIZE(efx_np_tech_to_lane_count))
+		lsp->enls_lane_count = efx_np_tech_to_lane_count[tech];
+	else
+		lsp->enls_lane_count = EFX_PHY_LANE_COUNT_DEFAULT;
+
 	return (0);
 
 #if EFSYS_OPT_LOOPBACK
@@ -526,6 +600,53 @@ efx_np_assign_loopback_props(
 }
 #endif /* EFSYS_OPT_LOOPBACK */
 
+static				void
+efx_np_assign_lane_counts(
+	__in			efx_nic_t *enp)
+{
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
+	efx_port_t *epp = &(enp->en_port);
+	unsigned int i;
+
+	for (i = 0; i < EFX_ARRAY_SIZE(encp->enc_phy_lane_counts); ++i) {
+		const struct efx_np_cap_map *map = efx_np_cap_map_tech;
+		uint16_t cap_enum_sw;
+		efx_dword_t dword;
+		efx_rc_t rc;
+
+		EFX_ZERO_DWORD(dword);
+
+		rc = efx_np_sw_link_mode_to_cap(i, &cap_enum_sw);
+		if (rc != 0) {
+			/* No support for this link mode => no lane counts. */
+			encp->enc_phy_lane_counts[i] = dword;
+			continue;
+		}
+
+		FOREACH_SUP_CAP(map,
+		    EFX_ARRAY_SIZE(efx_np_cap_map_tech),
+		    MCDI_STRUCT_MEMBER(epp->ep_np_cap_data_raw, const uint8_t,
+			    MC_CMD_ETH_AN_FIELDS_TECH_MASK),
+		    MC_CMD_ETH_AN_FIELDS_TECH_MASK_LEN) {
+			efx_phy_lane_count_t lane_count;
+
+			if (map->encm_sw != cap_enum_sw)
+				continue;
+
+			if (map->encm_hw >=
+			    EFX_ARRAY_SIZE(efx_np_tech_to_lane_count))
+				continue;
+
+			lane_count = efx_np_tech_to_lane_count[map->encm_hw];
+
+			if (lane_count != EFX_PHY_LANE_COUNT_DEFAULT)
+				EFX_SET_DWORD_BIT(dword, lane_count);
+		}
+
+		encp->enc_phy_lane_counts[i] = dword;
+	}
+}
+
 #if EFSYS_OPT_MAC_STATS
 /* HW statistic IDs, as per MC_CMD_MAC_STATISTICS_DESCRIPTOR format. */
 #define	EFX_NP_HW_STAT_ID(_src, _idx)					\
@@ -889,6 +1010,8 @@ efx_np_attach(
 	efx_np_assign_loopback_props(enp);
 #endif /* EFSYS_OPT_LOOPBACK */
 
+	efx_np_assign_lane_counts(enp);
+
 #if EFSYS_OPT_MAC_STATS
 	rc = efx_np_stats_assign(enp);
 	if (rc != 0)
@@ -993,6 +1116,13 @@ efx_np_mac_state(
 	return (rc);
 }
 
+/* Filter callback for capability lookups. Return 'B_FALSE' to skip the enum. */
+typedef			boolean_t
+(efx_np_cap_filter_cb)(
+	__in		uint16_t enum_hw,
+	__in		void *arg);
+
+
 static					void
 efx_np_cap_mask_sw_to_hw(
 	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
@@ -1000,6 +1130,8 @@ efx_np_cap_mask_sw_to_hw(
 	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
 	__in				size_t hw_cap_data_nbytes,
 	__in				uint32_t mask_sw,
+	__in_opt			efx_np_cap_filter_cb *filter_cb,
+	__in_opt			void *filter_arg,
 	__out				uint8_t *mask_hwp)
 {
 	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
@@ -1009,6 +1141,10 @@ efx_np_cap_mask_sw_to_hw(
 		if ((mask_sw & flag_sw) != flag_sw)
 			continue;
 
+		if (filter_cb != NULL &&
+		    filter_cb(hw_sw_map->encm_hw, filter_arg) == B_FALSE)
+			continue;
+
 		mask_hwp[CAP_BYTE(hw_sw_map)] |= CAP_FLAG(hw_sw_map);
 		mask_sw &= ~(flag_sw);
 	}
@@ -1024,16 +1160,18 @@ efx_np_cap_mask_sw_to_hw(
  *
  * Do not check the input mask for leftover bits (unknown to EFX), as
  * inputs should have been validated by efx_phy_adv_cap_set() already.
+ *
+ * It is possible to use a callback to filter out certain mappings.
  */
 #define	EFX_NP_CAP_MASK_SW_TO_HW(					\
 	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
-	    _mask_sw, _mask_hwp)					\
+	    _mask_sw, _filter_cb, _filter_arg, _mask_hwp)		\
 	efx_np_cap_mask_sw_to_hw((_hw_sw_cap_map),			\
 	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
 	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
 		    MC_CMD_##_hw_cap_section),				\
-	    MC_CMD_##_hw_cap_section##_LEN,				\
-	    (_mask_sw), (_mask_hwp))
+	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
+	    (_filter_cb), (_filter_arg), (_mask_hwp))
 
 static					void
 efx_np_cap_sw_mask_to_hw_enum(
@@ -1042,6 +1180,8 @@ efx_np_cap_sw_mask_to_hw_enum(
 	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
 	__in				size_t hw_cap_data_nbytes,
 	__in				uint32_t mask_sw,
+	__in_opt			efx_np_cap_filter_cb *filter_cb,
+	__in_opt			void *filter_arg,
 	__out				boolean_t *supportedp,
 	__out_opt			uint16_t *enum_hwp)
 {
@@ -1067,10 +1207,14 @@ efx_np_cap_sw_mask_to_hw_enum(
 			sw_check_mask |= flag_sw;
 
 			if ((hw_cap_data[byte_idx] & flag_hw) == flag_hw) {
-				mask_sw &= ~(flag_sw);
-
-				if (enum_hwp != NULL)
-					*enum_hwp = hw_sw_map->encm_hw;
+				if (filter_cb == NULL ||
+				    filter_cb(hw_sw_map->encm_hw, filter_arg) !=
+				    B_FALSE) {
+					mask_sw &= ~(flag_sw);
+
+					if (enum_hwp != NULL)
+						*enum_hwp = hw_sw_map->encm_hw;
+				}
 			}
 		}
 
@@ -1090,17 +1234,39 @@ efx_np_cap_sw_mask_to_hw_enum(
  * Convert (conceivably) the only EFX capability bit of the given mask to
  * the HW enum value, provided that the capability is supported by the HW,
  * where the latter follows from the given fraction of HW capability data.
+ *
+ * It is possible to use a callback to filter out certain mappings.
  */
 #define	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(					\
 	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
-	    _mask_sw, _supportedp, _enum_hwp)				\
+	    _mask_sw, _filter_cb, _filter_arg, _supportedp, _enum_hwp)	\
 	efx_np_cap_sw_mask_to_hw_enum((_hw_sw_cap_map),			\
 	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
 	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
 		    MC_CMD_##_hw_cap_section),				\
 	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
+	    (_filter_cb), (_filter_arg),				\
 	    (_supportedp), (_enum_hwp))
 
+static					boolean_t
+efx_np_filter_tech_by_lane_count_cb(
+	__in				uint16_t enum_hw,
+	__in				void *arg)
+{
+	efx_phy_lane_count_t lane_count = *((efx_phy_lane_count_t *)arg);
+
+	if (lane_count == EFX_PHY_LANE_COUNT_DEFAULT)
+		return B_TRUE;
+
+	if (enum_hw >= EFX_ARRAY_SIZE(efx_np_tech_to_lane_count))
+		return B_FALSE;
+
+	if (efx_np_tech_to_lane_count[enum_hw] != lane_count)
+		return B_FALSE;
+
+	return B_TRUE;
+}
+
 	__checkReturn	efx_rc_t
 efx_np_link_ctrl(
 	__in		efx_nic_t *enp,
@@ -1108,6 +1274,7 @@ efx_np_link_ctrl(
 	__in		const uint8_t *cap_data_raw,
 	__in		efx_link_mode_t loopback_link_mode,
 	__in		efx_loopback_type_t loopback_mode,
+	__in		efx_phy_lane_count_t lane_count,
 	__in		uint32_t cap_mask_sw,
 	__in		boolean_t fcntl_an)
 {
@@ -1176,12 +1343,13 @@ efx_np_link_ctrl(
 	} else if (cap_mask_sw & (1U << EFX_PHY_CAP_AN)) {
 		EFX_NP_CAP_MASK_SW_TO_HW(efx_np_cap_map_tech,
 		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    efx_np_filter_tech_by_lane_count_cb, &lane_count,
 		    cap_mask_hw_techp);
 
 		if (fcntl_an != B_FALSE) {
 			EFX_NP_CAP_MASK_SW_TO_HW(efx_np_cap_map_pause,
 			    ETH_AN_FIELDS_PAUSE_MASK, cap_data_raw, cap_mask_sw,
-			    cap_mask_hw_pausep);
+			    NULL, NULL, cap_mask_hw_pausep);
 		}
 
 		flags |= 1U << MC_CMD_LINK_FLAGS_AUTONEG_EN;
@@ -1189,6 +1357,7 @@ efx_np_link_ctrl(
 	} else {
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_tech,
 		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    efx_np_filter_tech_by_lane_count_cb, &lane_count,
 		    &supported, &link_tech);
 
 		if (supported == B_FALSE) {
@@ -1209,7 +1378,7 @@ efx_np_link_ctrl(
 	 */
 	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
 	    ETH_AN_FIELDS_FEC_REQ, cap_data_raw, cap_mask_sw,
-	    &supported, &cap_enum_hw);
+	    NULL, NULL, &supported, &cap_enum_hw);
 
 	if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0 && supported == B_FALSE) {
 		rc = ENOTSUP;
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index e3b9d20d59..1f99c72e62 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -262,6 +262,12 @@ efx_phy_adv_cap_set(
 		goto fail1;
 	}
 
+	if (efx_np_supported(enp) == B_FALSE &&
+	    epp->ep_np_lane_count_req != EFX_PHY_LANE_COUNT_DEFAULT) {
+		rc = ENOTSUP;
+		goto fail2;
+	}
+
 	if (epp->ep_adv_cap_mask == mask)
 		goto done;
 
@@ -269,13 +275,13 @@ efx_phy_adv_cap_set(
 	epp->ep_adv_cap_mask = mask;
 
 	if ((rc = epop->epo_reconfigure(enp)) != 0)
-		goto fail2;
+		goto fail3;
 
 done:
 	return (0);
 
-fail2:
-	EFSYS_PROBE(fail2);
+fail3:
+	EFSYS_PROBE(fail3);
 
 	epp->ep_adv_cap_mask = old_mask;
 	/* Reconfigure for robustness */
@@ -287,6 +293,9 @@ efx_phy_adv_cap_set(
 		EFSYS_ASSERT(0);
 	}
 
+fail2:
+	EFSYS_PROBE(fail2);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 
@@ -306,6 +315,53 @@ efx_phy_lp_cap_get(
 	*maskp = epp->ep_lp_cap_mask;
 }
 
+	__checkReturn	efx_rc_t
+efx_phy_lane_count_set(
+	__in		efx_nic_t *enp,
+	__in		efx_phy_lane_count_t lane_count)
+{
+	efx_port_t *epp = &(enp->en_port);
+	const efx_phy_ops_t *epop = epp->ep_epop;
+	efx_phy_lane_count_t lane_count_prev = epp->ep_np_lane_count_req;
+	efx_rc_t rc;
+
+	EFSYS_ASSERT3U(enp->en_magic, ==, EFX_NIC_MAGIC);
+	EFSYS_ASSERT3U(enp->en_mod_flags, &, EFX_MOD_PROBE);
+
+	if (lane_count == lane_count_prev)
+		return 0;
+
+	if (efx_np_supported(enp) == B_FALSE) {
+		rc = ENOTSUP;
+		goto fail1;
+	}
+
+	if (lane_count >= EFX_PHY_LANE_COUNT_NTYPES) {
+		rc = EINVAL;
+		goto fail2;
+	}
+
+	epp->ep_np_lane_count_req = lane_count;
+
+	rc = epop->epo_reconfigure(enp);
+	if (rc != 0) {
+		epp->ep_np_lane_count_req = lane_count_prev;
+		goto fail3;
+	}
+
+	return (0);
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
+
 	__checkReturn	efx_rc_t
 efx_phy_oui_get(
 	__in		efx_nic_t *enp,
diff --git a/drivers/common/sfc_efx/base/efx_port.c b/drivers/common/sfc_efx/base/efx_port.c
index 389efb2fe9..7e514e92dd 100644
--- a/drivers/common/sfc_efx/base/efx_port.c
+++ b/drivers/common/sfc_efx/base/efx_port.c
@@ -26,6 +26,7 @@ efx_port_init(
 
 	enp->en_mod_flags |= EFX_MOD_PORT;
 
+	epp->ep_np_lane_count_req = EFX_PHY_LANE_COUNT_DEFAULT;
 	epp->ep_mac_type = EFX_MAC_INVALID;
 	epp->ep_link_mode = EFX_LINK_UNKNOWN;
 	epp->ep_mac_drain = B_TRUE;
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index cc4e77587b..9ba6dfbc10 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -43,6 +43,7 @@ medford4_phy_get_link(
 
 	elsp->epls.epls_adv_cap_mask = ls.enls_adv_cap_mask;
 	elsp->epls.epls_lp_cap_mask = ls.enls_lp_cap_mask;
+	elsp->epls.epls_lane_count = ls.enls_lane_count;
 	elsp->els_loopback = ls.enls_loopback;
 
 	rc = efx_np_mac_state(enp, nph, &ms);
@@ -115,8 +116,8 @@ medford4_phy_reconfigure(
 #endif /* EFSYS_OPT_LOOPBACK */
 
 	rc = efx_np_link_ctrl(enp, epp->ep_np_handle, epp->ep_np_cap_data_raw,
-		    loopback_link_mode, loopback, epp->ep_adv_cap_mask,
-		    epp->ep_fcntl_autoneg);
+		    loopback_link_mode, loopback, epp->ep_np_lane_count_req,
+		    epp->ep_adv_cap_mask, epp->ep_fcntl_autoneg);
 	if (rc != 0)
 		goto fail2;
 
diff --git a/drivers/common/sfc_efx/sfc_base_symbols.c b/drivers/common/sfc_efx/sfc_base_symbols.c
index 0e74034031..bbb6f39924 100644
--- a/drivers/common/sfc_efx/sfc_base_symbols.c
+++ b/drivers/common/sfc_efx/sfc_base_symbols.c
@@ -195,6 +195,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_map)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_verify)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_get)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_set)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lane_count_set)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lp_cap_get)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_oui_get)
 RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_media_type_get)
-- 
2.39.5

