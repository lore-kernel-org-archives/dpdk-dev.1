Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18808CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 666C840ED3;
	Thu, 13 Nov 2025 05:40:09 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A40F240E54
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:40:07 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD2dX8P203309 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 7dvXuWfSvw/Wq3KixZxBUKjKN8Elv4S2fZBl5ygWQI=; b=IzD2g0Rg5wkGTqvyz
 3rdRJYiP2DABhoNgTPy4Dms1woG0pAoncvf7V7TBGLENkQz/nVhSSI1PHDNC+ze9
 4Naga5pZdC0GI0jTBqz6bvSzWmmMixt6PjIzXRSiRhLF0c6cgj36UEb0G2fCNeWv
 +9XXL709UPSOqz7/anYCWBLpv/Mp4Zj6PEOS5tchyG4O6h9uoqOpyOu2oqHHwvA6
 ToPBwr2PbreMnp8CAqf2e4XeMGEtVDsKeXZNiL8RXNqHUYDbT11UPQa0qeBxmv+a
 w0dls/70SbgEy4WelC4VA3yWIxNR0QFJeZwvk1T39250P44bu6clxPZ/u5NFltLc
 TFGPg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ad6r6g6nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:40:06 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:40:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:40:17 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 073D03F7087;
 Wed, 12 Nov 2025 20:40:02 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v5 21/23] common/cnxk: fix NIX Rx inject enable logic
Date: Thu, 13 Nov 2025 10:08:06 +0530
Message-ID: <20251113043808.1180851-21-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3JxNXLzJFMG6oOCgSvRE_VIkOgANhTOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX/fGAX4Uxyxw5
 4QayCMnlNrrA1Qxv6VY5Qv8fA+YAkvLSncd3Rt42fezD/o8LqFu/DcZ1uLhfDSHmJrX0xulyVCc
 vDAXBWbyIB98jZ3w42oQaPhPfn/wYPIi3bHESVKkDtu6jKJJ5D9LQcWmpYLNGImP295k7/+QyiF
 nIVoyl4oqtKF+CagALAx2Vpp4JpxUFp49/vZZYduoWGkbJYaiG35Hk1mdE45ShYtXX9pBAbbrp0
 Ah4HIj/A2835Urz0au/wZkYEHWyU5tjDRANeDb6Qg1lTln7S4XQ3FXynxiH+86Akg53d4HkOMjM
 UdhbjGatbt7AEgqQVO4JQLJOukv8eFxuxXSLFXruaw6pDOElpAvxbIlQtJax2KI8lgaEkr40JAq
 yvvtD8NWJHf83J4nPNHaJ4YMZR0OPg==
X-Proofpoint-ORIG-GUID: 3JxNXLzJFMG6oOCgSvRE_VIkOgANhTOE
X-Authority-Analysis: v=2.4 cv=Ic+KmGqa c=1 sm=1 tr=0 ts=69156126 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=vutZ09tH4-8uSkFm0o4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

