Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C5CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FE2140A6F;
	Mon, 15 Jun 2026 18:27:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7D22D400D6;
 Mon, 15 Jun 2026 18:27:05 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbYaJ1123713; Mon, 15 Jun 2026 09:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 UG5Smuuc2vTu0u5Mh/LpWynwpwdRJ9ReTqWEiGOZIo=; b=g8Gg6JxHT0d6kf8PS
 5utH+JRZCqEMJ0R0l8EgbhQlAg8rxWol1cE2t1XJE8NvKXyHbjQ251xSt5egHiL9
 M/aretXY7fYsUnpfFIz77IltjSolmMK/Gl3rvLlOyiF2QPxKHnIbxGeMprZVjjMe
 zeNGw8KAH2225bJRWKm+11ex1cijAalvXPLW/i4WsUpXAqGw8GDNB3GL3E4LNmNN
 Va1zMZolyr5JT/CN2aSluH8fTY7erW/px5FyG1L6Ua7icykad0ZPeh3MdSEC2Gjp
 Ah8/IiVga6Qd+mu3klCBh91ypwDoNbgMmZu2SCQiHcJenI1oMbIKpOK9quwbqt1H
 6bG7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk068j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:03 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 11F0B3F7065;
 Mon, 15 Jun 2026 09:26:59 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 14/20] net/cnxk: fix bitwise operand size mismatch in link
 mode
Date: Mon, 15 Jun 2026 21:54:40 +0530
Message-ID: <20260615162446.578336-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fdoMb5RjYMtFaysAR5Hxt4gIdVKQ9jcP
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027d8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=CJVFzQNyZXf_rX7GSKAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX0qe70WGeC666
 qJOdqQCGk6uQTp4YQ5G4y1OjMmUmRsVQXC5ZPB3cCditT1HZ+TPr+gGHYjRIINrMLRv8LENWaU0
 2N84dR1PGY1bcDerkReiqxbkZvy9ZRc=
X-Proofpoint-GUID: fdoMb5RjYMtFaysAR5Hxt4gIdVKQ9jcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX86OOZQsX3m1X
 Vmx87fX+3AdhzpCuZ1WYb42G9gFOob7ESyRaYm4EJiKtp1cj+fsPkRW1KIO4zr9zeQ+3Ginku1f
 HOiGflQIiawW1Hf72PzqjDFy5LBmgqAoohvewAhaUtmlgBQ9pvM+U7l14hMytxRrtEP0EhPRQO1
 vJcuE7WfTv+y1q4gaBTsRlsU7/pTF/BYh7Z42gz7uRdgmtxAYWcyR/Xd8IaxD2w/W8vppFoY7ON
 TUt1EkEv7f7JXM6VcvO4aKjCEGcoHMHFJypoKxL9CUsw0kpED2U5qBKpgfsxk5+6RkN/zEDf9QR
 MHR1A3IJxwK7ycDGyvL6wltwvfLS6Tz8x+kFBxAdeNZGupovfPzdzZaHbp0ZRegEiOmcoIS0+QE
 G5ysypN7U5ENYVZFi7nZzNTbXKq0FlkeBb9bAH3FFhRJ/Svv1gTlbU5EsxQtOyzM4Tk818rDWvx
 By28aOXmk9zusSrRNFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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
Changes in v3: No change.
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

