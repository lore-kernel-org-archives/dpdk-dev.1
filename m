Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB8CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B40F140668;
	Wed, 15 Oct 2025 09:10:18 +0200 (CEST)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mails.dpdk.org (Postfix) with ESMTP id E2151402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512217; x=1792048217;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=bGH5vr+wbHg4La3yZqy/xYcUxmS9NFQ8+UB8wrpi/BI=;
 b=VZ5q6mTM7szYYfLahcMoJ3FMBFXpEWIBjc1ImWEVsFNuJygYPyGIJAfn
 VEvjyWgt4m8Lz5fS55Z2jp5GMor92eLdGDLYcv9XtMzlW2hq0hFRenh4S
 vgesRh20aueHXOYDUfCjmwcmxvA0byMsxkjyVewscZHRQYIqRVYqJLkNn
 wPor1GCR68TH0p6yZYKq1wqu9tsFRvjw+G4vY3WNxQdrKdByDyfIbxIm4
 gOBigODhVlU4J2CVpS25jtnWMDUAzndjZqf4PVr6JuncbCcVkb16w3gTO
 y1aUWGmK8hzKXY2iH6mEUVSWV2TMIxCIUq16hTc7YbEyNHpy3yNDzi3Gw g==;
X-CSE-ConnectionGUID: cl/GwFx3RLGB17ql7ZNG+w==
X-CSE-MsgGUID: q8ZANKbxTsm964NwKSzJSA==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4915244"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:10:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:25511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.215:2525]
 with esmtp (Farcaster)
 id ba757776-2879-4802-bc58-6367f185e6c4; Wed, 15 Oct 2025 07:10:15 +0000 (UTC)
X-Farcaster-Flow-ID: ba757776-2879-4802-bc58-6367f185e6c4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:10:15 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:10:13 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 07/21] net/ena: add Rx HW timestamping support
Date: Wed, 15 Oct 2025 10:09:59 +0300
Message-ID: <20251015070959.553-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Add support for retrieving HW timestamps for Rx packets
with nanosecond resolution.
The feature is supported on platforms that set
RTE_ETH_RX_OFFLOAD_TIMESTAMP flag in rx_offload_capa, and is
configurable through setting RTE_ETH_RX_OFFLOAD_TIMESTAMP in dev_conf
rxmode offloads.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 doc/guides/nics/ena.rst                       |  4 +
 doc/guides/rel_notes/release_25_11.rst        |  4 +
 drivers/net/ena/base/ena_com.c                | 80 ++++++++++++++++++-
 drivers/net/ena/base/ena_com.h                | 32 ++++++++
 .../net/ena/base/ena_defs/ena_admin_defs.h    | 44 ++++++++++
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  8 +-
 drivers/net/ena/base/ena_eth_com.c            | 15 ++++
 drivers/net/ena/base/ena_eth_com.h            | 10 ++-
 drivers/net/ena/ena_ethdev.c                  | 79 +++++++++++++++++-
 drivers/net/ena/ena_ethdev.h                  | 18 +++++
 10 files changed, 285 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index cfc78f1e6a..54f44319a2 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -32,6 +32,7 @@ Supported features
 * Watchdog (requires handling of timers in the application)
 * Device reset upon failure
 * Rx interrupts
+* Rx HW packet timestamping
 
 Overview
 --------
@@ -55,6 +56,9 @@ Receive-side scaling (RSS) is supported for multi-core scaling.
 Some of the ENA devices support a working mode called Low-latency
 Queue (LLQ), which saves several more microseconds.
 
+Rx hardware timestamping is available in the ENA driver on platforms that
+support this feature
+
 Management Interface
 --------------------
 
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c3b94e1896..a8fbd0a483 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Amazon ENA (Elastic Network Adapter) net driver.**
+
+  * Added support for retrieving HW timestamps for Rx packets with nanosecond resolution.
+
 * **Added speed 800G.**
 
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 87296168da..db0c09c2f9 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -1129,6 +1129,82 @@ static int ena_com_get_feature(struct ena_com_dev *ena_dev,
 				      feature_ver);
 }
 
+bool ena_com_hw_timestamping_supported(struct ena_com_dev *ena_dev)
+{
+	return ena_com_check_supported_feature_id(ena_dev,
+						  ENA_ADMIN_HW_TIMESTAMP);
+}
+
+int ena_com_get_hw_timestamping_support(struct ena_com_dev *ena_dev,
+					u8 *tx_support,
+					u8 *rx_support)
+{
+	struct ena_admin_get_feat_resp get_resp;
+	int ret;
+
+	*tx_support = ENA_ADMIN_HW_TIMESTAMP_TX_SUPPORT_NONE;
+	*rx_support = ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_NONE;
+
+	if (!ena_com_hw_timestamping_supported(ena_dev)) {
+		ena_trc_dbg(ena_dev, "HW timestamping is not supported\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	ret = ena_com_get_feature(ena_dev,
+				  &get_resp,
+				  ENA_ADMIN_HW_TIMESTAMP,
+				  ENA_ADMIN_HW_TIMESTAMP_FEATURE_VERSION_1);
+
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev,
+			    "Failed to get HW timestamp configuration, error: %d\n",
+			    ret);
+		return ret;
+	}
+
+	*tx_support = get_resp.u.hw_ts.tx;
+	*rx_support = get_resp.u.hw_ts.rx;
+
+	return 0;
+}
+
+int ena_com_set_hw_timestamping_configuration(struct ena_com_dev *ena_dev,
+					      u8 tx_enable,
+					      u8 rx_enable)
+{
+	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
+	int ret;
+
+	if (!ena_com_hw_timestamping_supported(ena_dev)) {
+		ena_trc_dbg(ena_dev, "HW timestamping is not supported\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	memset(&cmd, 0x0, sizeof(cmd));
+
+	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	cmd.feat_common.feature_id = ENA_ADMIN_HW_TIMESTAMP;
+	cmd.u.hw_ts.tx = tx_enable ? ENA_ADMIN_HW_TIMESTAMP_TX_SUPPORT_ALL :
+				     ENA_ADMIN_HW_TIMESTAMP_TX_SUPPORT_NONE;
+	cmd.u.hw_ts.rx = rx_enable ? ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_ALL :
+				     ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_NONE;
+
+	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
+					    (struct ena_admin_aq_entry *)&cmd,
+					    sizeof(cmd),
+					    (struct ena_admin_acq_entry *)&resp,
+					    sizeof(resp));
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev,
+			    "Failed to set HW timestamping configuration, error: %d\n",
+			    ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int ena_com_get_current_hash_function(struct ena_com_dev *ena_dev)
 {
 	return ena_dev->rss.hash_func;
@@ -2471,8 +2547,8 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 		ena_trc_dbg(ena_dev, "AENQ! Group[%x] Syndrome[%x] timestamp: [%" ENA_PRIu64 "s]\n",
 			    aenq_common->group,
 			    aenq_common->syndrome,
-			    ((u64)aenq_common->timestamp_low |
-			    ((u64)aenq_common->timestamp_high << 32)));
+			    ((uint64_t)aenq_common->timestamp_low |
+			    ((uint64_t)aenq_common->timestamp_high << 32)));
 
 		/* Handle specific event*/
 		handler_cb = ena_com_get_specific_aenq_cb(ena_dev,
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 82306aaa9c..bc8e88c7ae 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -1155,6 +1155,38 @@ static inline void ena_com_disable_adaptive_moderation(struct ena_com_dev *ena_d
 	ena_dev->adaptive_coalescing = false;
 }
 
+/* ena_com_hw_timestamping_supported - query whether HW timestamping is
+ *                                     supported by the device
+ * @ena_dev: ENA communication layer struct
+ *
+ * @return - true if the feature is supported or false otherwise
+ */
+bool ena_com_hw_timestamping_supported(struct ena_com_dev *ena_dev);
+
+/* ena_com_get_hw_timestamping_support - query HW timestamping support options
+ *                                       in the device
+ * @ena_dev: ENA communication layer struct
+ * @tx_support: Will hold the TX side supported options
+ * @rx_support: Will hold the RX side supported options
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_get_hw_timestamping_support(struct ena_com_dev *ena_dev,
+					u8 *tx_support,
+					u8 *rx_support);
+
+/* ena_com_set_hw_timestamping_configuration - set HW timestamping configuration
+ *
+ * @ena_dev: ENA communication layer struct
+ * @tx_enable: Enable/Disable TX HW timestamping
+ * @rx_enable: Enable/Disable RX HW timestamping
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_set_hw_timestamping_configuration(struct ena_com_dev *ena_dev,
+					      u8 tx_enable,
+					      u8 rx_enable);
+
 bool ena_com_indirection_table_config_supported(struct ena_com_dev *ena_dev);
 /* ena_com_get_cap - query whether device supports a capability.
  * @ena_dev: ENA communication layer struct
diff --git a/drivers/net/ena/base/ena_defs/ena_admin_defs.h b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
index 707aa32f06..717d21f9b9 100644
--- a/drivers/net/ena/base/ena_defs/ena_admin_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
@@ -68,6 +68,7 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_LINK_CONFIG                       = 27,
 	ENA_ADMIN_HOST_ATTR_CONFIG                  = 28,
 	ENA_ADMIN_PHC_CONFIG                        = 29,
+	ENA_ADMIN_HW_TIMESTAMP                      = 31,
 	ENA_ADMIN_FEATURES_OPCODE_NUM               = 32,
 };
 
@@ -170,6 +171,22 @@ enum ena_admin_frag_bypass_feature_version {
 	/* Enable only */
 	ENA_ADMIN_FRAG_BYPASS_FEATURE_VERSION_0     = 0,
 };
+
+enum ena_admin_hw_timestamp_feature_version {
+	/* RX only - NONE/All Traffic */
+	ENA_ADMIN_HW_TIMESTAMP_FEATURE_VERSION_1    = 1,
+};
+
+enum ena_admin_hw_timestamp_tx_support {
+	ENA_ADMIN_HW_TIMESTAMP_TX_SUPPORT_NONE      = 0,
+	ENA_ADMIN_HW_TIMESTAMP_TX_SUPPORT_ALL       = 1,
+};
+
+enum ena_admin_hw_timestamp_rx_support {
+	ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_NONE      = 0,
+	ENA_ADMIN_HW_TIMESTAMP_RX_SUPPORT_ALL       = 1,
+};
+
 struct ena_admin_aq_common_desc {
 	/* 11:0 : command_id
 	 * 15:12 : reserved12
@@ -711,6 +728,29 @@ struct ena_admin_feature_llq_desc {
 	struct ena_admin_accel_mode_req accel_mode;
 };
 
+struct ena_admin_feature_hw_ts_desc {
+	/* HW timestamp version as defined in
+	 * enum ena_admin_hw_timestamp_feature_version,
+	 * used only for GET command as max supported HW timestamp version by
+	 * device.
+	 */
+	uint8_t version;
+
+	/* TX state
+	 * Used for GET command as device support indication
+	 * Used for SET command as enable/disable
+	 * Supported values from enum ena_admin_hw_timestamp_tx_support
+	 */
+	uint8_t tx;
+
+	/* RX state
+	 * Used for GET command as device support indication
+	 * Used for SET command as enable/disable
+	 * Supported values from enum ena_admin_hw_timestamp_rx_support
+	 */
+	uint8_t rx;
+};
+
 struct ena_admin_feature_frag_bypass_desc {
 	/* Enable frag_bypass */
 	uint8_t enable;
@@ -1152,6 +1192,8 @@ struct ena_admin_get_feat_resp {
 
 		struct ena_admin_feature_phc_desc phc;
 
+		struct ena_admin_feature_hw_ts_desc hw_ts;
+
 		struct ena_admin_get_extra_properties_strings_desc extra_properties_strings;
 
 		struct ena_admin_get_extra_properties_flags_desc extra_properties_flags;
@@ -1194,6 +1236,8 @@ struct ena_admin_set_feat_cmd {
 
 		/* Fragment bypass configuration */
 		struct ena_admin_feature_frag_bypass_desc frag_bypass;
+
+		struct ena_admin_feature_hw_ts_desc hw_ts;
 	} u;
 };
 
diff --git a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
index f35bba3202..bae3b85911 100644
--- a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
@@ -166,9 +166,9 @@ struct ena_eth_io_tx_cdesc {
 struct ena_eth_io_tx_cdesc_ext {
 	struct ena_eth_io_tx_cdesc base;
 
-	uint32_t reserved_w2;
+	uint32_t timestamp_low;
 
-	uint32_t reserved_w3;
+	uint32_t timestamp_high;
 };
 
 struct ena_eth_io_rx_desc {
@@ -263,9 +263,9 @@ struct ena_eth_io_rx_cdesc_ext {
 
 	uint16_t reserved16;
 
-	uint32_t reserved_w6;
+	uint32_t timestamp_low;
 
-	uint32_t reserved_w7;
+	uint32_t timestamp_high;
 };
 
 struct ena_eth_io_intr_reg {
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 212adc7d1f..7d982854c0 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -56,6 +56,11 @@ void ena_com_dump_single_rx_cdesc(struct ena_com_io_cq *io_cq,
 				ENA_FIELD_GET(desc->base.status,
 					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_MBZ17_MASK,
 					ENA_ETH_IO_RX_CDESC_BASE_MBZ17_SHIFT));
+		if (unlikely(ena_com_is_extended_rx_cdesc(io_cq)))
+			ena_trc_err(ena_com_io_cq_to_ena_dev(io_cq),
+				    "RX descriptor timestamp %" ENA_PRIu64 "(nsec)",
+				    (uint64_t)desc->timestamp_low |
+				    (uint64_t)desc->timestamp_high << 32);
 	}
 }
 
@@ -74,6 +79,12 @@ void ena_com_dump_single_tx_cdesc(struct ena_com_io_cq *io_cq,
 			    ENA_FIELD_GET(desc->base.flags,
 				(uint32_t)ENA_ETH_IO_TX_CDESC_MBZ6_MASK,
 				ENA_ETH_IO_TX_CDESC_MBZ6_SHIFT));
+
+		if (unlikely(ena_com_is_extended_tx_cdesc(io_cq)))
+			ena_trc_err(ena_com_io_cq_to_ena_dev(io_cq),
+				    "TX descriptor timestamp %" ENA_PRIu64 "(nsec)",
+				    (uint64_t)desc->timestamp_low |
+				    (uint64_t)desc->timestamp_high << 32);
 	}
 }
 
@@ -683,6 +694,10 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	/* Get rx flags from the last pkt */
 	ena_com_rx_set_flags(ena_rx_ctx, cdesc);
 
+	if (unlikely(ena_com_is_extended_rx_cdesc(io_cq)))
+		ena_rx_ctx->timestamp = (u64)cdesc->timestamp_low |
+					(u64)cdesc->timestamp_high << 32;
+
 	ena_trc_dbg(ena_com_io_cq_to_ena_dev(io_cq),
 		    "l3_proto %d l4_proto %d l3_csum_err %d l4_csum_err %d hash %d frag %d cdesc_status %x\n",
 		    ena_rx_ctx->l3_proto,
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index e56eb2c173..f25e26840d 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -60,6 +60,7 @@ struct ena_com_rx_ctx {
 	u16 descs;
 	u16 max_bufs;
 	u8 pkt_offset;
+	u64 timestamp;
 };
 
 int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
@@ -234,8 +235,9 @@ static inline void ena_com_cq_inc_head(struct ena_com_io_cq *io_cq)
 		io_cq->phase ^= 1;
 }
 
-static inline int ena_com_tx_comp_req_id_get(struct ena_com_io_cq *io_cq,
-					     u16 *req_id)
+static inline int ena_com_tx_comp_metadata_get(struct ena_com_io_cq *io_cq,
+					       u16 *req_id,
+					       u64 *hw_timestamp)
 {
 	struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
 	struct ena_eth_io_tx_cdesc_ext *cdesc;
@@ -279,6 +281,10 @@ static inline int ena_com_tx_comp_req_id_get(struct ena_com_io_cq *io_cq,
 		return ENA_COM_INVAL;
 	}
 
+	if (unlikely(ena_com_is_extended_tx_cdesc(io_cq)))
+		*hw_timestamp = (u64)cdesc->timestamp_low |
+				(u64)cdesc->timestamp_high << 32;
+
 	ena_com_cq_inc_head(io_cq);
 
 	return 0;
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 656e25fbac..a2863f1e22 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -49,6 +49,8 @@
 
 #define MAX_WIDE_LLQ_DEPTH_UNSUPPORTED 0
 
+#define ENA_TS_OFFSET_UNSET -1
+
 /*
  * We should try to keep ENA_CLEANUP_BUF_THRESH lower than
  * RTE_MEMPOOL_CACHE_MAX_SIZE, so we can fit this in mempool local cache.
@@ -719,6 +721,13 @@ static inline void ena_rx_mbuf_prepare(struct ena_ring *rx_ring,
 		ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN;
 	}
 
+	if (rx_ring->ts_mbuf.offset != ENA_TS_OFFSET_UNSET) {
+		*RTE_MBUF_DYNFIELD(mbuf,
+				   rx_ring->ts_mbuf.offset,
+				   rte_mbuf_timestamp_t *) = ena_rx_ctx->timestamp;
+		ol_flags |= rx_ring->ts_mbuf.rx_flag;
+	}
+
 	mbuf->ol_flags = ol_flags;
 	mbuf->packet_type = packet_type;
 }
@@ -1323,6 +1332,54 @@ static int ena_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return rc;
 }
 
+static int ena_set_hw_timestamp_rx_params(struct ena_adapter *adapter,
+					  bool hw_rx_requested)
+{
+	int i, rc, timestamp_offset;
+	uint64_t timestamp_rx_flag;
+	struct ena_ring *rx_ring;
+
+	if (hw_rx_requested) {
+		rc = rte_mbuf_dyn_rx_timestamp_register(&timestamp_offset,
+							&timestamp_rx_flag);
+		if (rc) {
+			PMD_INIT_LOG_LINE(ERR,
+					  "Failed to register Rx timestamp field/flag");
+			return rc;
+		}
+	} else {
+		timestamp_offset = ENA_TS_OFFSET_UNSET;
+		timestamp_rx_flag = 0;
+	}
+
+	for (i = 0; i < adapter->edev_data->nb_rx_queues; i++) {
+		rx_ring = &adapter->rx_ring[i];
+		rx_ring->ts_mbuf.offset = timestamp_offset;
+		rx_ring->ts_mbuf.rx_flag = timestamp_rx_flag;
+	}
+
+	return 0;
+}
+
+static int ena_configure_hw_timestamping(struct ena_adapter *adapter)
+{
+	bool hw_rx_requested = !!(adapter->edev_data->dev_conf.rxmode.offloads &
+				  RTE_ETH_RX_OFFLOAD_TIMESTAMP);
+	int rc;
+
+	rc = ena_com_set_hw_timestamping_configuration(&adapter->ena_dev, false,
+						       hw_rx_requested);
+	if (rc && rc != ENA_COM_UNSUPPORTED) {
+		PMD_INIT_LOG_LINE(ERR,
+				  "Failed to set Rx timestamp configuration");
+		return rc;
+	}
+
+	adapter->ena_dev.use_extended_rx_cdesc = hw_rx_requested;
+
+	return ena_set_hw_timestamp_rx_params(adapter, hw_rx_requested);
+}
+
 static int ena_start(struct rte_eth_dev *dev)
 {
 	struct ena_adapter *adapter = dev->data->dev_private;
@@ -1455,6 +1512,7 @@ static int ena_create_io_queue(struct rte_eth_dev *dev, struct ena_ring *ring)
 	} else {
 		ena_qid = ENA_IO_RXQ_IDX(ring->id);
 		ctx.direction = ENA_COM_IO_QUEUE_DIRECTION_RX;
+		ctx.use_extended_cdesc = ena_dev->use_extended_rx_cdesc;
 		if (rte_intr_dp_is_en(intr_handle))
 			ctx.msix_vector =
 				rte_intr_vec_list_index_get(intr_handle,
@@ -1940,6 +1998,15 @@ static int ena_device_init(struct ena_adapter *adapter,
 		goto err_admin_init;
 	}
 
+	rc = ena_com_get_hw_timestamping_support(ena_dev,
+						 &adapter->ts.hw_tx_supported,
+						 &adapter->ts.hw_rx_supported);
+	if (unlikely(rc && rc != ENA_COM_UNSUPPORTED)) {
+		PMD_DRV_LOG_LINE(ERR,
+			"Cannot get HW timestamping support, rc: %d", rc);
+		goto err_admin_init;
+	}
+
 	aenq_groups = BIT(ENA_ADMIN_LINK_CHANGE) |
 		      BIT(ENA_ADMIN_KEEP_ALIVE) |
 		      BIT(ENA_ADMIN_CONF_NOTIFICATIONS);
@@ -2561,6 +2628,10 @@ static int ena_dev_configure(struct rte_eth_dev *dev)
 	adapter->tx_cleanup_stall_delay = adapter->missing_tx_completion_to / 2;
 
 	rc = ena_configure_aenq(adapter);
+	if (rc)
+		return rc;
+
+	rc = ena_configure_hw_timestamping(adapter);
 
 	return rc;
 }
@@ -2611,6 +2682,9 @@ static uint64_t ena_get_rx_port_offloads(struct ena_adapter *adapter)
 
 	port_offloads |= RTE_ETH_RX_OFFLOAD_SCATTER;
 
+	if (adapter->ts.hw_rx_supported)
+		port_offloads |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
 	return port_offloads;
 }
 
@@ -3231,6 +3305,7 @@ static int ena_tx_cleanup(void *txp, uint32_t free_pkt_cnt)
 	struct ena_ring *tx_ring = (struct ena_ring *)txp;
 	size_t mbuf_cnt = 0;
 	size_t pkt_cnt = 0;
+	uint64_t hw_timestamp = 0;
 	unsigned int total_tx_descs = 0;
 	unsigned int total_tx_pkts = 0;
 	uint16_t cleanup_budget;
@@ -3249,7 +3324,9 @@ static int ena_tx_cleanup(void *txp, uint32_t free_pkt_cnt)
 		struct ena_tx_buffer *tx_info;
 		uint16_t req_id;
 
-		if (ena_com_tx_comp_req_id_get(tx_ring->ena_com_io_cq, &req_id) != 0)
+		if (ena_com_tx_comp_metadata_get(tx_ring->ena_com_io_cq,
+						 &req_id,
+						 &hw_timestamp) != 0)
 			break;
 
 		if (unlikely(validate_tx_req_id(tx_ring, req_id) != 0))
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index 830135bcfd..6a3b004653 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -141,6 +141,18 @@ struct ena_stats_rx {
 	u64 unknown_error;
 };
 
+struct ena_timestamp_config {
+	u8 hw_tx_supported;
+	u8 hw_rx_supported;
+};
+
+struct ena_timestamp_mbuf {
+	/* Dynamic mbuf timestamp flag */
+	uint64_t rx_flag;
+	/* Dynamic mbuf timestamp field offset */
+	int offset;
+};
+
 struct __rte_cache_aligned ena_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
@@ -199,6 +211,9 @@ struct __rte_cache_aligned ena_ring {
 	unsigned int numa_socket_id;
 
 	uint32_t missing_tx_completion_threshold;
+
+	/* Dynamic mbuf params for HW timestamping */
+	struct ena_timestamp_mbuf ts_mbuf;
 };
 
 enum ena_adapter_state {
@@ -350,6 +365,9 @@ struct ena_adapter {
 	uint64_t control_path_poll_interval;
 
 	bool enable_frag_bypass;
+
+	/* HW timestamp support by the device */
+	struct ena_timestamp_config ts;
 	/*
 	 * Helper variables for holding the information about the supported
 	 * metrics.
-- 
2.17.1

