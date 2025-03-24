Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6068FC36008
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 06:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E1640268;
	Mon, 24 Mar 2025 07:35:35 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id ED1CB40151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 07:35:33 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O4SD0P002780
 for <dev@dpdk.org>; Sun, 23 Mar 2025 23:35:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 CeSsqYjR8xuUY5e2ouHKXqIOayE5Exz64gPUKSfB7s=; b=NBWerwXq4lFBlfeOq
 q8JfIn0E7ZPcNHbarghg3LGE7Hn9hZhfXFkcljlq7+/EcaTAdQKi1UyDlcHi4/GT
 +JblHmgbJNYxpe/0KdysiuOj0rVD6enhxrshHP71BIlx7pPUBSvo7KqyS4x1MQ5D
 Jh1PQiewbZ/dB8oupssslwT29s12322CZbb2umonBxmhZ1I/CteaHZ8TdSQWokMU
 KU/JVOJgpl5PVu5qD6hjetUYiWwLlRTZmIG3vEieElsgayBb8YxbaCuV5aKsWc5W
 G6/cny6bOW8czb160yckAbc1Nk8TC7NviQgDJjJGqZ9JoDeLSznVgYAYj7kaZcIv
 VXuwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45jhfbh6mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 23 Mar 2025 23:35:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 23 Mar 2025 23:35:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 23 Mar 2025 23:35:31 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id DBDA23F70DE;
 Sun, 23 Mar 2025 23:35:28 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Ashwin Sekhar T K" <asekhar@marvell.com>
CC: <jerinj@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH v3] common/cnxk: fix aura offset
Date: Mon, 24 Mar 2025 12:05:25 +0530
Message-ID: <20250324063525.2650349-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304052217.796506-1-nkishor@marvell.com>
References: <20250304052217.796506-1-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TrPmhCXh c=1 sm=1 tr=0 ts=67e0fd34 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=40X4-YjR_UbWsa1tUAwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: iRQRLM1iPHbYOBrApMGJo9JtYpxXjnkk
X-Proofpoint-ORIG-GUID: iRQRLM1iPHbYOBrApMGJo9JtYpxXjnkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
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

Aura field width has reduced from 20 bits in cn10k/cn9k
to 17 bits in cn20k. Adjust the setting of aura offset in
NPA_LF_POOL_OP_INT register accordingly based on the platform.

Fixes: 620fc02bf7eb ("common/cnxk: accommodate change in aura field width")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
Changes in v3: Fixed checkpatch warnings.

 drivers/common/cnxk/roc_npa_irq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa_irq.c b/drivers/common/cnxk/roc_npa_irq.c
index 0a19319ebf..3142a40c8c 100644
--- a/drivers/common/cnxk/roc_npa_irq.c
+++ b/drivers/common/cnxk/roc_npa_irq.c
@@ -104,14 +104,15 @@ static inline uint8_t
 npa_q_irq_get_and_clear(struct npa_lf *lf, uint32_t q, uint32_t off,
 			uint64_t mask)
 {
-	uint64_t reg, wdata;
+	uint64_t reg, wdata, shift;
 	uint8_t qint;
 
-	wdata = (uint64_t)q << 44;
+	shift = roc_model_is_cn20k() ? 47 : 44;
+	wdata = (uint64_t)q << shift;
 	reg = roc_atomic64_add_nosync(wdata, (int64_t *)(lf->base + off));
 
 	if (reg & BIT_ULL(42) /* OP_ERR */) {
-		plt_err("Failed execute irq get off=0x%x", off);
+		plt_err("Failed execute irq get off=0x%x reg=0x%" PRIu64, off, reg);
 		return 0;
 	}
 
-- 
2.34.1

