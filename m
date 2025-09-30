Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0A1CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 18:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CD124025F;
	Tue, 30 Sep 2025 20:03:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4DD40151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 20:03:24 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U9aQjC006500;
 Tue, 30 Sep 2025 11:03:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 ztuQkCItNC0KOPWHx3t5FUMuRXWr5UiY6/AbLvAXgE=; b=UsdwK5z/DxiijBp37
 KmBoTD1AH4o6lUAgsSipSy+Mr1uBka/LIQ0Pw3CY3lL/vc+Qc9AfL+t4ITZfPrzX
 Ud42MsSSCxqIz23Wr2np7eruM8a8LMlPXNs9qsmDZRwxvJZ3/Dsko3VwUIXkWGkJ
 TiVpUMGDmBTfJhjgCL9/VB4ytUrwfWUUk9z2THRvMjjkaK6QUAVxp7813+2NdDRV
 4sPDlO7nFF1pe9d4QvYz89qE5B9pouMKW/j/Z15PBn5N7LZruCDwTFPkHmgxhD37
 KKZH5MhErTRqjAiYZ+siunPpSjCJw3HJgYG5bPRI5cV9Pq4EtBCyJ41uzyVUx9zM
 hEVjA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49gcqahamv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 11:03:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 30 Sep 2025 11:03:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 30 Sep 2025 11:03:21 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.101])
 by maili.marvell.com (Postfix) with ESMTP id 8F0313F7062;
 Tue, 30 Sep 2025 11:03:18 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v1 0/3] cryptodev: support PQC ML algorithms
Date: Tue, 30 Sep 2025 23:33:10 +0530
Message-ID: <20250930180316.1021-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250828070657.8968-1-gmuthukrishn@marvell.com>
References: <20250828070657.8968-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=68dc1b6a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=jAYgDtSajxceOUjdMdoA:9
X-Proofpoint-ORIG-GUID: VqT50TWHoEh-ehF9CGfrcqTR2YuUzOIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA4NSBTYWx0ZWRfX0gtAf4RXd1pq
 HeN5aH1kQomCOOVs21y7zWJ1HoggpM0kZsnGX+qkSUCKX9aaQuZeK91bbKuE7tt22n1PyQIWh2N
 30uC/q3y20QKeovl5JvhhhYxfECYWT4SC6arJZi9wJM9SiEZfe9ZA6k4E12caus1dmBJdZWQJw0
 j5akPGF6o4KfwRiBXc/DOH7OJlsPN4EJx7AXmHO6tJuFDp8+UD79ct/1GMisi5PG2Yfl4NsByRI
 EyePJGbFuEUUpDL+32ZdltR2aEB9WskDez5EU3Hxf+Mwf3Ynu9B12Y1L/IoPy07NCmjT56eFNXb
 Vj7+sD6f47cTcjgbQggHxpuaG2zODrqRQVN6zi7Zv9t7uXGBfpG3oCGXNscRxjohBn8oOgOHS+F
 3NWwImoPe9+FljwgCelOdu0Y42lK0A==
X-Proofpoint-GUID: VqT50TWHoEh-ehF9CGfrcqTR2YuUzOIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
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
 drivers/crypto/openssl/rte_openssl_pmd.c      |  868 ++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  129 ++
 lib/cryptodev/rte_crypto_asym.h               |  306 +++
 lib/cryptodev/rte_cryptodev.c                 |   60 +
 lib/cryptodev/rte_cryptodev.h                 |   15 +-
 13 files changed, 4994 insertions(+), 3 deletions(-)
 create mode 100644 app/test/test_cryptodev_ml_dsa_test_vectors.h
 create mode 100644 app/test/test_cryptodev_ml_kem_test_vectors.h

-- 
2.37.1

