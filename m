Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41748C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46F3340E0F;
	Wed, 28 May 2025 13:52:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5BAE840DD5
 for <dev@dpdk.org>; Wed, 28 May 2025 13:52:00 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S7GDK1021154
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 ieoMRTvR/6gGfpyG93l+35ign1ihB0HzXeRz9q+6gM=; b=DQtv9jieqBVMvrai4
 0cmuW+LES2PXfOVKgq3BlngAvw0tcY1enjK0GSSbwj4EX6QsEv6Z/AJYORErCDQM
 fc4bgt/i5PgcKx/qjbmYjYf9YsTUn/i8+Uo1pe6GbmvkhQreMjKAEZPk/RfgsbpK
 UaKh6vn8fWm+PRZ+D1Bo3u3oKa8ku/LPOXb5E/De1gq9bSc9Ht9b5IrmlThF3iZK
 TjfkJBDpBl2/UOLq8+uLUfynrTEAC+VD18zwC1k3sAT9vkWh45pSpGl1FPW8XHYX
 NNYHxqqcM+hKZ9/SlakN3hw4EDHioWKC47xlj+7Ym/f0M+vxmEt6u1880t+WvkZ6
 BazNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46wwjqrgkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:51:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:51:58 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id AA3773F7060;
 Wed, 28 May 2025 04:51:54 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 5/7] common/cnxk: disable xqe drop config in RQ context
Date: Wed, 28 May 2025 17:21:20 +0530
Message-ID: <20250528115122.24052-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX0Uv4POUNRIID
 3ZyNrRTNBpdf920olMXLaqpzXJXSToZEAPna3vzPEeSzYCKhrDpH+d/C6nAbyhhETcmx6fZt3q4
 HWFfueFYWt4RVzMFjAkKzwnzQWPCg6PDwqlLUBLwuGhw2tOwRlY9ZgSubTem2uucWEPSzxHrpBc
 SZ7LCwtoXlBhz+wI/w9agQ2+UjDv6OSIKM9uS0+eA2shKaoEW3RWePoeMBFocA/TdLEnX1z3Rsn
 wv5ttukO0jlBP+//D3jeWtNHlnMV4X8I7KzdE8znI71pXBDLUP09spkPh4WhfHTiVZ/M595Zzuw
 vz6H4LEN7BYnni7YenYkEavFvfF7JBW6YfjkEzzQPQEjS3zGnYpTJRqpUL8SZgitb58LdvAoNFi
 ewip2vM90My7wgopIpZW8GMaWSREXmSBrZjbT+MOC8OpshxrWxRlCsnYUQkAWoCyW0MOEaAs
X-Proofpoint-ORIG-GUID: 3wyVxrWdcizGhxrbPyuc1EbB36yPEa4b
X-Authority-Analysis: v=2.4 cv=M9pNKzws c=1 sm=1 tr=0 ts=6836f8df cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=OvZeQkCC9w_rEG-y7d4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3wyVxrWdcizGhxrbPyuc1EbB36yPEa4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

Disable RQ context xqe drop enable config when
dis_xqe_drop parameter is set.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix.h       | 1 +
 drivers/common/cnxk/roc_nix_queue.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 75b414a32a..a9cdc42617 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -487,6 +487,7 @@ struct roc_nix {
 	uint16_t inb_cfg_param1;
 	uint16_t inb_cfg_param2;
 	bool force_tail_drop;
+	bool dis_xqe_drop;
 	/* End of input parameters */
 	/* LMT line base for "Per Core Tx LMT line" mode*/
 	uintptr_t lmt_base;
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 84a736e3bb..e19a6877e6 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -956,7 +956,7 @@ roc_nix_rq_init(struct roc_nix *roc_nix, struct roc_nix_rq *rq, bool ena)
 	/* Enable XQE/CQ drop on cn10k to count pkt drops only when inline is disabled */
 	if (roc_model_is_cn10k() &&
 	    (roc_nix->force_tail_drop || !roc_nix_inl_inb_is_enabled(roc_nix)))
-		rq->xqe_drop_ena = true;
+		rq->xqe_drop_ena = roc_nix->dis_xqe_drop ? false : true;
 
 	if (is_cn9k)
 		rc = nix_rq_cn9k_cfg(dev, rq, nix->qints, false, ena);
-- 
2.25.1

