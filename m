Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F4CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB87540651;
	Wed,  1 Oct 2025 09:38:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 29222400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:38:00 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5912vnEk024470;
 Wed, 1 Oct 2025 00:37:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 s+gN8A93fPbU0LuueqPpxAnaunI16U/5ytup0MTyBY=; b=BuWzLq0Cu34RulZ/n
 0zWGo27C+KC161ENRv4OPKRDJVmF2od0p4Ih5EhVWqTxbh5zI4o2Qx2z/DWDbP/o
 Hb3JAqzdSQVtJtIhn1al+xdmjUAEfPnSMy2oqMV8hU70rSiwNmOXohFVE6jg/9Hv
 KJKipC0Gq1/1dPDPZmvIL5j/Iz7Cf8+25U6e3vMbRXUWNAv6XByxXKFyG4hF+AKs
 Pru5fpPhEGKbUwZvSOJb6ajLeA8Ee2Jtfr44e59SSencFRVIDFbbYi81n7Afc6T6
 mLw1dR+No1iKiOQ8slly7SpipPJEg/UxqAazP3tNFo99lOWLkQFJPWfFPGWjPsSx
 mkUlg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefhcgf-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 00:37:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Oct 2025 00:38:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Oct 2025 00:38:06 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.79.12])
 by maili.marvell.com (Postfix) with ESMTP id 4ACE83F70C2;
 Wed,  1 Oct 2025 00:37:55 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v2 0/3] cryptodev: support PQC ML algorithms
Date: Wed, 1 Oct 2025 13:07:52 +0530
Message-ID: <20251001073758.1295-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250930180316.1021-1-gmuthukrishn@marvell.com>
References: <20250930180316.1021-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: d46GafSeZTJeVROx9Z1Y46gUSpD8BAGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfX0nH3q8Pw3fTX
 xuI41ZHQrlYu4Wr3elEgtSBHmgVdl/pmI4qNdEizCZd7PDAgm5wPDNceFhDG3phnFYLQJWlVzJa
 FXVMDhzzhDxjKkflUvUGFLu8w5QcKPb+nYDMOf1BeFZu/erfFz2lY2epTOckPUWtZwUsWPInwYP
 EKHhSTGf+PXPd05uWJ7z31ySfNtypLRXurVEp+glAev9/jE/jHhVPQKhxik2OKw3N8YW/ydoI+J
 HmxlMmBTIfQsg+857pdxoRIonCKIhBU6VF51Sfsvv0OGxOIRjrIsVSPzo5AQlYQEDhxyyqceaJG
 I2dSt8sWyMXVwEDdsfZA+q8MnvV+SZjL9xdKMUZBzr6ouhCujb0LcKUBUQh9oN8e1KcAAe7iyZ7
 cb5yar58sQtroaS32NguNA1t18UAYQ==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dcda57 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=jAYgDtSajxceOUjdMdoA:9
X-Proofpoint-ORIG-GUID: d46GafSeZTJeVROx9Z1Y46gUSpD8BAGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |  131 ++
 lib/cryptodev/rte_crypto_asym.h               |  306 +++
 lib/cryptodev/rte_cryptodev.c                 |   60 +
 lib/cryptodev/rte_cryptodev.h                 |   15 +-
 13 files changed, 4998 insertions(+), 3 deletions(-)
 create mode 100644 app/test/test_cryptodev_ml_dsa_test_vectors.h
 create mode 100644 app/test/test_cryptodev_ml_kem_test_vectors.h

-- 
2.37.1

