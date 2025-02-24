Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19AC021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8799D40A76;
	Mon, 24 Feb 2025 10:39:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3B84E40693
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:39:52 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O8UrJS015460
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 jW37RoR1aShtCSVdxb/iCyeE/bBN5heOy3LyD95Srs=; b=P5xJN7PkPXAtzpEHL
 mLwc1ecDJdw08THW9bdy2umkDZ//+7prWRh+JmpqluEEWupLMjQjkco2RrlhjxPR
 j7JJC9hDSWaMJtWT4vs1K9dGJYYJpD4V57EZPeJzV8cMMp0JxSu2qABhA6GwDY1Q
 TdFF5rFTJ/ix5x+G1PHPIeJ4xvuV/e38SDsjsQW0GyBKlub1YuQFiSTSPa5qiV7q
 RcFGpNk6MSVYYhyrwyH5oGMtCi+mG1fUll7m4BlcEoyN8Y8w1TEL02JvJa2dkOPB
 XbTXj+RZ9spvAJ+5BKGLpQ1yI0SrJV5302fDFxltT9noRGHgqPNy2nRdMCsQlahF
 2I5pQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450nasg4g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:39:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:39:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:39:50 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B2B123F705D;
 Mon, 24 Feb 2025 01:39:47 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 10/33] common/cnxk: add 20k defines for IPsec
Date: Mon, 24 Feb 2025 15:08:52 +0530
Message-ID: <20250224093915.1253215-10-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ISD0BrECubSO7uYkkv-_J5xhYUYq5zjT
X-Proofpoint-GUID: ISD0BrECubSO7uYkkv-_J5xhYUYq5zjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Anoob Joseph <anoobj@marvell.com>

Add 20K defines for IPsec.

Signed-off-by: Anoob Joseph <anoobj@marvell.com>
---
 drivers/common/cnxk/meson.build |   1 +
 drivers/common/cnxk/roc_api.h   |   1 +
 drivers/common/cnxk/roc_ie_ow.c |  41 +++
 drivers/common/cnxk/roc_ie_ow.h | 537 ++++++++++++++++++++++++++++++++
 drivers/common/cnxk/version.map |   2 +
 5 files changed, 582 insertions(+)
 create mode 100644 drivers/common/cnxk/roc_ie_ow.c
 create mode 100644 drivers/common/cnxk/roc_ie_ow.h

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 00a352dc55..59f4eacf84 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -25,6 +25,7 @@ sources = files(
         'roc_idev.c',
         'roc_irq.c',
         'roc_ie_ot.c',
+        'roc_ie_ow.c',
         'roc_mbox.c',
         'roc_mcs.c',
         'roc_mcs_sec_cfg.c',
diff --git a/drivers/common/cnxk/roc_api.h b/drivers/common/cnxk/roc_api.h
index 93e7bf11bb..3cee5aa87c 100644
--- a/drivers/common/cnxk/roc_api.h
+++ b/drivers/common/cnxk/roc_api.h
@@ -93,6 +93,7 @@
 #include "roc_ie.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
+#include "roc_ie_ow.h"
 #include "roc_se.h"
 
 /* DPI */
diff --git a/drivers/common/cnxk/roc_ie_ow.c b/drivers/common/cnxk/roc_ie_ow.c
new file mode 100644
index 0000000000..dd83578b62
--- /dev/null
+++ b/drivers/common/cnxk/roc_ie_ow.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+
+
+#include "roc_api.h"
+#include "roc_priv.h"
+
+void
+roc_ow_ipsec_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa)
+{
+	size_t offset;
+
+	memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
+
+	sa->w0.s.pkt_output = ROC_IE_OW_SA_PKT_OUTPUT_NO_FRAG;
+	sa->w0.s.pkt_format = ROC_IE_OW_SA_PKT_FMT_META;
+	sa->w0.s.pkind = ROC_IE_OW_CPT_PKIND;
+	sa->w0.s.et_ovrwr = 1;
+	sa->w2.s.l3hdr_on_err = 1;
+
+	offset = offsetof(struct roc_ow_ipsec_inb_sa, ctx);
+	sa->w0.s.hw_ctx_off = offset / ROC_CTX_UNIT_8B;
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off + 1;
+	sa->w0.s.ctx_size = ROC_IE_OW_CTX_ILEN;
+	sa->w0.s.ctx_hdr_size = ROC_IE_OW_SA_CTX_HDR_SIZE;
+	sa->w0.s.aop_valid = 1;
+}
+
+void
+roc_ow_ipsec_outb_sa_init(struct roc_ow_ipsec_outb_sa *sa)
+{
+	size_t offset;
+
+	memset(sa, 0, sizeof(struct roc_ow_ipsec_outb_sa));
+
+	offset = offsetof(struct roc_ow_ipsec_outb_sa, ctx);
+	sa->w0.s.ctx_push_size = (offset / ROC_CTX_UNIT_8B) + 1;
+	sa->w0.s.ctx_size = ROC_IE_OW_CTX_ILEN;
+	sa->w0.s.aop_valid = 1;
+}
diff --git a/drivers/common/cnxk/roc_ie_ow.h b/drivers/common/cnxk/roc_ie_ow.h
new file mode 100644
index 0000000000..56ca1e7f75
--- /dev/null
+++ b/drivers/common/cnxk/roc_ie_ow.h
@@ -0,0 +1,537 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+
+#ifndef __ROC_IE_OW_H__
+#define __ROC_IE_OW_H__
+
+#include "roc_platform.h"
+
+#include "roc_cpt.h"
+
+/* CN20K IPsec opcodes */
+#define ROC_IE_OW_MAJOR_OP_PROCESS_OUTBOUND_IPSEC 0x28UL
+#define ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC  0x29UL
+
+#define ROC_IE_OW_MAJOR_OP_WRITE_SA 0x01UL
+#define ROC_IE_OW_MINOR_OP_WRITE_SA 0x09UL
+
+#define ROC_IE_OW_CTX_ILEN 2
+
+/* PKIND to be used for CPT Meta parsing */
+#define ROC_IE_OW_CPT_PKIND	  58
+#define ROC_IE_OW_CPT_TS_PKIND	  54
+#define ROC_IE_OW_SA_CTX_HDR_SIZE 1
+
+#define ROC_IE_OW_INPLACE_BIT BIT(6)
+
+enum roc_ie_ow_ucc_ipsec {
+	ROC_IE_OW_UCC_SUCCESS = 0x00,
+	ROC_IE_OW_UCC_ERR_SA_INVAL = 0xb0,
+	ROC_IE_OW_UCC_ERR_SA_EXPIRED = 0xb1,
+	ROC_IE_OW_UCC_ERR_SA_OVERFLOW = 0xb2,
+	ROC_IE_OW_UCC_ERR_SA_ESP_BAD_ALGO = 0xb3,
+	ROC_IE_OW_UCC_ERR_SA_AH_BAD_ALGO = 0xb4,
+	ROC_IE_OW_UCC_ERR_SA_BAD_CTX = 0xb5,
+	ROC_IE_OW_UCC_SA_CTX_FLAG_MISMATCH = 0xb6,
+	ROC_IE_OW_UCC_ERR_AOP_IPSEC = 0xb7,
+	ROC_IE_OW_UCC_ERR_PKT_IP = 0xb8,
+	ROC_IE_OW_UCC_ERR_PKT_IP6_BAD_EXT = 0xb9,
+	ROC_IE_OW_UCC_ERR_PKT_IP6_HBH = 0xba,
+	ROC_IE_OW_UCC_ERR_PKT_IP6_BIGEXT = 0xbb,
+	ROC_IE_OW_UCC_ERR_PKT_IP_ULP = 0xbc,
+	ROC_IE_OW_UCC_ERR_PKT_SA_MISMATCH = 0xbd,
+	ROC_IE_OW_UCC_ERR_PKT_SPI_MISMATCH = 0xbe,
+	ROC_IE_OW_UCC_ERR_PKT_ESP_BADPAD = 0xbf,
+	ROC_IE_OW_UCC_ERR_PKT_BADICV = 0xc0,
+	ROC_IE_OW_UCC_ERR_PKT_REPLAY_SEQ = 0xc1,
+	ROC_IE_OW_UCC_ERR_PKT_BADNH = 0xc2,
+	ROC_IE_OW_UCC_ERR_PKT_SA_PORT_MISMATCH = 0xc3,
+	ROC_IE_OW_UCC_ERR_PKT_BAD_DLEN = 0xc4,
+	ROC_IE_OW_UCC_ERR_SA_ESP_BAD_KEYS = 0xc5,
+	ROC_IE_OW_UCC_ERR_SA_AH_BAD_KEYS = 0xc6,
+	ROC_IE_OW_UCC_ERR_SA_BAD_IP = 0xc7,
+	ROC_IE_OW_UCC_ERR_PKT_IP_FRAG = 0xc8,
+	ROC_IE_OW_UCC_ERR_PKT_REPLAY_WINDOW = 0xc9,
+	ROC_IE_OW_UCC_SUCCESS_PKT_IP_BADCSUM = 0xed,
+	ROC_IE_OW_UCC_SUCCESS_PKT_L4_GOODCSUM = 0xee,
+	ROC_IE_OW_UCC_SUCCESS_PKT_L4_BADCSUM = 0xef,
+	ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST = 0xf0,
+	ROC_IE_OW_UCC_SUCCESS_PKT_UDPESP_NZCSUM = 0xf1,
+	ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN = 0xf2,
+	ROC_IE_OW_UCC_SUCCESS_PKT_UDP_ZEROCSUM = 0xf3,
+	ROC_IE_OW_UCC_SUCCESS_PKT_IP_GOODCSUM = 0x0,
+};
+
+enum {
+	ROC_IE_OW_SA_AR_WIN_DISABLED = 0,
+	ROC_IE_OW_SA_AR_WIN_64 = 1,
+	ROC_IE_OW_SA_AR_WIN_128 = 2,
+	ROC_IE_OW_SA_AR_WIN_256 = 3,
+	ROC_IE_OW_SA_AR_WIN_512 = 4,
+	ROC_IE_OW_SA_AR_WIN_1024 = 5,
+	ROC_IE_OW_SA_AR_WIN_2048 = 6,
+	ROC_IE_OW_SA_AR_WIN_4096 = 7,
+};
+
+enum {
+	ROC_IE_OW_SA_PKT_FMT_FULL = 0,
+	ROC_IE_OW_SA_PKT_FMT_META = 1,
+};
+
+enum {
+	ROC_IE_OW_SA_PKT_OUTPUT_DECRYPTED = 0,
+	ROC_IE_OW_SA_PKT_OUTPUT_NO_FRAG = 1,
+	ROC_IE_OW_SA_PKT_OUTPUT_HW_BASED_DEFRAG = 2,
+	ROC_IE_OW_SA_PKT_OUTPUT_UCODE_BASED_DEFRAG = 3,
+};
+
+enum {
+	ROC_IE_OW_SA_DEFRAG_ALL = 0,
+	ROC_IE_OW_SA_DEFRAG_IN_ORDER = 1,
+	ROC_IE_OW_SA_DEFRAG_IN_REV_ORDER = 2,
+};
+
+enum {
+	ROC_IE_OW_SA_IV_SRC_DEFAULT = 0,
+	ROC_IE_OW_SA_IV_SRC_ENC_CTR = 1,
+	ROC_IE_OW_SA_IV_SRC_FROM_SA = 2,
+};
+
+enum {
+	ROC_IE_OW_SA_COPY_FROM_SA = 0,
+	ROC_IE_OW_SA_COPY_FROM_INNER_IP_HDR = 1,
+};
+
+enum {
+	ROC_IE_OW_SA_INNER_PKT_IP_CSUM_ENABLE = 0,
+	ROC_IE_OW_SA_INNER_PKT_IP_CSUM_DISABLE = 1,
+};
+
+enum {
+	ROC_IE_OW_SA_INNER_PKT_L4_CSUM_ENABLE = 0,
+	ROC_IE_OW_SA_INNER_PKT_L4_CSUM_DISABLE = 1,
+};
+
+enum {
+	ROC_IE_OW_SA_ENCAP_NONE = 0,
+	ROC_IE_OW_SA_ENCAP_UDP = 1,
+	ROC_IE_OW_SA_ENCAP_TCP = 2,
+};
+
+enum {
+	ROC_IE_OW_SA_LIFE_UNIT_OCTETS = 0,
+	ROC_IE_OW_SA_LIFE_UNIT_PKTS = 1,
+};
+
+enum {
+	ROC_IE_OW_SA_IP_HDR_VERIFY_DISABLED = 0,
+	ROC_IE_OW_SA_IP_HDR_VERIFY_DST_ADDR = 1,
+	ROC_IE_OW_SA_IP_HDR_VERIFY_SRC_DST_ADDR = 2,
+};
+
+enum {
+	ROC_IE_OW_REAS_STS_SUCCESS = 0,
+	ROC_IE_OW_REAS_STS_TIMEOUT = 1,
+	ROC_IE_OW_REAS_STS_EVICT = 2,
+	ROC_IE_OW_REAS_STS_BAD_ORDER = 3,
+	ROC_IE_OW_REAS_STS_TOO_MANY = 4,
+	ROC_IE_OW_REAS_STS_HSH_EVICT = 5,
+	ROC_IE_OW_REAS_STS_OVERLAP = 6,
+	ROC_IE_OW_REAS_STS_ZOMBIE = 7,
+	ROC_IE_OW_REAS_STS_L3P_ERR = 8,
+	ROC_IE_OW_REAS_STS_MAX = 9
+};
+
+enum {
+	ROC_IE_OW_ERR_CTL_MODE_NONE = 0,
+	ROC_IE_OW_ERR_CTL_MODE_CLEAR = 1,
+	ROC_IE_OW_ERR_CTL_MODE_RING = 2,
+};
+
+static __plt_always_inline bool
+roc_ie_ow_ucc_is_success(uint8_t ucc)
+{
+	uint8_t uc_base = (uint8_t)ROC_IE_OW_UCC_SUCCESS_PKT_IP_BADCSUM - 1u;
+
+	ucc--;
+	return (ucc >= uc_base);
+}
+
+#define ROC_IPSEC_ERR_RING_MAX_ENTRY 65536
+
+union roc_ow_ipsec_err_ring_head {
+	uint64_t u64;
+	struct {
+		uint16_t tail_pos;
+		uint16_t tail_gen;
+		uint16_t head_pos;
+		uint16_t head_gen;
+	} s;
+};
+
+union roc_ow_ipsec_err_ring_entry {
+	uint64_t u64;
+	struct {
+		uint64_t data0 : 44;
+		uint64_t data1 : 9;
+		uint64_t rsvd : 3;
+		uint64_t comp_code : 8;
+	} s;
+};
+
+/* Common bit fields between inbound and outbound SA */
+union roc_ow_ipsec_sa_word2 {
+	struct {
+		uint64_t valid : 1;
+		uint64_t dir : 1;
+		uint64_t outer_ip_ver : 1;
+		uint64_t rsvd0 : 1;
+		uint64_t mode : 1;
+		uint64_t protocol : 1;
+		uint64_t aes_key_len : 2;
+
+		uint64_t enc_type : 3;
+		uint64_t life_unit : 1;
+		uint64_t auth_type : 4;
+
+		uint64_t encap_type : 2;
+		uint64_t et_ovrwr_ddr_en : 1;
+		uint64_t esn_en : 1;
+		uint64_t tport_l4_incr_csum : 1;
+		uint64_t ip_hdr_verify : 2;
+		uint64_t udp_ports_verify : 1;
+
+		uint64_t rsvd2 : 7;
+		uint64_t async_mode : 1;
+
+		uint64_t spi : 32;
+	} s;
+	uint64_t u64;
+};
+
+PLT_STATIC_ASSERT(sizeof(union roc_ow_ipsec_sa_word2) == 1 * sizeof(uint64_t));
+
+union roc_ow_ipsec_outer_ip_hdr {
+	struct {
+		uint32_t dst_addr;
+		uint32_t src_addr;
+	} ipv4;
+	struct {
+		uint8_t src_addr[16];
+		uint8_t dst_addr[16];
+	} ipv6;
+};
+
+struct roc_ow_ipsec_inb_ctx_update_reg {
+	uint64_t ar_base;
+	uint64_t ar_valid_mask;
+	uint64_t hard_life;
+	uint64_t soft_life;
+	uint64_t mib_octs;
+	uint64_t mib_pkts;
+	uint64_t ar_winbits[ROC_AR_WINBITS_SZ];
+};
+
+union roc_ow_ipsec_outb_iv {
+	uint64_t u64[2];
+	uint8_t iv_dbg[16];
+	struct {
+		uint8_t iv_dbg1[4];
+		uint8_t salt[4];
+
+		uint32_t rsvd;
+		uint8_t iv_dbg2[4];
+	} s;
+};
+
+struct roc_ow_ipsec_outb_ctx_update_reg {
+	union {
+		struct {
+			uint64_t reserved_0_2 : 3;
+			uint64_t address : 57;
+			uint64_t mode : 4;
+		} s;
+		uint64_t u64;
+	} err_ctl;
+
+	uint64_t esn_val;
+	uint64_t hard_life;
+	uint64_t soft_life;
+	uint64_t mib_octs;
+	uint64_t mib_pkts;
+};
+
+union roc_ow_ipsec_outb_param1 {
+	uint16_t u16;
+	struct {
+		uint16_t l4_csum_disable : 1;
+		uint16_t ip_csum_disable : 1;
+		uint16_t ttl_or_hop_limit : 1;
+		uint16_t dummy_pkt : 1;
+		uint16_t rfc_or_override_mode : 1;
+		uint16_t reserved_5_15 : 11;
+	} s;
+};
+
+union roc_ow_ipsec_inb_param1 {
+	uint16_t u16;
+	struct {
+		uint16_t l4_csum_disable : 1;
+		uint16_t ip_csum_disable : 1;
+		uint16_t esp_trailer_disable : 1;
+		uint16_t reserved_3_15 : 13;
+	} s;
+};
+
+struct roc_ow_ipsec_inb_sa {
+	/* Word0 */
+	union {
+		struct {
+			uint64_t ar_win : 3;
+			uint64_t hard_life_dec : 1;
+			uint64_t soft_life_dec : 1;
+			uint64_t count_glb_octets : 1;
+			uint64_t count_glb_pkts : 1;
+			uint64_t count_mib_bytes : 1;
+
+			uint64_t count_mib_pkts : 1;
+			uint64_t hw_ctx_off : 7;
+
+			uint64_t ctx_id : 16;
+
+			uint64_t orig_pkt_fabs : 1;
+			uint64_t orig_pkt_free : 1;
+			uint64_t pkind : 6;
+
+			uint64_t rsvd0 : 1;
+			uint64_t et_ovrwr : 1;
+			uint64_t pkt_output : 2;
+			uint64_t pkt_format : 1;
+			uint64_t defrag_opt : 2;
+			uint64_t x2p_dst : 1;
+
+			uint64_t ctx_push_size : 7;
+			uint64_t rsvd1 : 1;
+
+			uint64_t ctx_hdr_size : 2;
+			uint64_t aop_valid : 1;
+			uint64_t rsvd2 : 1;
+			uint64_t ctx_size : 4;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	/* Word1 */
+	union {
+		struct {
+			uint64_t orig_pkt_aura : 20;
+			uint64_t rsvd3 : 4;
+			uint64_t orig_pkt_foff : 8;
+			uint64_t cookie : 32;
+		} s;
+		uint64_t u64;
+	} w1;
+
+	/* Word 2 */
+	union {
+		struct {
+			uint64_t valid : 1;
+			uint64_t dir : 1;
+			uint64_t outer_ip_ver : 1;
+			uint64_t rsvd4 : 1;
+			uint64_t ipsec_mode : 1;
+			uint64_t ipsec_protocol : 1;
+			uint64_t aes_key_len : 2;
+
+			uint64_t enc_type : 3;
+			uint64_t life_unit : 1;
+			uint64_t auth_type : 4;
+
+			uint64_t encap_type : 2;
+			uint64_t et_ovrwr_ddr_en : 1;
+			uint64_t esn_en : 1;
+			uint64_t tport_l4_incr_csum : 1;
+			uint64_t ip_hdr_verify : 2;
+			uint64_t udp_ports_verify : 1;
+
+			uint64_t l3hdr_on_err : 1;
+			uint64_t rsvd6 : 6;
+			uint64_t async_mode : 1;
+
+			uint64_t spi : 32;
+		} s;
+		uint64_t u64;
+	} w2;
+
+	/* Word3 */
+	uint64_t rsvd7;
+
+	/* Word4 - Word7 */
+	uint8_t cipher_key[ROC_CTX_MAX_CKEY_LEN];
+
+	/* Word8 - Word9 */
+	union {
+		struct {
+			uint32_t rsvd8;
+			uint8_t salt[4];
+		} s;
+		uint64_t u64;
+	} w8;
+	uint64_t rsvd9;
+
+	/* Word10 */
+	union {
+		struct {
+			uint64_t rsvd10 : 32;
+			uint64_t udp_src_port : 16;
+			uint64_t udp_dst_port : 16;
+		} s;
+		uint64_t u64;
+	} w10;
+
+	/* Word11 - Word14 */
+	union roc_ow_ipsec_outer_ip_hdr outer_hdr;
+
+	/* Word15 - Word30 */
+	uint8_t hmac_opad_ipad[ROC_CTX_MAX_OPAD_IPAD_LEN];
+
+	/* Word31 - Word100 */
+	struct roc_ow_ipsec_inb_ctx_update_reg ctx;
+};
+
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, w1) == 1 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, w2) == 2 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, cipher_key) == 4 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, w8) == 8 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, w10) == 10 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, outer_hdr) == 11 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, hmac_opad_ipad) == 15 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_inb_sa, ctx) == 31 * sizeof(uint64_t));
+
+struct roc_ow_ipsec_outb_sa {
+	/* Word0 */
+	union {
+		struct {
+			uint64_t esn_en : 1;
+			uint64_t ip_id : 1;
+			uint64_t rsvd0 : 1;
+			uint64_t hard_life_dec : 1;
+			uint64_t soft_life_dec : 1;
+			uint64_t count_glb_octets : 1;
+			uint64_t count_glb_pkts : 1;
+			uint64_t count_mib_bytes : 1;
+
+			uint64_t count_mib_pkts : 1;
+			uint64_t hw_ctx_off : 7;
+
+			uint64_t ctx_id : 16;
+			uint64_t rsvd1 : 16;
+
+			uint64_t ctx_push_size : 7;
+			uint64_t rsvd2 : 1;
+
+			uint64_t ctx_hdr_size : 2;
+			uint64_t aop_valid : 1;
+			uint64_t rsvd3 : 1;
+			uint64_t ctx_size : 4;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	/* Word1 */
+	union {
+		struct {
+			uint64_t rsvd4 : 32;
+			uint64_t cookie : 32;
+		} s;
+		uint64_t u64;
+	} w1;
+
+	/* Word 2 */
+	union {
+		struct {
+			uint64_t valid : 1;
+			uint64_t dir : 1;
+			uint64_t outer_ip_ver : 1;
+			uint64_t rsvd5 : 1;
+			uint64_t ipsec_mode : 1;
+			uint64_t ipsec_protocol : 1;
+			uint64_t aes_key_len : 2;
+
+			uint64_t enc_type : 3;
+			uint64_t life_unit : 1;
+			uint64_t auth_type : 4;
+
+			uint64_t encap_type : 2;
+			uint64_t ipv4_df_src_or_ipv6_flw_lbl_src : 1;
+			uint64_t dscp_src : 1;
+			uint64_t iv_src : 2;
+			uint64_t ipid_gen : 1;
+			uint64_t rsvd6 : 1;
+
+			uint64_t rsvd7 : 7;
+			uint64_t async_mode : 1;
+
+			uint64_t spi : 32;
+		} s;
+		uint64_t u64;
+	} w2;
+
+	/* Word3 */
+	union {
+		struct {
+			uint64_t hoplimit : 8;
+			uint64_t rsvd8 : 56;
+		} s;
+		uint64_t u64;
+	} w3;
+
+	/* Word4 - Word7 */
+	uint8_t cipher_key[ROC_CTX_MAX_CKEY_LEN];
+
+	/* Word8 - Word9 */
+	union roc_ow_ipsec_outb_iv iv;
+
+	/* Word10 */
+	union {
+		struct {
+			uint64_t rsvd9 : 4;
+			uint64_t ipv4_df_or_ipv6_flw_lbl : 20;
+
+			uint64_t dscp : 6;
+			uint64_t rsvd10 : 2;
+
+			uint64_t udp_dst_port : 16;
+
+			uint64_t udp_src_port : 16;
+		} s;
+		uint64_t u64;
+	} w10;
+
+	/* Word11 - Word14 */
+	union roc_ow_ipsec_outer_ip_hdr outer_hdr;
+
+	/* Word15 - Word30 */
+	uint8_t hmac_opad_ipad[ROC_CTX_MAX_OPAD_IPAD_LEN];
+
+	/* Word31 - Word36 */
+	struct roc_ow_ipsec_outb_ctx_update_reg ctx;
+};
+
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, w1) == 1 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, w2) == 2 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, cipher_key) == 4 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, iv) == 8 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, w10) == 10 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, outer_hdr) == 11 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, hmac_opad_ipad) == 15 * sizeof(uint64_t));
+PLT_STATIC_ASSERT(offsetof(struct roc_ow_ipsec_outb_sa, ctx) == 31 * sizeof(uint64_t));
+
+#define ROC_OW_IPSEC_SA_SZ_MAX \
+	(PLT_MAX(sizeof(struct roc_ow_ipsec_inb_sa), sizeof(struct roc_ow_ipsec_outb_sa)))
+
+void __roc_api roc_ow_ipsec_inb_sa_init(struct roc_ow_ipsec_inb_sa *sa);
+void __roc_api roc_ow_ipsec_outb_sa_init(struct roc_ow_ipsec_outb_sa *sa);
+
+#endif /* __ROC_IE_OW_H__ */
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index dc8fb1b29f..03b37d7841 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -499,6 +499,8 @@ INTERNAL {
 	roc_npc_validate_portid_action;
 	roc_ot_ipsec_inb_sa_init;
 	roc_ot_ipsec_outb_sa_init;
+	roc_ow_ipsec_inb_sa_init;
+	roc_ow_ipsec_outb_sa_init;
 	roc_plt_control_lmt_id_get;
 	roc_plt_init;
 	roc_plt_init_cb_register;
-- 
2.34.1

