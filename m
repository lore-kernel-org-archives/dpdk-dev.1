Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240F4C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:42:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4103740E31;
	Mon, 24 Feb 2025 10:41:27 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9596D40B98
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:41:24 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O515Gr009516
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:41:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 YXx4JaZAJZ2ekz2bXTJKqHTanCHDJrQQB1gVPx3jr8=; b=KoR/avRu0nzvksAXO
 PhNNUC59gf32W4VPJeHE4DxPX2w4iYYfIn901p2VAe9NQJmweXptOcNNt7oOZW9+
 z8YdDZMrgSY3W8/bbEm0q8KcNTiUo+yhw0wU+kzmnOIvFbkuQ9ZYe+SvNnERyZAq
 8qFfZdg2n7s08aLaH/BWjNxfCCZLEUk8kv5Fppfb7RybsAau8r9rStj2YdNaq61x
 kqSX3O+lQREwVLNHAxbTcYu9/mqEE9WueCa65vXkiu8nGiE0yxVf8pwN/hdpAZPI
 t7KLCWBwQ7aGcFYb3N3bYFUrFmJe3/3C/hi6MuYix56F+AOK4wK/vE8RKAsKK1jB
 AAfgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4503qbspv8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:41:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:40:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:40:57 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 13A6B3F705D;
 Mon, 24 Feb 2025 01:40:54 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Srujana Challa <schalla@marvell.com>
Subject: [PATCH v2 31/33] common/cnxk: change the error log to a debug log
Date: Mon, 24 Feb 2025 15:09:13 +0530
Message-ID: <20250224093915.1253215-31-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224093915.1253215-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224093915.1253215-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0hj2XPTprMnnJA_5Et49LKDicAfuL1Jo
X-Proofpoint-ORIG-GUID: 0hj2XPTprMnnJA_5Et49LKDicAfuL1Jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Srujana Challa <schalla@marvell.com>

This patch updates the error log to a debug log since
it is not needed.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 2e753440b7..376582f5db 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1250,7 +1250,7 @@ roc_nix_inl_dev_qptr_get(uint8_t qid)
 		inl_dev = idev->nix_inl_dev;
 
 	if (!inl_dev) {
-		plt_err("Inline Device could not be detected");
+		plt_nix_dbg("Inline Device could not be detected");
 		return NULL;
 	}
 	if (!inl_dev->attach_cptlf) {
-- 
2.34.1

