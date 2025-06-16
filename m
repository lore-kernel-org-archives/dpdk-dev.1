Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC5C7115C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F34840DD5;
	Mon, 16 Jun 2025 08:54:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0CA3140DF5
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:54:09 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G0Q7qB019729;
 Sun, 15 Jun 2025 23:54:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 puthZNrDaAkmk59VbbA31DkbG+wTL9DJPk2dkxPN/A=; b=LOXZ7MXDTeNdasKX3
 Bxc00CNdIlUZ52WsER09CZKvRuOAaewxlqOGMQ0+k4Wkmj7ByK3KCiaaW0xxvcfM
 f4M/2a6VhRp3QhLVbJbuUfuG4mlq0d2doeS0b0KlTVISwPftRQX8gmWzYSiNVw+Q
 DVEotOTETpdBgVbN2hxvrSTD2iOatdRKEqtVSnYs1alCE2el9Yz4pOHwEAJZhvLb
 eTNlqnVYb13x814GSBePCFiQURikOO8maOafeMoURziu/LjOddotOHOiKaIKp4VP
 Xk21YSnhN12ArbZNyCVvDIzYIXXrGh8xU98fIKnMxRntEtaKNyW2I3LB+Eru+jkK
 EGZoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7w70mbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:54:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:54:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:54:08 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id C7B9D5E6875;
 Sun, 15 Jun 2025 23:54:06 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
Subject: [PATCH 5/6] test/pmu: enable fast test
Date: Mon, 16 Jun 2025 08:53:40 +0200
Message-ID: <20250616065341.3233106-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BIyzrEQG c=1 sm=1 tr=0 ts=684fbf91 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=7FwtgGkcutPkK8uoqrQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX1iIg0PAbsIz7
 DpMofW4EdTb/u8B5m4cFWH2oZcRO3Ea7yLjSXwcgCIHxI1BTr91Ezr8CI4o4EVtp2ic7uMDhjIz
 IAvNzsAVSjLiabRgaxwY7tC0NLRV1EAjc+xFuBD+Yc0P76g4VdR1M8zpt43+Gfq8GcvT0OVvOVS
 fn4ZL+SBMOZ2SQNy92EctZUiCUBXdZdIRItDCDkxgbuRu+mhmcOXhMFFXIO4qYmyFupLyJsMf9U
 gamQ3yJBqv0qTha2HHJbTBAeUFejmIkOkEW9xpQyfJj9pIZOtc6oJwTeR+LdRdtq03JLLsT5kxP
 ACBzD5BsGqFVKL8/K3sB9js2qXM+WzWeNUlyfMr5IhJQq7wNCAjF9PoY8kRdjkMgXxGupsvTsu4
 VIFkH+V355c0XBqWPB97jelUBTAj4vgSxzV/9YrbnLendlaC2SvEOBnkmVsgQXwlH62hSXj2
X-Proofpoint-ORIG-GUID: _dmXcODaLhImzaly7h7flA8RSzRC6XCH
X-Proofpoint-GUID: _dmXcODaLhImzaly7h7flA8RSzRC6XCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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

DPDK test suite provides much broader architecture coverage than
what can be tested locally so enable the test to help identify
potential issues.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 app/test/test_pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..4d7ee98393 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -52,6 +52,4 @@ test_pmu(void)
 	return unit_test_suite_runner(&pmu_tests);
 }
 
-/* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
- */
+REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
-- 
2.34.1

