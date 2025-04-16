Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C788C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6399B427BE;
	Wed, 16 Apr 2025 16:01:06 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 92CE441156
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DA507E11BE;
 Wed, 16 Apr 2025 18:00:57 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DA507E11BE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812058;
 bh=+8Q35esr1oiD8ynfQqXZBT3jvcdWh2K1O/mwF0z4jcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EzJB/117gP9ju/EG4Y+bcaYHuInZX7FFnGqh0nfYxPuMmvMJLoLjF+rlUCw8YvP3F
 jpuDstQn8u820jIZbKYRpY9HhdBvYlROeoUCR5SCmufWx+REtVbdd75up2tfSXQowk
 czHtMm4aMdkxG+cdujhRPc3v6ZVCWrpaEbqJPr6pL/oBzHdMltbZcugtD4unVjWrda
 CTIGNhkK2zOG94LMAkePUk7VyaKTYSGRHnGFkaJmhmqRSiUBg6vhyIK6SAfCHj1RmG
 6G8b0TiuRKhN8mCK+YkH9OgM7D8Y6KeTN7NJ0SkXSJnfgRBqv0X6aGRlAZa7GQzl7H
 YyBVqaFDFsTUQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 33/46] common/sfc_efx/base: fill in software LUT for MAC
 statistics
Date: Wed, 16 Apr 2025 18:00:03 +0400
Message-Id: <20250416140016.36127-34-ivan.malov@arknetworks.am>
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

To support MAC statistics, it is required to fill in a table
which will be used by EFX to get DMA field IDs (offsets into
the DMA buffer where MC FW uploads the data) by software IDs.

Fill in the lookup table by parsing HW statistic descriptors.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h |   8 +
 drivers/common/sfc_efx/base/efx_np.c   | 291 +++++++++++++++++++++++++
 2 files changed, 299 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index ac1cd5292b..aafb2bf998 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -341,6 +341,12 @@ typedef struct efx_virtio_ops_s {
 
 typedef uint32_t efx_np_handle_t;
 
+typedef struct efx_np_stat_s {
+	uint32_t	ens_hw_id;
+	uint16_t	ens_dma_fld;
+	boolean_t	ens_valid;
+} efx_np_stat_t;
+
 typedef struct efx_port_s {
 	efx_mac_type_t		ep_mac_type;
 	uint32_t		ep_phy_type;
@@ -388,6 +394,8 @@ typedef struct efx_port_s {
 	efx_np_handle_t		ep_np_handle;
 	efx_qword_t		ep_np_loopback_cap_mask;
 	uint8_t			ep_np_cap_data_raw[MC_CMD_ETH_AN_FIELDS_LEN];
+	/* Lookup table providing DMA buffer field IDs by EFX statistic IDs. */
+	efx_np_stat_t		ep_np_mac_stat_lut[EFX_MAC_NSTATS];
 } efx_port_t;
 
 typedef struct efx_mon_ops_s {
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 826ee93f0f..d4ee17ffb4 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -529,6 +529,286 @@ efx_np_assign_loopback_props(
 }
 #endif /* EFSYS_OPT_LOOPBACK */
 
+#if EFSYS_OPT_MAC_STATS
+/* HW statistic IDs, as per MC_CMD_MAC_STATISTICS_DESCRIPTOR format. */
+#define	EFX_NP_HW_STAT_ID(_src, _idx)					\
+	(((MC_CMD_STAT_ID_##_src) << MC_CMD_STAT_ID_SOURCE_ID_LBN) |	\
+	    ((uint32_t)(MC_CMD_STAT_ID_##_idx) <<			\
+		    MC_CMD_STAT_ID_MAC_STAT_ID_LBN))
+
+/*
+ * Mapping between EFX statistic IDs (array indices) and their HW counterparts.
+ *
+ * This is used in conjunction with HW statistic descriptors bearing DMA field
+ * IDs (offsets into the DMA buffer) to provide a SW lookup table for readings.
+ *
+ * From the HW perspective, statistics come from MAC and PHY, hence two macros.
+ */
+static const efx_np_stat_t efx_np_mac_stat_map[] = {
+#define	EFX_NP_STAT_MAC(_hw, _sw)				\
+	[EFX_MAC_##_sw] = {					\
+		.ens_hw_id = EFX_NP_HW_STAT_ID(MAC, _hw),	\
+		.ens_valid = B_TRUE,				\
+	}
+
+	EFX_NP_STAT_MAC(TX_PKTS, TX_PKTS),
+	EFX_NP_STAT_MAC(TX_PAUSE_PKTS, TX_PAUSE_PKTS),
+	/* TODO: TX_CONTROL_PKTS */
+	EFX_NP_STAT_MAC(TX_UNICAST_PKTS, TX_UNICST_PKTS),
+	EFX_NP_STAT_MAC(TX_MULTICAST_PKTS, TX_MULTICST_PKTS),
+	EFX_NP_STAT_MAC(TX_BROADCAST_PKTS, TX_BRDCST_PKTS),
+	EFX_NP_STAT_MAC(TX_BYTES, TX_OCTETS),
+	/* FIXME: TX_64_PKTS; TODO: TX_BAD_BYTES, TX_GOOD_BYTES, TX_LT64_PKTS */
+	EFX_NP_STAT_MAC(TX_64_PKTS, TX_LE_64_PKTS),
+	EFX_NP_STAT_MAC(TX_65_TO_127_PKTS, TX_65_TO_127_PKTS),
+	EFX_NP_STAT_MAC(TX_128_TO_255_PKTS, TX_128_TO_255_PKTS),
+	EFX_NP_STAT_MAC(TX_256_TO_511_PKTS, TX_256_TO_511_PKTS),
+	EFX_NP_STAT_MAC(TX_512_TO_1023_PKTS, TX_512_TO_1023_PKTS),
+	EFX_NP_STAT_MAC(TX_1024_TO_15XX_PKTS, TX_1024_TO_15XX_PKTS),
+	/* FIXME: TX_15XX_TO_JUMBO_PKTS; TODO: TX_GTJUMBO_PKTS */
+	EFX_NP_STAT_MAC(TX_15XX_TO_JUMBO_PKTS, TX_GE_15XX_PKTS),
+	/* TODO: TX_BAD_FCS_PKTS, TX_GOOD_FCS_PKTS */
+	EFX_NP_STAT_MAC(RX_PKTS, RX_PKTS),
+	EFX_NP_STAT_MAC(RX_PAUSE_PKTS, RX_PAUSE_PKTS),
+	/* TODO: RX_GOOD_PKTS, RX_BAD_PKTS, RX_CONTROL_PKTS */
+	EFX_NP_STAT_MAC(RX_UNICAST_PKTS, RX_UNICST_PKTS),
+	EFX_NP_STAT_MAC(RX_MULTICAST_PKTS, RX_MULTICST_PKTS),
+	EFX_NP_STAT_MAC(RX_BROADCAST_PKTS, RX_BRDCST_PKTS),
+	EFX_NP_STAT_MAC(RX_BYTES, RX_OCTETS),
+	/* TODO: RX_BAD_BYTES, RX_GOOD_BYTES */
+	/* FIXME: RX_64_PKTS; TODO: RX_UNDERSIZE_PKTS */
+	EFX_NP_STAT_MAC(RX_64_PKTS, RX_LE_64_PKTS),
+	EFX_NP_STAT_MAC(RX_65_TO_127_PKTS, RX_65_TO_127_PKTS),
+	EFX_NP_STAT_MAC(RX_128_TO_255_PKTS, RX_128_TO_255_PKTS),
+	EFX_NP_STAT_MAC(RX_256_TO_511_PKTS, RX_256_TO_511_PKTS),
+	EFX_NP_STAT_MAC(RX_512_TO_1023_PKTS, RX_512_TO_1023_PKTS),
+	EFX_NP_STAT_MAC(RX_1024_TO_15XX_PKTS, RX_1024_TO_15XX_PKTS),
+	/* FIXME: RX_15XX_TO_JUMBO_PKTS; TODO: RX_GTJUMBO_PKTS */
+	EFX_NP_STAT_MAC(RX_15XX_TO_JUMBO_PKTS, RX_GE_15XX_PKTS),
+	EFX_NP_STAT_MAC(RX_BAD_FCS_PKTS, RX_FCS_ERRORS),
+	/* TODO: RX_GOOD_FCS_PKTS, RX_OVERFLOW_PKTS */
+	EFX_NP_STAT_MAC(RX_SYMBOL_ERROR_PKTS, RX_SYMBOL_ERRORS),
+	EFX_NP_STAT_MAC(RX_ALIGN_ERROR_PKTS, RX_ALIGN_ERRORS),
+	/* TODO: RX_LENGTH_ERROR_PKTS */
+	EFX_NP_STAT_MAC(RX_INTERNAL_ERROR_PKTS, RX_INTERNAL_ERRORS),
+	EFX_NP_STAT_MAC(RX_JABBER_PKTS, RX_JABBER_PKTS),
+	EFX_NP_STAT_MAC(RX_NODESC_DROPS, RX_NODESC_DROP_CNT),
+	/* TODO: RX_LANES01_CHAR_ERR, RX_LANES23_CHAR_ERR */
+	/* TODO: RX_LANES01_DISP_ERR, RX_LANES23_DISP_ERR */
+	EFX_NP_STAT_MAC(RX_MATCH_FAULT, RX_MATCH_FAULT),
+
+#undef EFX_NP_STAT_MAC
+
+#define	EFX_NP_STAT_PHY(_hw, _sw)				\
+	[EFX_MAC_##_sw] = {					\
+		.ens_hw_id = EFX_NP_HW_STAT_ID(PHY, _hw),	\
+		.ens_valid = B_TRUE,				\
+	}
+
+	EFX_NP_STAT_PHY(FEC_UNCORRECTED_ERRORS, FEC_UNCORRECTED_ERRORS),
+	EFX_NP_STAT_PHY(FEC_CORRECTED_ERRORS, FEC_CORRECTED_ERRORS),
+	EFX_NP_STAT_PHY(FEC_CORRECTED_SYMBOLS_LANE0,
+	    FEC_CORRECTED_SYMBOLS_LANE0),
+	EFX_NP_STAT_PHY(FEC_CORRECTED_SYMBOLS_LANE1,
+	    FEC_CORRECTED_SYMBOLS_LANE1),
+	EFX_NP_STAT_PHY(FEC_CORRECTED_SYMBOLS_LANE2,
+	    FEC_CORRECTED_SYMBOLS_LANE2),
+	EFX_NP_STAT_PHY(FEC_CORRECTED_SYMBOLS_LANE3,
+	    FEC_CORRECTED_SYMBOLS_LANE3),
+
+#undef EFX_NP_STAT_PHY
+};
+#undef EFX_NP_HW_STAT_ID
+
+/* See efx_np_stats_describe() below. */
+static					void
+efx_np_stat_describe(
+	__in				uint8_t *hw_entry_buf,
+	__in				unsigned int lut_nentries,
+	__out_ecount_opt(lut_nentries)	efx_np_stat_t *lut)
+{
+	const efx_np_stat_t *map;
+	efx_mac_stat_t sw_id;
+	uint32_t hw_id;
+
+	hw_id = MCDI_STRUCT_DWORD(hw_entry_buf, MC_CMD_STAT_DESC_STAT_ID);
+
+	for (sw_id = 0; sw_id < EFX_ARRAY_SIZE(efx_np_mac_stat_map); ++sw_id) {
+		map = &efx_np_mac_stat_map[sw_id];
+
+		if (map->ens_valid != B_FALSE && map->ens_hw_id == hw_id)
+			goto found;
+	}
+
+	/* The statistic is unknown to EFX. */
+	return;
+
+found:
+	if (sw_id >= lut_nentries) {
+		/*
+		 * Static mapping size and the size of lookup
+		 * table are out-of-sync. Should never happen.
+		 */
+		return;
+	}
+
+	lut[sw_id].ens_dma_fld =
+	    MCDI_STRUCT_WORD(hw_entry_buf, MC_CMD_STAT_DESC_STAT_INDEX);
+	lut[sw_id].ens_valid = B_TRUE;
+	lut[sw_id].ens_hw_id = hw_id;
+}
+
+/*
+ * Get a fraction of statistic descriptors from the running FW, starting from
+ * the given HW ID offset, and fill DMA buffer field IDs in the corresponding
+ * entries of the software lookup table that will be used to get the readings.
+ */
+static	__checkReturn			efx_rc_t
+efx_np_stats_describe(
+	__in				efx_nic_t *enp,
+	__in				efx_np_handle_t nph,
+	__in				uint32_t req_ofst,
+	__in				unsigned int lut_nentries,
+	__out_ecount_opt(lut_nentries)	efx_np_stat_t *lut,
+	__out_opt			uint32_t *nprocessedp,
+	__out_opt			uint32_t *nstats_maxp)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN,
+	    MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2);
+	efx_port_t *epp = &(enp->en_port);
+	uint32_t nprocessed;
+	efx_mcdi_req_t req;
+	uint8_t *entries;
+	uint32_t stride;
+	unsigned int i;
+	size_t out_sz;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2;
+	req.emr_in_length = MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN;
+	req.emr_cmd = MC_CMD_MAC_STATISTICS_DESCRIPTOR;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, MAC_STATISTICS_DESCRIPTOR_IN_PORT_HANDLE, nph);
+	MCDI_IN_SET_DWORD(req, MAC_STATISTICS_DESCRIPTOR_IN_OFFSET, req_ofst);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	out_sz = req.emr_out_length_used;
+	if (out_sz < MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMIN) {
+		rc = EMSGSIZE;
+		goto fail2;
+	}
+
+	if (nstats_maxp != NULL) {
+		*nstats_maxp = MCDI_OUT_DWORD(req,
+		    MAC_STATISTICS_DESCRIPTOR_OUT_DMA_BUFFER_SIZE) /
+		    sizeof (efx_qword_t);
+	}
+
+	if (lut_nentries == 0 || lut == NULL || nprocessedp == NULL)
+		return (0);
+
+	stride = MCDI_OUT_DWORD(req, MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE);
+	nprocessed = MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_NUM(out_sz);
+	if (nprocessed == 0) {
+		rc = EMSGSIZE;
+		goto fail3;
+	}
+
+	entries = MCDI_OUT2(req, uint8_t,
+	    MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES);
+
+	for (i = 0; i < nprocessed; ++i)
+		efx_np_stat_describe(entries + i * stride, lut_nentries, lut);
+
+	*nprocessedp = nprocessed;
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
+static	__checkReturn	efx_rc_t
+efx_np_stats_assign(
+	__in		efx_nic_t *enp)
+{
+	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
+	efx_port_t *epp = &(enp->en_port);
+	unsigned int lut_nentries;
+	uint32_t nprocessed = 0;
+	efx_mac_stat_t sw_id;
+	efx_rc_t rc;
+
+	memset(epp->ep_np_mac_stat_lut, 0, sizeof (epp->ep_np_mac_stat_lut));
+	lut_nentries = EFX_ARRAY_SIZE(epp->ep_np_mac_stat_lut);
+
+	/*
+	 * First get encp->enc_mac_stats_nstats from the firmware.
+	 *
+	 * Do not limit encp->enc_mac_stats_nstats by the size of
+	 * epp->ep_np_mac_stat_lut, because the former is used to
+	 * allocate DMA buffer by client drivers, which must have
+	 * its size match expectations of the running MC firmware.
+	 */
+	rc = efx_np_stats_describe(enp, epp->ep_np_handle, 0, 0, NULL,
+			    NULL, &encp->enc_mac_stats_nstats);
+	if (rc != 0)
+		goto fail1;
+
+	/* Then process the actual descriptor data. */
+	while (nprocessed < encp->enc_mac_stats_nstats) {
+		uint32_t batch;
+
+		rc = efx_np_stats_describe(enp, epp->ep_np_handle, nprocessed,
+		    lut_nentries, epp->ep_np_mac_stat_lut, &batch, NULL);
+		if (rc != 0)
+			goto fail2;
+
+		nprocessed += batch;
+
+		if (batch == 0) {
+			/* Failed to supply all descriptors. */
+			rc = EMSGSIZE;
+			goto fail3;
+		}
+	}
+
+	sw_id = EFX_MAC_FEC_UNCORRECTED_ERRORS;
+	if (epp->ep_np_mac_stat_lut[sw_id].ens_valid == B_FALSE)
+		encp->enc_fec_counters = B_FALSE;
+	else
+		encp->enc_fec_counters = B_TRUE;
+
+	encp->enc_hlb_counters = B_FALSE;
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
+#endif /* EFSYS_OPT_MAC_STATS */
+
 	__checkReturn	efx_rc_t
 efx_np_attach(
 	__in		efx_nic_t *enp)
@@ -581,8 +861,19 @@ efx_np_attach(
 	efx_np_assign_loopback_props(enp);
 #endif /* EFSYS_OPT_LOOPBACK */
 
+#if EFSYS_OPT_MAC_STATS
+	rc = efx_np_stats_assign(enp);
+	if (rc != 0)
+		goto fail4;
+#endif /* EFSYS_OPT_MAC_STATS */
+
 	return (0);
 
+#if EFSYS_OPT_MAC_STATS
+fail4:
+	EFSYS_PROBE(fail4);
+#endif /* EFSYS_OPT_MAC_STATS */
+
 fail3:
 	EFSYS_PROBE(fail3);
 
-- 
2.39.5

