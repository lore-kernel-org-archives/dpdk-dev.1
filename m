Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CECD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:39:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBAD740E4F;
	Thu, 13 Nov 2025 05:39:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 24FFC40E4F
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:39:39 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ACMsOKm1058934 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 kg2Vhiwa0tSYwst3vP6MHPysNxzNALmvme3Rb/ut+g=; b=GX5tEAzVDJbsDFjmB
 O/aF9JQ7v0Rq6P4KCwez+DFO2C31+kqQVbE25gDbl+K7ugDPcNE1UfVTHs15a/u3
 meOyIWygry4T94gB+aTdgll2NNg2+y1k9MAR50sy+xhrMyxBJ86306szpBo9J8ni
 Rh3q5CBNXNbDNN+FbMS3iZfn8TEWoWhFlTtAE53GWjvMG1jW0tpy75aM5Dz3rlRP
 Jp8GTJ7m4LBNYRwIF94dXJI3Qd+gKgASiYCX9P/iuhRDIjdn1hkxDqrhXyHv6233
 tnaM/XkuxArHaeZ6/RIMWeQKqHd4sFu3/PyVze1JYj9HT0/1ZWghvHsZCGsANTx1
 G7xNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4acru1aa86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 12 Nov 2025 20:39:38 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:39:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:39:37 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 72C443F7076;
 Wed, 12 Nov 2025 20:39:34 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v5 14/23] common/cnxk: increase Tx schedular count
Date: Thu, 13 Nov 2025 10:07:59 +0530
Message-ID: <20251113043808.1180851-14-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=6915610a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=9znxC1Y1qzjyv-Gufa4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 19uK7_iqau8bimPqbqzJib8f4_hlDwso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfX0UBamgoJ8iEK
 KdXUlolwV50kBhnFVD7ZgZqGN2t3uWuE6D85SVP6w26P6g8ylEBrJk6XX7/AIAVKDROXT05W6RN
 DmDhhKEnM7RPqrzWJMBNo52YyyRjEInTtspwJ+8NOGpL5FEdNkWhmqm0KDdhDJjVVNnxLJdV3kO
 vCj5GBtHOEZbhiMKWUEFeiDNL2ie5sGzmcliVzcda+s6tjGT4EjRfDbDwjY0ve8EsIi8RDFZ2d6
 t2E6G5Hex0aFTla0Od9e4nwJIYvVBIE73dBvr30opC5r34tuq95xiGmLlEINm3oerqVrsGzPYX7
 2nZztoBwe72Jr2itS7NG7AupjGbcVPJV40a6LJ7aeSEYa5SU8ZrtVqt3gFR9t2ds1fhU8pKYmxR
 FQBKwa7k9ClAyGng1vyEQrEdfH1m+Q==
X-Proofpoint-ORIG-GUID: 19uK7_iqau8bimPqbqzJib8f4_hlDwso
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

From: Satha Rao <skoteshwar@marvell.com>

CN10K platform supports Tx schedulars up to 2K.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
---
 drivers/common/cnxk/roc_nix_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index ae1a8fd7e0..308a62a70e 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -41,7 +41,7 @@ struct nix_qint {
 };
 
 /* Traffic Manager */
-#define NIX_TM_MAX_HW_TXSCHQ 1024
+#define NIX_TM_MAX_HW_TXSCHQ 2048
 #define NIX_TM_HW_ID_INVALID UINT32_MAX
 #define NIX_TM_CHAN_INVALID UINT16_MAX
 
-- 
2.34.1

