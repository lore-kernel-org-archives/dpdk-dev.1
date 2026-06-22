Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E3CD98F0
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 03:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6020C4021F;
	Mon, 22 Jun 2026 05:06:30 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9621E40150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:06:28 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65LNwHt3125115; Sun, 21 Jun 2026 20:06:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rM5fzBGyv0iM49nioJfmNAJ
 d+dtKYUXaOmA5SSJylnE=; b=VLKQoR3iYZ1OrKehLKYfWvFMrnogGBnbMdxAruE
 DGUZFO3etvl6xubQqcdtEqaxfp1dOEmepyYzDdEmmJreuawITdPx/XZDEYwn1ASh
 L+B3CcUfjuMKgUJ7087U3rDiaZp7uKhMA/mKrV0ocG8qg7EaY6AeFw6eJeaRyUGk
 7kINtdEbFRAOucqcMvCLBXIIchAnyLlvMGgOxrq1BL3JEWxI+4gleTa+ZAu6rjsH
 FCjkLax99tog4nlZ5I7vdC0sH+MExrZseMmSIQulDCF5IMB5lmFgoLFKcG7YyS7Q
 GWRwme9ny6TKHW2dtmMSvXqdVnnIKuagM+lW6kT7nj7ymrA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48sgx2-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Jun 2026 20:06:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 20:06:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 20:06:26 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 3A9133F704C;
 Sun, 21 Jun 2026 20:06:23 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/2] test/dma: improve dmadev tests
Date: Mon, 22 Jun 2026 08:36:21 +0530
Message-ID: <20260622030623.86094-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hHdGS0oEzaZ7QEisCGFiYcun6eSbWjpb
X-Proofpoint-GUID: hHdGS0oEzaZ7QEisCGFiYcun6eSbWjpb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfXxN3WHK8pRGe/
 zNLTseLlQfhZQqVxUg7Knh4yhOzmzlreJKt51TM5DqJiERngLUFRiMUmD+UiaCd51BvGdIpPdGp
 KRThRRu45a05W9IuPw1zE9FfGnpPfZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfX7ovH7W/NUmcZ
 gKycTPOp58SlEwowFkK2/Bvs3VB6zUv8/1BcPhfhQp/+M66F10i0D7tdeUQeR8XEjdH/GYMuETS
 C+nSzFpEReA9jnhBbfwPzua2TQnuvXZ2Y239gs80nQuGRxll2efS+vnAXi76vlFmUVsmXJfqttv
 XIvdaxN+eevGysJ1U2L8wmOQMyIVaIUNkrVYTdqVRvBerMFydp+VZ+f+MOLvjTTL5gSehdhb6Rw
 o6PuiEQKiOp6bzQ6BMQj0r8Ng5JS6bWpg4CYeGDhS7slUWtwYBolNK0koOK1+DNWt4IZtcV07PY
 3thUq/oudHE18HwhBSk1Trk1UMQg6hyKMT4h0iRSixK2ttL+tAs6d4a7ByHg5YPqcJOMhYX9h26
 qfg+SgEFkLfnez3dmrzix9UYuhaNJpIp9f0zwvLK2efVKBetCJZl64fvzXbnR0wl/JypMuUWb6k
 Y+6E0C2qgbxj1+z98OA==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a38a6b3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=bVbIhm5BxSNEwZoTZ2EA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
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

Tejasree Kondoj (2):
  test/dma: update the sg test to verify wrap around case
  test/dma: add functions to verify zero and one fill

 app/test/test.h                |   4 ++
 app/test/test_dmadev.c         | 102 +++++++++++++++++------------
 app/test/test_dmadev_api.c     |   1 -
 app/test/test_dmadev_api.h     |   2 ++
 4 files changed, 72 insertions(+), 25 deletions(-)

-- 
2.34.1
