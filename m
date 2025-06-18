Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08793C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AA98427D2;
	Wed, 18 Jun 2025 08:56:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 734F4427D4
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:56:39 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNXMRo023310;
 Tue, 17 Jun 2025 23:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 puthZNrDaAkmk59VbbA31DkbG+wTL9DJPk2dkxPN/A=; b=cNlFEDk7MlRcT+zrf
 qEhonOzRp/a3UACXoQ2fYMRNcibNHdfARS2Gn4LW3WCCymHFFa6j9CDuEY5LFvmp
 +YfFTbW6uBbkqkp22M2QSC5bkGRHJASbjA0a3UbC/mLYyKOwLS1ylfSD/yc45sBu
 mT2kRpy+zHHISOvncED3xYFsrj+23Jaer7kJHvGVBzeGJocBhUMa8yayPwI5/tc8
 wcrXS0liAsq87fABwv7QrLttelLuAM/Z5eIcf/Iq6STI41NcMWZUl0VpIRtTd+C6
 l+eCiXeKaaVX7DbAbQmn7OjxcWW5yEXvfDNyu+/U78e5zQdoR99ib8MlbhuLCNDv
 RHzLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xrq6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 23:56:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:56:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:56:37 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 513B03F7043;
 Tue, 17 Jun 2025 23:56:35 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 5/6] test/pmu: enable fast test
Date: Wed, 18 Jun 2025 08:56:17 +0200
Message-ID: <20250618065618.4045910-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618065618.4045910-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=68526326 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=7FwtgGkcutPkK8uoqrQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfX7gd2xFjGbQbU
 CzzTJAGso+WxUQhDY0l6lYND2YDjKIMX3qeO7n/ib8KJ3tyO58yhmzfMV8B3WvXnOqC1hUk33/N
 72zUHBV7LJpqfsdDrDwOum6IHMneQchZizfWZKlqYVbR3ik+cTSezGQpiLGzEkpvo4FvYBATVzC
 gTysTQMwGYsgB4FWmgYUOWzhgDifXuCwYqFaxVm9hq3MqhZNpAkRNWU1Iry1LCVrnWFkXFYCEth
 SzZEMmBt+BJmgHBSrxSTz8dFoGNSzVCfXM0sPcPsLgixPO6yaPeDmz9tJ5THcUn/J2pcqZwnzL/
 3NBhdfq4GlluSZtRHvKjq6ru/fzbIUSUaJCA0Ck11ExO3B5MbnGIagkBxpw6UFjkDf0DU2RLE9w
 GKRMNIS9gfJqYy9WCpwFkE+Cw+6euNi84OIdeUEc5ricwRjznJfwl0lbT6EPYAed9UrpzGfX
X-Proofpoint-GUID: uaWgF4S5A1__ua0AD13CxFH5iy8TwzK0
X-Proofpoint-ORIG-GUID: uaWgF4S5A1__ua0AD13CxFH5iy8TwzK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
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

