Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7180BE9A04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59F0B40654;
	Thu, 19 Feb 2026 10:09:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 54D60402CC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:09:18 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J288GW553489 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 istEhpgRZcqBuyXFz9S/WcUNHCwuE6Bl09rGzr/IEM=; b=hYg/e1br2//ee9ER1
 fqTFrKmbKvupUp9SoaM/XKFYqKZ3jncl7K1wNQwpp2YcjcprQqgFAUapTrZn63KA
 FN/B47dI9hHd1ronrXjmyUTYEWGAEUbrs582XZKfMiGBCaYUVOgd+1yNZbhsf9Js
 f0yc+F6EMU3iY3M6EE9YqckkogWUM3Ae9No/fuEirXEIFVaFll2pp2Zn1bfQOfNL
 Vjj/TvAs2K5Yrxzmo2cgAsFpHcp8Dy5SgPvtZzAeAcXFkgNBgSmSH3+9yjT3vuF7
 cC4Ha0sdFy2YxHTSnRXO4lX7lQJDiA3pbayTXE4pyVDIngbEf7HJlE4JPmoUWs01
 5Aohg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cdsfagmeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 19 Feb 2026 01:09:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Feb 2026 01:09:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 19 Feb 2026 01:09:19 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 5B0123F708A;
 Thu, 19 Feb 2026 01:09:00 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 3/8] common/cnxk: update platform features
Date: Thu, 19 Feb 2026 14:38:42 +0530
Message-ID: <20260219090847.3257753-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219090847.3257753-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=T/GBjvKQ c=1 sm=1 tr=0 ts=6996d33d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=8XJruD5YaIXrFINUfzsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4MyBTYWx0ZWRfXw9yXrbUAcR+X
 b2CZwWpd7EIzlz6edKu6+Zj/1gEPk0ATwKoAa2crfMEAoYD7mmYz72c3KD99ICOWDNA3FSVMOfp
 6ZWxyVwcTQLBEaHur9qgGUCAFshvTgfcU0qwTDHzjn7sLRq+ECpTK4By1wgEE1DGIx7DmFuKura
 9eXjr3SwNR4efbRMQa5t/KM4rzGckAjsqtTNSgVyfBOHL4cIiAGj79Ovv8gsuXRYWJQWQoHnW04
 bG9Yw7ybkSb3PGFp/7CipPiTggVBr4CKldLtig+UHUPx/B2bqFyhhaPJYLMUU/SDrFIZVacvIFM
 mXPMHLCBKYsRLD7LqrFYId20APix9DskNcvZLRi9j7H0BXD1zyC/62St0B3ZbaVBSZGZu8y/rpE
 RX09lqTcZ2kq7DJ6X9iG5I43ZUSiWVuzRc0G6rt6MRIbpfAUadWAv7/aS1xynhmBoXG3ckwx4SS
 zGyLcrYMVeIdhogYUDA==
X-Proofpoint-ORIG-GUID: xwPje3QBcT0_u7ed7CvvCZ-yyvaw7O4n
X-Proofpoint-GUID: xwPje3QBcT0_u7ed7CvvCZ-yyvaw7O4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
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

Adds cnf20ka platform check for plain packet reassembly
features.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 3c34041d76..57a51c4db3 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -117,7 +117,7 @@ roc_feature_nix_has_inl_profile(void)
 static inline bool
 roc_feature_nix_has_plain_pkt_reassembly(void)
 {
-	return roc_model_is_cn20k();
+	return roc_model_is_cn20k() && !roc_model_is_cnf20ka();
 }
 
 static inline bool
-- 
2.34.1

