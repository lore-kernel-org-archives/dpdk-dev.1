Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A139FD9E34
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 04:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4903A40666;
	Fri, 27 Feb 2026 05:37:52 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D1A5E40663
 for <dev@dpdk.org>; Fri, 27 Feb 2026 05:37:50 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QHVgfS1535122 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 Ve5WqP51jBGiHDv6O9tABRvt9hQedC2Qt0yLORH2kI=; b=UAGd3UnpcafVlqYyy
 MegVk3km0ub7izZi557HN75FjVqFggDfqViC6d7aPrM6YhB6ACoGFq5KCgWBapLN
 LMJdkwWf1MR1lX6nZwJhZAtVca/YSsQ9Db+5Zu8jzV2565izE9FW4RERFIL9vNBq
 8VmM3BGRsjaheOuyk+UYZhJQJNkmYWYbCNnF3kjiqS9QUepUPhlikQIPxsfEokHN
 7UjVJWnMWaWdUH9z7F9b+MyIgHTESz/t7Q7ntkqdwPZn5YwFaf0DtBc+2Ti1UZQ/
 LEqm67HAc+QpbLjqoBtEJX1/1MCCKTtjNEzunkDBZ/hsGROYsLA1C3C46S+Q9zzd
 78SuQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjtnd9g4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 20:37:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 20:37:48 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 4407A3F70D0;
 Thu, 26 Feb 2026 20:37:45 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 3/8] common/cnxk: update platform features
Date: Fri, 27 Feb 2026 10:07:18 +0530
Message-ID: <20260227043723.1986183-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227043723.1986183-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
 <20260227043723.1986183-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JYQFxNcYBpTOYaZO7p5I485FSvK4W1D6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAzMSBTYWx0ZWRfX5hZxWcZIzXTX
 9EJKluzBqZspttBHufa4YZz2cuZ3XMR4oefyWp2uBD9kZ4KqIROxNslh0BQwhx6/Ukuwo12va/R
 PRtTTvAshUAC/UiSrGipPgttC8tdrTqGZzhVJ++444Iwo464yuYgIg47gXQAJi9hEmS2e+6zZLe
 b2IS/efQ7RGL08HuyC7MC2BL8zg0/X2LIU2a3vCJzK8keg4lDsTo2BTS+TU3mURPGv/nJj9O+/H
 HNCTgsb6lhv1UQrw8SlkpL9/UEbST6BeGgIzwGOm8bxs+9d/fekk105XbtXl/b32GkZ5KrrDkwO
 1RoQCDLhKdMQVpl8VYwKtYOqVQsCthCANqYasLO2AdoKP771jYUrQ1LwtyKAQM5kkDobBHHzRwt
 KfAi8OJOSR+a8oWdxgMgsJsxkvK/eTyqvgnYWNcoepPDuIZ52O/dBxl1hbai+3Qxi5gC4N3Y3SA
 ggt4+ozF9lu5KeUZdGA==
X-Proofpoint-ORIG-GUID: JYQFxNcYBpTOYaZO7p5I485FSvK4W1D6
X-Authority-Analysis: v=2.4 cv=WYMBqkhX c=1 sm=1 tr=0 ts=69a11f9e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=v69dt79VaSGfBV6H58AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
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
Changes in v2: No changes.
Changes in v3: No changes.

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

