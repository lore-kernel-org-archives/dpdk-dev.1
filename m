Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8ACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Oct 2025 03:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28C64021F;
	Sat,  4 Oct 2025 05:23:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BB1474014F
 for <dev@dpdk.org>; Sat,  4 Oct 2025 05:23:09 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 594360ch015374;
 Fri, 3 Oct 2025 20:23:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 iLO7/n+mjU6/dq9GQcpS4TydvgKd1Lv3ZAqWviAAvE=; b=L2k+0aW54yUUDJmkF
 oJ74sjxg/S0B58lXR5mzA0PrjNzC9kcQu7vDS970WqUX8Q3+KNh6/BpHSFKlZfIq
 gITg5RmwDzEYxFzisFA++bWRAJ1/pdUi0mCTVpAIcTCuADR1DFxHBnQMplCAEWdx
 Bu/ffDTREHtJOzftCPI5geaCFuIY004JZ6Bh8R21/vfod5NmvB2/8FCSDBbu+dIP
 PluYsnMj0p2caI+kXZQVCIaU5jLAjpqUJictfSU8fKhGEyT5hHgrvWSAfrwveTwh
 aYhxY7pOpttgGcUdzUR+CtzmnVXVgOEp5qibPkfAjjOh6q/p5wpfd8Uk5Pk8wka0
 MUkPQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49juby80vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 20:23:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 3 Oct 2025 20:23:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 3 Oct 2025 20:23:08 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.101])
 by maili.marvell.com (Postfix) with ESMTP id 9D7405B6955;
 Fri,  3 Oct 2025 20:23:05 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v4 0/3] cryptodev: support PQC ML algorithms
Date: Sat, 4 Oct 2025 08:52:52 +0530
Message-ID: <20251004032259.2707-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251001175658.2303-1-gmuthukrishn@marvell.com>
References: <20251001175658.2303-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5Mtbf0S_4EoXDirIAoYnC3zi7k8RPgvI
X-Proofpoint-ORIG-GUID: 5Mtbf0S_4EoXDirIAoYnC3zi7k8RPgvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNCBTYWx0ZWRfX/57rGJCRqKHr
 CBVFiMFhxQwB5a6RNWokCK5/D7/mbRA4cUtsfhRK7dyXN3C5MXJxSQEn99inaBlz3QnEpaEHkwv
 0ToDI80CJNyj7GhEpf0616oJuwCsN3CHT6B0sEy2SpgvjMiZulRMCOWJacLLw4UyhSyvusHiB+I
 cW4mTnNB061MKYFahztKSydtYlypxwEz66V4CLNvErTqRy3ol6H9dipbbrDjWNFKf6WQBF/502d
 8PgcFyIIYahr5QCWq5JP9yVdXriR2QKpEN5DuBrffZtOiVkx6I83jOgA4wjv0IDUeV6zwUP+8+I
 DzJtYOpMOPsAwr0CjJFulrt5RHQkiykf0LWbC2PH4YlwxX034D+Z69FLnuAsvjsYaxDg/ug1koY
 Mg26BbawaqJgeHJCJxnzljynp8nr8A==
X-Authority-Analysis: v=2.4 cv=d874CBjE c=1 sm=1 tr=0 ts=68e0931d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=jAYgDtSajxceOUjdMdoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
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

v4:
 - Enum and variable name changes.

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
 drivers/crypto/openssl/openssl_pmd_private.h  |   17 +
 drivers/crypto/openssl/rte_openssl_pmd.c      |  870 ++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  133 ++
 lib/cryptodev/rte_crypto_asym.h               |  308 +++
 lib/cryptodev/rte_cryptodev.c                 |   60 +
 lib/cryptodev/rte_cryptodev.h                 |   15 +-
 13 files changed, 5003 insertions(+), 3 deletions(-)
 create mode 100644 app/test/test_cryptodev_ml_dsa_test_vectors.h
 create mode 100644 app/test/test_cryptodev_ml_kem_test_vectors.h

-- 
2.37.1

