Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883CCC7115D
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 04:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D16AF402D9;
	Mon, 23 Jun 2025 06:49:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1951A400D6
 for <dev@dpdk.org>; Mon, 23 Jun 2025 06:49:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0FqSH018167
 for <dev@dpdk.org>; Sun, 22 Jun 2025 21:49:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 j9ncjDXopIgKKl8zebTEeAVSCi+Q9ZnEg08GLWR44M=; b=ICYaQ3JXuB43s8GLr
 JRUeG9edo2GEb/fZkUqWTrpxa6c9atmYoLSMbFvzkcfQAtciL8PyK7tvImM9641T
 Z+oE0ZfbKEfGitPn5f1cmId/WHMqNjiz5cq1GWpchJDwkY3z8REI3/mY9AjF0THf
 PPp2yjhFKUgJ/IaRlc7x7TzehLGjPNafzh32z+cHTRn3BsBLl8bgW3pbtFXjp/xK
 Tuf6FepaN0MH7wZyV+DxdIMXb0CLuK2zPraQFsjuxIuPRiyasa/V/mGN9tqrEk5J
 JLNcvZihQPVGDQwtSlN/Qq5V3Yv0rmE/AKMxTBYHJVrr8kvQBR/TQd3mMPu0NNgU
 gWMdA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47ethu0fa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 22 Jun 2025 21:49:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 22 Jun 2025 21:49:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 22 Jun 2025 21:49:35 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id EF1AA3F705B;
 Sun, 22 Jun 2025 21:49:32 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, Jerin Jacob <jerinj@marvell.com>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 2/2] common/cnxk: fix null pointer checks
Date: Mon, 23 Jun 2025 10:19:07 +0530
Message-ID: <20250623044907.2906896-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250623044907.2906896-1-rbhansali@marvell.com>
References: <20250620050950.2548925-1-rbhansali@marvell.com>
 <20250623044907.2906896-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6858dce1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=d8muHipexngm-UZBRnIA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: HOG_sRbBDNl2wnR9D84fWGwG2r61JPBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyNiBTYWx0ZWRfX0ZquIB9tAWBm
 PCZWv0hBPfpcbmfa7+V/9dswZ4O83L6cjgIimVZcS9rx3iv5rFh9q/zEPE/o4zfrw3jC70DG1JM
 z3QHemjKDTPZ6pTpubWazvjAhG+YByX96S2MKPtceOqPj1uJy80oD7QNeKnF3WZsNEfYo3mRIhn
 C6yZiomuZVkJQ5gD6o4BkJNNknI3ORXT/DN1uZhUB6V0XyF+zzieuyGI8iZqMccJcfsboEWXcB7
 u+lCyNKQpNhZbJyQBiNspN4WlWkB/jlJLODMex4iI1Qsk92jLg/frkqt0Vjcfmw3c7Urqfumehy
 XWrbNTbdpQhBR6Cluny9MzKDRQEEJvOclLHuU4jFO+yks3MNcX/2Gf0+gDCfsS28kvMgWYdKwZp
 7C8TYfkDXPoBwnSjuSmolyAiULIScM8+cSNh1f1+JCBY898+/89hvUXo+JLuaDStWRcbhen5
X-Proofpoint-ORIG-GUID: HOG_sRbBDNl2wnR9D84fWGwG2r61JPBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
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

Fixes: 4d00b8c6a331 ("common/cnxk: allocate dynamic BPIDs")
Fixes: 4af4e36a93d7 ("common/cnxk: support inline device API without ROC NIX")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated fixes in commit message.

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

