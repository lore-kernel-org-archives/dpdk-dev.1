Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557D606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=hqmLCBVZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C03A40430;
	Thu, 26 Nov 2026 16:40:16 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 70272402BD;
 Thu, 26 Nov 2026 11:47:31 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQAYBgL2488313; Thu, 26 Nov 2026 02:47:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=hBwgB+tj+q/0VC9hV1Ye74k
 c7Sy6zN3NRfnng7AOyJQ=; b=hqmLCBVZStQNqoovmkkDJse7iAvDtXkMPMjVn9I
 VOuPWCX3Xln52C7r8Rv/4jOv/v7PxVVg11SKvvPm415stb9gghFXA2aKKJ8vSsQN
 PsIiLNy2lqskWFq9VeuOITiEPpHzQ3K7gjjE0qRWihA/jhjgiUIGW9WGQM64KLnp
 U7Vr7WOHUvl+AxV50O/89rBa80CbFlb/4QdvSSw7xkeOb0bLlagBHm48MMUxAOg5
 aeaWxcKnQ3DBJmgxt0TlrnAHeacBMnrC7iVKJ1dMjJQRPAP9dZcLOBhx01ZpbbVn
 SWkVI15N7WSRqYfd9f/8lz1/oQMzWlEXto6YujL4zJHf/aQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j60g6cyus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 02:47:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Nov 2026 02:47:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Nov 2026 02:47:28 -0800
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 180453F7072;
 Thu, 26 Nov 2026 02:47:26 -0800 (PST)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gmuthukrishn@marvell.com>, <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v1 0/2] app/fips_validation: fix RSA sigVer and log skip reason
Date: Thu, 26 Nov 2026 16:17:23 +0530
Message-ID: <20261126104725.1192884-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=f7Hdl+yM c=1 sm=1 tr=0 ts=6b080e41 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=TPnLJwKxUPxOaJxgK40A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX5lMuAuNuxjJx
 /EEY8hYU3nvi9lizpHKAgNTMtoYQSv4TBmeinQZiidOmwTbPrC6FQkkj9kfXgZ+hCydcj17L9xV
 8a4vXp3clJPCpyNKTtDb6KJoUL4YNj6b9Q8i0p3hl6Tpw6Uu2RCTv3lOPmIAxCG2AZjl31InmOi
 Oh6mztlMPHCaXkMzwtMTUfGf9YDw3GvCwGcymznYunbGbI11exVIVFUlyEpnay3+hF9DGXdcgL3
 ENNP3U/5Rz/bDEjMPbwxz07Ur7ON9SVEY9ULW/13wQGk0LTOLQjidqqchpu+yTr5Zjl6BvsJC/D
 xa5IQqxclep6FCNIv3XXKUtKpjG0+47WJwxRGihrpjb9jFuIjESebDWO/S8ZrGkkd84NjiqR9Jr
 L8JQm9GCmpSxqWtTFfkIdOjhJP1K1OiLoVOR2OtnQCQkEhFrmEIeMbeBnmCC9kK4R12Zbyvi/ZK
 Zd7LcQg6/PyauafHteg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MCBTYWx0ZWRfX5BihNYO/9jkC
 N9wb1HnmgtQ28xS4RBjV2ld14VcYSGO73msO+YXThkPV4nG1SglaFwb3LQerXvywsrLyxW6NtaS
 fxGeaY3Kmc0CJs5cmtb+Jl1Ac6dIbq8=
X-Proofpoint-ORIG-GUID: hx43egzi-kXhEOcvEspcw8oz6tavDwxv
X-Proofpoint-GUID: hx43egzi-kXhEOcvEspcw8oz6tavDwxv
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two issues in the FIPS validation app:

Patch 1 fixes a bug where RSA sigVer operations fail because key_type
defaults to RTE_RSA_KEY_TYPE_QT (CRT), but sigVer vectors only carry
the public key (n, e) and no CRT components, causing the driver to
return -EINVAL at session creation. The fix defaults to EXP and
selects QT only where the private key is actually needed.

Patch 2 fixes silent failures: when OpenSSL is not built in, the
prepare_vec stubs for RSA, ECDSA, and EdDSA silently return -ENOTSUP
with no log output. A WARNING log is added to each stub so the reason
for skipped sigGen/keyGen groups is immediately visible.

Pratik Senapati (2):
  app/fips_validation: fix RSA key type selection
  app/fips_validation: log skip reason

 app/fips_validation/fips_validation_ecdsa.c | 10 ++++------
 app/fips_validation/fips_validation_eddsa.c |  5 ++---
 app/fips_validation/fips_validation_rsa.c   | 19 +++++++++++++------
 3 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.43.0
