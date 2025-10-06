Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0CCCA470
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 05:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02FB8402E3;
	Mon,  6 Oct 2025 07:14:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7AFC2402E2
 for <dev@dpdk.org>; Mon,  6 Oct 2025 07:14:10 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5964rPwg014238
 for <dev@dpdk.org>; Sun, 5 Oct 2025 22:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Te5XRO9vI8K3ZT6jJOt2uxA
 F953dLiqnboX4BOJmy2c=; b=ZUf64vJFl8OGLoaI8DAlZdgDCnjSLJgAzLrpeo3
 xzzMQmJ6G9lJcNr9AFmrKU3QcdNcU3Va/XR03o2eu0yuUDj2BtYoBzeCHjNInEqe
 Or9+cjCKqw20OQaHKF8UmpP99SeAztM3qkpowdh9DDSCL1MEZtUyDrbuYTSReo7Z
 xOzSg9ilnXfiaDU8sU0p0B2zi2i/09dV61chxZMyliLGjuUXxr8wjy+Xu9pFVu2L
 xBsmgSMKSkriNOhVSCyhumLJiZoZMQlXIJ+Ueve3qLO1kq7vNqcCI9qhl/n1Zvia
 vp0HtzVYaGYuESglOPVViTMKugSW1Xev3wnOh2vHbr3pU6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49m74y80u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 05 Oct 2025 22:14:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 5 Oct 2025 22:14:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 5 Oct 2025 22:14:18 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id C94B13F705A;
 Sun,  5 Oct 2025 22:14:05 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH 1/5] common/cnxk: add CPT CQ configuration
Date: Mon, 6 Oct 2025 10:43:58 +0530
Message-ID: <20251006051402.1387576-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s1xZoHX-61ZuRIxsnqjZgmU7FrhciYLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDAzNiBTYWx0ZWRfX7Ybneveqkpwl
 e3m1ipvd2YQIBCD+RDyGuic8dENLPYo4MPdd4aFIQcLGtrOuN8VoHcN1jV2eV4lvGAPNmHzRFiB
 hiPtnNY8Zb2RMviaEAq5Y7dTWJBE4CdAcrLWIaH3C6jlSMZyqdj1718DF99DF/0lhz5YQY5q+lL
 Ernwfi01rrht9pwSyvwIUvwFnleF3LfMkmSULrS5nW6su16y8J11UW559l3ul1dQKh8h7pC+wOp
 GJ6OiTkE2GhjouJjC9Mu8xRh14eR283Q3R8290Tyxm1UcZvmmDaOgKt8IwknpJzKaODqFXBcOkb
 2dj+YioRRc1JMKlgEVXzMtDiGOJgoVZw20+7C3k2KXdBvnPIV8TopzYs2h8n2udzV+3h+jO7q5S
 CTV5dtJLDNN/t6Ms3da9h4LTJyQSdg==
X-Authority-Analysis: v=2.4 cv=f6hFxeyM c=1 sm=1 tr=0 ts=68e35021 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=TsjYUoI9xJG_-VsspE0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: s1xZoHX-61ZuRIxsnqjZgmU7FrhciYLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
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

Add new structures to used initialize and enable & disable
CPT CQ

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index e542f3a3d4..19a1b87ae6 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -36,6 +36,10 @@
 #define CPT_LF_Q_SIZE		(0x100ull)
 #define CPT_LF_Q_INST_PTR	(0x110ull)
 #define CPT_LF_Q_GRP_PTR	(0x120ull)
+#define CPT_LF_CQ_BASE		(0x200ull)
+#define CPT_LF_CQ_SIZE		(0x210ull)
+#define CPT_LF_CQ_PTR		(0x220ull)
+#define CPT_LF_CQ_CTL		(0x230ull)
 #define CPT_LF_NQX(a)		(0x400ull | (uint64_t)(a) << 3)
 #define CPT_LF_CTX_CTL		(0x500ull)
 #define CPT_LF_CTX_FLUSH	(0x510ull)
@@ -87,6 +91,24 @@ union cpt_eng_caps {
 	};
 };
 
+union cpt_lf_cq_ctl {
+	uint64_t u;
+	struct cpt_lf_cq_ctl_s {
+		uint64_t ena : 1;
+		uint64_t fc_ena : 1;
+		uint64_t fc_up_crossing : 1;
+		uint64_t reserved_3_3 : 1;
+		uint64_t fc_hyst_bits : 4;
+		uint64_t reserved_8_15 : 8;
+		uint64_t entry_size : 2;
+		uint64_t reserved_18_23 : 6;
+		uint64_t dq_ack_ena : 1;
+		uint64_t cq_all : 1;
+		uint64_t reserved_26_43 : 18;
+		uint64_t busy_count : 20;
+	} s;
+};
+
 union cpt_lf_ctl {
 	uint64_t u;
 	struct cpt_lf_ctl_s {
@@ -161,6 +183,16 @@ union cpt_lf_q_inst_ptr {
 	} s;
 };
 
+union cpt_lf_cq_ptr {
+	uint64_t u;
+	struct cpt_lf_cq_ptr_s {
+		uint64_t count : 20;
+		uint64_t reserved_20_31 : 12;
+		uint64_t nq_ptr : 20;
+		uint64_t reserved_52_63 : 12;
+	} s;
+};
+
 union cpt_lf_q_base {
 	uint64_t u;
 	struct cpt_lf_q_base_s {
@@ -180,6 +212,23 @@ union cpt_lf_q_size {
 	} s;
 };
 
+union cpt_lf_cq_base {
+	uint64_t u;
+	struct cpt_lf_cq_base_s {
+		uint64_t reserved_0_6 : 7;
+		uint64_t addr : 46;
+		uint64_t reserved_53_63 : 11;
+	} s;
+};
+
+union cpt_lf_cq_size {
+	uint64_t u;
+	struct cpt_lf_cq_size_s {
+		uint64_t size : 20;
+		uint64_t reserved_20_63 : 44;
+	} s;
+};
+
 union cpt_lf_misc_int {
 	uint64_t u;
 	struct cpt_lf_misc_int_s {
@@ -297,6 +346,34 @@ struct cpt_inst_s {
 	union cpt_inst_w7 w7;
 };
 
+struct cpt_cq_s {
+	union cpt_cq_w0 {
+		struct {
+			uint64_t compcode : 7;
+			uint64_t doneint : 1;
+			uint64_t uc_compcode : 8;
+			uint64_t uc_info : 48;
+		} s;
+		uint64_t u64;
+	} w0;
+
+	struct {
+		uint64_t esn : 64;
+	} w1;
+
+	union cpt_cq_w2 {
+		struct {
+			uint64_t fmt : 2;
+			uint64_t rsv : 14;
+			uint64_t uc_info2 : 48;
+		} s;
+	} w2;
+
+	struct {
+		uint64_t comp_ptr : 64;
+	} w3;
+};
+
 union cpt_res_s {
 	struct cpt_cn20k_res_s {
 		uint64_t compcode : 7;
-- 
2.25.1

