Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759FC982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FADC4278E;
	Thu, 17 Sep 2026 09:14:31 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 52CEB400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:14:29 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60DA72202685 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 yzDeV9ZEGc8ZkdI0YWzihX7uFoV5A+k88KPVWVGG3k=; b=goW7//7Gf/Br8TMcf
 rGj8moAFGiO2h6dqVaomfn/7orF8bDugtYeytneBJ4kYy54zcIcDGWNn13Tcq3XO
 vPL7Jz/D5JxJlOP5s8sUZgevPFTQugpUnkB2XzqbtH+L1OmxtYKEGQ/sr0gqwuov
 C1LWtGB7a4Rg3NTxyaQ0xF3g5yA//EP/WdIOyfF3EjgOSsUiFGF1h4PHYQs+0iF0
 qriKfwE6Yzg90YQb8gXVDC9Az6hozfW0J0GN0Wy0lqmrhxsZMTtd4UTApbizB2mT
 j3RqWHDmqcbVskpLL3mqS+ymX8449SK3bjK49Z6LkWT7khlTlYwqR/TshYDQDWhP
 yPRHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gra5yge18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Sep 2026 00:14:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:14:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:14:27 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 606A85C68E2;
 Thu, 17 Sep 2026 00:14:23 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 05/14] common/cnxk: update macro for cn20k
Date: Thu, 17 Sep 2026 12:40:07 +0530
Message-ID: <20260917071016.2366467-5-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917071016.2366467-1-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX20uzXqUnhSE2
 lZCAldo3p+Ce99mkUeziJtv8mjKdXzsCyetUm0JrIbaUaHQipGObM/Zo3Y1EIhsfZMJmJ06Mu+E
 JbcmW/vyYkTRxPgC10dvr+4jloJtA3A=
X-Proofpoint-GUID: Ww0n3oZ9wEZspG_3BvzTyyMAKrk-rIlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX87lWXLFAFMrp
 5zaoKQTOf3ntabDS2ik5L/NLSxSsTUBu9kgZcccbQVZ2JwD45CVApVvQzPprQ5W55Mfe3lHFMQU
 nnra+l2OAKA6TReWPhyju5Aj/xfO+rTWeu30MfDiAtnKNVLpvkbJ0nYdhgzgzfNtXDywgL0Luoe
 R3xZ7J136L9kJlqO1AvdPZ5EWttGliRbGfKf3QYseLsMeqm4syLipAOm6yVYmKUvNS9vcuI2pXG
 uK41vVP9TW1rh2GmRvQ+/VGLDgfFIktqolDtz0txLqOXb2ghTE8MXIKtN2cVCFx1/lXwXMkRN6V
 7jF266s2DTUxv9gwDsPVvE+aO+LfIYiYWRtihulou8qRwYKh7O+myvqQzanz74G5qqDZWio6blX
 ZhYmgksAaMpaEW3714fjtcsGP27JxT/ekV47rGBpHSO3JOJ+tcHxk/hUqyZvGSVVIgQnECOqKwu
 Ja+SygVnLWSsNO33LDw==
X-Proofpoint-ORIG-GUID: Ww0n3oZ9wEZspG_3BvzTyyMAKrk-rIlu
X-Authority-Analysis: v=2.4 cv=TekDJhQh c=1 sm=1 tr=0 ts=6aab9354 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=9EVfq-8mMF83knPN1NEA:9
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

update macro for SA_LIFE_UNIT_OCTETS as per cn20k

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 228ff2781d..719d4987b1 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -1445,7 +1445,7 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			plt_err("Expiry tracking with both packets & bytes is not supported");
 			return -EINVAL;
 		}
-		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_PKTS;
+		w2->s.life_unit = ROC_IE_OW_SA_LIFE_UNIT_PKTS;
 	}
 
 	if (ipsec_xfrm->life.bytes_soft_limit != 0 || ipsec_xfrm->life.bytes_hard_limit != 0) {
@@ -1454,7 +1454,7 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			plt_err("Expiry tracking with both packets & bytes is not supported");
 			return -EINVAL;
 		}
-		w2->s.life_unit = ROC_IE_OT_SA_LIFE_UNIT_OCTETS;
+		w2->s.life_unit = ROC_IE_OW_SA_LIFE_UNIT_OCTETS;
 	}
 
 	return 0;
-- 
2.34.1

