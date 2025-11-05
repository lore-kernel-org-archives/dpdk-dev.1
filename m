Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C71CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:09:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7087E402EF;
	Wed,  5 Nov 2025 08:09:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AF378400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:09:39 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4JN9nu076784 for <dev@dpdk.org>; Tue, 4 Nov 2025 23:09:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 ZFj6XMZus3Bb2SS/grgTYr/oLqxGjqy78o1WXG7ejo=; b=WT8TZMc0E9gJ5e0yo
 2Hz2elX6uZYPV1l7XjlESFfvP8P9vGdaZV0VII1r1l0IgSxNmSSiRLoCeGqBka6X
 PkI4HZPa4KKklG7Rrkq9auJyONdLkwEgCBI6LifGQKxcpc8pukfCuE3yd5PNSYHV
 RwM37f48s+xVxQuVLcaMw80xm96gon/Qbnbf7x4wo1YCxOgA1SDLJpRSQk1mt0Jc
 4ymoDdcqqhsnTEW2st+Vj7HLZ8DjX663p/kNxa4n1k8ykGv65xYsRCCcrSN9h+ZQ
 K+LRJ4hcVVHM2OPkZKegBD4GoQAI/wvIrOMS7U3k4cqvNtEOT8LVS+Xrp0XmxU09
 9PP5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a7nv9th50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Nov 2025 23:09:38 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Nov 2025 23:09:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Nov 2025 23:09:37 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id CEA545E6865;
 Tue,  4 Nov 2025 23:09:34 -0800 (PST)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v3 1/5] common/cnxk: add CPT CQ configuration
Date: Wed, 5 Nov 2025 12:39:28 +0530
Message-ID: <20251105070932.3569572-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029130023.1637177-1-rkudurumalla@marvell.com>
References: <20251029130023.1637177-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA1MSBTYWx0ZWRfX1nmVIIjz6kG/
 aqERNT7q9PzpWndb2YzR9wQIWniob6Y12sfpZAtR3dR5wrVe+c0P1F7hbAaa56hsR6xSWyzG9D1
 LhUpha7H5Kt1LQdNQ4M2ICwUg54gRTtYA3iTqwdKA/8y0FSTjvxDv70Y9sjBpZqubJoCCi6yl34
 O7D1Q2Ew8zTo2523DuH3B8kIrNojeVjAWBoreCM+p4PlbUDzG8cAPL/7YtTcqHgcv5r2e6jzKEG
 Z3nIDo8uQRxvrJsPwa1ZvkYl64Gvsq9luJMwo9PTnkcUEDyKDx9WTruD85u0CZVF945B37Mrhkf
 Z3LyX5lFirgExpfWxfUypL9JtqHlko9Jg1oiE/xFRjrhiMqF5Akon9N6Iz6uVnLwkVvKds+aIT7
 iKUcTz+n/ujz+L14zSmnHhpSiy9edw==
X-Authority-Analysis: v=2.4 cv=aZVsXBot c=1 sm=1 tr=0 ts=690af832 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=zHFdOoqDFk87xL73tuUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: G4zH2uI9uUZXkQYxklKTDLwoDNBOCANn
X-Proofpoint-ORIG-GUID: G4zH2uI9uUZXkQYxklKTDLwoDNBOCANn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
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
v3: Resolve checkpatch issues
 drivers/common/cnxk/hw/cpt.h | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index 4079221676..727cee07b4 100644
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
@@ -307,6 +356,34 @@ struct cpt_inst_s {
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

