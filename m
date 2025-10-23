Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6BCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5955402F1;
	Thu, 23 Oct 2025 19:27:59 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E46C140667
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:27:56 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3hdNU029708
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 g3t6i888jM1znbMAvXnyh2tOcerRydyiEO40Y9+r0Y=; b=UVpzZWWHKXWiO9I+a
 5rgYd5dkIbubTqjGaOMDa+Dan82/S82zYGhgLY0k5ot9JDr08k1mYiaM779td/Ew
 wDr0jzaX3cCupAUoVhnGhiTgzph7tfjFGdm7B6mmD8nSv6jZC32Kw/9/+kIs+pGn
 UxQSqErQCBvs3CV2ncrBQTTBVMyCJvT7LwdzAEb6YFd54szJH4yXnWkvRqlZGfko
 lv/OUkUHdh/zymMD8nXzYz6gOINBRDXxMMyRQfG7ygonuAqgZLAYKTumB3D8qBr1
 v02q8MuxSVfCro2r03imTvu/RXLct5dG0i93mLj5Ne0IVSlenn8OdGKtJcUecgrW
 hu1rg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq49v88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:27:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 10:28:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 10:28:04 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0E33D3F7068;
 Thu, 23 Oct 2025 10:27:52 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v3 08/19] common/cnxk: update DF flag in IPv4 fragments
Date: Thu, 23 Oct 2025 22:57:16 +0530
Message-ID: <20251023172728.770661-8-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023172728.770661-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251023172728.770661-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfX3wUQwY1sTIpr
 4fTQmx7AuBe7bU+H3DTsKFxSzYnNWih2Q6115KNlBagLix5A5N0sEz/Gscpcf+RsLjWnwTCHkM2
 rgu6X8T4sszvw2zuXq9cZRDUxdH3jnRKfh+UYqC87DatgGXglTwKyP8pjFZ68ynyPOj89rnnPXv
 /ZMoQkeozSmsbiHV2n2YQ6qm6ntVxCSqdrYU5h//Yrp+a9+XKVA4GiF2YYKL9LvgqpTie5gl38r
 WxYoD1bQija/JBohqtYIa65WfyZl1Bq+JGBuPeWGyhPSMSQ2QgR0JzW01+QbPJf7g/MnfUoyfLF
 FxTW7Nh7cn5Tm9/IZUiLYIWuu6Xh9pg0l435TJvHMztpNLSPwKBVRseRLoAjOCCNkKh7joeqNs/
 +dlFCEDuawiSNNiW65RSONzJprcYOg==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68fa659c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=shHwveO5flH-z4HOgfUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mKt2iIk3ve_IWW8yINW6tSacOnLJ8tAi
X-Proofpoint-ORIG-GUID: mKt2iIk3ve_IWW8yINW6tSacOnLJ8tAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
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

From: Satha Rao <skoteshwar@marvell.com>

While performing IPv4 fragmentation, consider the DF flag from the
original packet header instead of setting it to zero.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_ops.c b/drivers/common/cnxk/roc_nix_ops.c
index 138090317a..12a12c6e35 100644
--- a/drivers/common/cnxk/roc_nix_ops.c
+++ b/drivers/common/cnxk/roc_nix_ops.c
@@ -240,11 +240,11 @@ nix_lso_ipv4(struct roc_nix *roc_nix)
 	/* First get flags profile to update v4 flags */
 	memset(&alt_flags, 0, sizeof(alt_flags));
 	alt_flags.s.alt_fsf_set = 0x2000;
-	alt_flags.s.alt_fsf_mask = 0x1FFF;
+	alt_flags.s.alt_fsf_mask = 0x5FFF;
 	alt_flags.s.alt_msf_set = 0x2000;
-	alt_flags.s.alt_msf_mask = 0x1FFF;
+	alt_flags.s.alt_msf_mask = 0x5FFF;
 	alt_flags.s.alt_lsf_set = 0x0000;
-	alt_flags.s.alt_lsf_mask = 0x1FFF;
+	alt_flags.s.alt_lsf_mask = 0x5FFF;
 	flag_idx = roc_nix_lso_alt_flags_profile_setup(roc_nix, &alt_flags);
 	if (flag_idx < 0)
 		return rc;
-- 
2.34.1

