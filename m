Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55173CA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA30402E2;
	Sun, 11 Oct 2026 09:41:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B272840274
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:28:44 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998K5PC1916581; Fri, 9 Oct 2026 04:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=gYPAXVzfj01S9+OLH//dS8m
 9gONfKjtM43oNuAp6Nrw=; b=c3V+Xv0oJgMXQKgWYCr9LaGMaGHwHXUCuMB7JZI
 yYrAd7DvJwKArfC35jQzOEby3SBh5l6eo9O5M6rHgkbxuqHzRgBHjXhU/HeyC245
 Exw6uz/5Q72EdNYM65D70oUPUpD4zNg5HFwWdImnzadKPYMeWLHzTMsDMScWjs5L
 g4z7XnVXRI/bCAnK8s/gZwoHk+yKGZCZ5bWSAxs2evVzDISBYx+ogs54Kfp2LpK/
 vt0y+jq0uoKx0Arh2vBCjGMJ2Z23Xx7yEyBB5sNwUfi/sEx8BPVnVCNVCMkiJ2xg
 jLinvzszP+2KbRftJLmwjVQzfA4fCa9Y5nCY9LrI/qX0Pfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h5xdd7r6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:28:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:28:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:28:42 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id C7B673F7058;
 Fri,  9 Oct 2026 04:28:40 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
Subject: [PATCH v1 0/1] crypto/openssl: fix DES capability reporting without
 legacy provider
Date: Fri, 9 Oct 2026 16:58:38 +0530
Message-ID: <20261009112839.1766920-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VKgzDaVV5qt5GUT-LGRGHd5JTbv2o-L1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX45KUcduzBWuw
 vnlSkEPHuLycGaTJo3BBm5CNSyPQHnhBwJBSbPl+VXl/0RBMxrITi/JL2vfOB0Mums1QOlQ2ByW
 CLZxBRwWjbA1qOTdmwSXLygekQp9MjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX8F387DslS51j
 HDG+QclyiG6i5ji/khJzsQsSc+OH2uo3ushmhzlbiUzmjGZrhrCzMXZj6Uh8DkUYRlEu8hmaYfr
 iACJXc9zYKYwOnkxSq5mvtUJa2PpGjQThWYX6d+LHoIiJjxgAmz1SkscnFhh92Yz1KZas1YPe0D
 UfrbqszkY7ts7PPeX9dCvaZ0W7e+oGCGbapfaPWVHBhiC2E4xzSrahhwgAvUe5Kkfu1KTHgXtRz
 GL3oKbGZW0t6dGWWGz6YUGNnLcLU9z0vO0/VFACM+AN+mJAgjkWvSXN8eaEu7bcPilf9gWs75EV
 esywdYikH4spN1cO3ACrsXgJCn6w5W7by/qv7GpOKMvgnTbpBCH0lrGXsa6PWz9V4bUjkUbZooc
 GSSrnIitriXsM2i6s1Js07STfMDnzG2Etpyk53f8bsEb4XN48x3XsBIFaTgnLgjoOkRD5iPNAlp
 pYBIw1RXGNoGSeYywuw==
X-Proofpoint-ORIG-GUID: VKgzDaVV5qt5GUT-LGRGHd5JTbv2o-L1
X-Authority-Analysis: v=2.4 cv=O4WsLx9W c=1 sm=1 tr=0 ts=6ac8cfeb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=rMF3n_TP1zqLZ5AbcsEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Mailman-Approved-At: Sun, 11 Oct 2026 09:41:40 +0200
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

OpenSSL 3.x moved DES algorithms to the legacy provider. When the legacy
provider is not installed or fails to load, the OpenSSL PMD still reported
DES-CBC and DES-DOCSISBPI as supported capabilities, leading to runtime
failures when applications attempted to use them.

This patch adds a capability filtering step at device init that checks
legacy provider availability and removes DES entries from the reported
capability list when unavailable.

Pratik Senapati (1):
  crypto/openssl: filter legacy ciphers from capability list

 drivers/crypto/openssl/openssl_pmd_private.h |  2 ++
 drivers/crypto/openssl/rte_openssl_pmd.c     |  3 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 29 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.43.0

