Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD25CD98C6
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 06:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72BA040E2B;
	Thu, 11 Jun 2026 08:18:58 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 728E640288
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:18:57 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QWXV757706 for <dev@dpdk.org>; Wed, 10 Jun 2026 23:18:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=zo30u3fmaZZTzuk8HUI8cRN
 tn6FUx1G8hDMXB2kSMYo=; b=CBed21VvtWA1/7wtXD9MOzZZJpk3E59wDQenqpx
 vRAcPIipxJ1sGQ51sO3/pkBCKjCRwujNaQMVIGzuTtBr6XNC1ZSYo3Lmo2ttmeot
 Oo9+NHYThqL30Bvely6WHFcakFjVVn/1s+IXm3uYx1h2QrqDkjddZ2oqklT6p3eR
 Vj9jH/AW/ENpcYihRXAw/no7/+5aFX8bVOCBKZP/ZRBEUoB7S/ZReJVh1pPXC4j9
 kpXOi6+961XFr4jm2MFlY7brHYtjMVgXIzjbOszDm77MLFsQlLsfkoQsvlOcbF5H
 GCJpQGs2aGF0vYC2YlbJI27q0ioiQUmMvE9ThXdMvbEYcmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w1r80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 10 Jun 2026 23:18:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 10 Jun 2026 23:18:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 10 Jun 2026 23:18:55 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 226565B6973;
 Wed, 10 Jun 2026 23:18:53 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH] test/security: increase wait time for reassebmly test
Date: Thu, 11 Jun 2026 11:48:51 +0530
Message-ID: <20260611061851.3099305-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1OSBTYWx0ZWRfX2GEowYurVtvd
 IeGqc84NZb0/17FNgC4cU0jaelvNfXJKWfFgNyrRgkWW8UphXzrm8wGlIZkTtFC1ooJHD+wvHGW
 dZOhi1IJRm/MLv+G6RBGbA4tTTN7yB6RCTSNwrltAi7iE1d7rpxBlcVG/vKSfx+qTptJ/Mv3pAz
 FsVXOfetpid0favIpRK4Anv5WzDLK2ViyzVhPw++BcpGXxFCCLFEditw4w92w2r4u5rWajGBt3L
 lUhAwMEBylqYWMNR8gdH5pYmUiNFnuWosHKL46dCfUEh4KXLO+rlWVSmUxMSpuvyE4nuYwU9qjS
 lPocTV2rej1Z5nNPXoxWmaoPQhd1H/EIUBRVC3r6/c+H5rYFR/Bs1N4EM/PT+Ma/zYaNwxKXvvM
 zwPqmuDJxRT+HiUeMqWZoV2gEUoKDr85ML86LFhsGs3TQ5MOSEdkyqjrVF4jmzTHXNDpe0AsNoz
 iaa7Fzu/Rr37M+WKZwQ==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2a5350 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=r8A6qn465uYm-O1Hi-oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1OSBTYWx0ZWRfXxxHVIVCRKp5T
 S1bApyhfqi0KIEcaCee936o7stGq9/5I2JAzOcmU8/AJsuJjfL3M2jqOSlAEwNhDntx83Pn7YWw
 Lefi5hnDKwUrq5gCTBKjYUmP8GS7L6c=
X-Proofpoint-GUID: fndUCigA5qI4bk6Q_R19mK7DyDEiwTOB
X-Proofpoint-ORIG-GUID: fndUCigA5qI4bk6Q_R19mK7DyDEiwTOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

In case of multi segment inline IPsec reassembly burst test
of 4 fragment per packet where each fragment is multi
segmented ~11k bytes and sometimes few of reassembly fails
out of 33 such burst.

Delay of 1ms after burst Tx is not sufficient in this case,
hence need to increase to 10ms to avoid random reassembly
failures in functional tests.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 app/test/test_security_inline_proto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index b0cce5ebd9..55d81041df 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -1107,6 +1107,7 @@ test_ipsec_with_reassembly(struct reassembly_vector *vector,
 	void *ctx;
 	unsigned int i, nb_rx = 0, j;
 	uint32_t ol_flags;
+	uint32_t delay_ms;
 	bool outer_ipv4;
 	int ret = 0;
 
@@ -1214,7 +1215,9 @@ test_ipsec_with_reassembly(struct reassembly_vector *vector,
 		goto out;
 	}
 
-	rte_delay_ms(1);
+	/* Multi-segment fragments requires more delay for burst Tx and reassembly in Rx path. */
+	delay_ms = sg_mode ? 10 : 1;
+	rte_delay_ms(delay_ms);
 
 	/* Retry few times before giving up */
 	nb_rx = 0;
-- 
2.34.1

