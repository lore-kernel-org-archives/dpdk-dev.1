Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED3CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E305C4028E;
	Wed, 29 Oct 2025 14:00:31 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 610C140288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:00:30 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59TCfX7F3884952 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 /OUKVMmXzuqeoITCMga7eESL66RT/iXIQp6Bl0PFGU=; b=Khsa++yzv8iIiJ3uM
 KjuS6aj1kZKvFLpNWmToPF6BAwhu5BgoWJWhGnch2OAhMX2K8k0JkKotHEn1AJzs
 0VdUQ+PjqtHhCDfpJovlLLA+v4A67aKtXNYM0hhHeTAs7MkZ0L1OVubMuMqY4IpN
 H+txa7h080u87IZFxgYr2wGotkHZeNWQNMFhA3K0xpMNB4loyR1RTOOa1M3+xLAH
 ciexGkMWCoqSSPUDbdEOHrgpajCkb+B12npfWCMXnElfalXZh1B8PmTKrxpxs3HX
 naCFtBwCVEvWdZ0/cIAI9rUq/cIowMwYkjE2VjBJgo44IO+D0UkPz3qi5+lvdZvA
 D+tzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a348ma7yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 29 Oct 2025 06:00:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 06:00:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 06:00:38 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 26EA95B6941;
 Wed, 29 Oct 2025 06:00:25 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/5] common/cnxk: add CPT CQ configuration
Date: Wed, 29 Oct 2025 18:30:19 +0530
Message-ID: <20251029130023.1637177-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006051402.1387576-1-rkudurumalla@marvell.com>
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5OSBTYWx0ZWRfX7CsO1HoXSiQS
 FhNUySSAPAqJtT7Uqt3z0msmZiQ/aevsex8B0hrEs83M0nR4F9IogwMjWK06GcG0TbsMEMKLCTv
 KU2g8SYGBfNUAwXZTOjDf+VSqFsGlFGDa+WfmdB/E0nWGlkpEtZMMJX1ywF9eaPNrb0E51s07lD
 KYd7jSm6mjCk0yN8lYZdgKLSLIIdYSoZ6dDq33jKIdRexj4+UH3BULV87OFySMW+kQIEC4eDIX0
 6zIgMQ0s5HUEA1NLxpLr8KmFHVVDJXmDHX/Nuv9oVHWCLKir5fMyb8ZrlWjL4dDpfay9U8TgAwW
 mDPPKfr/nwGLNjo8qsemKbXpJUY6bltlsKLhECsIkn9vfl/Exqq8UiLVffLQNrw3gaMyiTOD6Yn
 LndyhhvkwXBpdLrPahTd4aSIyMOemw==
X-Authority-Analysis: v=2.4 cv=T/mBjvKQ c=1 sm=1 tr=0 ts=69020fed cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=P-QZ-QV2CIGMkEk3wzoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: XuZbSsiy5xqvqjUBnBy3Lsx-9CdExkW6
X-Proofpoint-ORIG-GUID: XuZbSsiy5xqvqjUBnBy3Lsx-9CdExkW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
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
v2: updated doc/guides/nics/cnxk.rst
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

