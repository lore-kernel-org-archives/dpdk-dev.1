Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B7C982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B7E04275B;
	Thu, 17 Sep 2026 09:10:46 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9B681400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:10:44 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60JiC2203112 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:10:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 qqrpzLskZ8BoPWj0nwYM0jGdqPf7MoXthWhX4Cb//g=; b=gV4LrrkR/YAXtj9Mc
 yFfj1BEKc/li3yYEtsq22vto9l73EuivO1whhPwU55x6Lh2fvzFNPZMmU2iddL2R
 W9RKr1W5N6lraYMcVLEThy1NUpoHmcSsSEaHlSGQcxkydVm0OFKp+gvhWhnwgQKR
 SJjWI6Q7VNusx1+LEsQ4gR08noy5todBwBAe5E4squAnpH9RlsCXEAvWMabljE75
 qxAA/HyANTt8cK+j+TiIbXkLDlhzngrfXB+/ehYeuH9o+1vUHLJ5wMQ9qZw8R9ui
 hC2rfSPpgrjJW2Wcs4xLZfgdDPpJU4h1ahFd3gwwJegwbhG8QWp3Cy28tyW2PTpb
 NGjRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5ygdkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:10:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:10:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:10:42 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 0A4485C68E1;
 Thu, 17 Sep 2026 00:10:38 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 02/14] common/cnxk: disable CPT drop error in CQ
Date: Thu, 17 Sep 2026 12:40:04 +0530
Message-ID: <20260917071016.2366467-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfXxwquG9qxsLGK
 ALO00DXeUMlS+aSALuj1JEKGDhlq0U5FNP9uJzDJvW0VHQ6756M4LwjrCJ8QF08IVnjHJYD5nnx
 3u/MliID+6EZtWI9v6DmCAo1hQQvzHk=
X-Proofpoint-GUID: Gnpvekt7jAa10usTpLbAKLBJsWBTAplW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfX71k6vn68ZP0b
 hLTN8GiV21j5zRHddf/SWBFyiGh1MdRjjJ6XaV+fAWNZXsVGYIh1VTQ0f1S7BRdTHh4XP3GMAmR
 GgUV8Jg0ryOuryygBtGGaT2gPftU5/ePwRAuruin8qZym//gzxKFlQq1d2Yyp9G62lUbj49aKtP
 zaIUkgQG30KirvNbuMSYIDiJVnW+UG8Ebo0gp6YlA6+jViSphj1z5lVHtACBXG4609U/Ln5QzVy
 1Ca5iWOrzROKU3BX4C6iHbcoSkbtMnO9CazH2iaoCtkJfzxRheUVzoDcTEsNW7h6Y+V9p830Jlh
 ihf7bPMMvE1KAppyjcBHOQOK6fuQv1Okyu7d8+s7pd5Wwix33c2edsARLTitNQLhM7GdxQMJNHG
 MgV4SKvwWhuKGL8Zpfz6OVDscl3LxNk+avUZl+D3Usvv3JqpyvxwMhJ1EDL8oXdxgURfK6WZiKx
 IOH55U5YLl0PUPc/BkA==
X-Proofpoint-ORIG-GUID: Gnpvekt7jAa10usTpLbAKLBJsWBTAplW
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9273 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=dYgLdVBHlXNHSjDaLz4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

Disable CPT drop error in CQ context for cn20k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 075c9c1591..ad8f62f38f 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1251,7 +1251,7 @@ roc_nix_cn20k_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 	cq_ctx->cq_err_int_ena |= BIT(NIX_CQERRINT_DOOR_ERR);
 	if (roc_feature_nix_has_late_bp() && roc_nix_inl_inb_is_enabled(roc_nix)) {
 		cq_ctx->cq_err_int_ena |= BIT(NIX_CQERRINT_CPT_DROP);
-		cq_ctx->cpt_drop_err_en = 1;
+		cq_ctx->cpt_drop_err_en = 0;
 		/* Enable Late BP only when non zero CPT BPID */
 		if (cpt_lbpid) {
 			cq_ctx->lbp_ena = 1;
-- 
2.34.1

