Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A5606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=CK3zz8/y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7CFF4064E;
	Tue, 27 Oct 2026 17:14:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A5DD400D7;
 Tue, 27 Oct 2026 17:14:51 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFiToH1915893; Tue, 27 Oct 2026 09:14:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=cZvjJpvq8PoIHOU4b+bNkzG
 yL5xOBKUtW8KhzEywtF8=; b=CK3zz8/yE2CtAtotAUd7WxgEKxwIfN3/DYTd3Bq
 aQ2iMBM0hl7MKOsHAMKNTJR9KYSZq82e3nax8gKoUfW/j8/ZjJHVzlKN8nbCvWxC
 VRI/jpFfO+P/T1QH6HrHepmTWtFFEKyTGOm4qhclthGZGr/z5EjuPmy9cXmYJfqo
 5cdXVIyM7/aCB7s0NOHzeFQxaUIF59quBB423nW6CHTkE+zZYlgnIMOnrT1sFJ2F
 4UhjH8XXK724t3RL9/KLiKBqZpmO613x5Q7REp3ovL4luAhTu1j7XkTAcE5E668g
 AXS6zF0rt5j0Av9iVqYtKumd8j7n1M9jvUPPiFGgSmrNELg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hjtxbh946-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:14:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Oct 2026 09:14:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Oct 2026 09:14:43 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.159])
 by maili.marvell.com (Postfix) with ESMTP id 325AB3F7043;
 Tue, 27 Oct 2026 09:14:39 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Ruifeng Wang <ruifeng.wang@arm.com>
CC: <dev@dpdk.org>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <jerinj@marvell.com>, <gakhil@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] lpm: fix SVE bulk lookup loop bound for small bursts
Date: Tue, 27 Oct 2026 21:44:36 +0530
Message-ID: <20261027161436.231088-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ny-zrShv91TdllIu5TB2P5s8pnJ46ZY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfX+JNKKpYI4YwM
 Nr2ANfda+fdvuMtSW6zPfusMcnr9AgcKs66Wuv6jrPDLbmnlDnU8PMHwrCiX4qMZWxBXDV5Hi6h
 XtpFOLgIYfbJJFbgpGPWY4OaFqU0Wz326pA7se8+si0GZPdUGYh4vfLfBtXgyyXUy6G3FJ+60wc
 HpJgFA2p57q76QCZyDsDPF6pyKFz4Z/B7e6q4z48fItwYImvGeqrBHqPj6QAxR2cJTsP+cSHLpZ
 pN76WgGHwOIZaiAckSkrYe7HRp/SYSR3FAtZmoq2liSWedb+bdeaVpo/TYq9WVvTOTjHF9/XeZY
 mYs0nNnQis2yn+7/eiURu7pXlnBz3XvQ7XECV+Trb+tCReTXHB4aZLaEmfDPT+JOldYL/twnGSJ
 9sKqPSkZRoNo4+FrZWBxqPSW+x5Pf8V3VoViqnqssO4uAyfyYL0fx74yihrPusqMwhF74t/g7Rw
 6iWN3lYPM2MB/AZnfdw==
X-Authority-Analysis: v=2.4 cv=D7PSufRj c=1 sm=1 tr=0 ts=6ae0cdf4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=xlctbQWhmfW0-lF8so8A:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ny-zrShv91TdllIu5TB2P5s8pnJ46ZY0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfXwoI9J7GiPb6P
 jgVkSduKWiFRjCv2qNT0xbD5nEA5iJ8zOxVG0D1ROsYbqBkSP00PWPZZ4bpQXYaJO3bMq2Gn41Z
 b7LqPmotYPUmV6GzckvBV0E2djhxAT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
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

In __rte_lpm_lookup_vec() (SVE), the main loop condition was

    for (i = 0; i < n - vl; i += vl)

where n is uint32_t and vl is uint64_t. When n < vl the subtraction
is done in 64-bit unsigned arithmetic and wraps to a very large
value, so the loop does not terminate at the end of the input array.
It reads past the end of ips[] resulting in a segmentation fault.

Rewrite the condition as "i + vl < n" so no unsigned wrap occurs. The
existing tail handling with svwhilelt_b32() covers the remaining
elements, including n == 0.

Fixes: b29ccbea24 ("lpm: use SVE for bulk lookup")
Cc: stable@dpdk.org

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 lib/lpm/rte_lpm_sve.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lpm/rte_lpm_sve.h b/lib/lpm/rte_lpm_sve.h
index 52b8bd4940..6113269120 100644
--- a/lib/lpm/rte_lpm_sve.h
+++ b/lib/lpm/rte_lpm_sve.h
@@ -26,7 +26,7 @@ __rte_lpm_lookup_vec(const struct rte_lpm *lpm, const uint32_t *ips,
 	for (i = 0; i < n; i++)
 		next_hops[i] = 0;
 
-	for (i = 0; i < n - vl; i += vl) {
+	for (i = 0; i + vl < n; i += vl) {
 		v_ip = svld1(pg, &ips[i]);
 		/* Get indices for tbl24[] */
 		v_idx = svlsr_x(pg, v_ip, 8);
-- 
2.43.0

