Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F031EC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 14:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8353240DD7;
	Thu,  3 Apr 2025 16:49:28 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 70927402CB
 for <dev@dpdk.org>; Thu,  3 Apr 2025 16:49:26 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-476a304a8edso8810091cf.3
 for <dev@dpdk.org>; Thu, 03 Apr 2025 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743691766; x=1744296566; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ROhPjTOZtv3ktSJt3S4g2poY4arg2i6us8IbWaAubI=;
 b=eGkA6kRo0O8pZ4amhWEU2pg18U8REv4JwdibYYJHKoefEpMJF0wAdB98DDZwUgHePa
 xFLVJlfF5HG1YmiySe+DoA1WvCvVHLvUu6gJAaZCOcxRLDwLj4yxFtlDcBRsSEmYqVbz
 lL58qvOd1HKUvYUX7H0Ek/cyvSJdRHIjyUhy9c6ycGGSjWRF04xwjhbPBcKT34j57fYp
 wqjV51N5T9y0cSgMI8gu4cBq8Ii3q1O4HFPT4w9Uh750BkIRCIrEcULoq12gtDlAY3ar
 0CnjfULHUOLk4MH7xlRBa7ySSCE65JsX9zlKOO6MXEcU9e2ysOeOT/Tm3VfkDxrMiQJ0
 b0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743691766; x=1744296566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ROhPjTOZtv3ktSJt3S4g2poY4arg2i6us8IbWaAubI=;
 b=PPYSVzIhM98OBv6qc6aNwu6can9NOgHiaxOvOQABF14droQQJaQHer4E5j4cdV+j9M
 PuyeWo5GHOlyay0CqGulYIbWk77R8mTCIdwkbV2RdITAT13mNpsfrQTBQPB6yeve1Z54
 PNbTCM38C3z/NWEZp4RwmSX2KjPRJgD7hu4ZaiiYcsoAVdci9AzXX9TLKdzmsta45oCr
 BNQlF4Aj9q/Z8Qy9XCpSycutx9UmLcFiKZ2DNPFvh6KxUeQjKevlKyAsdZNz3k7WOoLE
 7oISVpTvdA4JB9SJe/D/QX7jkEwtozK0vMOJGsyr1+jbPQcDyTHWVyf7hGEQpmzFwyAl
 nkCw==
X-Gm-Message-State: AOJu0Yz9CSxKF8vqwkxkEIGUta++GK+1JDK3E9wm3zVdpPCwxMfvXSub
 aC9Yaa3h12GwJYm4+2vQ/YiO2KcznPK0I6kydLHT13uOmY8WDNLN3wYiU7Cm
X-Gm-Gg: ASbGnctD/4zeB4lGm37ho6KkEb57eeXrUNCCOOP3yzrbKPPfX/LHC/JniDYimZnwnoA
 MP0O9ezUDmV09xQOsGU7is32/4kZ+jkDtl8QEKxsQ8v5AD2YFtyN1HjjFY0aRZunARLG7+r+kSC
 6rJXTNIAMcRQPtIh+TwdEINk74ddRXft/moN9nKplSrzwNj9zDcWhH8oF/O+dasFltehA/8GZQb
 1Z7l9DgvMYws+NolQyTW1MMM5xDgPlE8+GKh76fg6FB3nq8vfyFSePF+uONo7nAq1IGbSmJ8aXT
 6D7D9huwbvJpRX5mpf+GQ6fn8dKsc1sjdhYeRDwJzkcYqdm6vr1sl9d3PTKBbMD5bBv+DBMQkQA
 NT2G0xw==
X-Google-Smtp-Source: AGHT+IHNMXTW4iiSlN76jpM/mZp2WVyTCWaNM6zEVhoJDyGrASwtNjgZmcghkjfm4aCeZBJOTyzpnQ==
X-Received: by 2002:a05:622a:1186:b0:477:1e83:184b with SMTP id
 d75a77b69052e-47909fa79aamr85767951cf.29.1743691765627; 
 Thu, 03 Apr 2025 07:49:25 -0700 (PDT)
Received: from fedora.mshome.net (23-233-92-188.cpe.pppoe.ca. [23.233.92.188])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e759a66sm85050785a.25.2025.04.03.07.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:49:25 -0700 (PDT)
From: LukeSeewald <luke.seewald@gmail.com>
To: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Cc: dev@dpdk.org,
	luke@aterlo.com,
	LukeSeewald <luke.seewald@gmail.com>
Subject: [PATCH] net/ice: enlarge limits to 64 bits (ice_stats_get)
Date: Thu,  3 Apr 2025 10:49:21 -0400
Message-ID: <20250403144921.1390510-1-luke.seewald@gmail.com>
X-Mailer: git-send-email 2.49.0
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

There are various counters/stats coming from ice_stats_get that appear
to only use 32 or 40 bits and once it hits that limit it "overflows"
and resets. This was causing large spikes (sudden 2^42 increase from
one second to the next) in values of ibytes and obytes, while causing
sudden drops in opackets and ipackets (as they "overflow" and reset).
The sudden spike in bytes is due to the packets count being multiplied
by 4 (crc bytes) and subtracted from the byte count. E.g. One second
the packet count could be just under the 40 bit limit, subtracting a
very large number from the byte count and then in the next second hit
the limit, "overflow" and reset subtracting a very small number, thus
causing the byte counts to appear as if there was a large increase in a
single second.

This patch fixes the issue by enlarging the limitations of any counters
or stats used by ice_stats_get to 64 bits, following the pattern of a
previous patch -
https://mails.dpdk.org/archives/stable/2020-July/023940.html

Signed-off-by: LukeSeewald <luke.seewald@gmail.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 103 +++++++++++++++++++++--------
 drivers/net/intel/ice/ice_ethdev.h |  44 ++++++++++--
 2 files changed, 115 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 21d3795954..012b78a469 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6061,6 +6061,37 @@ ice_stat_update_40(struct ice_hw *hw,
 	*stat &= ICE_40_BIT_MASK;
 }
 
+/**
+ * There are various counters that are bubbled up in uint64 values but do not make use of all
+ * 64 bits, most commonly using only 32 or 40 bits. This function handles the "overflow" when
+ * these counters hit their 32 or 40 bit limit to enlarge that limitation to 64 bits.
+
+ * @offset_loaded: refers to whether this function has been called before and old_value is known to
+ * have a value, i.e. its possible that value has overflowed past its original limitation
+ * @value_bit_limitation: refers to the number of bits the given value uses before overflowing
+ * @value: is the current value with its original limitation (i.e. 32 or 40 bits)
+ * @old_value: is expected to be the previous value of the given value with the overflow accounted
+ * for (i.e. the full 64 bit previous value)
+ *
+ * This function will appropriately update both value and old_value, accounting for overflow
+ */
+static void
+ice_handle_overflow(bool offset_loaded,
+			uint8_t value_bit_limitation,
+			uint64_t *value,
+			uint64_t *old_value)
+{
+	uint64_t low_bit_mask = RTE_LEN2MASK(value_bit_limitation, uint64_t);
+	uint64_t high_bit_mask = ~low_bit_mask;
+
+	if (offset_loaded) {
+		if ((*old_value & low_bit_mask) > *value)
+			*value += (uint64_t)1 << value_bit_limitation;
+		*value += *old_value & high_bit_mask;
+	}
+	*old_value = *value;
+}
+
 /* Get all the statistics of a VSI */
 static void
 ice_update_vsi_stats(struct ice_vsi *vsi)
@@ -6082,13 +6113,16 @@ ice_update_vsi_stats(struct ice_vsi *vsi)
 	ice_stat_update_40(hw, GLV_BPRCH(idx), GLV_BPRCL(idx),
 			   vsi->offset_loaded, &oes->rx_broadcast,
 			   &nes->rx_broadcast);
-	/* enlarge the limitation when rx_bytes overflowed */
-	if (vsi->offset_loaded) {
-		if (ICE_RXTX_BYTES_LOW(vsi->old_rx_bytes) > nes->rx_bytes)
-			nes->rx_bytes += (uint64_t)1 << ICE_40_BIT_WIDTH;
-		nes->rx_bytes += ICE_RXTX_BYTES_HIGH(vsi->old_rx_bytes);
-	}
-	vsi->old_rx_bytes = nes->rx_bytes;
+
+	ice_handle_overflow(vsi->offset_loaded, ICE_40_BIT_WIDTH,
+			   &nes->rx_unicast, &vsi->old_get_stats_fields.rx_unicast);
+	ice_handle_overflow(vsi->offset_loaded, ICE_40_BIT_WIDTH,
+			   &nes->rx_multicast, &vsi->old_get_stats_fields.rx_multicast);
+	ice_handle_overflow(vsi->offset_loaded, ICE_40_BIT_WIDTH,
+			   &nes->rx_broadcast, &vsi->old_get_stats_fields.rx_broadcast);
+	ice_handle_overflow(vsi->offset_loaded, ICE_40_BIT_WIDTH,
+			   &nes->rx_bytes, &vsi->old_get_stats_fields.rx_bytes);
+
 	/* exclude CRC bytes */
 	nes->rx_bytes -= (nes->rx_unicast + nes->rx_multicast +
 			  nes->rx_broadcast) * RTE_ETHER_CRC_LEN;
@@ -6115,13 +6149,14 @@ ice_update_vsi_stats(struct ice_vsi *vsi)
 	/* GLV_TDPC not supported */
 	ice_stat_update_32(hw, GLV_TEPC(idx), vsi->offset_loaded,
 			   &oes->tx_errors, &nes->tx_errors);
-	/* enlarge the limitation when tx_bytes overflowed */
-	if (vsi->offset_loaded) {
-		if (ICE_RXTX_BYTES_LOW(vsi->old_tx_bytes) > nes->tx_bytes)
-			nes->tx_bytes += (uint64_t)1 << ICE_40_BIT_WIDTH;
-		nes->tx_bytes += ICE_RXTX_BYTES_HIGH(vsi->old_tx_bytes);
-	}
-	vsi->old_tx_bytes = nes->tx_bytes;
+
+	ice_handle_overflow(vsi->offset_loaded, ICE_32_BIT_WIDTH,
+			   &nes->rx_discards, &vsi->old_get_stats_fields.rx_discards);
+	ice_handle_overflow(vsi->offset_loaded, ICE_32_BIT_WIDTH,
+			   &nes->tx_errors, &vsi->old_get_stats_fields.tx_errors);
+	ice_handle_overflow(vsi->offset_loaded, ICE_40_BIT_WIDTH,
+			   &nes->tx_bytes, &vsi->old_get_stats_fields.tx_bytes);
+
 	vsi->offset_loaded = true;
 
 	PMD_DRV_LOG(DEBUG, "************** VSI[%u] stats start **************",
@@ -6169,13 +6204,11 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
 	ice_stat_update_32(hw, PRTRPB_RDPC,
 			   pf->offset_loaded, &os->eth.rx_discards,
 			   &ns->eth.rx_discards);
-	/* enlarge the limitation when rx_bytes overflowed */
-	if (pf->offset_loaded) {
-		if (ICE_RXTX_BYTES_LOW(pf->old_rx_bytes) > ns->eth.rx_bytes)
-			ns->eth.rx_bytes += (uint64_t)1 << ICE_40_BIT_WIDTH;
-		ns->eth.rx_bytes += ICE_RXTX_BYTES_HIGH(pf->old_rx_bytes);
-	}
-	pf->old_rx_bytes = ns->eth.rx_bytes;
+
+	ice_handle_overflow(pf->offset_loaded, ICE_40_BIT_WIDTH,
+			   &ns->eth.rx_bytes, &pf->old_get_stats_fields.rx_bytes);
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->eth.rx_discards, &pf->old_get_stats_fields.rx_discards);
 
 	/* Workaround: CRC size should not be included in byte statistics,
 	 * so subtract RTE_ETHER_CRC_LEN from the byte counter for each rx
@@ -6206,13 +6239,16 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
 			   GLPRT_BPTCL(hw->port_info->lport),
 			   pf->offset_loaded, &os->eth.tx_broadcast,
 			   &ns->eth.tx_broadcast);
-	/* enlarge the limitation when tx_bytes overflowed */
-	if (pf->offset_loaded) {
-		if (ICE_RXTX_BYTES_LOW(pf->old_tx_bytes) > ns->eth.tx_bytes)
-			ns->eth.tx_bytes += (uint64_t)1 << ICE_40_BIT_WIDTH;
-		ns->eth.tx_bytes += ICE_RXTX_BYTES_HIGH(pf->old_tx_bytes);
-	}
-	pf->old_tx_bytes = ns->eth.tx_bytes;
+
+	ice_handle_overflow(pf->offset_loaded, ICE_40_BIT_WIDTH,
+			   &ns->eth.tx_bytes, &pf->old_get_stats_fields.tx_bytes);
+	ice_handle_overflow(pf->offset_loaded, ICE_40_BIT_WIDTH,
+			   &ns->eth.tx_unicast, &pf->old_get_stats_fields.tx_unicast);
+	ice_handle_overflow(pf->offset_loaded, ICE_40_BIT_WIDTH,
+			   &ns->eth.tx_multicast, &pf->old_get_stats_fields.tx_multicast);
+	ice_handle_overflow(pf->offset_loaded, ICE_40_BIT_WIDTH,
+			   &ns->eth.tx_broadcast, &pf->old_get_stats_fields.tx_broadcast);
+
 	ns->eth.tx_bytes -= (ns->eth.tx_unicast + ns->eth.tx_multicast +
 			     ns->eth.tx_broadcast) * RTE_ETHER_CRC_LEN;
 
@@ -6321,6 +6357,17 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
 			   pf->offset_loaded, &os->tx_size_big,
 			   &ns->tx_size_big);
 
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->crc_errors, &pf->old_get_stats_fields.crc_errors);
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->rx_undersize, &pf->old_get_stats_fields.rx_undersize);
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->rx_fragments, &pf->old_get_stats_fields.rx_fragments);
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->rx_oversize, &pf->old_get_stats_fields.rx_oversize);
+	ice_handle_overflow(pf->offset_loaded, ICE_32_BIT_WIDTH,
+			   &ns->rx_jabber, &pf->old_get_stats_fields.rx_jabber);
+
 	/* GLPRT_MSPDC not supported */
 	/* GLPRT_XEC not supported */
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index afe8dae497..bfe093afca 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -260,6 +260,22 @@ struct ice_vsi_list {
 struct ice_rx_queue;
 struct ci_tx_queue;
 
+
+/**
+ * Used to store previous values of fields reported by ice_stats_get that can overflow
+ * for the purpose of enlarging all their limitations to 64 bits rather than 32 or 40
+ */
+struct ice_vsi_get_stats_fields {
+	uint64_t rx_bytes;
+	uint64_t rx_unicast;
+	uint64_t rx_multicast;
+	uint64_t rx_broadcast;
+	uint64_t rx_discards;
+	uint64_t tx_errors;
+	uint64_t tx_bytes;
+};
+
+
 /**
  * Structure that defines a VSI, associated with a adapter.
  */
@@ -307,8 +323,8 @@ struct ice_vsi {
 	struct ice_eth_stats eth_stats_offset;
 	struct ice_eth_stats eth_stats;
 	bool offset_loaded;
-	uint64_t old_rx_bytes;
-	uint64_t old_tx_bytes;
+	/* holds previous values so limitations can be enlarged to 64 bits */
+	struct ice_vsi_get_stats_fields old_get_stats_fields;
 };
 
 enum proto_xtr_type {
@@ -495,6 +511,26 @@ struct ice_mbuf_stats {
 	uint64_t tx_pkt_errors;
 };
 
+
+/**
+ * Used to store previous values of fields reported by ice_stats_get that can overflow
+ * for the purpose of enlarging all their limitations to 64 bits rather than 32 or 40
+ */
+struct ice_pf_get_stats_fields {
+	uint64_t rx_bytes;
+	uint64_t rx_discards;
+	uint64_t rx_undersize;
+	uint64_t rx_fragments;
+	uint64_t rx_oversize;
+	uint64_t rx_jabber;
+	uint64_t tx_unicast;
+	uint64_t tx_multicast;
+	uint64_t tx_broadcast;
+	uint64_t tx_bytes;
+	uint64_t crc_errors;
+};
+
+
 struct ice_pf {
 	struct ice_adapter *adapter; /* The adapter this PF associate to */
 	struct ice_vsi *main_vsi; /* pointer to main VSI structure */
@@ -533,8 +569,8 @@ struct ice_pf {
 	struct ice_flow_list flow_list;
 	rte_spinlock_t flow_ops_lock;
 	bool init_link_up;
-	uint64_t old_rx_bytes;
-	uint64_t old_tx_bytes;
+	/* holds previous values so limitations can be enlarged to 64 bits */
+	struct ice_pf_get_stats_fields old_get_stats_fields;
 	uint64_t supported_rxdid; /* bitmap for supported RXDID */
 	uint64_t rss_hf;
 	struct ice_tm_conf tm_conf;
-- 
2.49.0

