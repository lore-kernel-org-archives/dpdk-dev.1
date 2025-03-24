Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13686C36001
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 06:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B252240268;
	Mon, 24 Mar 2025 07:09:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C8C9840151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 07:09:47 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NMmYgc032149
 for <dev@dpdk.org>; Sun, 23 Mar 2025 23:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 C73rb8WR9gX76FcmqMbGJhJ9heNTccDzZ3HesjbA+c=; b=P47nalzIMPvp6Q9bH
 rH/gQbNL4dC3i+2b4dypXBpw47PK7IYWpK9ysycYmNY6DP+CG1vGnfmoCe+8D82+
 4d9aHgNMiALLcw2j9aObetjP91vOh7l40gUT0aTGqzw5BAkcPXI8cwLVDeQm3Yel
 qnj2uVmGZnY1IA1s9VLs/EpcHz+vrsWHgQryS+7n4ZAIQ93S/NywI7eii3biEbHb
 AlVzRCf2KH9JlyV7wQekng6Oqm9n6HGR3YHJazH6CghsJomMBizHYHmw/EjyYDHz
 vUuxfSXEpmKCncvTDNydHVZRDOmDl5E1Vpk2k5F1nHLOP6iKpoY3l+iXz7oYkZIX
 4DorA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45hvqjjens-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 23 Mar 2025 23:09:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 23 Mar 2025 23:09:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 23 Mar 2025 23:09:45 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 809123F70DD;
 Sun, 23 Mar 2025 23:09:42 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Ashwin Sekhar T K" <asekhar@marvell.com>
CC: <jerinj@marvell.com>, Nawal Kishor <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: fix aura offset
Date: Mon, 24 Mar 2025 11:39:35 +0530
Message-ID: <20250324060935.2644402-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304052217.796506-1-nkishor@marvell.com>
References: <20250304052217.796506-1-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0SzesF8CnE36ujZMUnX5DTdB_mDVlS03
X-Proofpoint-GUID: 0SzesF8CnE36ujZMUnX5DTdB_mDVlS03
X-Authority-Analysis: v=2.4 cv=YYO95xRf c=1 sm=1 tr=0 ts=67e0f72a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=40X4-YjR_UbWsa1tUAwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

