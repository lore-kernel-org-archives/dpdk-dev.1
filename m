Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA3BC7115B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 05:10:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BBF42E90;
	Fri, 20 Jun 2025 07:10:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 79EEE42E90
 for <dev@dpdk.org>; Fri, 20 Jun 2025 07:10:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4iPDh028289
 for <dev@dpdk.org>; Thu, 19 Jun 2025 22:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 2SwCyHSwgzbm6Lnu7rwrdGAh2odgA4Nhxyx/eC3So4=; b=VKf9B0FJ0KP24ExMA
 po6ksWHNdTkWV0po3Wf3Ym+Zf7duYMeiQ4MSsu2K/Qio3OCCtuSsoj969TCv2DOu
 ZaY64g7NcSbtKdSb+sYGMU2NvooUMf7F+C90/V01H8pINMIhHEwKezhpd0cRiYUg
 J3JVN3tXAhbb3lFOgKa+k4ANhVTBqEl1QAuWc6zdoiLbMw2IFnJFZKDdm0i9LkmG
 RPLUW0Oeehi8uGD4TSUPC9pCoOeUNMCt/DuCeMvmiF2u7Qy20qtQpH6T2TSuoV1H
 zxUY/7KRDluSYtIx7vb4D6Y0TwpPaRaXyH/kBhxecSgvEZV/fg8uGRb8fkT9Xg2Y
 lWF1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47d0vb0197-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 19 Jun 2025 22:10:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Jun 2025 22:10:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Jun 2025 22:10:05 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id EEFE35B6934;
 Thu, 19 Jun 2025 22:10:02 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 2/2] common/cnxk: add null pointer checks
Date: Fri, 20 Jun 2025 10:39:50 +0530
Message-ID: <20250620050950.2548925-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250620050950.2548925-1-rbhansali@marvell.com>
References: <20250620050950.2548925-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lhOEcVsIbU0-qk0f07vNRrYRkAlru7Ou
X-Authority-Analysis: v=2.4 cv=O+s5vA9W c=1 sm=1 tr=0 ts=6854ed2e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=pEjzAy1FaGkatut210AA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lhOEcVsIbU0-qk0f07vNRrYRkAlru7Ou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAzNyBTYWx0ZWRfX7HXJ7wPwzhRw
 /zGkrMvP7lPSsBDgpiYnLggi66IW07gIBXepBj3OiTeAF9JPXpKtUXPLOLxOX2DnuqugLFHDX48
 DtSWa0RrLhCpF6dOP0gRKE/Do+Q6d+nVSeBP6OWZKx2++c0YW7t8BNDSQSR4XaHLKlBcG6994E4
 KfaD08syNZezyIH4dFqfUOfeM/EFmHc/off/UL7eNWqDKhYkj4GlKojL4phcOBHviPUQZO+Bpo1
 JHyyHKMGdXgUBcAGAi5BV22oBk9m5SgaRHWFBHrs/4DurzQ08YKwv9o/sJv2opNdoyooeWnHw0p
 XBmj/XN67vWpa1AMe6VQfzFHIt5MCkwfTdALUcdRxFTwrzryND46i3KdPNrGZ26C1cIScOdRDuh
 Jky9EHG7bpuNPGNHWp+gbMxbmbpa8gIHjjxK+RPxqJGh2LslUDqHUp6LdVbk9ejTQ6DKUlGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_01,2025-06-18_03,2025-03-28_01
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

Adds null pointer check before executing CPT instruction.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index bee8e25c7c..c7637ddbdc 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -1312,7 +1312,7 @@ static int
 nix_inl_legacy_inb_init(struct roc_nix *roc_nix)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	struct roc_cpt_inline_ipsec_inb_cfg cfg;
+	struct roc_cpt_inline_ipsec_inb_cfg cfg = {0};
 	struct idev_cfg *idev = idev_get_cfg();
 	uint16_t bpids[ROC_NIX_MAX_BPID_CNT];
 	struct roc_cpt *roc_cpt;
@@ -2219,7 +2219,7 @@ roc_nix_inl_sa_sync(struct roc_nix *roc_nix, void *sa, bool inb,
 	if (idev)
 		inl_dev = idev->nix_inl_dev;
 
-	if (!inl_dev && roc_nix == NULL)
+	if ((!inl_dev && roc_nix == NULL) || sa == NULL)
 		return -EINVAL;
 
 	if (roc_nix) {
@@ -2299,7 +2299,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	if (idev)
 		inl_dev = idev->nix_inl_dev;
 
-	if (!inl_dev && roc_nix == NULL)
+	if ((!inl_dev && roc_nix == NULL) || sa_dptr == NULL || sa_cptr == NULL)
 		return -EINVAL;
 
 	if (roc_nix) {
-- 
2.25.1

