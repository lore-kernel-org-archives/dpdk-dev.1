Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C08EFEC0EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 18:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3119F402CC;
	Tue, 24 Mar 2026 19:01:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 871604021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:01:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OGkITO731003 for <dev@dpdk.org>; Tue, 24 Mar 2026 11:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=mAB8ea2pKhH6mdxiLYk5piw
 3uktYNWkMHxPfEuX7zrA=; b=EgnZz9nf/psvsAVpJPjSo0wfbFtMcJbkFv9lC84
 jO6QCItgqBJAfwHcyywi4eSZrVP1jBQZYCrY2w++4h23HZ1URvAXQjQVZ8Gjik4i
 vc4WV2RBqRclHTTdSYofTUcGzbyWZgHPBxPh1bgLqScHWYY6LULmndKZnIDWykV+
 MER3Eg0KY36fl7i/EnTs5oNUYNpGd6dlfvwmT+6wHutMuJMXpwbX30ep0Q+gyrnv
 ESTpFUGpfVUOeX3YW+0xPETVo1OFEK/D5r6i77VDGNi3ulPAntThLdOb8a71tPsw
 U8zGy3Bo6WtGYfyVqoyE6EcCPj8wecxOOxEpyuAjK9fKCYg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d2c36695w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 24 Mar 2026 11:01:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Mar 2026 11:01:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Mar 2026 11:01:24 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.42])
 by maili.marvell.com (Postfix) with ESMTP id 869A13F705A;
 Tue, 24 Mar 2026 11:01:22 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH v2 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Date: Tue, 24 Mar 2026 23:31:19 +0530
Message-ID: <20260324180121.1449787-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOSBTYWx0ZWRfXxJoS6CYNe5gG
 qbNcHUDJFVoN4je+qUMj4TFP08pLNC/NNd+4DeFpJQcAg72Vvd3SZfg32j9Gh6ucUO9Gch/QUuX
 /pr0PJvvcKkv3mR0R4inWmDsBrcb5the/KPdBy/qLkfoQXfgxs8Sd05svjXay/0EKQrcgPY8jgh
 oh1l3qVqJ+MSSpFqPf4tHGBsCW905VPAcRp6H6WdmDLpQxa5U1ggawmmpVtPE1ssxuTvL/sil2z
 OGpGcEAPkEwaUKOyoDRQZz28WMNYAf/alcOSDpbDnXNU9hyIzHCPB7Gz1acjHKTaET6iuvfkhwA
 n3ijP/NubfgitZ+25gkt4RybTMgewDBBd2wck+JNeLKqgw+mcL9Uz6ngW8HFt4GK+owdjcxI4sv
 2J7Shlpv3KGlUhGJqttFZ3CrSuQa31IL9alau2nMSBeCYZ0BSUZZ34EmIYOGRkkoZjA6E/pxwma
 UrOIe8H/cCO43HXn1sg==
X-Proofpoint-ORIG-GUID: ULEbfYTxIefD5yZqIDrm81rL3bvm8tAG
X-Proofpoint-GUID: ULEbfYTxIefD5yZqIDrm81rL3bvm8tAG
X-Authority-Analysis: v=2.4 cv=SItPlevH c=1 sm=1 tr=0 ts=69c2d175 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=pKJgRPgL4S9wehBeXhMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
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

This patch series extends the cnxk crypto PMD to support SNOW5G
NEA4/NIA4 and ZUC256 NEA6/NIA6 confidentiality and integrity
algorithms for CN20K SoC.

v2:
- Amended patch 2/2 to include release notes update
- Updated cn20k.ini configuration for CN20K

Nithinsen Kaithakadan (1):
  crypto/cnxk: add SNOW5G and ZUC256 support

Tejasree Kondoj (1):
  crypto/cnxk: add ZUC256 v2 support for cn20k

 doc/guides/cryptodevs/features/cn20k.ini      |   4 +
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/common/cnxk/hw/cpt.h                  |   4 +-
 drivers/common/cnxk/roc_se.c                  |  52 +++++++-
 drivers/common/cnxk/roc_se.h                  |  18 ++-
 drivers/crypto/cnxk/cnxk_cryptodev.h          |   2 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c | 118 ++++++++++++++++--
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  13 +-
 drivers/crypto/cnxk/cnxk_se.h                 |  32 ++++-
 9 files changed, 219 insertions(+), 28 deletions(-)

-- 
2.34.1

