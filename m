Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B1C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA66F40E2A;
	Mon, 26 May 2025 19:00:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9624140654
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9dMvK000446
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 S1jmhBme3oZd7MLDml3G90IcHY5VUyCv9AdPfqlxdI=; b=JCadnr67TxCGBqvZf
 3Xs1UJ5RWyHqX0MVL1JCEZiT1++viuVJ9jBlwSVzM0B54QYwjfuR2Qqa83VBZlvM
 1Q/SgNJ69NawuApYRRIAgL1o3R+GAN0Dju59MyGDHxYDnS3vn/98WE+7KfZoVjts
 F28G6KrbF28Bm+cVgobxf5qQIU6Wga2Tm4W3K7UAxkFjotqdChyZqzfbtZ2ZW99H
 tbr12bsOF5ADXcuk3zjIoPkBF62huytaClf1X+74VDvizTN2MTw/FCga7E8pGpQy
 PdSZaKUKQTOz1+aUWq6Pw6ffek2avOAu7RyYAbIwi2Sx553USnj0dmE6lult5q2z
 8sE6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46vnv1gsup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:17 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 85A203F7048;
 Mon, 26 May 2025 10:00:14 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 35/40] crypto/cnxk: add struct variable for custom metadata
Date: Mon, 26 May 2025 22:28:14 +0530
Message-ID: <20250526165819.2197892-36-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5HvI0QBUJBTTtRu5mEULE9xyx-LY-j0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX1bz/PhSFqMQz
 Xkhl/PylN8hq1rtWXNJS8YVoN2D82kVDemANRrojbfkWLATnR78l0TRSii9sivDuO0HB7BT7Hlb
 WtTfCylcWwBRf1wfB0WxxRO7ETfrA8ldL63srrzFBY5KbgOPck0JeonSnDUNkqi/cMUA6ZHD0Kf
 c43Sh+czD3MjWxHl5UV2gk5HUm/POygseYDECgG/uIQBOSs83XaXfJmkLZ1K6ouNUZu+SAEVIbV
 mp/0WFUF5T2Z3k3x0Ylug62ZBmcrLaNbI9X8mOVJlFle9PGLAYZ3vVEAvmPGEeBdpkVOwXvbBex
 gkmmLxDdW+t1PMZmlnNwRiFsaDa7Y5isNxSrRpKdhwoAG/9ZM7QeAYeA1tuDU6QpuICEeLshsJv
 7jSKhvwb9yMIoKFMHRIWwtmbHLFYaRE9+9vK5jrRvV34OM6visDX5s80Du9WWwlbzM0lH9Yi
X-Proofpoint-ORIG-GUID: 5HvI0QBUJBTTtRu5mEULE9xyx-LY-j0f
X-Authority-Analysis: v=2.4 cv=PPgP+eqC c=1 sm=1 tr=0 ts=68349e2d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FbTz2Mgud2xj_ohD22wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Adding struct variable for passing custom metadata
to microcode.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index df8d08b7c5..17d39aa34f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -30,6 +30,8 @@
 /* Default command timeout in seconds */
 #define DEFAULT_COMMAND_TIMEOUT 4
 
+#define META_LEN 64
+
 #define MOD_INC(i, l) ((i) == (l - 1) ? (i) = 0 : (i)++)
 
 #define CN10K_CPT_PKTS_PER_LOOP 64
@@ -58,6 +60,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 		struct rte_event_vector *vec;
 	};
 	void *mdata;
+	uint8_t meta[META_LEN];
 	uint8_t op_flags;
 #ifdef CPT_INST_DEBUG_ENABLE
 	uint8_t scatter_sz;
@@ -70,6 +73,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 };
 
 PLT_STATIC_ASSERT(sizeof(struct cpt_inflight_req) == ROC_CACHE_LINE_SZ);
+PLT_STATIC_ASSERT(offsetof(struct cpt_inflight_req, meta) == 32);
 
 struct pending_queue {
 	/** Array of pending requests */
-- 
2.25.1

