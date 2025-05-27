Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60620C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4372540672;
	Tue, 27 May 2025 06:00:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0095A40685
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNX8KX005905
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 ADd6f4fsrikhj/zdb92IdrhiAqSlmjw9XuQXW6mgJY=; b=bvVX6Vs03lGXSO3ID
 ya/GtvqMlJ7aGhbhYkTAM/ZGjg6U2qIsaq2NyLnYGIlZ2FZhq3n+ByrMCDtQ5ENs
 LYZkFjo5lWL29lBhb4fHAdsoJYx5cOA+u24l3rraRLjygzo1EIKLzhxexSYR45Fj
 TjgQrYgOBtsXWioyPdUaljitrxlJ16Kv8/eWgVStudqo3nOSQ+W6czorIt0eaer+
 YYdGttVL/K9fL6wuL/OWpUbcfM+D9OF/ZyMhGOykODEFHjVRyww6JCYTf6NmGsxl
 mHoQ7jesE9twhMVVm+WBugE7yqgBUdN2EgmHYUwq7H0hpD4mUJru+rvRPIoqXATZ
 dVmQg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w2128bj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:52 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C47153F7060;
 Mon, 26 May 2025 21:00:50 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>,
 Aakash Sasidharan <asasidharan@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 5/6] crypto/cnxk: add check for max supported gather entries
Date: Tue, 27 May 2025 09:30:35 +0530
Message-ID: <20250527040036.2280893-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=683538f6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=2BcuznHVefZWE-FKmY4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: KtIzinxLBtDvZ9p_ZUTrFqBZWRLAwwLS
X-Proofpoint-ORIG-GUID: KtIzinxLBtDvZ9p_ZUTrFqBZWRLAwwLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfX1W92Hl5a/J1C
 JQpCMt4G+Avt+96UvwPMdEQg5YgKWYrT9pLGFt6YiTk6W58CSZ0+M9zMA+w0Hv/Jfq3hsSz/dbt
 t+HqkYDXPY4p4ZPVA6WQ8AAsD078yuhJWv27NrYXiB88pfZRkAKmVNRJa+cF7dyM1vFgT/KNF7p
 NQBSfzTZKc1GvPI2QS+yOCVryoQWSu0wr3S0PRZohw/yabQnJuYM5rUJm+z8Umerj8bZbAVR8ci
 tzb7moN9qsqJ72zrg+0bjRXd1e5xPfgMwXvNheKM4ZFcSDNMPtBUE6Cok27xthvkYwlQDFj9z8B
 QaxOVyO5a5oHnc3+jdyQWV50S7XwKSXNEYfliEf3wBRV2uRRu9cEYPIJwx078j8V3QtEEFAINpb
 ctFF5ax2j+XLHjsZ75/kqjfQoyjW8RWqMcUR3JxzoONCJc/x4KTZL1gP9HwjYYmDhulWcly4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

