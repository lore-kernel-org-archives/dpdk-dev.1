Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5909CA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA5084028D;
	Sun, 11 Oct 2026 09:41:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8908A40274
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:25:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IXEX2796908; Fri, 9 Oct 2026 04:25:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=gYPAXVzfj01S9+OLH//dS8m
 9gONfKjtM43oNuAp6Nrw=; b=NoGURi7kDZPKoHiypymmQdyYf+pkRdHcLeWqp1U
 rUVsgGEvi4KH26l4k+gdp2YahnrK1KfYPIOftGwJuaxbEorjBUUbpDdsI8LLcjbi
 7ag+BoyAwV0B2j3wO7XQwiGDr29V9Lz/GG1uOOpwg9bqZo1nvkUiJxWPAHXwi4ZG
 wPwUvwFJ2jmvwT5m7noU7p7NrI1ch6FcF+ZM+J7lwsAP4ZuNgBm+S+PM9oQMuLJV
 soVGD0/18gRI7P4jS8DFZYdezj9qbrGmsVLOWfWtj/w/ujoFk7+XQZC3AjgPQE0Y
 EqTeU5OQ/YiKyHY0SzTo+AHojKrNB7gDn+w8+jovr/gM5Ew==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h6kjs2kvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:25:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:25:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:25:45 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id D73E33F7055;
 Fri,  9 Oct 2026 04:25:44 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <kai.ji@intel.com>
Subject: [PATCH v1 0/1] crypto/openssl: fix DES capability reporting without
 legacy provider
Date: Fri, 9 Oct 2026 16:55:42 +0530
Message-ID: <20261009112543.1766727-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 27ytnTIZB3fEqn6dkbl-TdXb3QyTum7b
X-Proofpoint-ORIG-GUID: 27ytnTIZB3fEqn6dkbl-TdXb3QyTum7b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX20pOWewbJBPy
 QHV5lL+80ivqERBewa8MzRVKZ6x+UJwj8SlnNo3obYHajBBzHSY5574MtvSeTegukHdTAadtJEH
 79LuAWurZlA5MIN9ZK6a8Hi60CXC8xo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX7JFtDwsnllaq
 KJ3P3bxzkkHDN7nrjV8RZH1BADtAjBwKr+oAqorvE7SjG6TV33WZPgxQ/RqVN0dijp2zUuqCg+h
 1d8Of4S0CCaXB92cbQY6QYj/xGDambwkYV7/2hj7UMXfzViV3nD7/aK8bOsVUZVIGNt552n+xVH
 L+nTDjnS4TwFvRbPfcreHD5djN+B69J3gHtnh17U3I09TY8dJlsNfXCvmwoH24rd98jQyU7efFh
 l9XRFE7voGADIrW7NTNI87nLvW04QMRwgl9OZgnqPmYHrqsRcMUjEBX7auKUGohUFGfLC2JS/BI
 3RiXVHeiVuy8VAwVLGUXnZHMN2CGtcDnllMJ1Vq3a2br+zD+iSoZsNQsoWyhy6qwSQE6Ti4gc8O
 hnYSCu6qdsRlIA56bwDzQhGwhU7vAPV3czyaHtsPURCXwWOw7flcIPhoBFY4ytM4MUkjEB7s/QJ
 Pjockv1LRLSIHFt55Lw==
X-Authority-Analysis: v=2.4 cv=BPQmP1QG c=1 sm=1 tr=0 ts=6ac8cf3a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=rMF3n_TP1zqLZ5AbcsEA:9
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

