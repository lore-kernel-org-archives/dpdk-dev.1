Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B765FCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 758214014F;
	Tue, 23 Jun 2026 06:27:31 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5654003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:27:29 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0fuUE2831788; Mon, 22 Jun 2026 21:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=gON/1Zpyt7uLdL+8GB2sSbA
 BOYP3BzW0ZFCsqsgkEHA=; b=EtKHby8z1OHamvhl3S7pSrotg5IBe/ofTSD1WK6
 bHxQFA3B/yK8iQTtZ/WrlMX9tDKG42349sZpqy67ns0Yc92BB95Q/a5WJEZ4OXAG
 iuk5IuCrJCYT11iUuXfaMdYoc8ogkkqvz3CYFn3sbl5vQYXrJNqZdPBTFmoPxWbf
 Kk/FWLjL8ax0HM93pFvbNs7X+/0+TYaeONllIMQ+BSZs4NqXKmCdGb0mi+decd5M
 9xGa9RTBUTMC6jKg0E9lA2FJ5jFkiwj020s6mddUyG/5ghvVltCtH+Zglv7eJFEo
 vUD/MzJ+Em0mKurGQQIza0rbqSSUlcz96sHtDSTuAm2j/Nw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48wnbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 21:27:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:27:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:27:26 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 547723F708D;
 Mon, 22 Jun 2026 21:27:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 0/3] update tests with CN20K support
Date: Tue, 23 Jun 2026 09:57:20 +0530
Message-ID: <20260623042723.89226-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zDDVsaiVqnxy4N6umm62K_3KyaxGyTBM
X-Proofpoint-GUID: zDDVsaiVqnxy4N6umm62K_3KyaxGyTBM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX7GSqA1D/EODF
 l8vdbFicJ+UHKqS8LVNrhe73uOs8nqAlirZ7Kau2qgOpIGAKTC6uQJi05ajC+IPOW86/GoIxXCi
 BbzT+OyQgtB51WIvBdZ9h68gPVXudkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfXx711V7caDXP0
 ymipVnKmX9kYiFP4B1vLNJxGYjUr9C0aGd8IHN9fMm1eXegWE+PcoFT5CWCdxJaNBkDRG5J1q7r
 bNVgoCjWkqBzhaDIPWnrtDx/UuSc+NM9gkv8JY8tjeWWJYz+1PPLp6MaMKH6z2Zc6TAaU4yRDzz
 A1otEXfMk/0IcnuTJUNODQ4XP6LNbtryF7h+zUquRUikCWbmkrR5mo7U17eMVy1ptYn1CYrHxO6
 2nod8ZIlgxbLD81DHAct3+gC/zuPAAL5JrA3hR4o6aW+pXU+aPgVrNHEnwko7x9dk4hMCsUKSud
 uOEiW3WLGkEqv1qokIQm+qa3p9QDzFxtCgKaLNLwIL8o1B5JChcyDGAxiL9hX9MQFSpCWw11hXj
 N9D1UcRpw4nw17f7dUr/CQ9qJjsikV6XMh5Kb7E2EvVR862QLGl+PLvZsXLp8gU+ywyrfoGrf3X
 g2tThuC7UUYg8vS0KzA==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a3a0b2e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=uQP3lt9qalru4-4fnr0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

Add CN20K sym/asym autotests and Rx-inject multi-segment unit test.

v2:
- Removed asym sessionless test patch
- Fixed test names ordering

Vidya Sagar Velumuri (3):
  test/crypto: add asym autotest support for cn20k
  test/crypto: add autotest support for cn20k
  test/crypto: add unit test for Rx inject multi seg

 app/test/test_cryptodev.c      | 42 +++++++++++++++++++++++++++++++++-
 app/test/test_cryptodev.h      |  1 +
 app/test/test_cryptodev_asym.c |  7 ++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.34.1

