Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9EBC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F80A40A4B;
	Tue, 27 May 2025 15:02:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6955F40697
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsgO001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 fMoDlpoL0S1MJGDq0RF20pGeAr/K/fyVboxXhUc/TY=; b=j00HDw2CovKmSAB1d
 ZYY4oeMj6Ulc/60ArZXC6Nw9dBcZNWJlFrk2yTFbANHYf+TujVhn7pBi+qZGhJXq
 8M+8Q+hh9+rE4LFef3XCa5amlXtpVKgJkvHUz3mze6Zbc5RRY/GTqSSzbBC6G87J
 a+QQ/MxjWpVgki7IOXd10Tp0vmH2EA+JgOAHIHFwEGqvaeC0OWfEJHKjJkrnr3mp
 62g+6QIeEM/GkhxBQDV0DXW9wlrEDvSXxiHpBOcQRxBFbVfmJdMWkhkucZACwTmB
 RgkoCy+lBoe6TXN+3+saX9PTX6DSA0Wn70jixHYI9aMq8jzW0IdxMBnzw/hsTF6o
 SQ9ag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:55 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 706F03F705D;
 Tue, 27 May 2025 06:01:53 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 6/9] crypto/cnxk: add asym sessionless handling
Date: Tue, 27 May 2025 18:31:32 +0530
Message-ID: <20250527130135.2301726-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7cc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=wXFYHL2ICx7M5fKW5-AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: N4IojHqtS0LTQkn5kPs19OU2fz5A2Not
X-Proofpoint-ORIG-GUID: N4IojHqtS0LTQkn5kPs19OU2fz5A2Not
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfXzDYeQrTuAclU
 csriMwudJvvFAvx5o8s15j5Ebw7W0Gjrj80VUAnM/Y1XaQzgJhZCJmuPHgkTz5oKUh6HQCrPO5Y
 HLqRE5+jKMG4s6iVclXKjk1eSR0jEKyXFkaRs4oFZssJvsHbkA2qN1Kor/M0QZEF2qYlSbbXJw/
 yYXtooewSSVSOzaherf3i+h96wTRjONBUQiX0iJcJSs45xeVR7ZStEVdC1XpNnf/L09+wgrUvsy
 LN/AWKkfe2Hwqr8g4+UDSXqac43WTGNkynLMAB0pCRqnESpenM//afT1QME7LlDiGavrfgwljWM
 x6K9mUAqm7H4nPURybOzB1w9YBHgDAS35f1t+EpyWesKvYeS/Vfh48MwRjNn7FlZ+CvzzCK/IwO
 KtXW+lt8/heOuLP1TT0TngVQm1moTMm8qHYEJUjbju/VlW8Pd5HiN+pY5Jq0OJ73qPY4JYP/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

Add asymmetric sessionless handling for cnxk

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 19 +++++++++++++++++--
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 20 ++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 9ad0629519..813a2deb66 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -417,8 +417,23 @@ cn10k_ca_meta_info_extract(struct rte_crypto_op *op, struct cnxk_cpt_qp **qp, ui
 			priv = (struct cnxk_ae_sess *)op->asym->session;
 			*qp = priv->qp;
 			*w2 = priv->cpt_inst_w2;
-		} else
-			return -EINVAL;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			*w2 = CNXK_CPT_INST_W2((RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+					       rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
 	} else
 		return -EINVAL;
 
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index ee35ed1eba..fa22b5ce44 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -333,8 +333,24 @@ cn9k_ca_meta_info_extract(struct rte_crypto_op *op,
 			priv = (struct cnxk_ae_sess *)op->asym->session;
 			*qp = priv->qp;
 			inst->w2.u64 = priv->cpt_inst_w2;
-		} else
-			return -EINVAL;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			inst->w2.u64 = CNXK_CPT_INST_W2(
+				(RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+				rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
 	} else
 		return -EINVAL;
 
-- 
2.25.1

