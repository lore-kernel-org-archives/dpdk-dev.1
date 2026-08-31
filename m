Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BAC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06BFC40615;
	Mon, 31 Aug 2026 12:24:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B874540615
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:23:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V85c9a880510; Mon, 31 Aug 2026 03:23:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 xRj96mFgI9MRqIfPFhMZGo7EjDnPR0iyTh7p2l37WM=; b=GuBvIo1S6+kKo+21r
 v5voyiVCB2TDzhECNXNmILaHaF6awELM4La0/Rq0nQqgZ0uNMEHiH8gBzPXsF6uN
 NCXxkHGAoFJr7zwF2nYptd2A2qLDxbTW2EYwS0CqOCaf2XodEu+BEcm4pwxvQfbD
 dr7ieDih13sbYR+gTdVDzO6nl+jIZ9sjtGkkLl9/+4r05vXr0e4N9O0HU1xx01xi
 8UOZjicnQJ4Ew2A5OUKIID0BKYPmOISKrYfo8QIn0m7Qm/9wJcfmu3fTc5Z7Qoaa
 00VibMyaM0cIn9RRmfu89WII5+rUQ9B8g7M6PUxRpJeE8m2W4muF1puOITGaq+Og
 0TMvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gcy3ss7u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:23:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:23:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:23:57 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id DA6AE3F704C;
 Mon, 31 Aug 2026 03:23:53 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 04/10] crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
Date: Mon, 31 Aug 2026 10:23:22 +0000
Message-ID: <20260831102328.2813604-5-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX4lJ5IxrSCsaR
 SypSL5MUrmlQzp9uOa7KDqx6IWobnXyfGPFAva+jnl3hRCW/kuoUhQ9MS93fwd2c3BP827WAlJ7
 Zc5Vtg7ZGhlqK84dBWN6ThOo2FAm9zUBvXY1lxC4nAtaXp4PWlnKGUqsYDIh/3sseLWiPsMBYjg
 nVRd+aFiJG7/mcn24AtsywWlX3M3J3ojjkkC/guS7HMxKvry7LaUBqOIIPNPBKrHCYzeG1bGOrE
 togXxFcQX039M+v5MmU5ScouhxELeR3cjRh6KPQcXv4bDZHnF9KL0NMxO1LgEeP3VLs0ljO4jqm
 haxH3Yagn+RMPmoJxnYZVa0gzVKGwOIrMsSfJGRn2fWf2R7ppk4EqfWQbbDLlXpoyECoOtNIsWO
 QT1wl7dlXx60c2+sMSQlM6liVIwDnK4kRTIyRf7HYeO1ftJzkX6FW5PHRFfME9E85zd9mSpXD0P
 G0GFZ+1zk8Ye2cdgTfQ==
X-Proofpoint-ORIG-GUID: KaPS44-ucR1RfGoItb-qh_xjYncEHynA
X-Proofpoint-GUID: KaPS44-ucR1RfGoItb-qh_xjYncEHynA
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a95563d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX7WtXmiVDJGzZ
 Ayb/cuu1tzdmiU5aIks5fXXDasZxpNtdYuJ0WxG+Sk/Hj+WizpITXVi7AhHqiOBWW19hzGlm2Nw
 S0nVBayEBwSkBCxpkBkm85yG8uEi1Bs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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

Update the CNXK cryptodev RSA asymmetric capability to use
rsa_capa and report supported padding schemes.

Advertise RTE_CRYPTO_RSA_PADDING_NONE and
RTE_CRYPTO_RSA_PADDING_PKCS1_5 via pad_types to match RSA
padding support in the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 736d588bde..577f080ba7 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -60,11 +60,15 @@ static const struct rte_cryptodev_capabilities caps_mul[] = {
 					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-				{.modlen = {
+				.rsa_capa = {
+				.modlen = {
 					.min = 17,
 					.max = 1024,
 					.increment = 1
-				}, }
+				},
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5)),
+				},
 			}
 		}, }
 	},
-- 
2.54.0

