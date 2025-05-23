Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335BC54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0FC40B92;
	Fri, 23 May 2025 15:52:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E4B4140DCF
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8S4006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 ADd6f4fsrikhj/zdb92IdrhiAqSlmjw9XuQXW6mgJY=; b=UjyGwJCOQ3KZqU40R
 YklO0vTyE+DPRlGgO/DZVH273hbUIcxrDuf6g1Z2A95jUWlYIct0O9Gcx3gMcZOI
 sDoFuJ/jAn3VDdr05FegemCsUTj6rnPHE8QAFTLEj8vnhV+haFDTfI/nx4OKRe6q
 T130mQB+qn7c0z2YlKdJBcCwfD4U2Z7QElwQNCzscCyYmyRqJoCmhawVY9xglygU
 d9yf9373qc+JajTygwmaONh+ClsfUvjSZhQvfSrIBL61G+v8BEQF5q6dqgnn8KdF
 ag4Qj7zI+zXHd+8CvDbuq5C8W5BZfgqkuFSNK6EMoBUpZWsncIwrMCfAYRbgCATH
 m6UMA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:31 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id B191C3F707B;
 Fri, 23 May 2025 06:51:28 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 05/40] crypto/cnxk: add check for max supported gather entries
Date: Fri, 23 May 2025 19:20:36 +0530
Message-ID: <20250523135111.2178408-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX0u007b29NmsG
 oE8S525iwfHMkzdQx7KRgPX8VrFbCcHTnVls81eVOqQZb/81GW5inyQTAjuxpUvxnuvoKnxH8SJ
 K1mjNKGdTYO7rOEPK7CZLR3iAHLtDOLoz6gI8QWNB7pg57+V/iDR5fE9DKvDnc1uNpGwOcT6Sal
 TgiGI5G+wFcO8l4mmzRD6hd7RJajeI/hPRPHpFkQUBAZdz8Tij6NrJDqnelv8+Vpi6Xi5wGmPxZ
 US1+HfFiyekTtHNZmBohVJzMWyw7wLfb3NH4Kh7zSmuP7Ih6T8i902QozlYSip4FxGhSX2oSp44
 FO9w9XyKyFsEsftoU7hEd6T3rvF0wHRzFoIlW6+IxyuleP1WRVKG9VNXY9HtU+foYOuOGC395eu
 rZKpGbR/aHPP7xfKHZ/jFvYpbwAlzSqdOopiI9MV0D3qCjYFeJgi3klAvTK3MIWNx7PnRClO
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d95 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=2BcuznHVefZWE-FKmY4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Sv28g2rDDdiiV1cxTesXgDtyOV7mwzpa
X-Proofpoint-ORIG-GUID: Sv28g2rDDdiiV1cxTesXgDtyOV7mwzpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add check for max supported gather entries.

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/common/cnxk/roc_cpt_sg.h         |  1 +
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h | 10 ++++++++++
 drivers/crypto/cnxk/cn10k_tls_ops.h      | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt_sg.h b/drivers/common/cnxk/roc_cpt_sg.h
index c12187144f..e7e01cd29a 100644
--- a/drivers/common/cnxk/roc_cpt_sg.h
+++ b/drivers/common/cnxk/roc_cpt_sg.h
@@ -14,6 +14,7 @@
 #define ROC_SG_ENTRY_SIZE    sizeof(struct roc_sglist_comp)
 #define ROC_SG_MAX_COMP	     25
 #define ROC_SG_MAX_DLEN_SIZE (ROC_SG_LIST_HDR_SIZE + (ROC_SG_MAX_COMP * ROC_SG_ENTRY_SIZE))
+#define ROC_SG2_MAX_PTRS 48
 
 struct roc_sglist_comp {
 	union {
diff --git a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
index 2c500afbca..87442c2a1f 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
@@ -159,6 +159,11 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k_s
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -259,6 +264,11 @@ process_inb_sa(struct rte_crypto_op *cop, struct cn10k_sec_session *sess, struct
 		void *m_data;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
diff --git a/drivers/crypto/cnxk/cn10k_tls_ops.h b/drivers/crypto/cnxk/cn10k_tls_ops.h
index c5ef3027ac..427c31425c 100644
--- a/drivers/crypto/cnxk/cn10k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn10k_tls_ops.h
@@ -174,6 +174,11 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -305,6 +310,11 @@ process_tls_read(struct rte_crypto_op *cop, struct cn10k_sec_session *sess,
 		uint32_t g_size_bytes;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
-- 
2.25.1

