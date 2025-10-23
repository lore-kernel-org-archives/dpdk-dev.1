Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A3CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65D204067C;
	Thu, 23 Oct 2025 19:27:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C1286402EE
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3cppT021903
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 v7Szwfd1J1IXECkxZiULhtxkQ2IrF77QtNYD2jZCW8=; b=Nz0ApVClSyYxgknhV
 3xDcta7FSB7dTIVMe4+jfwRUYOyKxRjhQEWho/y7I49k1khDguQk1eNCtJiAwGZW
 MSMhyOzp7+7i6o1vXXOsHElXeUSasLl6i7zDxlePU930oUMej0D/39gq4/Sdn91t
 pFM3taNgBk6kt+dloD7N9LW/V9B984X/FqA3o+hEER/Z/r8pjtSleQzRALmnCd81
 Q9nwNkmbVEPnFAI7/0d0D/k/ftJn1oue6938URRiA+eKv7JrPDPok2VUJs3HOJxQ
 Vr/8CX1ReSNLTKEGqZowVZ502R8eUSTIPtXtwNemz/Vj8FTlTGdOG5DxuEhDBL6i
 LMZpg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr1w5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:27:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:27:52 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 225883F7068;
 Thu, 23 Oct 2025 10:27:49 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 07/19] common/cnxk: add IPv4 fragmentation offload
Date: Thu, 23 Oct 2025 22:57:15 +0530
Message-ID: <20251023172728.770661-7-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hsyc7N-O_fkr5YCCmG3ya2FhEmbu6S3v
X-Proofpoint-GUID: hsyc7N-O_fkr5YCCmG3ya2FhEmbu6S3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX1EoEH8EHb7JA
 /vo5uiibIBEXswHztvfqEXEZTXQ4ugOe6hHDVtzp2XybfWIV26+o/yhDHSTWJ8yxJHciHd3VSQy
 X0GXjdkRshC1cNn14MUpQoa3dZ/7Q01immdMQlMx+jQXSD5d/ElI7kL3TAXMuvHx76S57BsuIPr
 OEqTR/v2jMtgVI5VSyeiBy4518PJJ06Q2+jwjSxgPX9wFDDKYFRKN8V3IxXc7I7Dd51fw/wbOkb
 xSNIg9XMbjLGod/Cd4Duh+G/UIawN06pN1JNGk0s2AMfhF2EKcouguraiknlYOJIi8uDFryKqUv
 5wLRleELrBItdv5EEhFjUanW8o4ShmL47VaotFdwUJn1EjSZ++x2OB2YhbPFs1PoTV/XeoxAgWJ
 MI6OJLJGqM2vZglXtoDHglYpPbOLtA==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa6599 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=QGoeRDoOkeeAEG8Ov14A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

Extend LSO offload to support IPv4 fragmentation.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/hw/nix.h                  |   2 +-
 drivers/common/cnxk/roc_nix.h                 |   8 ++
 drivers/common/cnxk/roc_nix_ops.c             | 113 +++++++++++++++++-
 drivers/common/cnxk/roc_nix_priv.h            |   1 +
 .../common/cnxk/roc_platform_base_symbols.c   |   2 +
 5 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index f5811ee1ab..8956b95040 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2692,7 +2692,7 @@ typedef union nix_lso_alt_flg_format {
 #define NIX_LSO_SEG_MAX 256
 #define NIX_LSO_MPS_MAX (BIT_ULL(14) - 1)
 
-/* Software defined LSO base format IDX */
+/* Kernel defined LSO base format IDX */
 #define NIX_LSO_FORMAT_IDX_TSOV4 0
 #define NIX_LSO_FORMAT_IDX_TSOV6 1
 
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a156d83200..35eb855986 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -28,6 +28,11 @@
 #define ROC_NIX_INTF_TYPE_CPT_NIX 254
 #define ROC_NIX_INTF_TYPE_SSO     253
 
+/* Software defined LSO base format IDX */
+#define ROC_NIX_LSO_FORMAT_IDX_TSOV4 0
+#define ROC_NIX_LSO_FORMAT_IDX_TSOV6 1
+#define ROC_NIX_LSO_FORMAT_IDX_IPV4  2
+
 enum roc_nix_rss_reta_sz {
 	ROC_NIX_RSS_RETA_SZ_64 = 64,
 	ROC_NIX_RSS_RETA_SZ_128 = 128,
@@ -878,9 +883,12 @@ int __roc_api roc_nix_lso_fmt_setup(struct roc_nix *roc_nix);
 int __roc_api roc_nix_lso_fmt_get(struct roc_nix *roc_nix,
 				  uint8_t udp_tun[ROC_NIX_LSO_TUN_MAX],
 				  uint8_t tun[ROC_NIX_LSO_TUN_MAX]);
+int __roc_api roc_nix_lso_fmt_ipv4_frag_get(struct roc_nix *roc_nix);
 int __roc_api roc_nix_lso_custom_fmt_setup(struct roc_nix *roc_nix,
 					   struct nix_lso_format *fields,
 					   uint16_t nb_fields);
+int __roc_api roc_nix_lso_alt_flags_profile_setup(struct roc_nix *roc_nix,
+						  nix_lso_alt_flg_format_t *fmt);
 
 int __roc_api roc_nix_eeprom_info_get(struct roc_nix *roc_nix,
 				      struct roc_nix_eeprom_info *info);
diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index efb0a41d07..138090317a 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -5,6 +5,8 @@
 #include "roc_api.h"
 #include "roc_priv.h"
 
+#define NIX_LSO_FRMT_IPV4_OFFSET_SHFT 3
+
 static void
 nix_lso_tcp(struct nix_lso_format_cfg *req, bool v4)
 {
@@ -159,6 +161,34 @@ nix_lso_tun_tcp(struct nix_lso_format_cfg *req, bool outer_v4, bool inner_v4)
 	field++;
 }
 
+int
+roc_nix_lso_alt_flags_profile_setup(struct roc_nix *roc_nix, nix_lso_alt_flg_format_t *fmt)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox = mbox_get(dev->mbox);
+	struct nix_lso_alt_flags_cfg_rsp *rsp;
+	struct nix_lso_alt_flags_cfg_req *req;
+	int rc = -ENOSPC;
+
+	req = mbox_alloc_msg_nix_lso_alt_flags_cfg(mbox);
+	if (req == NULL)
+		goto exit;
+
+	req->cfg = fmt->u[0];
+	req->cfg1 = fmt->u[1];
+
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+
+	plt_nix_dbg("Setup alt flags format %u", rsp->lso_alt_flags_idx);
+	rc = rsp->lso_alt_flags_idx;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_nix_lso_custom_fmt_setup(struct roc_nix *roc_nix,
 			     struct nix_lso_format *fields, uint16_t nb_fields)
@@ -194,6 +224,74 @@ roc_nix_lso_custom_fmt_setup(struct roc_nix *roc_nix,
 	return rc;
 }
 
+static int
+nix_lso_ipv4(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct nix_lso_format_cfg_rsp *rsp;
+	nix_lso_alt_flg_format_t alt_flags;
+
+	__io struct nix_lso_format *field;
+	struct nix_lso_format_cfg *req;
+	int flag_idx = 0, rc = -ENOSPC;
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox;
+
+	/* First get flags profile to update v4 flags */
+	memset(&alt_flags, 0, sizeof(alt_flags));
+	alt_flags.s.alt_fsf_set = 0x2000;
+	alt_flags.s.alt_fsf_mask = 0x1FFF;
+	alt_flags.s.alt_msf_set = 0x2000;
+	alt_flags.s.alt_msf_mask = 0x1FFF;
+	alt_flags.s.alt_lsf_set = 0x0000;
+	alt_flags.s.alt_lsf_mask = 0x1FFF;
+	flag_idx = roc_nix_lso_alt_flags_profile_setup(roc_nix, &alt_flags);
+	if (flag_idx < 0)
+		return rc;
+
+	mbox = mbox_get(dev->mbox);
+
+	/*
+	 * IPv4 Fragmentation
+	 */
+	req = mbox_alloc_msg_nix_lso_format_cfg(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	/* Format works only with TCP packet marked by OL3/OL4 */
+	field = (__io struct nix_lso_format *)&req->fields[0];
+	req->field_mask = NIX_LSO_FIELD_MASK;
+	/* Update Payload Length */
+	field->layer = NIX_TXLAYER_OL3;
+	field->offset = 2;
+	field->sizem1 = 1; /* 2B */
+	field->alg = NIX_LSOALG_ADD_PAYLEN;
+	field++;
+
+	/* Update fragment offset and flags */
+	field->layer = NIX_TXLAYER_OL3;
+	field->offset = 6;
+	field->sizem1 = 1;
+	field->shift = NIX_LSO_FRMT_IPV4_OFFSET_SHFT;
+	field->alt_flags_index = flag_idx;
+	field->alt_flags = 1;
+	/* Cumulative length of previous segments */
+	field->alg = NIX_LSOALG_ADD_OFFSET;
+	field++;
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+
+	/* IPv4 fragment offset shifted by 3 bits, store this value in profile ID */
+	nix->lso_ipv4_idx = (NIX_LSO_FRMT_IPV4_OFFSET_SHFT << 8) | (rsp->lso_format_idx & 0x1F);
+	plt_nix_dbg("ipv4 fmt=%u", rsp->lso_format_idx);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_nix_lso_fmt_setup(struct roc_nix *roc_nix)
 {
@@ -370,12 +468,25 @@ roc_nix_lso_fmt_setup(struct roc_nix *roc_nix)
 
 	nix->lso_tun_idx[ROC_NIX_LSO_TUN_V6V6] = rsp->lso_format_idx;
 	plt_nix_dbg("tun v6v6 fmt=%u", rsp->lso_format_idx);
-	rc = 0;
+
 exit:
 	mbox_put(mbox);
+
+	nix->lso_ipv4_idx = 0; /* IPv4 fragmentation not supported */
+	if (!rc && roc_model_is_cn20k())
+		return nix_lso_ipv4(roc_nix);
+
 	return rc;
 }
 
+int
+roc_nix_lso_fmt_ipv4_frag_get(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+
+	return nix->lso_ipv4_idx;
+}
+
 int
 roc_nix_lso_fmt_get(struct roc_nix *roc_nix,
 		    uint8_t udp_tun[ROC_NIX_LSO_TUN_MAX],
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index d7ea3c6be2..dc61a55d1b 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -152,6 +152,7 @@ struct nix {
 	uint8_t lso_tsov4_idx;
 	uint8_t lso_udp_tun_idx[ROC_NIX_LSO_TUN_MAX];
 	uint8_t lso_tun_idx[ROC_NIX_LSO_TUN_MAX];
+	uint16_t lso_ipv4_idx;
 	uint8_t lf_rx_stats;
 	uint8_t lf_tx_stats;
 	uint8_t rx_chan_cnt;
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index cc35c46456..7174e5fe08 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -323,9 +323,11 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_rx_ena_dis)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mcast_config)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_alt_flags_profile_setup)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_custom_fmt_setup)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_setup)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_ipv4_frag_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_switch_hdr_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_eeprom_info_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_drop_re_set)
-- 
2.34.1

