Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC9606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=Ui+JEGt4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FC4E4064C;
	Thu, 26 Nov 2026 16:40:18 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 8AC69402C9;
 Thu, 26 Nov 2026 11:47:36 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQAXm2D2698052; Thu, 26 Nov 2026 02:47:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 szJPdW+sdA5klBY1qu3wrLJ5Xo08G/r7VfaNHLtI1w=; b=Ui+JEGt4EQp5BiGE7
 fGvHsbCGVQwIMQhIpk3bXpa25uzt7+vh08HDRK/g/H/R9clRLcbn6mlQ9V6zXckt
 KityG591kXrm7pUw+Z0V9FF5nuVs3aJ+1bGGceLog3mNCsa1nblTCYXtIiui5gEx
 Aju8p1BsWPv779Ko0YA/AG6NAEkWg2LguK16MpYKI4dF8TfSNZoQWlkXrNzI5uIM
 l0apScTHKQZLMqnuPNBYtCo/wbZLJppCfFid2Yy8rpCa2Ad7PdR+QG0LISQylxp+
 5slq/Uesn15ZEtxstH9Tk3mKXRubdktBjDxu0a6CjkAsHC347gBgSvIlezCIoLao
 55IGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j6jcar6d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 02:47:34 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 02:47:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 02:47:33 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id B33F93F7072;
 Thu, 26 Nov 2026 02:47:31 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gmuthukrishn@marvell.com>, <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v1 2/2] app/fips_validation: log skip reason
Date: Thu, 26 Nov 2026 16:17:25 +0530
Message-ID: <20261126104725.1192884-3-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126104725.1192884-1-psenapati@marvell.com>
References: <20261126104725.1192884-1-psenapati@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zJ_oA-xO5WfPDX9g5zxnNWpgwOHqgdDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX/zqg1aXnFYeJ
 bpX66hPoUcPMbME3VGx3E/VXfbjWCVxCKm4KAbTT6zsM5hkterpRcQkh+3kgm//aWJ//mvs6Oxc
 3wqkm2BtIy2T/9i5FnTRuPo7sid4/ClGbsAF2XgzBf55rDNSvy7ty01PVhXlbbYKrK3dLeiY0qN
 gbfnyuYYsC5hD23vvw55fIPa0hHPCnDvKpw/ROOF6npwfSgH7GZrZSTKAtAGeqvvMTJBwjRBfmP
 LS6k5oe02mSBUijYu7zu47tpAQbBYGzJ2RQHqA3N0YSb27736WwsS5iCWqXiHJuKwN1RPZESz5t
 DJjKdub3eaKxArOfFcXCuKaJOv181bHPmikkBB4WlP99Arf2nW8Hz9IbUXORgi4HriMJI51LFjv
 TI1jdK4uJQfl6Nc1nfcQljWtyWc1iLBb8ZYb41mrSXFK9jM1Ud1Ob+GMUfmD0wcE7jnpuVd9bfU
 SQHItQRNZlPG5cBj/CA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX5VdKb5BoNKQa
 Fc0mJXcP2DhsCrwebXqs7jZlwMsOq7VeTjLbl6CuRPUY6R7PjiT6QYzbXR8u6VhQWz2pwYf7iRo
 oa124R9J3NBl4dLbLsZ6g1O5sbLLjJo=
X-Proofpoint-ORIG-GUID: zJ_oA-xO5WfPDX9g5zxnNWpgwOHqgdDU
X-Authority-Analysis: v=2.4 cv=TJ7Q2Fla c=1 sm=1 tr=0 ts=6b080e46 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=dSDXpUk8y-uVuRxKH_YA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 26 Nov 2026 16:40:15 +0100
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

When OpenSSL is not available at build time, the prepare_vec stubs for
RSA, ECDSA, and EDDSA silently return -ENOTSUP, leaving no indication
in the logs of why sigGen and keyGen test groups are not producing
output.

Add a WARNING log to each stub so the cause is immediately
visible.

Fixes: 36128a67c27e ("examples/fips_validation: add asymmetric validation")
Fixes: b455d261eb89 ("examples/fips_validation: validate ECDSA")
Fixes: 12ede9ac497f ("examples/fips_validation: support EdDSA")
Cc: stable@dpdk.org

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 app/fips_validation/fips_validation_ecdsa.c | 10 ++++------
 app/fips_validation/fips_validation_eddsa.c |  5 ++---
 app/fips_validation/fips_validation_rsa.c   |  5 ++---
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/app/fips_validation/fips_validation_ecdsa.c b/app/fips_validation/fips_validation_ecdsa.c
index aef722d147..fc180942c5 100644
--- a/app/fips_validation/fips_validation_ecdsa.c
+++ b/app/fips_validation/fips_validation_ecdsa.c
@@ -200,18 +200,16 @@ prepare_vec_ecdsa_k(void)
 static int
 prepare_vec_ecdsa(void)
 {
-	/*
-	 * Generate ECDSA values.
-	 */
+	RTE_LOG(WARNING, USER1,
+		"ECDSA sigGen/keyGen skipped: OpenSSL not available at build time\n");
 	return -ENOTSUP;
 }
 
 static int
 prepare_vec_ecdsa_k(void)
 {
-	/*
-	 * Generate ECDSA values.
-	 */
+	RTE_LOG(WARNING, USER1,
+		"ECDSA secret number generation skipped: OpenSSL not available at build time\n");
 	return -ENOTSUP;
 }
 #endif /* USE_OPENSSL */
diff --git a/app/fips_validation/fips_validation_eddsa.c b/app/fips_validation/fips_validation_eddsa.c
index 89fa6c17ca..456848b14e 100644
--- a/app/fips_validation/fips_validation_eddsa.c
+++ b/app/fips_validation/fips_validation_eddsa.c
@@ -110,9 +110,8 @@ prepare_vec_eddsa(void)
 static int
 prepare_vec_eddsa(void)
 {
-	/*
-	 * Generate EdDSA values.
-	 */
+	RTE_LOG(WARNING, USER1,
+		"EdDSA sigGen/keyGen skipped: OpenSSL not available at build time\n");
 	return -ENOTSUP;
 }
 #endif /* USE_OPENSSL */
diff --git a/app/fips_validation/fips_validation_rsa.c b/app/fips_validation/fips_validation_rsa.c
index 3d4704894b..da97da1c1f 100644
--- a/app/fips_validation/fips_validation_rsa.c
+++ b/app/fips_validation/fips_validation_rsa.c
@@ -297,9 +297,8 @@ prepare_vec_rsa(void)
 static int
 prepare_vec_rsa(void)
 {
-	/*
-	 * Generate RSA values.
-	 */
+	RTE_LOG(WARNING, USER1,
+		"RSA key parameters not generated: OpenSSL not available at build time\n");
 	return -ENOTSUP;
 }
 #endif /* USE_OPENSSL */
-- 
2.43.0

