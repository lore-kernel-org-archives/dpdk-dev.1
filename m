Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A01A840A6D;
	Fri,  7 Nov 2025 11:49:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 65EC14067D
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:59 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73TjPi1335071 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 7dvXuWfSvw/Wq3KixZxBUKjKN8Elv4S2fZBl5ygWQI=; b=RS7xJvg9sKkCqYPZp
 Uv+0UAAZOWOr2BgrnnPY2ruyFHzvTu9qBn0vBGlGVY9lOsdbZeE4cXF+79/KRMWe
 jEU6sQLTZ9m/7ey14PAC5E0732EydF3BC+X7chU6EErboo80MpZRwqS1hE8v/NXI
 2dKYTv0G+Yof7rDpIqQjpTP2+Gwe40lpYnYOuA515nN+yGUhin9tJlpRSb5SOxzF
 yS3OEdAT7g2O3XNPlbAWRDbD3RH3+BClhkWscYZ4/bSU12Eg6IqP7B2Nb/IZzln+
 B5EdOUxO5VczLzogSsQ+qlogATiI4qjIQGoA0bKy2qqUNAhzF0UHSllSP/i6oVMt
 hr9Xw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkh9tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:49:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:49:08 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 16EAA3F70C9;
 Fri,  7 Nov 2025 02:48:54 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v4 21/23] common/cnxk: fix NIX Rx inject enable logic
Date: Fri, 7 Nov 2025 16:17:45 +0530
Message-ID: <20251107104747.1131008-21-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X4sfkdQeK_kmu977pF3TiFboLO0qmAk4
X-Proofpoint-GUID: X4sfkdQeK_kmu977pF3TiFboLO0qmAk4
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690dce9a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=vutZ09tH4-8uSkFm0o4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX+IDYlZ8nQea9
 GogeNsRTmJPeKCSW6l6bf9SnCQPIMZ+OeOC+llkhJkMF3KFRIalZ8pdqFZT6sok0u06DatRumN3
 Nc+l7tbIeXvMk59x2iFYm1H4LsrZZ9FyoaSqPH1aiKw4jCC4wzuADcNNaxS4XsUxlozf7cFZQxw
 HqMyi7/uSUgqGk0qXDpFYRmvwXbQGOV9I6l3JTNAANcwSpW0ZMGKA2nYiG+HaAjqTMG+6kIwyZs
 kyBDz93sEHcA/3AS5uJnrYciEUpKAi6r8wSEeXTkmN0mJkrRmKR5cnH98zfuwR6i9xbuuUT/v0X
 460KLJEew/tVfJIkcGgpzsAD9fTyci0mhzBFz5ptI0pArCa2jiof8FkQhx4NTYPhxLHfRu1r+MF
 BL9GvXIsOVFVqZVtgsJaO8SHIxUmOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

Rx inject can only be supported with roc_nix.

Fixes: 4b8eb5bd6627 ("common/cnxk: reserve CPT LF for Rx inject")
Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 780f4cbbfc..f8be98efd5 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -849,12 +849,12 @@ roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inb_inl_dev)
 
 	if (inb_inl_dev) {
 		inl_dev = idev->nix_inl_dev;
-		if (inl_dev && inl_dev->attach_cptlf && inl_dev->rx_inj_ena &&
+		if (inl_dev && inl_dev->attach_cptlf && inl_dev->rx_inj_ena && roc_nix &&
 		    roc_nix->rx_inj_ena)
 			return true;
 	}
 
-	return roc_nix->rx_inj_ena;
+	return roc_nix ? roc_nix->rx_inj_ena : 0;
 }
 
 uint32_t
-- 
2.34.1

