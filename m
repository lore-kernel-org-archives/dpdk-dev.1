Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB9C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:03:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F00D41149;
	Wed, 16 Apr 2025 16:00:56 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 7416A41143
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BB094E0872;
 Wed, 16 Apr 2025 18:00:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BB094E0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812049;
 bh=OFKOXTRZm6V2uAZgvyJxk3LGNoV7APALAoL1OljGli4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pJAvwuy8qAm96WN2wk1ZDH9A/0ZTT2OLE1iw8zU1ZIrbWgQuVmqn+i8vEluCfT+gQ
 954DdlDrSHqB+936vvmcUSEe+BBWHNkvGOj+i5Z+b6Cr1XKCxJ8Ny6EVAqgSOvDh1z
 7xvUXKrAUbXCPcV8IlDQgSrvktARlDuJ2bRSqjU3uV5LABQK1TQFiF/GukMpFKBuDU
 B/nmCo7QTKRTzwiLL3Xn84bszBWAiwrTO0qLQevCqQdbgeRnwBnzxyOsifAnMw+NxG
 GnWEfvfxzvXZ3zhTe7HKUopn/q+iuU4cO2u8RzQe8l0B9UugSbQ8+LJJULZXiB1wMo
 H3ovtR8g7chug==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 24/46] common/sfc_efx/base: get netport fixed capabilities on
 probe
Date: Wed, 16 Apr 2025 17:59:54 +0400
Message-Id: <20250416140016.36127-25-ivan.malov@arknetworks.am>
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

These make the basic subset of PHY capabilities known to EFX

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx.h    |  21 ++-
 drivers/common/sfc_efx/base/efx_np.c | 209 +++++++++++++++++++++++++++
 2 files changed, 224 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index a9ed3f423f..2c6af5f6b5 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -1212,6 +1212,11 @@ typedef enum efx_phy_cap_type_e {
 	EFX_PHY_CAP_RS_FEC_REQUESTED,
 	EFX_PHY_CAP_25G_BASER_FEC,
 	EFX_PHY_CAP_25G_BASER_FEC_REQUESTED,
+	EFX_PHY_CAP_200000FDX,
+	EFX_PHY_CAP_IEEE_RS_INT_FEC,
+	EFX_PHY_CAP_IEEE_RS_INT_FEC_REQUESTED,
+	EFX_PHY_CAP_ETCS_RS_LL_FEC,
+	EFX_PHY_CAP_ETCS_RS_LL_FEC_REQUESTED,
 	EFX_PHY_CAP_NTYPES
 } efx_phy_cap_type_t;
 
@@ -4009,12 +4014,16 @@ typedef enum efx_phy_fec_type_e {
 
 #define EFX_PHY_CAP_FEC_BIT(_fec_bit) (1U << EFX_PHY_CAP_##_fec_bit)
 #define EFX_PHY_CAP_FEC_MASK \
-	(EFX_PHY_CAP_FEC_BIT(BASER_FEC) |		\
-	 EFX_PHY_CAP_FEC_BIT(25G_BASER_FEC) |		\
-	 EFX_PHY_CAP_FEC_BIT(BASER_FEC_REQUESTED) |	\
-	 EFX_PHY_CAP_FEC_BIT(25G_BASER_FEC_REQUESTED) |	\
-	 EFX_PHY_CAP_FEC_BIT(RS_FEC) |			\
-	 EFX_PHY_CAP_FEC_BIT(RS_FEC_REQUESTED))
+	(EFX_PHY_CAP_FEC_BIT(BASER_FEC) |			\
+	 EFX_PHY_CAP_FEC_BIT(25G_BASER_FEC) |			\
+	 EFX_PHY_CAP_FEC_BIT(BASER_FEC_REQUESTED) |		\
+	 EFX_PHY_CAP_FEC_BIT(25G_BASER_FEC_REQUESTED) |		\
+	 EFX_PHY_CAP_FEC_BIT(RS_FEC) |				\
+	 EFX_PHY_CAP_FEC_BIT(RS_FEC_REQUESTED) |		\
+	 EFX_PHY_CAP_FEC_BIT(IEEE_RS_INT_FEC) |			\
+	 EFX_PHY_CAP_FEC_BIT(IEEE_RS_INT_FEC_REQUESTED) |	\
+	 EFX_PHY_CAP_FEC_BIT(ETCS_RS_LL_FEC) |			\
+	 EFX_PHY_CAP_FEC_BIT(ETCS_RS_LL_FEC_REQUESTED))
 
 LIBEFX_API
 extern	__checkReturn	efx_rc_t
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index ec6a432623..6a36abf5c9 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -76,6 +76,203 @@ efx_np_get_assigned_handle(
 fail2:
 	EFSYS_PROBE(fail2);
 
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+struct efx_np_cap_map {
+	uint16_t	encm_hw;
+	uint16_t	encm_sw;
+};
+
+static const struct efx_np_cap_map efx_np_cap_map_tech[] = {
+	/* 1G */
+	{ MC_CMD_ETH_TECH_1000BASEKX, EFX_PHY_CAP_1000FDX },
+	{ MC_CMD_ETH_TECH_1000BASEX, EFX_PHY_CAP_1000FDX },
+
+	/* 10G */
+	{ MC_CMD_ETH_TECH_10GBASE_KR, EFX_PHY_CAP_10000FDX },
+	{ MC_CMD_ETH_TECH_10GBASE_CR, EFX_PHY_CAP_10000FDX },
+	{ MC_CMD_ETH_TECH_10GBASE_SR, EFX_PHY_CAP_10000FDX },
+	{ MC_CMD_ETH_TECH_10GBASE_LR, EFX_PHY_CAP_10000FDX },
+	{ MC_CMD_ETH_TECH_10GBASE_LRM, EFX_PHY_CAP_10000FDX },
+	{ MC_CMD_ETH_TECH_10GBASE_ER, EFX_PHY_CAP_10000FDX },
+
+	/* 25GBASE */
+	{ MC_CMD_ETH_TECH_25GBASE_CR, EFX_PHY_CAP_25000FDX },
+	{ MC_CMD_ETH_TECH_25GBASE_KR, EFX_PHY_CAP_25000FDX },
+	{ MC_CMD_ETH_TECH_25GBASE_SR, EFX_PHY_CAP_25000FDX },
+	{ MC_CMD_ETH_TECH_25GBASE_LR_ER, EFX_PHY_CAP_25000FDX },
+
+	/* 40G */
+	{ MC_CMD_ETH_TECH_40GBASE_KR4, EFX_PHY_CAP_40000FDX },
+	{ MC_CMD_ETH_TECH_40GBASE_CR4, EFX_PHY_CAP_40000FDX },
+	{ MC_CMD_ETH_TECH_40GBASE_SR4, EFX_PHY_CAP_40000FDX },
+	{ MC_CMD_ETH_TECH_40GBASE_LR4, EFX_PHY_CAP_40000FDX },
+
+	/* 50G */
+	{ MC_CMD_ETH_TECH_50GBASE_CR2, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_KR2, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_SR2, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_KR, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_SR, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_CR, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_LR_ER_FR, EFX_PHY_CAP_50000FDX },
+	{ MC_CMD_ETH_TECH_50GBASE_DR, EFX_PHY_CAP_50000FDX },
+
+	/* 100G */
+	{ MC_CMD_ETH_TECH_100GBASE_KR4, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_SR4, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_CR4, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_LR4_ER4, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_KR2, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_SR2, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_CR2, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_LR2_ER2_FR2, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_DR2, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_KR, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_SR, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_LR_ER_FR, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_CR, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_DR, EFX_PHY_CAP_100000FDX },
+	{ MC_CMD_ETH_TECH_100GBASE_CR10, EFX_PHY_CAP_100000FDX },
+
+	/* 200G */
+	{ MC_CMD_ETH_TECH_200GBASE_KR4, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_SR4, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_LR4_ER4_FR4, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_DR4, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_CR4, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_KR2, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_SR2, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_LR2_ER2_FR2, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_DR2, EFX_PHY_CAP_200000FDX },
+	{ MC_CMD_ETH_TECH_200GBASE_CR2, EFX_PHY_CAP_200000FDX },
+};
+
+static const struct efx_np_cap_map efx_np_cap_map_fec[] = {
+	{ MC_CMD_FEC_BASER, EFX_PHY_CAP_BASER_FEC },
+	{ MC_CMD_FEC_RS, EFX_PHY_CAP_RS_FEC },
+	{ MC_CMD_FEC_IEEE_RS_INT, EFX_PHY_CAP_IEEE_RS_INT_FEC },
+	{ MC_CMD_FEC_ETCS_RS_LL, EFX_PHY_CAP_ETCS_RS_LL_FEC },
+};
+
+static const struct efx_np_cap_map efx_np_cap_map_fec_req[] = {
+	{ MC_CMD_FEC_BASER, EFX_PHY_CAP_BASER_FEC_REQUESTED },
+	{ MC_CMD_FEC_RS, EFX_PHY_CAP_RS_FEC_REQUESTED },
+	{ MC_CMD_FEC_IEEE_RS_INT, EFX_PHY_CAP_IEEE_RS_INT_FEC_REQUESTED },
+	{ MC_CMD_FEC_ETCS_RS_LL, EFX_PHY_CAP_ETCS_RS_LL_FEC_REQUESTED },
+};
+
+static const struct efx_np_cap_map efx_np_cap_map_pause[] = {
+	{ MC_CMD_PAUSE_MODE_AN_ASYM_DIR, EFX_PHY_CAP_ASYM },
+	{ MC_CMD_PAUSE_MODE_AN_PAUSE, EFX_PHY_CAP_PAUSE },
+};
+
+#define	CAP_BYTE(_map)	((_map)->encm_hw / CHAR_BIT)
+
+#define	CAP_VLD(_map, _data_nbytes)	(CAP_BYTE(_map) < (_data_nbytes))
+
+#define	CAP_FLAG(_map)	(1U << ((_map)->encm_hw % CHAR_BIT))
+
+#define	CAP_SUP(_map, _data)						\
+	(((_data)[CAP_BYTE(_map)] & CAP_FLAG(_map)) == CAP_FLAG(_map))
+
+#define	FOREACH_SUP_CAP(_map, _map_nentries, _data, _data_nbytes)	\
+	for (unsigned int _i = 0; _i < (_map_nentries); ++_i, ++(_map))	\
+		if (CAP_VLD(_map, _data_nbytes) && CAP_SUP(_map, _data))
+
+static					void
+efx_np_cap_mask_hw_to_sw(
+	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
+	__in				unsigned int hw_sw_map_nentries,
+	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
+	__in				size_t hw_cap_data_nbytes,
+	__out				uint32_t *sw_cap_maskp)
+{
+	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
+	    hw_cap_data, hw_cap_data_nbytes) {
+		*sw_cap_maskp |= 1U << hw_sw_map->encm_sw;
+	}
+}
+
+/*
+ * Convert the given fraction of raw HW netport capability data (identified by
+ * the given section name of the MCDI response) to the EFX mask representation,
+ * in accordance with the specified collection of HW-to-SW capability mappings.
+ */
+#define	EFX_NP_CAP_MASK_HW_TO_SW(					\
+	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data, _sw_maskp)	\
+	efx_np_cap_mask_hw_to_sw((_hw_sw_cap_map),			\
+	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
+	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
+		    MC_CMD_##_hw_cap_section),				\
+	    MC_CMD_##_hw_cap_section##_LEN, (_sw_maskp))
+
+static				void
+efx_np_cap_hw_data_to_sw_mask(
+	__in			const uint8_t *hw_data,
+	__out			uint32_t *sw_maskp)
+{
+	EFX_NP_CAP_MASK_HW_TO_SW(efx_np_cap_map_tech, ETH_AN_FIELDS_TECH_MASK,
+	    hw_data, sw_maskp);
+
+	EFX_NP_CAP_MASK_HW_TO_SW(efx_np_cap_map_fec, ETH_AN_FIELDS_FEC_MASK,
+	    hw_data, sw_maskp);
+
+	EFX_NP_CAP_MASK_HW_TO_SW(efx_np_cap_map_fec_req, ETH_AN_FIELDS_FEC_REQ,
+	    hw_data, sw_maskp);
+
+	EFX_NP_CAP_MASK_HW_TO_SW(efx_np_cap_map_pause, ETH_AN_FIELDS_PAUSE_MASK,
+	    hw_data, sw_maskp);
+}
+
+static	__checkReturn		efx_rc_t
+efx_np_get_fixed_port_props(
+	__in			efx_nic_t *enp,
+	__in			efx_np_handle_t nph,
+	__out_opt		uint32_t *sup_cap_maskp)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN,
+	    MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN);
+	const uint8_t *cap_data;
+	efx_mcdi_req_t req;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN;
+	req.emr_in_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN;
+	req.emr_cmd = MC_CMD_GET_FIXED_PORT_PROPERTIES;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, GET_FIXED_PORT_PROPERTIES_IN_PORT_HANDLE, nph);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	if (req.emr_out_length_used <
+	    MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN) {
+		rc = EMSGSIZE;
+		goto fail2;
+	}
+
+	cap_data = MCDI_OUT2(req, const uint8_t,
+		    GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES);
+
+	if (sup_cap_maskp != NULL)
+		efx_np_cap_hw_data_to_sw_mask(cap_data, sup_cap_maskp);
+
+	return (0);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
@@ -109,8 +306,20 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail1;
 
+	/*
+	 * FIXME: This may need revisiting for VFs, which
+	 * don't necessarily have access to these details.
+	 */
+	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
+		    &epp->ep_phy_cap_mask);
+	if (rc != 0)
+		goto fail2;
+
 	return (0);
 
+fail2:
+	EFSYS_PROBE(fail2);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
-- 
2.39.5

