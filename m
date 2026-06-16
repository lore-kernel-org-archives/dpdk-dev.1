Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C61CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7459540289;
	Tue, 16 Jun 2026 13:21:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 85F464026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:21:18 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GBIeMU2587094; Tue, 16 Jun 2026 04:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vOuA9WuICDLhSuaZzMHZwv0
 Pq0WnzHMhi7s1U3iQD0E=; b=I5ONbau7DJHl+lpKvV1kEQUofIft7HbNlVz4In3
 vD/0mfxoaehhw5YJo0ydwuOpnWBb4LHNuMsM+T7Hc3eA76VbTvqwVAHO+g3kQG/u
 1Ktp9K/6AvlLTUrZMpzX//hgimMu59kS54PRrfiJZTD1hlunQLyR1z4Xeg8YRRy8
 aEYJBl1hVpQ/60AVqGnxYhy8l87QwnlsT3CC18yQoDrwvTPU2gKRzreki8E4cRyq
 kLb5h8ci4iFBLirs0NDkTKf/dWxdygc1Lt0zoYCffpciBf7pycjoNRUCrCcQnrUP
 I3pxmMlZ4O6RuQcRlQ7diiQcetfQhGKRTpwRkVr1zI9nEsA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38jcdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:21:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 04:21:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 04:21:16 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C140F3F7099;
 Tue, 16 Jun 2026 04:21:14 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 0/4] test/crypto: update CN20K and sessionless coverage
Date: Tue, 16 Jun 2026 16:51:09 +0530
Message-ID: <20260616112113.73680-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KhKfm-oQygXP2YZO20zGLs6yW1ARBmQ-
X-Proofpoint-ORIG-GUID: KhKfm-oQygXP2YZO20zGLs6yW1ARBmQ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfXzYW2mH3G8hcN
 SgQttGTo2mJDRNnsu3Ub9QFooxUBNfCPR/zbPC4QLD2tc+TqpsjmlSNxhKtj5KAKnlXAaYbYE6W
 wWq7EVH6Ft0Khlf+CTFR215+QBT+Te0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfXxAxDynUERQKE
 PJnPLR+RCkk8/+sk/ar+SefC1rZPr5aDAyjIRrLww+5UVLK9xCreeQqtnDXY77fKzxkFy5N7PA0
 asIdQBc+ANie634z/8o3ghijwlBxy3HQ1dhA6ffYTAsbFAWkTFIwdPhX6cFYxSX1LN+iiCyBnBI
 sZT8SccP2lbyrzLtCSpilo71Fv3H2eqwXmAqFspB87BxuDJW8dM+NXw1yIEKlrDY50ib2jdV2xz
 Wczq+Ebg8USYQ8yoSWLopWz8rPYwn9ELUGY+DOICyCHS8bX55uMDyqRKuJx7ZnMGY+jYsDDLcCc
 saScIPTnEqXhts6n8lT4oTImN+VD/hcvLkCjRU1WP4VbSJ3s7gqmGA9MjjUq4rVrN7YjyzLnJnI
 74L3smb6B96Iowz1mrIoC4UdcnzKul9vmNepRrAMELh5L8YaGFpfih1owtThww2yBNPp6iwrkBA
 npfRHXKFgdhzbN7STtw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a3131ad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=jHkDha5rcs9NMYSuAzMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
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

Add CN20K sym/asym autotests, asymmetric sessionless test
and Rx-inject multi-segment unit test.

Vidya Sagar Velumuri (4):
  test/crypto: add asymmetric sessionless test case
  test/crypto: add asym autotest support for cn20k
  test/crypto: add autotest support for cn20k
  test/crypto: add unit test for Rx inject multi seg

 app/test/test.h                |   4 ++
 app/test/test_cryptodev.c      |  42 +++++++++++-
 app/test/test_cryptodev.h      |   1 +
 app/test/test_cryptodev_asym.c | 113 +++++++++++++++++++++++++++++++--
 4 files changed, 160 insertions(+), 31 deletions(-)

-- 
2.34.1
