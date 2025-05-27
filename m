Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89925C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:00:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25203402D6;
	Tue, 27 May 2025 06:00:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E39C4402CD
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTGBb022487
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=dF/sPihxClX68NlY98AFBG9
 KJoeIJ4C4VzEGGZxlmI4=; b=gpsLaaUrXqrMpzAmIqzTVy6pJxykn/W1+ZbnuSL
 eaJlbqbEvlW4u9Oe8CsvakPaLDwfCH3pEq3v9ZwDfnoZYA7T4XlEC9/FfDIZOkIn
 6z+icgYgOtMSXdMnCy9FuTtfli1yPs32ZKRev59d3MbmBOlou/pSlLgTaO7PY1uL
 upPAzwEfVV4qfCz2lHhOf71S8UAwDIJKztLVfhNsTQZeo9lUp60Va+yeLzdZRIXF
 T6gcEFWp6N4BWVPEPR8BvG//tigeufuflPUFBESsRQ6p4euBsXBEgd2EAHccN6Q6
 UveJ4LGA2+HChp7SpZPDeuiNbBStA4jKuOy6s3m4H0OiKPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w20v0bm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:39 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id CBEC53F7060;
 Mon, 26 May 2025 21:00:37 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/6] fixes and improvements to cnxk crypto PMD
Date: Tue, 27 May 2025 09:30:30 +0530
Message-ID: <20250527040036.2280893-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=c8OrQQ9l c=1 sm=1 tr=0 ts=683538e9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=GUFH8EpoFLBsYmRDYRsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfXzEgFkptcKZ8k
 3VjHoz7vwPnsXVXCP6zFjtW9Vtt+fn+/Sm/nS93QtpuqJbiI8isOX1PQNSshhU5a+9DIe5mgCPH
 DuVsm0j8kb1yngQWiSAvkcV98dJ7E+ozBbT/56+sy0VusxaUFP/FifO4CgQcS8PrOODihDh5JGP
 +I4WMhtCczy2+WjsO90ami78+nlydGurLzii2ZeWUX0vgL1a62N86T0SD6OsQP+EPU04N4qNm0V
 iEuimG4LrQo+Q2NdIJehMFylypdA3QQRl6FSE+c0PCrBEuV7s2u1ha6nY848f1ZA3b3za011EqU
 BImzhfR04nJ67HEIbD12tioIIGNLeXmmVlaGxHlyC7Po00gB8c99GI4pIffPO5j+mred+CClCrp
 tk8n5FoENq6h1WDvwBfYkqlQDdRSL1LKiiZE5JFzzCZ7Dqf6/9xgNimitmaSYbZW9aY0YmY3
X-Proofpoint-ORIG-GUID: wd0kvImcHrr8ZLlnnUZ0mwHCKm2SC0bD
X-Proofpoint-GUID: wd0kvImcHrr8ZLlnnUZ0mwHCKm2SC0bD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

This patch adds fixes and improvements to cnxk crypto PMD.

Aakash Sasidharan (1):
  crypto/cnxk: fail Rx inject configure if not supported

Tejasree Kondoj (3):
  crypto/cnxk: add lookaside IPsec CPT LF stats
  crypto/cnxk: fix qp stats PMD API
  crypto/cnxk: enable IV from application support

Vidya Sagar Velumuri (2):
  crypto/cnxk: update the sg list population
  crypto/cnxk: add check for max supported gather entries

 drivers/common/cnxk/roc_cpt_sg.h              |  1 +
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  6 ++++++
 drivers/crypto/cnxk/cn10k_ipsec.c             |  4 ++++
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h      | 10 ++++++++++
 drivers/crypto/cnxk/cn10k_tls_ops.h           | 18 ++++++++++++++----
 drivers/crypto/cnxk/cn9k_ipsec.c              | 19 +------------------
 drivers/crypto/cnxk/cn9k_ipsec_la_ops.h       |  5 +----
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |  6 ++----
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  3 ++-
 9 files changed, 41 insertions(+), 31 deletions(-)

-- 
2.25.1

