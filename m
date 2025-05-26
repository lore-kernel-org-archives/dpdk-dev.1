Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837ECC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71EA440E3E;
	Mon, 26 May 2025 19:00:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 064D340A7D
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:21 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGva5a027176
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 fMoDlpoL0S1MJGDq0RF20pGeAr/K/fyVboxXhUc/TY=; b=FpGPOrYjTzP4LuViU
 Ii2E9evM6mWljpyokwoR4W01s6e3rW05DaoD1Nb9rLL35bp3KUicAYnner7cZfni
 TSBSN+29WIi5E5NZqVfreINX/Kb6sPg17DYxA9I20hSysFzHR8gb+7r0fvCbajQA
 qhYal/fW4NY55cnolkuFpbuU0LCj1K4GHN9Z4MiZfbRibKADlxcRLDUp8T/6zpTx
 sx/hbdhpbG1IjlnJUWYekugJrKSm3eV+tHmFiTlqrMULwPu+GeZZwOt2UjuaCgzd
 384aJq8ZLTGATa9krxflhkM8GDYqJ0veFKtTx/rX40WKZk7XHT1BC9TIvsVDznbU
 BX/SA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:20 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C44283F7068;
 Mon, 26 May 2025 10:00:17 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Aakash Sasidharan <asasidharan@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 36/40] crypto/cnxk: add asym sessionless handling
Date: Mon, 26 May 2025 22:28:15 +0530
Message-ID: <20250526165819.2197892-37-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tC95n0wJbY88hbgQ-kmnWTV4BOeim8MY
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349e25 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=wXFYHL2ICx7M5fKW5-AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX5dvivMzGCFlG
 HUoDxEbQlGGIl2U3Lfhk+EAwXJm+QLexEGH3z7eJimbfGD77Lgb9LUwRppHm/5d/tPYYozbw+3k
 HvxYbAxVdF+k7O8hUwWg6Nlkh+wQXmuVXgrKaCGSkh+9nVIuqWSO8EdfPHWAFVHwnXmAVDVIIAN
 4fACSotmxlNYnfPfZq9jjFh9b8E4fwuTuWK804zMaxzk2vzxIsespdUFjH5pchxrH/XcR2elZAV
 czd5g7my6CwP9n7gU0YIcrVZz4tyjidY0McLoya+CyZ0W6iLnQ8dwQ7CutvK9uVER2QHiolcap9
 VmD/YwExsvvWb1Z0DJvHIoXbpJ37e+3pOje0xjYlJ1W7f4JWPZZAfmq6NnXMcoQB6svYelhIoJG
 tHF0pC5cZ/c0lDrnqIL/4v97/VgXgei+C2dUeC3fLDcGr2furleZ55zuGGoold/gS/mRvJYX
X-Proofpoint-GUID: tC95n0wJbY88hbgQ-kmnWTV4BOeim8MY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

