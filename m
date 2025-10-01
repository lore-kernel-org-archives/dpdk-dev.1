Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A010CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 17:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6382E402C1;
	Wed,  1 Oct 2025 19:57:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A4D5E400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 19:57:06 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918cBEH026872;
 Wed, 1 Oct 2025 10:57:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 T6AXD5sOO/N+ufqcInaAC72USixXhlJ9MuKxG1ojWI=; b=B93Ih9vwRraRgYgaF
 2yGdvdTFr0cJq/BlbGh5+VGuU2qYsPXHAZBsg1481Ua59fCyktiQNHvMa2HK9mgR
 8w+YegbZJAGHGYLcgX9axM3pt+Svba2+a+nAVlZ33o0Rcc0t7YBKqkgTsfJfK7vD
 boTT9nV2gPSQ2KTWYMQxGK3cQLk93JbeBvmvj5vNb0hFvxYtLZfOvGjyx9M6KGVY
 Z2D18BPo5QTVCeVbb24Jo/6SalZZASl89uuGgxg2O7ombiHky6D9m/LP9H3jDrzC
 5D9pbi0rVJRPMWR4TFiVC0hTZcnvn5eCPOTMXLHiLk4sB/CWkptnrp17Utnef2TQ
 RrQgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0thfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 10:57:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Oct 2025 10:57:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Oct 2025 10:57:13 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.79.12])
 by maili.marvell.com (Postfix) with ESMTP id 6E5085B693A;
 Wed,  1 Oct 2025 10:57:02 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v3 0/3] cryptodev: support PQC ML algorithms
Date: Wed, 1 Oct 2025 23:26:50 +0530
Message-ID: <20251001175658.2303-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251001073758.1295-1-gmuthukrishn@marvell.com>
References: <20251001073758.1295-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfX00KjacbzSHjP
 BSmmACdL5DsWL9Izl5P2KrABrCIR4Qopa3PylSyah5NO/1XrD0SwpUwbJJ14BFrIrnRSzqGOGvS
 m0JvqlMth8EkT/7dFPSYOuBcDvpM+wwEqv4/SyIwgvi4TdI/kzfhNDvN2B+kfhIk2GREqQNrbCq
 q5n0s2UgN+L/u7u1N/2xhmADbCT6pCkdDMIsHDdrY3O524x68JlW615iIbfc8ysXgCTZp0t3nJM
 RAOMo2Fl/Nb5LJT2lEn/0MMa2JZdzYik4R+4ToSDdXd9AbCYdmlpfcZmn/DamRvKuxCFl3fnFW4
 SKEz9bfI9lLnjA0dvz4ADSX/0fnIihDRH6mC0XycBc9vX6VOH5dvcsadbuiRJt0yn48B7RhKBEk
 CAzfZO0I1V27fmV+VJ9LD4W7rt5GXA==
X-Proofpoint-GUID: ZlHOxiB_SQ2GVddeiE0E4C7wERtx0Fbk
X-Proofpoint-ORIG-GUID: ZlHOxiB_SQ2GVddeiE0E4C7wERtx0Fbk
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dd6b71 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=jAYgDtSajxceOUjdMdoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
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

This series added support for PQC ML-KEM and ML-DSA algorithms.

Gowrishankar Muthukrishnan (3):
  cryptodev: support PQC ML algorithms
  crypto/openssl: add ML crypto support
  app/test: add ML crypto test vectors

 app/test/test_cryptodev_asym.c                |  856 ++++++++
 app/test/test_cryptodev_ml_dsa_test_vectors.h | 1856 +++++++++++++++++
 app/test/test_cryptodev_ml_kem_test_vectors.h |  873 ++++++++
 doc/guides/cryptodevs/features/default.ini    |    2 +
 doc/guides/cryptodevs/features/openssl.ini    |    2 +
 doc/guides/prog_guide/cryptodev_lib.rst       |    3 +-
 doc/guides/rel_notes/release_25_11.rst        |   11 +
 drivers/crypto/openssl/openssl_pmd_private.h  |   16 +
 drivers/crypto/openssl/rte_openssl_pmd.c      |  870 ++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  133 ++
 lib/cryptodev/rte_crypto_asym.h               |  306 +++
 lib/cryptodev/rte_cryptodev.c                 |   60 +
 lib/cryptodev/rte_cryptodev.h                 |   15 +-
 13 files changed, 5000 insertions(+), 3 deletions(-)
 create mode 100644 app/test/test_cryptodev_ml_dsa_test_vectors.h
 create mode 100644 app/test/test_cryptodev_ml_kem_test_vectors.h

-- 
2.37.1

