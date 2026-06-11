Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970CFCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74ACB432A0;
	Thu, 11 Jun 2026 16:21:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A7DC34328B;
 Thu, 11 Jun 2026 16:21:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXd3c2103786; Thu, 11 Jun 2026 07:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 wfFKUFYA0ehA/6f1Vg5CR9vDm4bjIAQyyXGMUiQNlg=; b=HmM88geBJE5T32/x2
 R1QHgf+kwbrqMezh96qiNM1hVHt7t23EkFUQT3kydlOj7S5j/j3RHUfw3Wu8mqF1
 z63RbjlbvBN8CwO31JqEknLL8reTJmqmJ0pyElz59Emjc68G9Z4x1ZLHDdcjZAaR
 Bf/4kvh0Btuzvi3P2d0XgiFYnDJW24CNPj71UFb+QVo4Q1luV683ewvIgezY1D8j
 ufTNuBsltZmuojyJedXTkgN22YgNzWbhmU0WbYH9Q+EhWyGJQE7bWUZYrX8UfAQS
 2B1FLtUz8SfUUC9ORV6/vj7QqjZUOk08pBPtwz46+LqnU39tAPrm/66DugsugH58
 fsz1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r37ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:21:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:51 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 088745B6974;
 Thu, 11 Jun 2026 07:21:47 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 14/22] net/cnxk: fix bitwise operand size mismatch in link
 mode
Date: Thu, 11 Jun 2026 19:50:21 +0530
Message-ID: <20260611142029.3351415-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXzWKFV5waDMVm
 Md97wvgR4QFMpBgPg3HkfR9Ms6BkLYy1qUTc22ITpS+sYSk/X4SQTWfne9v1om1JdwWHEXV4iFe
 70UaTTX9rgSIvDSUMfogR2k5NPUCdO0=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2ac47f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=CJVFzQNyZXf_rX7GSKAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: VkG2lhCiJD1-myiFf4L5wUIkngYxiDuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX66tNkTWj54CW
 GfEFWGIDKTN0I01ONmPJm8e7rbxPkfzUYwnWCvJB2Hz2rGdG17SASuvcuvclqXrF9SFJSgsiN/F
 s3kKe8PrEqqqxQI3IX4yk1U7C5jlsUWI/GxrluncUewWGLRbXU4nJAgl0F28ktK/YV+q5rVJosF
 CWHk04CPxmrhjJy2oF3v2ctaNw6KS0keYi9Npj0kkm7OzB8FkRgrILLzhRy3QViVQnn/7VrDYkB
 pcBuTXIzF3WeNadL6JLV+CQp/SS/GZ5yrQMvWLwwuRSfZB9m0Ol4oBPUaWThxcpvbo83zJ+kFia
 h8Mh8kqxfJUvVtMAqQt92XQA9QRMLyO163aJW2JfmxgY3TVF/qZBzsmsjcvs0b0toH2p1vBzjZ0
 5RAVVZr0EG2GFPGSGJ+X0T11k1aAxO4L4dD5G6xYOndwxspr44pnX3y5Ii+lWxo02lPaUBwoG4b
 c4uwZ1Cae0+wrpHY0qA==
X-Proofpoint-ORIG-GUID: VkG2lhCiJD1-myiFf4L5wUIkngYxiDuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Cast enum roc_nix_link_mode values to uint64_t before bitwise
OR with uint64_t advertise variable to ensure consistent
operand sizes.

Fixes: 292fcbb3d290 ("net/cnxk: support link mode configuration")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v2: No change.

 drivers/net/cnxk/cnxk_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index dde2c3a313..f6682b4697 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -61,13 +61,13 @@ nix_link_advertising_get(struct cnxk_eth_dev *dev, struct roc_nix_link_info *lin
 		} else {
 			for (bit = 0; bit < ROC_NIX_LINK_SPEED_MAX; bit++) {
 				if (link_info->speed_bitmask & BIT_ULL(bit))
-					advertise |= rte_to_ethtool_mode[bit];
+					advertise |= (uint64_t)rte_to_ethtool_mode[bit];
 			}
 			goto exit;
 		}
 	}

-	advertise |= mac_to_ethtool_mode[linfo.lmac_type_id][link_info->full_duplex];
+	advertise |= (uint64_t)mac_to_ethtool_mode[linfo.lmac_type_id][link_info->full_duplex];
 exit:
 	return advertise;
 }
--
2.34.1

