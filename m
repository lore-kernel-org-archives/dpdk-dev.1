Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6875ECCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4B8C40A73;
	Tue, 14 Oct 2025 09:20:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3C2D0402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 08:00:51 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C6391A1BEF;
 Tue, 14 Oct 2025 08:00:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB8621A1BE7;
 Tue, 14 Oct 2025 08:00:50 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5F44F1800093;
 Tue, 14 Oct 2025 14:00:50 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 14/15] net/dpaa2: add eCPRI header and message dump
Date: Tue, 14 Oct 2025 11:30:44 +0530
Message-ID: <20251014060045.1304694-15-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

From: Jun Yang <jun.yang@nxp.com>

Dump ECPRI header over ethernet/vlan/udp.
Dump message contents according to various types.
ECPRI are set to parser result areas by softparser.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_parse_dump.h | 124 +++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_parse_dump.h b/drivers/net/dpaa2/dpaa2_parse_dump.h
index 78fd3b768c..bcab3bf0cb 100644
--- a/drivers/net/dpaa2/dpaa2_parse_dump.h
+++ b/drivers/net/dpaa2/dpaa2_parse_dump.h
@@ -74,6 +74,122 @@ struct dpaa2_fapr_field_info support_dump_fields[] = {
 	}
 };
 
+static inline void
+dpaa2_print_ecpri(struct dpaa2_fapr_array *fapr)
+{
+	uint8_t ecpri_type;
+	struct rte_ecpri_combined_msg_hdr ecpri_msg;
+
+	ecpri_type = fapr->pr[DPAA2_FAFE_PSR_OFFSET];
+	if ((ecpri_type >> 1) > 7) {
+		DPAA2_PR_PRINT("Invalid ECPRI type(0x%02x)\r\n",
+			ecpri_type);
+	} else {
+		DPAA2_PR_PRINT("ECPRI type %d present\r\n",
+			ecpri_type >> 1);
+		if (ecpri_type == ECPRI_FAFE_TYPE_0 ||
+			ecpri_type == ECPRI_FAFE_TYPE_1) {
+			/* Type 0 is identical to type1*/
+			ecpri_msg.type0.pc_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
+			ecpri_msg.type0.pc_id =
+				ecpri_msg.type0.pc_id << 8;
+			ecpri_msg.type0.pc_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+
+			ecpri_msg.type0.seq_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
+			ecpri_msg.type0.seq_id =
+				ecpri_msg.type0.seq_id << 8;
+			ecpri_msg.type0.seq_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
+
+			DPAA2_PR_PRINT("pc_id(0x%04x) seq_id(0x%04x)\r\n",
+				rte_be_to_cpu_16(ecpri_msg.type0.pc_id),
+				rte_be_to_cpu_16(ecpri_msg.type0.seq_id));
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_2) {
+			ecpri_msg.type2.rtc_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
+			ecpri_msg.type2.rtc_id =
+				ecpri_msg.type2.rtc_id << 8;
+			ecpri_msg.type2.rtc_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+
+			ecpri_msg.type2.seq_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
+			ecpri_msg.type2.seq_id =
+				ecpri_msg.type2.seq_id << 8;
+			ecpri_msg.type2.seq_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
+
+			DPAA2_PR_PRINT("rtc_id(0x%04x) seq_id(0x%04x)\r\n",
+				rte_be_to_cpu_16(ecpri_msg.type2.rtc_id),
+				rte_be_to_cpu_16(ecpri_msg.type2.seq_id));
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_3) {
+			DPAA2_PR_PRINT("ECPRI type3 extract not support\r\n");
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_4) {
+			ecpri_msg.type4.rma_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+			ecpri_msg.type4.rw =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] >> 4;
+			ecpri_msg.type4.rr =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] & 0xf;
+
+			ecpri_msg.type4.ele_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
+			ecpri_msg.type4.ele_id =
+				ecpri_msg.type4.ele_id << 8;
+			ecpri_msg.type4.ele_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
+
+			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)",
+				ecpri_msg.type4.rma_id, ecpri_msg.type4.rw);
+			DPAA2_PR_PRINT(" rr(0x%02x) ele_id(0x%04x)\r\n",
+				ecpri_msg.type4.rr,
+				rte_be_to_cpu_16(ecpri_msg.type4.ele_id));
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_5) {
+			ecpri_msg.type5.msr_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+			ecpri_msg.type5.act_type =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
+
+			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)\r\n",
+				ecpri_msg.type5.msr_id,
+				ecpri_msg.type5.act_type);
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_6) {
+			ecpri_msg.type6.rst_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
+			ecpri_msg.type6.rst_id =
+				ecpri_msg.type6.rst_id << 8;
+			ecpri_msg.type6.rst_id |=
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+
+			ecpri_msg.type6.rst_op =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
+
+			DPAA2_PR_PRINT("rst_id(0x%04x) rst_op(0x%02x)\r\n",
+				rte_be_to_cpu_16(ecpri_msg.type6.rst_id),
+				ecpri_msg.type6.rst_op);
+		} else if (ecpri_type == ECPRI_FAFE_TYPE_7) {
+			ecpri_msg.type7.evt_id =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
+			ecpri_msg.type7.evt_type =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
+			ecpri_msg.type7.seq =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
+			ecpri_msg.type7.number =
+				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
+
+			DPAA2_PR_PRINT("evt_id(0x%02x) evt_type(0x%02x)",
+				ecpri_msg.type7.evt_id,
+				ecpri_msg.type7.evt_type);
+			DPAA2_PR_PRINT(" seq(0x%02x) number(0x%02x)\r\n",
+				ecpri_msg.type7.seq,
+				ecpri_msg.type7.number);
+		}
+	}
+}
+
 static inline void
 dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
 {
@@ -82,6 +198,7 @@ dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
 	int i, byte_pos, bit_pos, vxlan = 0, vxlan_vlan = 0;
 	struct rte_ether_hdr vxlan_in_eth;
 	uint16_t vxlan_vlan_tci;
+	int ecpri = 0;
 
 	for (i = 0; i < faf_bit_len; i++) {
 		faf_bits[i].position = i;
@@ -111,6 +228,8 @@ dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
 			faf_bits[i].name = "UDP Present";
 		else if (i == FAF_TCP_FRAM)
 			faf_bits[i].name = "TCP Present";
+		else if (i == FAFE_ECPRI_FRAM)
+			faf_bits[i].name = "ECPRI Present";
 		else
 			faf_bits[i].name = "Check RM for this unusual frame";
 	}
@@ -124,6 +243,8 @@ dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
 				faf_bits[i].position, faf_bits[i].name);
 			if (i == FAF_VXLAN_FRAM)
 				vxlan = 1;
+			else if (i == FAFE_ECPRI_FRAM)
+				ecpri = 1;
 		}
 	}
 
@@ -192,6 +313,9 @@ dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
 				vxlan_vlan_tci);
 		}
 	}
+
+	if (ecpri)
+		dpaa2_print_ecpri(fapr);
 }
 
 static inline void
-- 
2.43.0

