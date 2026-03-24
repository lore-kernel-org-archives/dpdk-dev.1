Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6673F532CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 03:48:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE5CF402CE;
	Tue, 24 Mar 2026 04:48:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2ED154025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 04:48:24 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHXv8W526978 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=6bhgfLC7xQXVVUTDG7Dekrb
 6nDvZZs8lRqmEaBEjBJ0=; b=PxbpDEfXT5eYaSlW2M3mNUAg6NvLh2CDsZCT25o
 RBRKy/mJDlqXsPBHZWlKE5dbxK7adc+DlCyOSaNDfX8SaQ7VyN08+0T2UJaH/Ipz
 vET7PjB5Cd9be4jjXe+pkv/04wnRt5/BjChBZv5VZY0mdEMNxW1aD26Ihoc/khXs
 3nI5G2fndSOTwMsQcKa5uEl5ZR1ANlbSF6IO9Jx9sUx33GmXkfi7qRWC6ICJoobe
 a3Dd6/Q3Xd9AMA57cDoxduXYR7G7zMTrux+KMC9zPqinF4R3DgnYR3n8p7LVDWMw
 qXPOD3iYsQdq0ws+WcKRLz8rVHUfxmx5MXQ8cADMlTIDIoQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d1rpjnd2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Mar 2026 20:48:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Mar 2026 20:48:22 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.42])
 by maili.marvell.com (Postfix) with ESMTP id 944565B6922;
 Mon, 23 Mar 2026 20:48:20 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH 0/2] crypto/cnxk: add SNOW5G and ZUC256 support
Date: Tue, 24 Mar 2026 09:18:17 +0530
Message-ID: <20260324034819.1010198-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5D9G8iedglldwKzKxgEeQoOkftWfRJL6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyOSBTYWx0ZWRfXyYTO9A7yeLkB
 ZQfE+SrAQ5sy9nA0koYAOQslPQ6BwgRmmj2sJdEU93g1WHNCXu+Dyc6vY25MQizlXXzjRvaF8ju
 g6+xyWi82DbT3WZHpbwDXoOPtPvEfyXlkHYFiJ+ZAWvFC2NUFDFpSIVrZpUNupHS513sUVx3Zd8
 wyjXJJmwazoHooS/DibFzEN4ZpFW5EW+t+e2kYWaFGT2HkBCOrB/SwHvU2N8rZ24AU1vw0lEzQi
 8grcA6Xnp1h9rBXHoxIwIlokQPk+p53jRVdEmA/reSfvgnoLn2fzJGhxVjFG1xuzdBVPY7R+Xcz
 Ir1PlQXEAXjuIq5rN/zkUv6YmCKCDBKWuSc8hjhap13UEJamVU1ZrKw2FBqiBIq92XVmpIfWZM1
 ovwJKihxeuRHsLJE60MVDlqT9PPlOX/lrPrN8iv8LeQ5MchhQRA6KvEumjDvvO1Gz0kw1xE7KH8
 6NqUXKuxG2VfbUmhDAA==
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69c20987 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=XmPPfM7G01kl-fcD4IcA:9
X-Proofpoint-GUID: 5D9G8iedglldwKzKxgEeQoOkftWfRJL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
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
algorithms across supported CNXK platforms.

Nithinsen Kaithakadan (1):
  crypto/cnxk: add SNOW5G and ZUC256 support

Tejasree Kondoj (1):
  crypto/cnxk: add ZUC256 v2 support for cn20k

 drivers/common/cnxk/hw/cpt.h                  |   4 +-
 drivers/common/cnxk/roc_se.c                  |  52 +++++++-
 drivers/common/cnxk/roc_se.h                  |  18 ++-
 drivers/crypto/cnxk/cnxk_cryptodev.h          |   2 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c | 118 ++++++++++++++++--
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  13 +-
 drivers/crypto/cnxk/cnxk_se.h                 |  32 ++++-
 7 files changed, 211 insertions(+), 28 deletions(-)

-- 
2.34.1

