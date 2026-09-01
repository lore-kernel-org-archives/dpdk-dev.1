Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA52C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 09:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E9FC4065A;
	Tue,  1 Sep 2026 11:53:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 149EC4027E;
 Tue,  1 Sep 2026 11:53:20 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6817C7Um3449348; Tue, 1 Sep 2026 02:53:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=IHarNOk455duq+Zq5mX5OAL
 k7yuQmrsQmDUPx8DxfTs=; b=hQX0oMKTOVwH5Hwdfp6Tj4MSV7KNXFiTLf3kk0C
 hx6755I+Gkbsdb6TAIC7DjQtfOYlelWE+sYg0Upt/0EDEGtUE2Ek4pEwyWH6b0nJ
 Mp6zuk7K93DtD1ZyUrvNRQfnkzd7ZZGVfSsWQC063G53de+ChGhPEieZX/6DqaW/
 kjYHNh5iu4MeFzn+g77tWhOsoMpWUHM5ltI9/M5IBTTEgWz8hhC7sD6PnKJSEtfk
 o7SFTgL8Cq63j0QAa1fyPwnUhV5ihGRgxHlYELmzP6ZO3X3jZcSegMnZQGjAIWqZ
 s+7TuzzrtnsICfgctq9JTQzarmrOTDABxrI3Nebnd2ICMyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gdcy1b4pn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 02:53:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 02:53:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 02:53:19 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.196])
 by maili.marvell.com (Postfix) with ESMTP id 7F4A35B6930;
 Tue,  1 Sep 2026 02:53:16 -0700 (PDT)
From: Harman Kalra <hkalra@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] common/cnxk: fix mailbox message size underflow
Date: Tue, 1 Sep 2026 15:23:12 +0530
Message-ID: <20260901095312.1088024-1-hkalra@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=W9MIkxWk c=1 sm=1 tr=0 ts=6a96a08f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=9sc9bnZYiaJ70bFWuzgA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2tcykVTcwRnCdN2j74id_IdgxOSSql-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX3Yn/7DT92v5W
 n/vzcXPSF8Qx2X7aCvbdz8EbxrSh2Doh060jU4iLSopf4Gcc7/122m8nuWmbhMDFuEHZPA8bpB0
 3MO9zvJ3r5wT156KxaybiF561cFZZGr8LUlEVqCC4Izl4DZj3dVVHYirAyF5qSTSl5Q5Nf4lESS
 mDgD1dUIfmcDeofEtMj8mIg4GKiUW3gLGokvaUY7iWx6wd+1p807PI1jFnNq3BOnm2Il9dB5pec
 dUvvTw7Hmxaia2zgEQc6eicxblKXbkEkr8sxpV7cHxA/s3/UR+8bcE6vkd5GCXcCaxiGUDLQaWe
 EPSB6glhW8YQmG3U+o2VWM8V1eVrYxIOy0GNwZJwO94Jf+oZ0LsS9xZd6jYem1nKQk5o6YF3heb
 4n4EQkQH+QSWLqNbnYAQsH2ePMGwDKFd6Hsz4t0YsJ0j2/BmS/vUcQVkYLrxx8Hl0L0CiG973GL
 pyWNlfHwvsLVZs638dQ==
X-Proofpoint-ORIG-GUID: 2tcykVTcwRnCdN2j74id_IdgxOSSql-U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX1fy/PLg7vNTb
 DR5mh20btEN2ZffaZPyL7XAvafupWJyOJ21xZBIlXqHA5c1LMJpswuEELT4slkp4NmIo4sLLvCk
 YuwdLjC7ZVYJjlwXsjwHLsH8ISdDarM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
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

When the PF forwards a VF mailbox message to the AF, it computes the
message size from an offset supplied by the VF without validating it. A
malicious VF can pick a small offset that wraps the size to a huge value
used as the copy length, so the copy overruns the mailbox region and
crashes the PF. Validate the size before use, as other paths already do.

Bugzilla ID: 2024
Fixes: 585bb3e538f9 ("common/cnxk: add VF support to base device class")
Cc: stable@dpdk.org

Signed-off-by: Harman Kalra <hkalra@marvell.com>
---
 drivers/common/cnxk/roc_dev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/common/cnxk/roc_dev.c b/drivers/common/cnxk/roc_dev.c
index 61aa4b3075..433aca1dd3 100644
--- a/drivers/common/cnxk/roc_dev.c
+++ b/drivers/common/cnxk/roc_dev.c
@@ -286,6 +286,17 @@ vf_pf_process_msgs(struct dev *dev, uint16_t vf)
 		msg = (struct mbox_msghdr *)((uintptr_t)mdev->mbase + offset);
 		size = mbox->rx_start + msg->next_msgoff - offset;
 
+		/*
+		 * next_msgoff is VF-controlled. Reject a message whose size is
+		 * smaller than the header or larger than the maximum request so
+		 * an underflowed size cannot be used as the copy length below.
+		 */
+		if (size < sizeof(struct mbox_msghdr) ||
+		    (size - sizeof(struct mbox_msghdr)) > MBOX_MSG_REQ_SIZE_MAX) {
+			plt_err("VF%d: invalid mbox msg size %zu", vf, size);
+			break;
+		}
+
 		/* RVU_PF_FUNC_S */
 		msg->pcifunc = dev_pf_func(dev->pf, vf);
 
-- 
2.43.0

