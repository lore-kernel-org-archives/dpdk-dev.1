Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CDCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A25BF42EDB;
	Thu, 11 Jun 2026 09:34:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0EAC442ED7;
 Thu, 11 Jun 2026 09:34:31 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QiBc856212; Thu, 11 Jun 2026 00:34:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=L
 skSqC4T6DpGpZHKaRatmiLEdWqgAPcrvTlJiYDA7Rk=; b=YOMVQwkArvxFnVymQ
 GdUybpM3BWCdWtFj/lfE4yO9tMg6l+taXGTTgvdCTUWOF+8Ss28a9IQvdDXBDqe3
 hCOoZ+lmbRiKYActnyJaa54feyQFepaRuPj8p/HapZvQCiUK9F/by18VTiESCUaY
 qd53huOHlsHQyGDlUs7ssgKo3MiAvvxm9DS/2WSlk8nY39VQ9jFN8+fGfi7/YwFE
 ShyPfjxqSoeZZngMgZ+lmbjnLZH6iHO7q18QTWxoz4Y5FaGfAY3kRQUGsiwcyQZW
 kgK9mrlDvFrFvU7Zy7Y1UlITZMlvPln4WSUBD0UyPd8rlSO7duJf56iONQ1VTXMc
 so8Sg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r9yce-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 00:34:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:29 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id CE3A95B6973;
 Thu, 11 Jun 2026 00:34:26 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 14/17] net/cnxk: fix bitwise operand size mismatch in link mode
Date: Thu, 11 Jun 2026 13:03:08 +0530
Message-ID: <20260611073311.3129711-14-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2a6507 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=CJVFzQNyZXf_rX7GSKAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: QkoH0l-YJllOuW6mnDpcp1mfrjs_rMfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfXwII88DWfDwyu
 WaobHTLnwMAKtgN5TtgtDkiZmm4H/MrhkH38uOJD58hMU21waKuhNpMHsxZtFRiLx1gNk9jQNGi
 fES3rGDQKBxAb2o2xBI2K2FSveQl90o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX5MtSOEC7xni3
 eZ0XzmvBE1wQ5l2i3KSBtnmWV1gGMNNsNqucvgum00hU8yf02eVHgp1Y1ADYB+NQjGRAJNlMmmf
 ZHDagJD4cFm/p1J2GSJpDIfujad7/xvStk4yMsx06Cn3FBEdgpOEemWePykK799GiJkY8u6rLr3
 VLda4ERvbApEEJ/zxhLbRnMWkhkWD7kxuNRMB/G6etN3Ifugy5A/iYZDxEOTfHwmfsJ/RRvojal
 D2SUmj0cyQTALjpDL8tD27ptKMlnPhYTE4aGIMZVlRveyxsnCgaO0ZL3xJ0OWHFHuI+EMDMXHK3
 VnJVasMmDv4dGFiClRvupb3gTJRk0qTz/1O2iz5+Q7r2YrPFmCPugh/cQVuTvf+fT7P9/hv9c1l
 SnkaWtBWdLKNl9BvqnUvfKplxuyxdIW64X0ZCCg6Uzp1knWQrXnZpKCd5P58a2B+hWrf+QHCWz5
 qj6seFLqy3gNd2TQkBQ==
X-Proofpoint-ORIG-GUID: QkoH0l-YJllOuW6mnDpcp1mfrjs_rMfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

