Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C2CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 13:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C628240150;
	Mon, 22 Jun 2026 15:52:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3647B40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 15:52:14 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDJ9h82706781; Mon, 22 Jun 2026 06:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=wUtKqjH9tm3YeGfzG2pM1qD
 MaEYCtMRubC4Xl+cTm3Q=; b=H4jZ2ywtCHyeTfhnGO5B9UV5iYBINmiwkQg7CQZ
 7BJb3zs12Jldm9bZwBmmgTv+nfy1GcCA9sfWL7qugfdJ0U89N+/LPvgKYotzxi9Z
 HIfqA0/K0mxtv1lDkh6x08/MiuBSw8eR5kErPSZr2Z79vjKSw8bfyLLRJ4q78/fy
 nwAdHWdsD0tNzFCPmzCV13+8BscKF2PRT9uSIAH2WKPXr9v0vjIbvRdZsxoIcCsX
 nwCysA1VE2n98LhKJZS1GVknL5Y/5QM32AAM1aoKGz7I8nTAUIKmhfbIU58/FPpD
 x3EPdWTpq611cVbFo+08zh4IVUYMyeEUA/58EjQMFqf1eHg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ewtchnexn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 06:52:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 06:52:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 06:52:12 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A4E385C68F6;
 Mon, 22 Jun 2026 06:52:09 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 0/2] improve dmadev tests
Date: Mon, 22 Jun 2026 19:22:06 +0530
Message-ID: <20260622135208.87697-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzNyBTYWx0ZWRfX8yrLAperX2cl
 Z+wYN22Cn7/JFnEhSmtO20bOmuJ73xdXtTQHtyukdo75r17OJYHFW3jjm+iYwkt3rR9xTTceHqI
 8axhVxfLh/IzJS7ynTw1Z4zTPrXBC2AFVUofkK9WGVzX0p5w/jTbPfWFzxhrhdAKjcxRT1pwuV2
 UJ5P1HiMZYy6PosokWUdaHhTjyek59ljdiqIBiumjGfjmmVWh2+WRWXy9FkcPl3rNmBPSMcI2Yx
 +ZL4A9IAz9uflamLOHrizm3IfaaDJTSYBAIhq0T9tOzMdwedqdJygem1htPBsLxEBuKshV88ua6
 iPknNilyOha4z97lV3EonBscGp5/Eehr5Gna3D/s+QCYmKMSdA5GYuvG1O9SVEX14i7knOb691o
 hGNA46vRYVnwvclk48SHoUMjjuVVQCHiti95QmiY7bFkpfeZcn16LZO3TFEaN/PGoZmeMm5yyUL
 ixDmdSqIIhJWJb6d00w==
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a393e0d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=SaFRPCu7GM8-itkRDOMA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 0lEM0V_ZWhYJr1VWBw6nH6dIhc1DgESN
X-Proofpoint-GUID: 0lEM0V_ZWhYJr1VWBw6nH6dIhc1DgESN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzNyBTYWx0ZWRfX8bjbf1nK51ZB
 sji2flf9s7JKmzN4CXsiWEBVEXeu19ohmFbt4jJCQwXB5gi/WPjFv4/8Yi6oXjYcvSdTaRFWLK1
 mcQoxbj0ePi/tQLWj+WewtRcDWAxQY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
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

Extend dmadev tests for SG wrap-around and zero/one fill coverage.

v2:
- Fixed checkpatch warnings.

Tejasree Kondoj (2):
  test/dma: update the sg test to verify wrap around case
  test/dma: add functions to verify zero and one fill

 app/test/test.h            |   4 ++
 app/test/test_dmadev.c     | 102 ++++++++++++++++++++++---------------
 app/test/test_dmadev_api.c |   1 -
 app/test/test_dmadev_api.h |   2 +
 4 files changed, 68 insertions(+), 41 deletions(-)

-- 
2.34.1

