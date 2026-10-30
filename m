Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=dGHm2wXY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C5A84027B;
	Fri, 30 Oct 2026 06:50:15 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id ACB364025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:50:14 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5Df9R1210806 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:50:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=d4rBu5MJNzhny5a8+NKON8x
 XX68zW6/DOEDiguOXzU0=; b=dGHm2wXYOMhxyB9xdRe/jJzQ3lrnXfzZvBwpXIK
 SsBDH9JabvRWiqLsq6+3YbS++21/F27NFXwXqOgtRs8o/JYDC9zJeQoFQQOkRgCe
 X0uj65CzxEkK2w54FJmNQPJ/2GD9V0kWJL5sxBUx9HSM7u7qw172cyBMHZC+brDj
 rxm8goUAK3kyVt+FBQIZvQCOz6P69Bng7giN/5RqqdlC6hrST57S50+4r9cxYSE5
 //D4pk0zA2rUn24E3yi49fhkVWnjZL+hkm6AEMMYKbLw0haVoxSLZsXgJ0euAn+I
 d9Brex7V/kNN1vpsVNM8xXN+WO+7r42YAOwsB9J3T57pnxQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5t1efe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:50:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Oct 2026 22:50:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Oct 2026 22:50:12 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 3ABB85B6923;
 Thu, 29 Oct 2026 22:50:08 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>
Subject: [PATCH] common/cnxk: fix uninitialized pointers in NPA context dump
Date: Fri, 30 Oct 2026 11:20:03 +0530
Message-ID: <20261030055006.947575-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMiBTYWx0ZWRfX+jqK5bqTGRAl
 5pOo5rWgKI3KzdKn7lKz7C7HynK6JvSWJgS2usNo7rfIRlsuIJDgBU7RWxnfQRSqFGtRSjfkR0F
 uq5eCaqs2xwnFCj9IZ+8vIHHnbdPY28KoMf5wvaNXo7DrouBCGpFqu1EZr4sHr5+gG14PkAdDuf
 nC342cBNzOI0/HjfCwMqCyQBTqHljctMsQCTWI8fUewPWfvPhxI3MSM1JlPaXEH8Qe3Zl1bOn5h
 hK3xnbYdpBdm7sSwfeypPRWXc9L4mU7pr+DZflEUB2WBN7cR0vl5QKP7NWEzuiM04GqKh2MWo8q
 KgNxlCWQAXXcRzFLI4rk/YruYZJT0/Ggthrj1v6IfNFBoRZQpNI6astWaNGc6YZWrCZWA6VaY81
 /4BI8UyhPm89qLPkK/yuY3X1hDylMTJAQn5MimVyKpXOfLlURWqZOinei/M+Rf31uNBvAdPHh4j
 cPoNuaMvREJfmRqvCyw==
X-Proofpoint-ORIG-GUID: rYX-8N82SRHlm-fxKIG63Xo-qyUIvRa-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMiBTYWx0ZWRfX1f+awaAVC70n
 0TNl4Iy7bgA5JLDvd7/1WvRiy1eY23IoykKtXIRRrRpBD9NkQMG8P2eM7Tb95B+GwO/MZhORps4
 y2SAwRrI1cqt3r5EZjblUlqyyu9wzuY=
X-Authority-Analysis: v=2.4 cv=G/yJgNk5 c=1 sm=1 tr=0 ts=6ae43015 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=aT3B6NHbfpHHwxP4S80A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rYX-8N82SRHlm-fxKIG63Xo-qyUIvRa-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In roc_npa_ctx_dump(), rsp and rsp_cn20k are only set through
mbox_process_msg() in separate branches, while the dump code that reads
them selects the pointer in a different branch. The compiler cannot
prove that the pointer being read was set, and warns about a possibly
uninitialized variable.

Initialize both pointers to NULL.

Fixes: a7cc84c6e9e5 ("common/cnxk: support HALO in NPA")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa_debug.c b/drivers/common/cnxk/roc_npa_debug.c
index f978be9642..e2b50ae1c3 100644
--- a/drivers/common/cnxk/roc_npa_debug.c
+++ b/drivers/common/cnxk/roc_npa_debug.c
@@ -249,9 +249,9 @@ npa_cn20k_aura_dump(__io struct npa_cn20k_aura_s *aura)
 int
 roc_npa_ctx_dump(void)
 {
+	struct npa_cn20k_aq_enq_rsp *rsp_cn20k = NULL;
 	struct npa_cn20k_aq_enq_req *aq_cn20k;
-	struct npa_cn20k_aq_enq_rsp *rsp_cn20k;
-	struct npa_aq_enq_rsp *rsp;
+	struct npa_aq_enq_rsp *rsp = NULL;
 	struct npa_aq_enq_req *aq;
 	struct mbox *mbox;
 	struct npa_lf *lf;
-- 
2.48.1

