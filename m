Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C369606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=ig55JE/c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4159C40611;
	Thu, 26 Nov 2026 16:40:17 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 813C2402BD;
 Thu, 26 Nov 2026 11:47:33 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQAXLDb2696510; Thu, 26 Nov 2026 02:47:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 FXQ/ZXUf5g9brsOc8dh2vJwp4AKmtaZiCDXaoetyfA=; b=ig55JE/coC8doSlcz
 qLcbPJn/XX3KIcPa2vPIuudB2TtGLj8xNOhJXcFhopmon/eGJREi0wQQ2rzIM3Bb
 az6KW4rbahb/sHDZUrje9Z+S82WTf8WolRB/exqDjepPK/vR5dYIeGZ2EnnWaRxI
 E9kVfrA4Z9PHAgSD5F9y7+AibONvS6TUYPIZ1q5/FsthnI2GHy0FrYbqbznJd2nW
 8hoC2T3AGMsuNKUPAho4P5RHlckVmRVMQFnmzMYuiOrKxNDalU3QtVFwg0cQ+SvG
 asWswqHFT05PzaX07upMrHtdcQ/ODl7CCPTq6yw58hHSQF1PIXs4XX3JVWAv96kE
 gyKww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j6jcar6d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 02:47:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 02:47:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 02:47:31 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 6A4F23F7072;
 Thu, 26 Nov 2026 02:47:29 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gmuthukrishn@marvell.com>, <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v1 1/2] app/fips_validation: fix RSA key type selection
Date: Thu, 26 Nov 2026 16:17:24 +0530
Message-ID: <20261126104725.1192884-2-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126104725.1192884-1-psenapati@marvell.com>
References: <20261126104725.1192884-1-psenapati@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3-JKBnoVk4G5wlqPz8mQfQ02s_kRHJ1Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfXwPt5uWtLVylK
 ioTT6FCU8HrotUPr2f96588pKQenIdrq735uYQkve1iLQR0TA0ERzDqDduZ/jIMb/LL4tHIgpvX
 1Dew5LegWpWISQFIvKm6HM0pmm00WchxQuJNK/fV3SZu9j3xJipbw6CjNQ3wWlBiNXwY4s++vR0
 mcTnp6Xcdc+QwJJ0OhOb91nbbu5C/IONfR8wIyKKnAhzDAFFacfLB4lJpI2DDsv/0vWBLGIdDUd
 wS9LJtESyjsI05bp+FxkyBGkulb94XsZ+E5GAS9/Hp9iy0Ky2ksrxXTu0vM2Osg+xLCuzZ1JDpq
 vNfHLMzmD7DY+JoziFqAkhVqVMf55jFMbqT8KBoAPGUJ5ENOX9EaSCk4bZkJM4JDGIfN7KjpGGp
 2fQ+xJKgyR3C/085IVTJepxvaZ0Gs5JRM/LLM8soa41wR+uQJg8QPQVH5IzDglmhkkj/uGqSTzo
 v8y6dL4/RnzQ2wwY2zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX+oR22CCeLrrG
 gF8/79orurL9Lpxd7qioZPvUbcdA74E8b3rw/FHeojkjyg8bJgeEIaNAYi0uGomYUDob+2WZgUc
 +aFBDYNU9BgIpSHJe2HioL9keLi7TL4=
X-Proofpoint-ORIG-GUID: 3-JKBnoVk4G5wlqPz8mQfQ02s_kRHJ1Z
X-Authority-Analysis: v=2.4 cv=TJ7Q2Fla c=1 sm=1 tr=0 ts=6b080e43 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=hzw9IT3l1MRWExHaAo4A:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Per the ACVP spec, keyFormat applies only to keyGen and takes the
values "standard" (exponent) or "crt" (quintuple). sigGen and sigVer
vectors carry no keyFormat field, so keyfmt_str is always NULL for
those operations.

Default key_type to RTE_RSA_KEY_TYPE_EXP and override to
RTE_RSA_KEY_TYPE_QT when the operation requires it:
  - sigVer: stays EXP (public key only, no private key material)
  - sigGen: overrides to QT (CRT, fastest for signing)
  - keyGen/crt: overrides to QT (keyFormat="crt" explicitly requested)
  - keyGen/standard: stays EXP (keyFormat="standard" explicitly requested)

Fixes: 36128a67c27e ("examples/fips_validation: add asymmetric validation")
Cc: stable@dpdk.org

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 app/fips_validation/fips_validation_rsa.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/app/fips_validation/fips_validation_rsa.c b/app/fips_validation/fips_validation_rsa.c
index 55f81860a0..3d4704894b 100644
--- a/app/fips_validation/fips_validation_rsa.c
+++ b/app/fips_validation/fips_validation_rsa.c
@@ -622,9 +622,17 @@ parse_test_rsa_json_init(void)
 		return -EINVAL;
 	}
 
-	info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_QT;
-	if (keyfmt_str != NULL && strcmp(keyfmt_str, "standard") == 0)
-		info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_EXP;
+	/* sigVer uses EXP (public key only). */
+	info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_EXP;
+	/* sigGen uses CRT by default for performance. */
+	if (info.op == FIPS_TEST_ASYM_SIGGEN)
+		info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_QT;
+	if (info.op == FIPS_TEST_ASYM_KEYGEN && keyfmt_str != NULL) {
+		if (strcmp(keyfmt_str, "crt") == 0)
+			info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_QT;
+		if (strcmp(keyfmt_str, "standard") == 0)
+			info.interim_info.rsa_data.privkey = RTE_RSA_KEY_TYPE_EXP;
+	}
 
 	return 0;
 }
-- 
2.43.0

